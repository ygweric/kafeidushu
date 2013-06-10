//
//  BookInfoManager.m
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookInfoManage.h"
#import "BookInfo.h"
#import "FileUtil.h"


@implementation BookInfoManage

@synthesize bookInfos=_bookInfos;

static BookInfoManage* instance;
+(BookInfoManage*)share{
    if (!instance) {
        instance=[[BookInfoManage alloc]init];
        instance.bookInfos= [instance uncacheBookInfos];
        if (!instance.bookInfos) {
            instance.bookInfos=[[NSMutableDictionary alloc]initWithCapacity:3];
        }
        
    }
    return instance;
}
#pragma mark -
-(void)updateBookInfo:(NSString*)name offset:(long long)offset{
    BookInfo* bi=[_bookInfos objectForKey:name];
    if (!bi) {
        bi=[[[BookInfo alloc]init]autorelease];
        [_bookInfos setObject:bi forKey:name];
    }
    bi.lastOffset=offset;
    [self cacheBookInfos];
}
-(BookInfo*)getBookInfo:(NSString*)name{
    return [_bookInfos objectForKey:name];
}



#pragma mark archive
#define DATA_DIR @"datas"
#define DATA_BOOKINFOS @"bookinfos"

-(void)cacheBookInfos{
    NSString* bmsPath =[FileUtil getLibraryFilePathWithFile:DATA_BOOKINFOS dir:DATA_DIR, nil];
    [NSKeyedArchiver archiveRootObject:_bookInfos toFile:bmsPath];
}

-(NSMutableDictionary*)uncacheBookInfos{
    NSString* bmsPath =[FileUtil getLibraryFilePathWithFile:DATA_BOOKINFOS dir:DATA_DIR, nil];
    NSMutableDictionary* bms = [NSKeyedUnarchiver unarchiveObjectWithFile:bmsPath];
    return bms;
    
}

@end
