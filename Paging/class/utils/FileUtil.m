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
        NSLog(@"createDocumentDirAtPath Error !!!!---%@",[error localizedDescription]);
        return NO;
    }else{
        return YES;
    }

}
@end
