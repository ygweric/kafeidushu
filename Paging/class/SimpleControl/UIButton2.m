
#import "UIButton2.h"

#import "Resource.h"

@implementation UIButton2
{
@private
    BOOL backgroundImgStretched;
}



@synthesize backgroundImageEdgeInsets;


static void initInstanceVariables(UIButton2 * self);

void initInstanceVariables(UIButton2 * self)
{
    self->backgroundImgStretched = NO;
}


- (id) init
{
    if(self = [super init])
    {
        initInstanceVariables(self);
    }

    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{

    if(self = [super initWithCoder:aDecoder])
    {
        initInstanceVariables(self);
    }

    return self;

}

- (id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        initInstanceVariables(self);
    }

    return self;
}



- (void)drawRect:(CGRect)rect
{
    [self localizeText];

    [self stretchBackgroundImage];

    [super drawRect:rect];
}

- (void) stretchBackgroundImage
{
    if(backgroundImgStretched)
    {
        return;
    }

    if([self backgroundImageEdgeInsets ]!= nil && [[self backgroundImageEdgeInsets ] length] > 0)
    {
       [self setBackgroundImageEdgeInsets:[backgroundImageEdgeInsets stringByReplacingOccurrencesOfString:@" " withString:@""]];

        UIEdgeInsets edge = UIEdgeInsetsFromString(self.backgroundImageEdgeInsets);

        NSInteger states[] = {
            UIControlStateNormal,
            UIControlStateHighlighted,
            UIControlStateSelected,
            UIControlStateDisabled
        };

        int count = sizeof(states)/sizeof(states[0]);

        UIImage * currentBgImg = [self currentBackgroundImage];
        for (int i = 0; i < count; i++)
        {
            NSInteger state = states[i];

            UIImage * img = [self backgroundImageForState:state];
            if(img==nil)
            {
                continue;
            }

            UIImage * img2 = [img resizableImageWithCapInsets:edge];

            [self setBackgroundImage:img2 forState:state];

            if([self state] == state)
            {
                currentBgImg = img;
            }
        }

        //
        // now, the image property of the background image view has been set before,
        // and our code does NOT affect the current background imge view.
        // so, we need find the image view and set the streteched image to it.
        //
        // I has not found a way to get the background image view, so, i will iterate
        // the subview and try to get it.
        //
        for (UIView * subView in [self subviews])
        {
            if([subView isKindOfClass:[UIImageView class]])
            {
                UIImageView * t = (UIImageView *)subView;
                if(t != nil && t.image != nil && t.image == currentBgImg)
                {
                    // so, it is the background image view.
                    UIImage * img2 = [currentBgImg resizableImageWithCapInsets:edge];

                    [t setImage:img2];
                }
            }
        }
    }

    backgroundImgStretched = YES;
}

- (void) localizeText
{
    NSInteger states[] = {
        UIControlStateNormal,
        UIControlStateHighlighted,
        UIControlStateSelected,
        UIControlStateDisabled
    };

    int count = sizeof(states)/sizeof(states[0]);

    for (int i = 0; i < count; i++)
    {
        NSInteger state = states[i];

        NSString * title = [self titleForState:state];

        NSString * localizedString = [Resource getUIStringForText:title];

        if(localizedString != nil)
        {
            [self setTitle:localizedString forState:state];

            if([self state] == state)
            {
                [[self titleLabel] setText:localizedString];
            }
        }
    }
}

@end
