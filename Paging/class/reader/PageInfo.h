//
//  PageInfo.h
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageInfo : NSObject
@property BOOL isValid;
@property int pageIndex;
@property int dataOffset;
@property int pageLength;
@property (retain,nonatomic) UIView* pageView;


@end

