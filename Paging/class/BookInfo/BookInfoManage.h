//
//  BookInfoManager.h
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookInfo.h"

@interface BookInfoManage : NSObject
@property (nonatomic,retain) NSMutableDictionary* bookInfos;

+(BookInfoManage*)share;
#pragma mark -
-(void)updateBookInfo:(NSString*)name offset:(long long)offset;
-(BookInfo*)getBookInfo:(NSString*)name;
@end
