//
//  BookMark.m
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookMark.h"

@implementation BookMark
@synthesize offset=_offset,percent=_percent,desc=_desc,time=_time;

-(id)init{
    self=[super init];
    if (self) {
        _time=[[[[NSDate alloc]init]autorelease] timeIntervalSince1970];
    }
    return self;
}

#pragma mark coding

#define OFFSET @"OFFSET"
#define PERCENT @"PERCENT"
#define DESC @"DESC"
#define TIME @"TIME"
-(id)initWithCoder:(NSCoder *)aDecoder{
    BookMark* bm=[self init];
    bm.percent=[aDecoder decodeFloatForKey:PERCENT];
    bm.desc=[aDecoder decodeObjectForKey:DESC];
    bm.offset=[aDecoder decodeInt32ForKey:OFFSET];
    return bm;    
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt32:_offset forKey:OFFSET];
    [aCoder encodeFloat:_percent forKey:PERCENT];
    [aCoder encodeObject:_desc forKey:DESC];
    [aCoder encodeFloat:_time forKey:TIME];    
}
@end
