
#import "UILabel2.h"

#import "Resource.h"

@implementation UILabel2



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
