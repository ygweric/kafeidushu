//
//  ViewController.m
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "ViewController.h"
#define FONT_SIZE_MAX 10

#define MAX_CHARACTER_LENGHT IS_IPAD?8000:2000

#define MAX_PAGING_STEP 40 //单位pixel,大概一行





#define  e_can_show_one_page -1



@implementation ViewController{

    
    
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
- (int)pageString:(NSString*)content isNext:(BOOL)isNext
{
    //text 整个文本内容
    
    NSLog(@"-----pageString   -----before text:\n%@\n\n",content);
    
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
        
        
        // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
        NSRange range = NSMakeRange(isNext?0:textLength-referCharatersPerPage, referCharatersPerPage);//首页range
        
        // reach end of text ?
        NSString *pageText; //当前page的content
        CGSize pageTextSize;//content做占用的单行最大长度
        
        
        
        //得到合适的range
        //保证没有达到文章尾部
        while (isNext?(range.location + range.length < textLength):(range.location >0)) {
            pageText = [self.text substringWithRange:range];
            
            pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                    lineBreakMode:NSLineBreakByWordWrapping];
            
            //如果填充满，则停止
            if (pageTextSize.height > lbContent.frame.size.height) {
                break;
            }
            else {
                //否则，再加上/下一页继续填充
                if(isNext){
                    //range总长度加 referCharatersPerPage，起点前移referCharatersPerPage
                    range.length += referCharatersPerPage;
                }else{
                    range.location-=referCharatersPerPage;
                    range.length += referCharatersPerPage;
                }
                
            }
        }
        //到文章结尾/开头时候处理
        if (range.location <= 0) {
            range.location = 0;
        }
        if (range.location + range.length >= textLength) {
            if(isNext){
                range.length = textLength - range.location;
            }else{
                range.location = textLength - range.length;
            }
            
        }
        
        
        // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于lbContent的尺寸时即为满足
        int step=MAX_PAGING_STEP;
        NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
        while (1) {
            pageText = [self.text substringWithRange:range];
//            NSLog(@"range.location:%d range.length:%d",range.location,range.length);
//            NSLog(@"pageText:%@",pageText);
            //得到前面计算得到的当页string
            pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                    lineBreakMode:NSLineBreakByWordWrapping];
            
            
            //TODO 得到合适的，记录，不然循环太多
//            NSLog(@"pageTextSize.height:%f ;lbContent.frame.size.height:%f",pageTextSize.height,lbContent.frame.size.height);
            if (pageTextSize.height <= lbContent.frame.size.height) {
                if (step==MAX_PAGING_STEP) {
                    if(isNext){
                        range.length += step;
                    }else{
                        range.location -= step;
                        range.length+=step;
                    }
                    step=1;
                } else {
                    if(isNext){
                        range.length = [pageText length];
                    }else{
                        range.location = textLength-[pageText length];
                    }
                    
                    break;
                }
                
            }
            else {
                if(isNext){
                    range.length -= step;
			    }else{
                    range.location += step;
                    range.length-=step;
			    }
                
            }
        }
        NSLog(@"time interval--viewDidLoad ---4--:%lf",[[[[NSDate alloc]init]autorelease]timeIntervalSince1970]-timeStart);
        
        // 得到一个页面的显示范围
        if (page >= maxPages) {
            maxPages += 10;
            rangeOfPages = (NSRange *)realloc(rangeOfPages, maxPages*sizeof(NSRange));
        }
        rangeOfPages[0] = range;
        
        
        // 更新UILabel内容
        NSString* currentContent= [self.text substringWithRange:rangeOfPages[0]];
        NSLog(@"-----pageString   -----end text:\n%@\n\n",currentContent);
        lbContent.text = currentContent;
        int length= [currentContent lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
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

    lbContent.numberOfLines = 0;
    lbContent.font=[UIFont systemFontOfSize:FONT_SIZE_MAX];
    
    preOffset=0;
    currentOffset=0;
    nextOffset=0;
    currentLength=0;
    maxLength=0;
    fileLength=1; //初始化1，显示页数%时候，做除数，所以不为0

    self.filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"笑傲江湖-utf8.txt"];
    
    fileLength= [self getFileSize:_filePath];
    if (fileLength==0) {
        fileLength=1;
        NSLog(@"file is empty!!!!");
    }
    
    // 从文件里加载文本串
    self.text=nil;

    int tmpLength=MAX_CHARACTER_LENGHT;
    while (!self.text) {
        self.text=[self loadStringFrom:0 length:tmpLength];
        NSLog(@"tmpLength:%d",tmpLength);
        if (!self.text) {
            tmpLength--;
        }
    }
   
    int currentPageLength= [self pageString:self.text isNext:YES];
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

    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:_filePath];
    [fileHandle seekToFileOffset:index];
    NSData *responseData = [fileHandle readDataOfLength:length];
    
    //GBK encoding
//    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    NSString *mTxt = [[[NSString alloc] initWithData:responseData encoding:encode]autorelease];
    return mTxt;
}

#pragma mark -
// 上一页
- (IBAction)actionPrevious:(id)sender {
    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
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
        int currentPageLength= [self pageString:self.text isNext:NO];
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
    NSLog(@"time interval--viewDidLoad ---4--:%lf",[[[[NSDate alloc]init]autorelease]timeIntervalSince1970]-timeStart);

    
}

////////////////////////////////////////////////////////////////////////////////////////
// 下一页
- (IBAction)actionNext:(id)sender {
    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
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
        int currentPageLength= [self pageString:self.text isNext:YES];
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
    NSLog(@"time interval--viewDidLoad ---4--:%lf",[[[[NSDate alloc]init]autorelease]timeIntervalSince1970]-timeStart);
}

- (void)dealloc {
    [lbContent release];
    [pageInfoLabel release];
    [super dealloc];
}
@end
