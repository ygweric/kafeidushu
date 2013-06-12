//
//  UMSocialBar.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-9-13.
//  Copyright (c) umeng.com All rights reserved.
//
#import "UMSocialData.h"
#import "UMSocialControllerServiceComment.h"

/**
 按钮类型
 
 */
typedef enum {
    UMSButtonTypeAddComment = 1,              //添加评论
    UMSButtonTypeShareToSNS,                  //分享到微博
    UMSButtonTypeAddLike,                     //添加喜欢
    UMSButtonTypeDisLike,                     //取消喜欢
} UMSButtonType;

/**
 按钮类型组合
 
 */
typedef enum {
    UMSButtonTypeMaskAddComment = (1 << UMSButtonTypeAddComment),   //添加评论
    UMSButtonTypeMaskShareToSNS = (1 << UMSButtonTypeShareToSNS),   //分享到微博
    UMSButtonTypeMaskAddLike = (1 << UMSButtonTypeAddLike),         //添加喜欢
    UMSButtonTypeMaskDisLike = (1 << UMSButtonTypeDisLike),         //取消喜欢
    UMSButtonTypeMaskCommentAndShare = (UMSButtonTypeMaskAddComment | UMSButtonTypeMaskShareToSNS),
    //评论并分享
    UMSButtonTypeMaskAll = (UMSButtonTypeAddLike | UMSButtonTypeAddComment | UMSButtonTypeShareToSNS),
    //喜欢、评论、分享
} UMSButtonTypeMask;


/**
 操作栏主题颜色
 
 */
typedef enum {
    UMSBarColorWhite = 1,              //白色
    UMSBarColorBlack,                  //黑色
} UMSBarColor;


@protocol UMSocialBarActionDelegate <NSObject>

-(void)likeButtonTouched;

-(void)commentButtonTouched;

-(void)shareButtonTouched;

-(void)accountButtonTouched;

@end

/**
 社会化操作栏对应的视图，你可以对此视图源代码进行自定义修改，例如修改显示是否出现数字，出现哪些按钮和修改按钮的响应
 
 
 ## 按钮类型
 
 typedef enum {
 UMSButtonTypeAddComment = 1,              //添加评论
 UMSButtonTypeShareToSNS,                  //分享到微博
 UMSButtonTypeAddLike,                     //添加喜欢
 UMSButtonTypeDisLike,                     //取消喜欢
 } UMSButtonType;
 
 
 ## 按钮类型组合
 
 typedef enum {
 UMSButtonTypeMaskAddComment = (1 << UMSButtonTypeAddComment),   //添加评论
 UMSButtonTypeMaskShareToSNS = (1 << UMSButtonTypeShareToSNS),   //分享到微博
 UMSButtonTypeMaskAddLike = (1 << UMSButtonTypeAddLike),         //添加喜欢
 UMSButtonTypeMaskDisLike = (1 << UMSButtonTypeDisLike),         //取消喜欢
 UMSButtonTypeMaskCommentAndShare = (UMSButtonTypeMaskAddComment | UMSButtonTypeMaskShareToSNS),                               //评论并分享
 UMSButtonTypeMaskAll = (UMSButtonTypeAddLike | UMSButtonTypeAddComment | UMSButtonTypeShareToSNS),                                   //喜欢、评论、分享
 } UMSButtonTypeMask;
 
 */
@interface UMSocialBarView : UIView

/**
 操作栏回调对象
 
 */
@property (nonatomic, unsafe_unretained) id<UMSocialBarActionDelegate> socialBarActionDelegate;

/**
 操作栏主题颜色，有白色和黑色
 
 */
@property (nonatomic, assign) UMSBarColor themeColor;

/**
 更新操作栏上的数字
 
 @param response 进行网络请求返回的对象，如果不是网络请求要刷新数字，可以设置为nil
 
 @return UMSButtonTypeMask 说明更新了哪几个操作栏的按钮,定义如上
 */
-(UMSButtonTypeMask)updateButtonNumber:(UMSocialResponseEntity *)response;

/**
 网络错误
 
 */
-(void) showError;

/**
 修改喜欢按钮的图片
 
 */
-(void) changeLikeButtonImage;
@end

/**
 `UMSocialControllerService`对象用到的一些回调方法，可以对出现的分享列表进行设置，或者得到一些完成事件的回调方法。
 */
@protocol UMSocialBarDelegate <NSObject>

/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param actionType 操作类型，返回是评论、分享微博或者喜欢,定义在`UMSocialBarView.h`
 */
-(void)didFinishUpdateBarNumber:(UMSButtonTypeMask)actionTypeMask;

@end

/**
 一个集成了多个社会化功能的工具栏，可以查看并添加评论、分享到微博、添加喜欢、查看用户信息等功能。
 你要用一个identifier标识符字符串和添加到的`UIViewController`对象来初始化，然后可以自己添加到你要添加到的`UIView`上，并自定义其位置。也可以通过他的socialData属性来获取分享数等。
 
 */
@interface UMSocialBar : UIView
<
    UMSocialDataDelegate,
    UMSocialUIDelegate
>

///---------------------------------------
/// @name 对象属性
///---------------------------------------

/**
 `UMSocialData`对象，可以通过该对象设置分享内嵌文字、图片，获取分享数等属性
 */
@property (nonatomic, readonly) UMSocialData *socialData;

/**
 `UMSocialControllerService`对象，可以通过该对象得到分享编辑页面等
 */
@property (nonatomic, readonly) UMSocialControllerServiceComment *socialControllerService;

/**
 `UMSocialBar`所弹出的分享页面要添加到的`UIViewController`对象
 */
@property (nonatomic, assign) UIViewController *presentingViewController;

/**
 实现回调协议`<UMSocialBarDelegate>`的对象
 */
@property (nonatomic, unsafe_unretained) id<UMSocialBarDelegate> socialBarDelegate;

/**
 操作栏对应的视图对象
 */
@property (nonatomic, retain) UMSocialBarView *socialBarView;

///---------------------------------------
/// @name 初始化方法
///---------------------------------------


/**
 初始化方法
 
 @param viewController `UMSocialBar`出现的分享列表、评论列表等`UINavigationCtroller`要添加到的`UIViewController`
 
 @return 初始化对象
 */
- (id)initWithViewController:(UIViewController *)viewController;


/**
 初始化方法
 
 @param socialData `UMSocialData`对象
 @param viewController `UMSocialBar`出现的分享列表、评论列表等`UINavigationCtroller`要添加到的`UIViewController`
 
 @return 初始化对象
 */
- (id)initWithUMSocialData:(UMSocialData *)socialData withViewController:(UIViewController *)viewController;

/**
 更新操作栏所对应的UMSocialData的identifier,获取此UMSocialData的数据，并重新刷新操作栏的数字
 
 @param identifier 标识此操作栏对应的UMSocialData的identifier字符串
 
 */
- (void)updateButtonNumberWithIdentifier:(NSString *)identifier;
@end