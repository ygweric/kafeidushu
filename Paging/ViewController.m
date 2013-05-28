//
//  ViewController.m
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "ViewController.h"
#define FONT_SIZE_MAX 12
#define MAX_CHARACTER_LENGHT 2000

#define MAX_PAGING_STEP 40 //单位pixel,大概一行


#define  e_can_show_one_page -1



@implementation ViewController{
    int totalPages;
    int currentPage;
    
    
    int referTotalPages;
    int referCharatersPerPage;
    
    NSRange* rangeOfPages;
    
    int preOffset;
    int currentOffset;
    int nextOffset;
    int currentLength;
    int maxLength;
    
    long long fileLength;
    
}
@synthesize  lbContent;
@synthesize pageInfoLabel;
@synthesize text=_text;
@synthesize filePath=_filePath;

// return current page character length
- (int)pageString:(NSString*)content
{
    //text 整个文本内容
    
    NSLog(@"-----pageString   -----before text:\n%@\n\n",content);
//    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
//    NSTimeInterval now=0;
    // 计算文本串的大小尺寸
    CGSize totalTextSize = [self.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                 constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    // 如果一页就能显示完，直接显示所有文本串即可。
    if (totalTextSize.height < lbContent.frame.size.height) {
        lbContent.text = self.text;
        NSLog(@"----- all text can be show in only one page -----end \n\n");
        return e_can_show_one_page;
    }
    else {
        // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
        NSUInteger textLength = [self.text length];//总字符数 524
        referTotalPages = (int)totalTextSize.height/(int)lbContent.frame.size.height+1;//页数
        referCharatersPerPage = textLength/referTotalPages;//每页字符数
        
        // 申请最终保存页面NSRange信息的数组缓冲区
        int maxPages = referTotalPages;
        rangeOfPages=nil;
        rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));
        memset(rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));
        
        // 页面索引
        int page = 0;
//        now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
        //            NSLog(@"time interval--viewDidLoad ---1--:%lf",now-timeStart);
//        timeStart=now;
        for (NSUInteger location = 0; location < textLength; ) {
            // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
            NSRange range = NSMakeRange(location, referCharatersPerPage);//首页range
            
            // reach end of text ?
            NSString *pageText; //当前page的content
            CGSize pageTextSize;//content做占用的单行最大长度
            
            
            
            //得到合适的range
            //保证没有达到文章尾部
//            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---2--:%lf",now-timeStart);
//            timeStart=now;
            while (range.location + range.length < textLength) {
                pageText = [self.text substringWithRange:range];
                
                pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                    constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                        lineBreakMode:NSLineBreakByWordWrapping];
                
                //如果填充满，则停止
                if (pageTextSize.height > lbContent.frame.size.height) {
                    break;
                }
                else {
                    //否则，再加上一页继续填充
                    range.length += referCharatersPerPage;
                }
            }
//            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---3--:%lf",now-timeStart);
//            timeStart=now;
            //到文章结尾时候处理
            if (range.location + range.length >= textLength) {
                range.length = textLength - range.location;
            }
//            NSLog(@"---2---range.location:%d length:%d",range.location,range.length);
            // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于lbContent的尺寸时即为满足
            while (range.length > 0) {
                pageText = [self.text substringWithRange:range];
                
                //得到前面计算得到的当页string
                pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                    constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                        lineBreakMode:NSLineBreakByWordWrapping];
                
                //可能会大于lable长度(why？？)，逐个测试，逐渐减小，直到得到合适的长度
                if (pageTextSize.height <= lbContent.frame.size.height) {
                    range.length = [pageText length];
                    break;
                }
                else {
                    range.length -= 2;
                }
            }
