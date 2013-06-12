
#import "Resource.h"

@implementation Resource

+ (NSString *) getUIStringForText: (NSString *) text
{

    NSString * key = nil;

    NSRange range1 = [text rangeOfString:@"@"];
    NSRange range2 = [text rangeOfString:@"@@"];
    if(range1.location == 0 && range2.location != 0)
    {
        key = [text substringFromIndex:(range1.location + 1)];
    }

    NSString * localizedString = nil;
    if(key != nil)
    {
        localizedString = NSLocalizedString(key, "");
    }

    if(localizedString == nil)
    {
        localizedString = text;
    }

    return localizedString;
}

+ (NSString *) getUIStringForKey: (NSString *) key inFile:(NSString *) resourceFile
{
    if(resourceFile == nil)
    {
        resourceFile = @"UIText";
    }

    NSString * localizedString = nil;
    if(key != nil)
    {
        localizedString = NSLocalizedStringFromTable(key, resourceFile, nil);
    }

    return localizedString;
}


@end
