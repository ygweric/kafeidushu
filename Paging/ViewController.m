//
//  ViewController.m
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "ViewController.h"
#define FONT_SIZE_MAX 12

@interface ViewController ()

@end

@implementation ViewController{
    int totalPages;
    int currentPage;
    NSString* text;
    
    int referTotalPages;
    int referCharatersPerPage;
    
    NSRange* rangeOfPages;
}
@synthesize  lbContent;
@synthesize pageInfoLabel;
- (void)viewDidLoad
{
    [super viewDidLoad];
	//
    totalPages = 0;
    currentPage = 0;
    
    //
    lbContent.numberOfLines = 0;
    lbContent.font=[UIFont systemFontOfSize:FONT_SIZE_MAX];
    
    //text 整个文本内容
    if (!text) {
        // 从文件里加载文本串
        text=[self loadString];
        
        // 计算文本串的大小尺寸
        CGSize totalTextSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]
                                constrainedToSize:CGSizeMake(lbContent.frame.size.width, CGFLOAT_MAX)
                                    lineBreakMode:NSLineBreakByWordWrapping];
        
        // 如果一页就能显示完，直接显示所有文本串即可。
        if (totalTextSize.height < lbContent.frame.size.height) {
            lbContent.text = text;
        }
        else {
            // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！
            NSUInteger textLength = [text length];//总字符数
            referTotalPages = (int)totalTextSize.height/(int)lbContent.frame.size.height+1;//页数
            referCharatersPerPage = textLength/referTotalPages;//每页字符数
            
            // 申请最终保存页面NSRange信息的数组缓冲区
            int maxPages = referTotalPages;
            rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));
            memset(rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));
            
            // 页面索引
            int page = 0;
            
            for (NSUInteger location = 0; location < textLength; ) {
                // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）
                NSRange range = NSMakeRange(location, referCharatersPerPage);//首页range
                
                // reach end of text ?
                NSString *pageText; //当前page的content
                CGSize pageTextSize;//content做占用的单行最大长度
                
                
                
                //得到合适的range
                //保证没有达到文章尾部
                while (range.location + range.length < textLength) {
                    pageText = [text substringWithRange:range];
                    
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
                
                //到文章结尾时候处理
                if (range.location + range.length >= textLength) {
                    range.length = textLength - range.location;
                }
                
                // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于lbContent的尺寸时即为满足
                while (range.length > 0) {
                    pageText = [text substringWithRange:range];
                    
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
            lbContent.text = [text substringWithRange:rangeOfPages[currentPage]];
        }
    }
    
    // 显示当前页面进度信息，格式为："8/100"
    pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];
}
-(NSString*)loadString{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"push实现.txt"];   
    
//    NSError* err=nil;
//    NSString* mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
//    NSString* mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&err];


    //GBK encoding
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);    
    NSData *responseData = [NSData dataWithContentsOfFile:filePath];
    NSString *mTxt = [[NSString alloc] initWithData:responseData encoding:encode];
    
    
//     NSLog(@"err:%@",err);
    
//    NSLog(@"filePath:%@",filePath);
//    NSLog(@"mTxt:%@",mTxt);
    return mTxt;
}

////////////////////////////////////////////////////////////////////////////////////////
// 上一页
- (IBAction)actionPrevious:(id)sender {
    if (currentPage > 0) {
        currentPage--;
        
        NSRange range = rangeOfPages[currentPage];
        NSString *pageText = [text substringWithRange:range];
        
        lbContent.text = pageText;
        
        //
        pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];
    }
}

////////////////////////////////////////////////////////////////////////////////////////
// 下一页
- (IBAction)actionNext:(id)sender {
    if (currentPage < totalPages-1) {
        currentPage++;
        
        NSRange range = rangeOfPages[currentPage];
        NSString *pageText = [text substringWithRange:range];
        
        lbContent.text = pageText;
        
        //
        pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];
    }
}

- (void)dealloc {
    [lbContent release];
    [pageInfoLabel release];
    [super dealloc];
}
@end
