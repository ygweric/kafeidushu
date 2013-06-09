
//
//  StringUtil.m
//  Yunho2
//
//  Created by l on 12-11-6.
//
//

#import "StringUtil.h"

@implementation StringUtil
+(BOOL)isNilOrEmpty:(NSString*) s{
    if (s==nil || [@"" isEqualToString:s]) {
        return YES;
    }else{
        return NO;
    }
}
+(NSString*)deleteSuffix:(NSString*) suffix withTarget:(NSString*) targetS{
     NSRange range = [targetS rangeOfString:suffix];
    if (range.location!=NSNotFound) {
         return [targetS substringToIndex:range.location];
    } else {
        NSLog(@"!!!! ERROR!!,%@ not contain suffix %@",targetS,suffix);
        return @"";
    }
   
    
}
+ (NSString *)createUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}




@end
