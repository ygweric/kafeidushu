//
//  AppDelegate.h
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ReaderViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic) UIViewController *viewController;
@property (retain,nonatomic) UITabBarController * tabBarController;

@end
