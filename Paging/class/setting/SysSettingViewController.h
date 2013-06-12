//
//  SysSettingViewController.h
//  Yunho2
//
//  Created by user on 12-8-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface SysSettingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>{
    NSDictionary* datasource ;
    NSString * versionString;
    NSString * is_force;
}
@property (retain,nonatomic) NSDictionary* datasource;


@end
