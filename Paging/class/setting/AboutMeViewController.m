//
//  AboutMeViewController.m
//  Yunho2
//
//  Created by user on 12-8-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutMeViewController.h"
@interface AboutMeViewController ()

@end

@implementation AboutMeViewController
@synthesize lbVersion;
@synthesize lbBuild;
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
    self.navigationItem.title = @"关于我们";
    // Do any additional setup after loading the view from its nib.
    

    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString * build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    NSLog(@"version:%@,build:%@",version,build);

    self.lbVersion.text = version;
    self.lbBuild.text = build;
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