//            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---4--:%lf",now-timeStart);
//            timeStart=now;
            // 得到一个页面的显示范围
            if (page >= maxPages) {
                maxPages += 10;
                rangeOfPages = (NSRange *)realloc(rangeOfPages, maxPages*sizeof(NSRange));
            }
            rangeOfPages[0] = range;
            break;
            // 更新游标
            location += range.length;
        }
        
        // 获取最终页面数量
        totalPages = page;
        
        // 更新UILabel内容
        NSString* currentContent= [self.text substringWithRange:rangeOfPages[0]];
        //            NSLog(@"+++++++++++\ncurrentContent:%@\n\n",currentContent);
        NSLog(@"-----pageString   -----end text:\n%@\n\n",currentContent);
        lbContent.text = currentContent;
        int length= [currentContent lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"length:%d",length);
        //            length=(length/2!=0)?(length-10):(length-11);
        if (rangeOfPages) {
            free(rangeOfPages);
            rangeOfPages=nil;
        }
        return length;
    }
    
}
- (int)prePageString:(NSString*)content
{
    //text 整个文本内容
    
    NSLog(@"-----pageString   -----before text:\n%@\n\n",content);
    //    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
    //    NSTimeInterval now=0;
    // 计算文本串的大小尺寸
    CGSize totalTextSize = [self.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                 constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    // 如果一页就能显示完，直接显示所有文本串即可。
    if (totalTextSize.height < lbContent.frame.size.height) {
        lbContent.text = self.text;
        NSLog(@"----- all text can be show in only one page -----end \n\n");
        return e_can_show_one_page;
    }
    else {
        // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
        NSUInteger textLength = [self.text length];//总字符数 524
        NSLog(@"textLength:%d",textLength);
        NSLog(@"totalTextSize.height:%f ;(int)lbContent.frame.size.height:%d",totalTextSize.height,(int)lbContent.frame.size.height+1);
        referTotalPages = (int)totalTextSize.height/(int)lbContent.frame.size.height+1;//页数
        referCharatersPerPage = textLength/referTotalPages;//每页字符数
        
        // 申请最终保存页面NSRange信息的数组缓冲区
        int maxPages = referTotalPages;
        rangeOfPages=nil;
        rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));
        memset(rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));
        
        // 页面索引
        int page = 0;

        

            // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
            NSRange range = NSMakeRange(textLength-referCharatersPerPage, referCharatersPerPage);//首页range
            
            // reach end of text ?
            NSString *pageText; //当前page的content
            CGSize pageTextSize;//content做占用的单行最大长度
            
            
            
            //得到合适的range
            //保证没有达到文章尾部
            while (range.location >0) {
                pageText = [self.text substringWithRange:range];
                
                pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                    constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                        lineBreakMode:NSLineBreakByWordWrapping];
                
                //如果填充满，则停止
                if (pageTextSize.height > lbContent.frame.size.height) {
                    break;
                }
                else {
                    //否则，再加下一页继续填充
                    //range总长度加 referCharatersPerPage，起点前移referCharatersPerPage
                    range.location-=referCharatersPerPage;
                    range.length += referCharatersPerPage;
                }
            }
            //到文章开头时候处理
            if (range.location <= 0) {
                range.location = 0;
            }
            if (range.location + range.length >= textLength) {
                range.location = textLength - range.length;
            }
            NSLog(@"---1---range.location:%d length:%d",range.location,range.length);
        
            
            // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于lbContent的尺寸时即为满足
        int step=MAX_PAGING_STEP;
        NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            while (1) {
                pageText = [self.text substringWithRange:range];
//                NSLog(@"[self.text substringWithRange:range]:%@",[self.text substringWithRange:range]);
                //得到前面计算得到的当页string
                pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                    constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                        lineBreakMode:NSLineBreakByWordWrapping];
                
                //可能会大于lable长度(why？？)，逐个测试，逐渐减小，直到得到合适的长度
                //TODO 得到合适的，记录，不然循环太多
                NSLog(@"pageTextSize.height:%f ;lbContent.frame.size.height:%f",pageTextSize.height,lbContent.frame.size.height);
                if (pageTextSize.height <= lbContent.frame.size.height) {
                    if (step==MAX_PAGING_STEP) {
                        range.location -= step;
                        range.length+=step;
                        step=1;
                    } else {
                        range.location = textLength-[pageText length];
                        break;
                    }
                    
                }
                else {
                    range.location += step;
                    range.length-=step;
                }
            }
         NSLog(@"time interval--viewDidLoad ---4--:%lf",[[[[NSDate alloc]init]autorelease]timeIntervalSince1970]-timeStart);
            //            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---4--:%lf",now-timeStart);
            //            timeStart=now;
            // 得到一个页面的显示范围
            if (page >= maxPages) {
                maxPages += 10;
                rangeOfPages = (NSRange *)realloc(rangeOfPages, maxPages*sizeof(NSRange));
            }
            rangeOfPages[0] = range;

        
        
        // 获取最终页面数量
        totalPages = page;
        
        // 更新UILabel内容
        NSString* currentContent= [self.text substringWithRange:rangeOfPages[0]];
        //            NSLog(@"+++++++++++\ncurrentContent:%@\n\n",currentContent);
        NSLog(@"-----pageString   -----end text:\n%@\n\n",currentContent);
        lbContent.text = currentContent;
        int length= [currentContent lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        //            length=(length/2!=0)?(length-10):(length-11);
        if (rangeOfPages) {
            free(rangeOfPages);
            rangeOfPages=nil;
        }
        return length;
    }
    
}
#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    totalPages = 0;
    currentPage = 0;
    
    lbContent.numberOfLines = 0;
    lbContent.font=[UIFont systemFontOfSize:FONT_SIZE_MAX];
    
    preOffset=0;
    currentOffset=0;
    nextOffset=0;
    currentLength=0;
    maxLength=0;
    fileLength=1; //初始化1，显示页数%时候，做除数，所以不为0
    
    
    //    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"push实现.txt"];
    //    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"笑傲江湖.txt"];
    self.filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"笑傲江湖-utf8.txt"];
    //    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
    
    fileLength= [self getFileSize:_filePath];
    if (fileLength==0) {
        fileLength=1;
        NSLog(@"file is empty!!!!");
    }
    
    // 从文件里加载文本串
    self.text=nil;
    /*/
    int tmpOffset=987;
    while (!self.text) {
        self.text=[self loadStringFrom:tmpOffset length:MAX_CHARACTER_LENGHT];
        NSLog(@"tmpOffset:%d",tmpOffset);
        if (!self.text) {
            tmpOffset++;
        }
    }
    /*/
    int tmpLength=MAX_CHARACTER_LENGHT;
    while (!self.text) {
        self.text=[self loadStringFrom:0 length:tmpLength];
        NSLog(@"tmpLength:%d",tmpLength);
        if (!self.text) {
            tmpLength--;
        }
    }
     //*/

