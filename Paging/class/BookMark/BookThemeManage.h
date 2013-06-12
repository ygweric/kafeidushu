//
//  BookThemeManage.h
//  Paging
//
//  Created by Eric Yang on 13-6-13.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookTheme.h"

#define THEME_WRITE @"THEME_WRITE"
#define THEME_BLACK @"THEME_BLACK"

@interface BookThemeManage : NSObject
@property (nonatomic,retain) NSMutableDictionary* bookThemes;

+(BookThemeManage*)share;
-(BookTheme*)getBookThemeByTheme:(NSString*)theme;
@end
