//
//  FileUtil.m
//  Yunho2
//
//  Created by l on 12-12-20.
//
//

#import "FileUtil.h"

@implementation FileUtil

+(NSString*)getDocumentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
//FIXME 这里dir没有使用，稍后检查
+(NSString*)getDocumentFilePathWithFile:(NSString*)fileName dir:(NSString*)dir ,...NS_REQUIRES_NIL_TERMINATION{
    NSString* path=[self getDocumentPath];
    return [self getFilePathWithFile:fileName basePath:path dir:dir, nil];
}
+(NSString*)getLibraryFilePathWithFile:(NSString*)fileName dir:(NSString*)dir ,...NS_REQUIRES_NIL_TERMINATION{
    NSString* path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [self getFilePathWithFile:fileName basePath:path dir:dir, nil];
}

+(NSString*)getFilePathWithFile:(NSString*)fileName basePath:(NSString*)basePath dir:(NSString*)dir ,...NS_REQUIRES_NIL_TERMINATION{
    id arg;
    va_list argList;
    if(dir)
    {
        basePath=[basePath stringByAppendingPathComponent:dir];
        va_start(argList,dir);
        while ((arg = va_arg(argList,id)))
        {
            basePath=[basePath stringByAppendingPathComponent:((NSString*)arg)];
        }
        va_end(argList);
    }
    [self createFileAtPath:basePath];
    basePath=[basePath stringByAppendingPathComponent:fileName];
    return basePath;
}

+(BOOL)createDocumentDirAtPath:(NSString*)dir,...NS_REQUIRES_NIL_TERMINATION{
    NSString* path=[self getDocumentPath];
    id arg;
    va_list argList;
    if(dir)
    {
        va_start(argList,dir);
        while ((arg = va_arg(argList,id)))
        {
            path=[path stringByAppendingPathComponent:((NSString*)arg)];
        }
        va_end(argList);
    }
    return [self createFileAtPath:path];
}
+(BOOL) createFileAtPath:(NSString*)path{
    NSFileManager* fm = [NSFileManager defaultManager];
    NSError * error=nil;
    if(![fm fileExistsAtPath:path]){
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    if(error){
        NSLog(@"createDocumentDirAtPath Error !-%s:%d--%@",__FUNCTION__,__LINE__,[error localizedDescription]);
        return NO;
    }else{
        return YES;
    }

}
//@type nil means any type
+ (NSMutableDictionary *)recursivePathsWithFolderOfType:(NSString *)type inDirectory:(NSString *)directoryPath{
    NSArray *filePaths =[self recursivePathsForResourcesOfType:type inDirectory:directoryPath];
    NSMutableDictionary* fps=[[[NSMutableDictionary alloc]initWithCapacity:3]autorelease];
    for (NSString* fp in filePaths) {
        NSRange r=[fp rangeOfString:directoryPath];
        NSString* simpleFilePath= [fp substringFromIndex:(r.location+r.length)];
        
        NSArray* ps=[simpleFilePath componentsSeparatedByString:@"/"];
        NSString* fname=[ps objectAtIndex:ps.count-1];
        NSString* newDir =[simpleFilePath stringByReplacingOccurrencesOfString:fname withString:@""];
        
        [fps setObject:newDir forKey:fp];
    }
    return fps;
}


+ (NSArray *)recursivePathsForResourcesOfType:(NSString *)type inDirectory:(NSString *)directoryPath{
    
    NSMutableArray *filePaths = [[[NSMutableArray alloc] init]autorelease];
    
    // Enumerators are recursive
    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath] ;
    
    NSString *filePath;
    
    while ((filePath = [enumerator nextObject]) != nil){
        
        // If we have the right type of file, add it to the list
        // Make sure to prepend the directory path
        if((type==nil ||  [@"" isEqualToString:type])
           || [[filePath pathExtension] isEqualToString:type]){
            [filePaths addObject:[directoryPath stringByAppendingPathComponent:filePath]];
        }
    } 
    return filePaths;
}
+(void)copyFilesRecursiveOfType:(NSString *)type inDirectory:(NSString *)directoryPath toDir:(NSString*)destDir deleteOldFiles:(BOOL)toDelete {
    NSDictionary *filePaths =[self recursivePathsWithFolderOfType:type inDirectory:directoryPath];
    NSFileManager* fm= [NSFileManager defaultManager];
    NSArray* keys= filePaths.allKeys;
    for (NSString* srcPath in keys) {
        [self copyFile:srcPath toDir:destDir withNewDir:[filePaths objectForKey:srcPath]];
        if (toDelete) {
            NSError * error=nil;
            [fm removeItemAtPath:srcPath error:&error];
            if(error){
                NSLog(@"error!-%s:%d--%@",__FUNCTION__,__LINE__,[error localizedDescription]);
            }
        }
    }
    
    
    
}
+(void)copyFile:(NSString*)srcPath toDir:(NSString*)destDir withNewDir:(NSString*)newDir{
    NSString* destPath=[destDir stringByAppendingPathComponent: newDir];
    NSFileManager* fm= [NSFileManager defaultManager];
    NSError * error=nil;
    [fm createDirectoryAtPath:destPath withIntermediateDirectories:YES attributes:nil error:&error];
    if(error){
        NSLog(@"error!-%s:%d--%@",__FUNCTION__,__LINE__,[error localizedDescription]);
    }
    [self copyFile:srcPath toDir:destPath];
}
+(void)copyFile:(NSString*)srcPath toDir:(NSString*)destDir{
    NSArray* ps=[srcPath componentsSeparatedByString:@"/"];
    NSString* fname=[ps objectAtIndex:ps.count-1];
    NSString* destPath=[destDir stringByAppendingPathComponent:fname];
    
    NSFileManager* fm= [NSFileManager defaultManager];
    NSError * error=nil;
    [fm copyItemAtPath:srcPath toPath:destPath error:&error];
    if(error){
        NSLog(@"error!!!!-%s:%d--%@",__FUNCTION__,__LINE__,[error localizedDescription]);
    }

}
@end
