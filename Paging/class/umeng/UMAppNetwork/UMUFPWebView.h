//
//  UMUFPWebView.h
//  UFP
//
//  Created by liu yu on 1/9/12.
//  Updated by liu yu on 05/09/13.
//  Copyright 2010-2013 Umeng.com. All rights reserved.
//  Version 3.5.5

#import <UIKit/UIKit.h>

/**
 
 UMUFPWebView is a subclass of UIWebView that supports Ads impression in webview.
 
 */

@interface UMUFPWebView : UIWebView {
@private
    NSString *_mAppkey;
    NSString *_mSlotId;     
    NSString *_mKeywords;
    
    BOOL _mAutoFill;
}

@property (nonatomic) BOOL  mAutoFill; //shows whether automatic add other promoters when data of this position is not enough
@property (nonatomic, copy) NSString *mKeywords; //keywords for the promoters data, promoter list will return according to this property, default is @""

/** 
 
 This method return a UMUFPWebView object
 
 @param  frame frame for the UMUFPWebView 
 @param  appkey appkey get from www.umeng.com, if you want use ufp service only, set this parameter empty
 @param  slotId slotId get from ufp.umeng.com
 
 @return a UMUFPWebView object
 */

- (id)initWithFrame:(CGRect)frame appKey:(NSString *)appkey slotId:(NSString *)slotId;

/** 
 
 This method start the releated url request load
 
 */

- (void)startLoadRequest;

/** 
 
 This method set channel for this app, the default channel is App Store, call this method if you want to set channel for another value, don't need to call this method among different views, only once is enough
 
 @param  channel channel name for the app
 
 */

+ (void)setAppChannel:(NSString *)channel;

@end

