//
//  AppDelegate.m
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "AppDelegate.h"

#import "ReaderViewController.h"
#import "RJBookListViewController.h"




@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
//    self.viewController = [[[ViewController alloc] initWithNibName:IS_IPAD?@"ViewController_ipad": @"ViewController_iphone" bundle:nil] autorelease];
    
    self.viewController = [[[RJBookListViewController alloc] init] autorelease];
//    self.viewController =[[[UIViewController alloc]init]autorelease];
    UINavigationController* navVC=[[[UINavigationController alloc]initWithRootViewController:self.viewController]autorelease];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    
    
    
    /*
     升级须知
     每次app生新版本，
     1、appVersion加一
     2、然后在case中做对应修改
     */
    int appVersion=1;
    NSUserDefaults* def=[NSUserDefaults standardUserDefaults];
    int currentVersion=[def integerForKey:UDF_CURRENT_VERSION];
    if (appVersion!=currentVersion) { //未升级
        switch (currentVersion) {
            case 0:
                //首次初始化
                [def setInteger:DEFAULT_FONT_SIZE forKey:UDF_FONT_SIZE];
            case 1:
                break;
        }
        [def setInteger:appVersion forKey:UDF_CURRENT_VERSION];
    }

    
    
    
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
