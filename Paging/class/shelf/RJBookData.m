//
//  RJBookData.m
//  txtReader
//
//  Created by Zeng Qingrong on 12-8-22.
//  Copyright (c) 2012年 Zeng Qingrong. All rights reserved.
//

#import "RJBookData.h"

@implementation RJSingleBook

@synthesize name,icon,pages,pageSize,bookFile,bookPath;

@end

@implementation RJBookData
@synthesize books;


static RJBookData *shareBookData = nil;

+(RJBookData *)sharedRJBookData{
    @synchronized(self){
        if(shareBookData == nil){
            shareBookData = [[RJBookData alloc] init];
        }
    }
    return shareBookData;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(shareBookData == nil)
		{
            shareBookData = [super allocWithZone:zone];
            return shareBookData;
        }
    }
    return nil;
}


-(id)init
{
	if (self = [super init])
	{
        self.books = [[NSMutableArray alloc]initWithCapacity:1];
	}
	return self;
}

-(void)loadBookList{
    
    [books removeAllObjects];
    NSString *dicpath = [NSString stringWithFormat:@"%@/Library/books",NSHomeDirectory()];
    

    NSFileManager* fm= [NSFileManager defaultManager];
    [fm createDirectoryAtPath:dicpath withIntermediateDirectories:YES attributes:nil error:nil];
    NSArray *levelList = [fm contentsOfDirectoryAtPath:dicpath error:nil ] ;
    
    for (NSString *fname  in levelList) {
        NSString *fpath = [NSString stringWithFormat:@"%@/%@",dicpath,fname];
        if ([fname hasSuffix:@".txt"]) {
            RJSingleBook* singleBook = [[[RJSingleBook alloc]init]autorelease];
            singleBook.name=fname;
            singleBook.icon =@"default_icon.png";
            singleBook.bookPath=fpath;
            [books addObject:singleBook];
        }
        
       
    }

    
    
}


@end
