
#import <Foundation/Foundation.h>

@interface Resource : NSObject

//
// text如果是以@开头的，如，@textKey，则认为是从资源文件中取出key＝textKey的文字；
// 如果没有找到，则返回原始的text，也就是@textKey。
// 如果不是以@开头的，如，textString，则直接返回原text，不做任何变化。
// @@表示字符@，不用来表示是key，如，@@string，将被认为不需要查询资源文件，将直接返回@@string
//
+ (NSString *) getUIStringForText: (NSString *) text inFile:(NSString *) resourceFile;

//
// 直接从资源文件中取出key对应的文字；key不需要以@开头。
// 如果没有找到，返回nil。
//
+ (NSString *) getUIStringForText: (NSString *) text;


@end
