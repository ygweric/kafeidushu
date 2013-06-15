//
//  FileUtil.h
//  Yunho2
//
//  Created by l on 12-12-20.
//
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject
+(NSString*)getDocumentPath;
+(NSString*)getDocumentFilePathWithFile:(NSString*)fileName dir:(NSString*)dir ,...NS_REQUIRES_NIL_TERMINATION;
+(NSString*)getLibraryFilePathWithFile:(NSString*)fileName dir:(NSString*)dir ,...NS_REQUIRES_NIL_TERMINATION;

+ (NSMutableDictionary *)recursivePathsWithFolderOfType:(NSString *)type inDirectory:(NSString *)directoryPath;
+ (NSArray *)recursivePathsForResourcesOfType:(NSString *)type inDirectory:(NSString *)directoryPath;+(void)copyFilesRecursiveOfType:(NSString *)type inDirectory:(NSString *)directoryPath toDir:(NSString*)destDir deleteOldFiles:(BOOL)toDelete;
+(void)copyFile:(NSString*)srcPath toDir:(NSString*)destDir;
@end