//    NSLog(@"text:%@",self.text);
    
   
    int currentPageLength= [self pageString:self.text];
    preOffset=0;
    //这里不能+1是因为currentOffset从0开始
    nextOffset=currentOffset+ currentPageLength;
    NSLog(@"--currentPageLength:%d,preOffset:%d,currentOffset%d,nextOffset:%d",currentPageLength,preOffset,currentOffset,nextOffset);
    [self updatePageInfo];
    
    
}
-(void)updatePageInfo{
    // 显示当前页面进度信息，格式为："8/100"
    pageInfoLabel.text = [NSString stringWithFormat:@"%0.2f %@", (double)currentOffset/fileLength*100,@"%"];
}
-(NSString*)loadString{
    return [self loadStringFrom:0 length:MAX_CHARACTER_LENGHT];
}
-(long long)getFileSize:(NSString*)filePath{
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:0];
    
    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
    long long fileSize = [fileSizeNumber longLongValue];
    NSLog(@"fileSize:%lld",fileSize);
    return fileSize;
}

-(NSString*)loadStringFrom:(int)index length:(int)length{

    
    //    NSError* err=nil;
    //    NSString* mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    
    
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:_filePath];
    //    fileHandle.l
    [fileHandle seekToFileOffset:index];
    NSData *responseData = [fileHandle readDataOfLength:length];
    
