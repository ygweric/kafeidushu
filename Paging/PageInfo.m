//
//  PageInfo.m
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "PageInfo.h"

@implementation PageInfo
@synthesize isValid,pageIndex,dataOffset,pageView;
-(id)init{
    if ([super init]) {
        isValid=NO;
        pageIndex=0;
        dataOffset=0;
        pageView=nil;
    }
    return self;
}
@end
