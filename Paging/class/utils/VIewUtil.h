//
//  VIewUtil.h
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIewUtil : NSObject
+(UIView*)clone:(UIView*)v;
+(void)removeAllSubviews:(UIView*)v;
@end
