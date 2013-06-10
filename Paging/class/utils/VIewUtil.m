//
//  VIewUtil.m
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "VIewUtil.h"

@implementation VIewUtil

+(UIView*)clone:(UIView*)v{
    NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:v];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
}
+(void)removeAllSubviews:(UIView*)view{
    for(UIView *subview in [view subviews]) {
        [subview removeFromSuperview];
    }
}
@end
