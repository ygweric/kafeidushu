//
//  SysSettingViewController.m
//  Yunho2
//
//  Created by user on 12-8-8.
//  Copyright (c) 2012年 ____. All rights reserved.
//

#import "SysSettingViewController.h"
#import "WifiViewController.h"
#import "AboutMeViewController.h"




enum{
    tag_cell_value=101,
    tag_cell_icon,
    tag_alert_clear_cache,
    tag_alert_upgrade,
};


@interface SysSettingViewController ()

@end

@implementation SysSettingViewController
@synthesize datasource;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = LocalizedString(@"tab_setting");
    NSString *path = [[NSBundle mainBundle] pathForResource:@"syssettring"
                                                     ofType:@"plist"];
    self.datasource = [[[NSDictionary alloc]
                          initWithContentsOfFile:path]autorelease];
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
}
- (void)viewDidUnload
{
    NSLog(@"SysSettingViewControlle -----viewDidUnload -----");
    [super viewDidUnload];
    self.datasource = nil;
}
-(void)dealloc
{
    NSLog(@"sysViewController------dealloc.....");
    [datasource release];
    [super dealloc];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [([datasource objectForKey:[self getIndexKey:section]]) count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    self.SNSDatasource = [dict objectForKey:@"sns"];
//    self.otherDatasource = [dict objectForKey:@"syssettring"];
    
    static NSString *CellIdentifier = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell =[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
//        UILabel* lbValue=[[[UILabel alloc]initWithFrame:CGRectMake(200, 5, 100, 30)]autorelease];
//        lbValue.backgroundColor=[UIColor clearColor];
//        lbValue.tag=tag_cell_value;
//        [cell addSubview:lbValue];
        UIImageView* ivIcon=[[[UIImageView alloc]initWithFrame:CGRectMake(240, 10, 20, 20)]autorelease];
        ivIcon.tag=tag_cell_icon;
        [cell addSubview:ivIcon];

        
    }
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator ;
    
    UILabel* lbTitle=[cell textLabel];
    NSString* key= [[datasource objectForKey:[self getIndexKey:indexPath.section]] objectAtIndex:indexPath.row];
    lbTitle.frame=CGRectMake(lbTitle.frame.origin.x, lbTitle.frame.origin.y, 250, lbTitle.frame.size.height);
    lbTitle.text =LocalizedString(key);
    if (indexPath.row==3) {
        UIImageView* ivIcon=(UIImageView*)[cell viewWithTag:tag_cell_icon];
        ivIcon.image=[UIImage imageNamed:@"vip"];
    }
   
    
    
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *controller =nil;
    switch ([indexPath section]) {
        case 1:
            switch (indexPath.row) {
                case 0:
//                    [ShareSDK authWithType:ShareTypeSinaWeibo  options:nil result:^(SSAuthState state, id<ICMErrorInfo> error) {
//                        NSUserDefaults* udf=[NSUserDefaults standardUserDefaults];
//                        if (state == SSAuthStateSuccess)
//                        {
//                            NSLog(@"授权成功");
//                            [udf setBool:YES forKey:UDF_SNS_GRANTED_SINA_WEIBO];
//                            [tableView reloadData];
//                            [udf synchronize];
//                        }
//                        else if (state == SSAuthStateFail)
//                        {
//                            NSLog(@"授权失败");
//                            [udf setBool:NO forKey:UDF_SNS_GRANTED_SINA_WEIBO];
//                            [tableView reloadData];
//                            [udf synchronize];
//                        }
//                    }];
                    break;
                case 1:
//                    [ShareSDK authWithType:ShareTypeTencentWeibo  options:nil result:^(SSAuthState state, id<ICMErrorInfo> error) {
//                        NSUserDefaults* udf=[NSUserDefaults standardUserDefaults];
//                        if (state == SSAuthStateSuccess)
//                        {
//                            NSLog(@"授权成功");
//                            [udf setBool:YES forKey:UDF_SNS_GRANTED_TENCENT_WEIBO];
//                            [tableView reloadData];
//                            [udf synchronize];
//                        }
//                        else if (state == SSAuthStateFail)
//                        {
//                            NSLog(@"授权失败");
//                            [udf setBool:NO forKey:UDF_SNS_GRANTED_TENCENT_WEIBO];
//                            [tableView reloadData];
//                            [udf synchronize];
//                        }
//                    }];

                    break;
            }
            
            break;
        case 0:
        {
            switch (indexPath.row) {
//                case 0:
//                {
//                    [MobClick event:@"clearCache"];
//                    UIAlertView* alert=[[[UIAlertView alloc]initWithTitle:nil message:@"确定清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定清除", nil]autorelease];
//                    alert.tag=tag_alert_clear_cache;
//                    [alert show];
//                }
//                    break;
                case 0:
                {
                    [MobClick event:@"mailme"];
                    if ([MFMailComposeViewController canSendMail]) {
                        MFMailComposeViewController* controller = [[[MFMailComposeViewController alloc] init]autorelease];
                        controller.mailComposeDelegate = self;
                        [controller setToRecipients:[NSArray arrayWithObject:@"support@kafeidev.com"]];
                        [controller setSubject:@"意见反馈"];
                        [controller setMessageBody:@"\n\n谢谢您的宝贵意见,我们会尽快改进\n咖啡科技工作室 " isHTML:NO];
                        [self presentModalViewController:controller animated:YES];
                    } else {
                        Alert2(@"您的设备不能发送邮件\n请检查");
                    }
                   
                   
                }
                    break;
//                case 2:
//                    [MobClick event:@"checkUpdate"];
//                    [self getVersion];
//                    break;

                case 1:
                    [MobClick event:@"aboutme"];
                    controller =[[[AboutMeViewController alloc]initWithNibName:@"AboutMeViewController" bundle:nil]autorelease];
                    break;
                case 2:
                    [MobClick event:@"rateme"];
                    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=661040207"]];
                    break;
                case 3:
                    [MobClick event:@"sponsorme"];
                  
                    break;
                     case 4:
                    controller =[[[WifiViewController alloc]initWithNibName:@"WifiViewController" bundle:nil]autorelease];
                    break;
            }
        }
            break;
    }
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case tag_alert_clear_cache:
            
            break;
        case tag_alert_upgrade:
            
            break;
            
        default:
            break;
    }
    
    
}





- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

/*
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewSection = [[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 20)]autorelease];
    UILabel *textSection = [[UILabel alloc] initWithFrame:CGRectMake(10,5, 300, 20)];
    textSection.text = section==0?@"分享账户":@"管理";
    textSection.backgroundColor = [UIColor clearColor];
    textSection.font = [UIFont systemFontOfSize:14.0f];
    [viewSection addSubview:textSection];
    [textSection release];
    return viewSection ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
*/
-(NSString*)getIndexKey:(int)section{
    return @"syssettring";
    /*
    NSString* key=nil;
    switch (section) {
        case 0:
            key=@"sns";
            break;
        case 1:
            key=@"syssettring";
            break;
            
        default:
            break;
    }
    return key;
     */

}


#pragma mark - Rotation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}
//判断ui是否会随设备而旋转，先于supportedInterfaceOrientations执行
-(BOOL)shouldAutorotate{
    return NO;
}
//设置ui支持的设备方向，需要和info.plist的target设置一样，
//在shouldAutorotate返回YES时候才回执行
//如果navigation的下一个view旋转了，返回时候，会根据这个函数来判断view的方向
//判断是和另一个view一样旋转，还是保持自己原来的状态
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
