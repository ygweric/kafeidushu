//
//  LableMargin.m
//  Paging
//
//  Created by Eric Yang on 13-6-12.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "LableMargin.h"

@implementation LableMargin{
//    CGRect margin ;
    NSValue* vlInsets;
}

- (id)initWithFrame:(CGRect)frame margin:(UIEdgeInsets)pInsert
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        vlInsets = [[NSValue value:&pInsert withObjCType:@encode(UIEdgeInsets)]retain];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawTextInRect:(CGRect)rect {
//    UIEdgeInsets pInsert;
//    [vlInsets getValue:&pInsert];
    //FIXME 这里竟然没法传递参数，fuck
    UIEdgeInsets insets = {44,0, 50, 0};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}
-(void)dealloc{
    [vlInsets release];
    [vlInsets dealloc];
    [super dealloc];
}
@end
