//
//  UITextView2.m
//  MeiTu
//
//  Created by Eric Yang on 13-6-2.
//
//

#import "UITextView2.h"
#import "Resource.h"
@implementation UITextView2

- (void)drawRect:(CGRect)rect
{
    [self localizeText];
    [super drawRect:rect];
}

- (void) localizeText
{
    NSString * localizedString = [Resource getUIStringForText:self.text];
    [self setText: localizedString];
}

@end
