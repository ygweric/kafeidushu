//
//  BookInfo.m
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookInfo.h"

@implementation BookInfo
@synthesize lastOffset=_lastOffset;

#pragma mark coding

#define LASTOFFSET @"LASTOFFSET"


-(id)initWithCoder:(NSCoder *)aDecoder{
    BookInfo* bi=[self init];
    bi.lastOffset=[aDecoder decodeInt32ForKey:LASTOFFSET];
    return bi;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt32:_lastOffset forKey:LASTOFFSET];
}
@end
