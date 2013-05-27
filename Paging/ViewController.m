//
//  ViewController.m
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "ViewController.h"
#define FONT_SIZE_MAX 12
#define MAX_CHARACTER_LENGHT 3000

@interface ViewController ()

@end


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
    
}
@synthesize  lbContent;
@synthesize pageInfoLabel;
@synthesize text=_text;

// return current page character length
- (int)pageString:(NSString*)content
{
    //text 整个文本内容
    
    NSLog(@"-----pageString   -----before text:\n%@\n\n",content);
    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
    NSTimeInterval now=0;
    // 计算文本串的大小尺寸
    CGSize totalTextSize = [self.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                 constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                     lineBreakMode:NSLineBreakByWordWrapping];
    
    // 如果一页就能显示完，直接显示所有文本串即可。
    if (totalTextSize.height < lbContent.frame.size.height) {
        lbContent.text = self.text;
        return -1;
    }
    else {
        // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
        NSUInteger textLength = [self.text length];//总字符数 524
        referTotalPages = (int)totalTextSize.height/(int)lbContent.frame.size.height+1;//页数
        referCharatersPerPage = textLength/referTotalPages;//每页字符数
        
        // 申请最终保存页面NSRange信息的数组缓冲区
        int maxPages = referTotalPages;
        rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));
        memset(rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));
        
        // 页面索引
        int page = 0;
        now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
        //            NSLog(@"time interval--viewDidLoad ---1--:%lf",now-timeStart);
        timeStart=now;
        for (NSUInteger location = 0; location < textLength; ) {
            // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
            NSRange range = NSMakeRange(location, referCharatersPerPage);//首页range
            
            // reach end of text ?
            NSString *pageText; //当前page的content
            CGSize pageTextSize;//content做占用的单行最大长度
            
            
            
            //得到合适的range
            //保证没有达到文章尾部
            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---2--:%lf",now-timeStart);
            timeStart=now;
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
            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---3--:%lf",now-timeStart);
            timeStart=now;
            //到文章结尾时候处理
            if (range.location + range.length >= textLength) {
                range.length = textLength - range.location;
            }
            
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
            now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
            //                NSLog(@"time interval--viewDidLoad ---4--:%lf",now-timeStart);
            timeStart=now;
            // 得到一个页面的显示范围
            if (page >= maxPages) {
                maxPages += 10;
                rangeOfPages = (NSRange *)realloc(rangeOfPages, maxPages*sizeof(NSRange));
            }
            rangeOfPages[page++] = range;
            
            // 更新游标
            location += range.length;
        }
        
        // 获取最终页面数量
        totalPages = page;
        
        // 更新UILabel内容
        NSString* currentContent= [self.text substringWithRange:rangeOfPages[currentPage]];
        //            NSLog(@"+++++++++++\ncurrentContent:%@\n\n",currentContent);
        NSLog(@"-----pageString   -----end text\n:%@\n\n",currentContent);
        lbContent.text = currentContent;
        int length= [currentContent lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        //            length=(length/2!=0)?(length-10):(length-11);
        return length;
    }
    
}

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
    
    // 从文件里加载文本串
    self.text=nil;
    int tmpOffset=0;
    while (!self.text) {
        self.text=[self loadStringFrom:tmpOffset length:MAX_CHARACTER_LENGHT];
        NSLog(@"tmpOffset:%d",tmpOffset);
        if (!self.text) {
            tmpOffset++;
        }
    }
//    NSLog(@"text:%@",self.text);
    
   
    int currentPageLength= [self pageString:self.text];
    preOffset=0;
    nextOffset=currentOffset+ currentPageLength;
    NSLog(@"currentPageLength:%d,preOffset:%d,currentOffset%d,nextOffset:%d",currentPageLength,preOffset,currentOffset,nextOffset);
    
    
    // 显示当前页面进度信息，格式为："8/100"
    pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];
}
-(NSString*)loadString{
    return [self loadStringFrom:0 length:MAX_CHARACTER_LENGHT];
}


-(NSString*)loadStringFrom:(int)index length:(int)length{
    //    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"push实现.txt"];
//    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"笑傲江湖.txt"];
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"笑傲江湖-utf8.txt"];
    NSTimeInterval timeStart=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
    
    //    NSError* err=nil;
    //    NSString* mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    
    
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    //    fileHandle.l
    [fileHandle seekToFileOffset:index];
    NSData *responseData = [fileHandle readDataOfLength:length];
    
    NSTimeInterval now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
//    NSLog(@"time interval--loadString ---1--:%lf",now-timeStart);
    timeStart=now;
    
    
    //GBK encoding
//    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//  NSData *responseData = [NSData dataWithContentsOfFile:filePath];
//    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
    unsigned long encode = NSUTF8StringEncoding;
//    unsigned long encode = NSASCIIStringEncoding;
    NSString *mTxt = [[NSString alloc] initWithData:responseData encoding:encode];


    
    now=[[[[NSDate alloc]init]autorelease]timeIntervalSince1970];
//    NSLog(@"time interval--loadString ---2--:%lf",now-timeStart);
    timeStart=now;
    
    //     NSLog(@"err:%@",err);
    
    //    NSLog(@"filePath:%@",filePath);
    //    NSLog(@"mTxt:%@",mTxt);
    
//     NSLog(@"+++++++++++\nloadString:%@\n\n",mTxt);
//    NSLog(@"------mTxt:%zd",[mTxt lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    return mTxt;
}

////////////////////////////////////////////////////////////////////////////////////////
// 上一页
- (IBAction)actionPrevious:(id)sender {
    if (currentPage > 0) {
        currentPage--;
        
        NSRange range = rangeOfPages[currentPage];
        NSString *pageText = [self.text substringWithRange:range];
        
        lbContent.text = pageText;
        
        //
        pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];
    }
}

////////////////////////////////////////////////////////////////////////////////////////
// 下一页
- (IBAction)actionNext:(id)sender {
    
    // 从文件里加载文本串
    self.text=nil;
    while (!self.text) {
        self.text=[self loadStringFrom:nextOffset length:MAX_CHARACTER_LENGHT];
        NSLog(@"nextOffset:%d,text:",nextOffset);
        if (!self.text) {
            nextOffset++;
        }
    }
    
    
    int currentPageLength= [self pageString:self.text];
    preOffset=currentOffset;
    currentOffset=nextOffset;
    nextOffset+=currentPageLength;
    
    NSLog(@"currentPageLength:%d,preOffset:%d,currentOffset%d,nextOffset:%d",currentPageLength,preOffset,currentOffset,nextOffset);
    return;
    /*
    if (currentPage < totalPages-1) {
        currentPage++;
        
        NSRange range = rangeOfPages[currentPage];
        NSString *pageText = [text substringWithRange:range];
        
        lbContent.text = pageText;
        
        //
        pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];
    }
     */
}

- (void)dealloc {
    [lbContent release];
    [pageInfoLabel release];
    [super dealloc];
}
@end
