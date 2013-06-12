//
//  UMSConfigManager.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-9-15.
//  Copyright (c) umeng.com All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef __IPHONE_6_0
typedef enum {
    UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
    UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
    UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
    UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
    UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
    UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
    UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
} UIInterfaceOrientationMask;
#endif

/**
 SDK设置类，负责改变SDK功能配置
 
 */
@interface UMSocialConfig : NSObject

/**
 设置显示的sns平台类型
 
 @param platformNames  由`UMSocialEnum.h`定义的UMShareToSina、UMShareToTencent、UMShareToQzone、UMShareToRenren、UMShareToDouban、UMShareToEmail、UMShareToSms组成的NSArray
 */
+ (void)setSnsPlatformNames:(NSArray *)platformNames;

/**
设置sdk所有页面需要支持屏幕方向.

@param interfaceOrientations 一个bit map（位掩码），ios 6定义的`UIInterfaceOrientationMask`
*/
+ (void)setSupportedInterfaceOrientations:(UIInterfaceOrientationMask)interfaceOrientations;

/**
 设置官方微博账号,设置之后可以在授权页面有关注微博的选项，默认勾选，授权之后用户即关注官方微博，仅支持新浪微博和腾讯微博
 
 @param weiboUids  腾讯微博和新浪微博的key分别是`UMShareToSina`和`UMShareToTenc`,值分别是官方微博的uid
 */
+ (void)setFollowWeiboUids:(NSDictionary *)weiboUids;

/**
 设置新增加`UMSocialSnsPlatform`对象 
 @param snsPlatformArray `UMSocialSnsPlatform`组成的数组对象
 
 */
+ (void)addSocialSnsPlatform:(NSArray *)snsPlatformArray;

/**
 设置页面的背景颜色
 @param defaultColor 设置页面背景颜色
 
 */
+ (void)setDefaultColor:(UIColor *)defaultColor;

/**
 设置iPad页面的大小
 @param size 页面大小
 
 */
+ (void)setBoundsSizeForiPad:(CGSize)size;

/**
 设置分享编辑页面是否等待完成之后再关闭页面还是立即关闭，如果设置成YES，就是等待分享完成之后再关闭，否则立即关闭。默认等待分享完成之后再关闭。如果设置成立即关闭的话，需要用`UMSocialDataServie`的`- (void)setUMSoicalDelegate:(id <UMSocialDataDelegate>)delegate;`来设置回调对象来获取分享是否成功，如果回调对象的`responseCode`为`UMSResponseCodeAccessTokenExpired`的话是授权过期，新浪微博对于不同应用的过期时间不一样，这种情况下要利用sdk提供的授权页面需要重新授权。

 @param 是否同步分享
 
 */
+ (void)setShouldShareSynchronous:(BOOL)shouldShareSynchronous;

/**
 设置评论页面是否出现分享按钮，默认出现

 */
+ (void)setShouldCommentWithShare:(BOOL)shouldCommentWithShare;

/**
 设置评论页面是否出现分享地理位置信息的按钮，默认出现
 
 */
+ (void)setShouldCommentWithLocation:(BOOL)shouldCommentWithLocation;

+ (UMSocialConfig *)shareInstance;

/**
 设置是否支持新浪微博SSO，默认支持

 */
+ (void)setSupportSinaSSO:(BOOL)supportSinaSSO;
@end


/**
 此类用于自定义sdk出现的样式，例如导航栏和导航栏上的按钮。自定义的方式是需要写一个UMUIHelper的分类，然后覆盖你要自定义的方法。
 
 例如定义一个UMSocialUIHelper(UMSocial)，覆盖的方法是：
 
 ```
 
 +(void) customNavBackButton:(UIButton *)button WithTitle:(NSString *)title
 {
 button.frame = CGRectMake(0, 0, 50, 30);
 UIImage * normalImage = [UIImage imageNamed:@"UMS_nav_back_button_normal"];
 UIImage * tapImage = [UIImage imageNamed:@"UMS_nav_back_button_tap"];
 [button titleLabel].font = [UIFont boldSystemFontOfSize:13];
 [button setTitle:title forState:UIControlStateNormal];
 [button setTitle:title forState:UIControlStateHighlighted];
 [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
 [button setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:16 topCapHeight:10] forState:UIControlStateNormal];
 [button setBackgroundImage:[tapImage stretchableImageWithLeftCapWidth:16 topCapHeight:10] forState:UIControlStateHighlighted];
 }
 
 ```
 
 */

@interface UMSocialUIHelper : NSObject

/**
 自定义导航栏的返回按钮
 
 @param button 返回按钮设置
 
 @param title 需要设置的title
 */
+ (void) customNavBackButton:(UIButton *)button WithTitle:(NSString *)title;

/**
 自定义导航栏非返回的按钮
 
 @param button 非返回按钮设置
 
 @param title 需要设置的title
 */
+ (void) customNavButton:(UIButton *)button WithTitle:(NSString *)title;

/**
 自定义导航栏
 
 @param bar 导航栏
 */
+ (void) customNavBar:(UINavigationBar *) bar;

/**
 自定以取消地理位置的按钮
 
 @param button 取消地理位置的按钮
 
 @param title 需要设置的title
 */
+ (void) customCancelLocationButton:(UIButton *) button WithTitle:(NSString *) title;

/**
 自定义分享列表cell的样式
 
 @param cell 分享列表的UITableViewCell
 
 */
+ (void) customShareListCell:(UITableViewCell*)cell;

@end

