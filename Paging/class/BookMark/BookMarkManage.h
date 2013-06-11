//
//  BookMarkManage.h
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookMarkManage : NSObject
@property (nonatomic,retain)NSMutableDictionary* bookMarks;
+(BookMarkManage*)share;

-(BOOL)addBookMarkWithName:(NSString*)name offset:(long long)offset percent:(float)percent desc:(NSString*)desc;
-(NSArray*)getBookMarksWithBookName:(NSString*)name;
-(void)cacheBookMarks;
-(NSMutableDictionary*)uncacheBookMarks;
@end
