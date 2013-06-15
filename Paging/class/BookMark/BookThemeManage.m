//
//  BookThemeManage.m
//  Paging
//
//  Created by Eric Yang on 13-6-13.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookThemeManage.h"



@implementation BookThemeManage
@synthesize bookThemes=_bookThemes;

static BookThemeManage* instance;
+(BookThemeManage*)share{
    if (!instance) {
        instance=[[BookThemeManage alloc]init];
        instance.bookThemes=[[[NSMutableDictionary alloc]initWithCapacity:2]autorelease];
        
        BookTheme* btWrite=[[[BookTheme alloc]init]autorelease];
        btWrite.colVBg=[UIColor whiteColor];
        btWrite.colLbContnetBg=[UIColor whiteColor];
        btWrite.colFont=[UIColor blackColor];
        btWrite.colTopPageReverseOverlay=[UIColor whiteColor];
        [instance.bookThemes setValue:btWrite forKey:[StringUtil int2String:THEME_WHITE]];
        
        BookTheme* btBlack=[[[BookTheme alloc]init]autorelease];
        btBlack.colVBg=[UIColor blackColor];
        btBlack.colLbContnetBg=[UIColor blackColor];
        btBlack.colFont=[UIColor whiteColor];
        btBlack.colTopPageReverseOverlay=[UIColor blackColor];
        [instance.bookThemes setValue:btBlack forKey:[StringUtil int2String:THEME_BLACK]];
        
    }
    return instance;
}
-(BookTheme*)getBookThemeByTheme:(NSString*)theme{
    return [self.bookThemes valueForKey:theme];
}
@end