//    NSTimeInterval now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
//    NSLog(@"time interval--loadString ---1--:%lf",now-timeStart);
//    timeStart=now;
    
    
    //GBK encoding
//    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//  NSData *responseData = [NSData dataWithContentsOfFile:filePath];
//    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    unsigned long encode = NSUTF8StringEncoding;
//    unsigned long encode = NSASCIIStringEncoding;
    NSString *mTxt = [[[NSString alloc] initWithData:responseData encoding:encode]autorelease];


    
//    now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
//    NSLog(@"time interval--loadString ---2--:%lf",now-timeStart);
//    timeStart=now;
    
    //     NSLog(@"err:%@",err);
    
    //    NSLog(@"filePath:%@",filePath);
    //    NSLog(@"mTxt:%@",mTxt);
    
//     NSLog(@"+++++++++++\nloadString:%@\n\n",mTxt);
//    NSLog(@"------mTxt:%zd",[mTxt lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    return mTxt;
}

#pragma mark -
// 上一页
- (IBAction)actionPrevious:(id)sender {
    // 从文件里加载文本串
    NSLog(@"---1--preOffset:%d,currentOffset:%d,nextOffset:%d",preOffset,currentOffset,nextOffset);
    if (currentOffset<=0) {
         NSLog(@"++++++++++++++\n it is the first page already !!!\n");
        return;
    }
    int tmpLength=(currentOffset<MAX_CHARACTER_LENGHT)?currentOffset:MAX_CHARACTER_LENGHT;
    self.text=nil;
    while (!self.text
           && tmpLength>=0) {
        self.text=[self loadStringFrom:currentOffset-tmpLength length:tmpLength];
        NSLog(@"tmpLength:%d",tmpLength);
        if (!self.text) {
            tmpLength--;
        }
    }
    if (tmpLength!=0) {
        int currentPageLength= [self prePageString:self.text];
        nextOffset=currentOffset;
        if (currentPageLength>0) {
            currentOffset=currentOffset-currentPageLength;
        }else if(currentPageLength==e_can_show_one_page){
            currentOffset=0;
        }
        
        NSLog(@"++currentPageLength:%d,preOffset:%d,currentOffset:%d,nextOffset:%d",currentPageLength,preOffset,currentOffset,nextOffset);
    }else{
        currentOffset=0;
        NSLog(@"++++++++++++++\n it is the first page already !!!\n");
    }
    
   [self updatePageInfo];
    
    
}

////////////////////////////////////////////////////////////////////////////////////////
// 下一页
- (IBAction)actionNext:(id)sender {
    if (currentOffset==nextOffset
        && currentOffset!=0) {
         NSLog(@"++++++++++++++\n it is the last page already !!!!\n");
        return;
    }
    // 从文件里加载文本串
    self.text=nil;
    
    int tmpLength=MAX_CHARACTER_LENGHT;    
    while (!self.text) {
        self.text=[self loadStringFrom:nextOffset length:tmpLength];
        NSLog(@"tmpLength:%d",tmpLength);
        if (!self.text) {
            tmpLength--;
        }
    }
    if (tmpLength!=0) {
        int currentPageLength= [self pageString:self.text];
        preOffset=currentOffset;
        currentOffset=nextOffset;
        if (currentPageLength>0) {
            nextOffset+=currentPageLength;
        }

        NSLog(@"++currentPageLength:%d,preOffset:%d,currentOffset:%d,nextOffset:%d",currentPageLength,preOffset,currentOffset,nextOffset);
    }else{
        currentOffset=0;
        NSLog(@"++preOffset:%d,currentOffset:%d,nextOffset:%d",preOffset,currentOffset,nextOffset);
        NSLog(@"++++++++++++++\n it is the last page already !!!\n");
    }
    [self updatePageInfo];
}

- (void)dealloc {
    [lbContent release];
    [pageInfoLabel release];
    [super dealloc];
}
@end
