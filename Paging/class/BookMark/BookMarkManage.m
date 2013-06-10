//
//  BookMarkManage.m
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookMarkManage.h"
#import "BookMark.h"
#import "FileUtil.h"
@implementation BookMarkManage

// bookdesc <---> BookMark (Array)
@synthesize bookMarks;

static BookMarkManage* instance;
+(BookMarkManage*)share{
    if (!instance) {
        instance=[[BookMarkManage alloc]init];
        instance.bookMarks= [instance uncacheBookMarks];
        if (!instance.bookMarks) {
            instance.bookMarks=[[NSMutableDictionary alloc]initWithCapacity:3];
        }
        
    }
    return instance;
}
#pragma mark -

-(BOOL)addBookMarkWithName:(NSString*)name offset:(long long)offset desc:(NSString*)desc{
    NSMutableArray* bms =[instance.bookMarks objectForKey:name];
    if (!bms) {
        bms =[[[NSMutableArray alloc]initWithCapacity:3]autorelease];
        [instance.bookMarks setObject:bms forKey:name];
    }
    BookMark* bm=[[[BookMark alloc]init]autorelease];
    bm.offset=offset;
    bm.desc=desc;
    [bms addObject:bm];
    [self cacheBookMarks];
    return YES;
}
-(NSArray*)getBookMarksWithBookName:(NSString*)name{
    return [instance.bookMarks objectForKey:name];
}
#pragma mark archive
#define DATA_DIR @"datas"
#define DATA_BOOKMARKS @"bookmarks"

-(void)cacheBookMarks{
    NSString* bmsPath =[FileUtil getLibraryFilePathWithFile:DATA_BOOKMARKS dir:DATA_DIR, nil];
    [NSKeyedArchiver archiveRootObject:bookMarks toFile:bmsPath];
}

-(NSMutableDictionary*)uncacheBookMarks{
    NSString* bmsPath =[FileUtil getLibraryFilePathWithFile:DATA_BOOKMARKS dir:DATA_DIR, nil];
    NSMutableDictionary* bms = [NSKeyedUnarchiver unarchiveObjectWithFile:bmsPath];
    return bms;

}




@end
