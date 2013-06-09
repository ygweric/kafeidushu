//
//  StringUtil.h
//  Yunho2
//
//  Created by l on 12-11-6.
//
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

+(BOOL)isNilOrEmpty:(NSString*) s;
+(NSString*)deleteSuffix:(NSString*) suffix withTarget:(NSString*) targetS;
+ (NSString *)createUUID;

@end
