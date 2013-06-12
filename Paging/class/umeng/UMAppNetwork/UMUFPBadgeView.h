//
//  UMUFPBadgeView.h
//  UFP
//
//  Created by liu yu on 04/02/13.
//  Updated by liu yu on 05/09/13.
//  Copyright 2010-2013 Umeng.com. All rights reserved.
//  Version 3.5.5

#import <UIKit/UIKit.h>

/**
 
 UMUFPBadgeView is a class for new promoter notice.
 
 */

@interface UMUFPBadgeView : UIView
{
    UILabel *badgeNumberLabel;
}

@property (nonatomic) BOOL shouldShowBadgeNumberLabel; // Default is YES
@property (nonatomic, retain) UIImageView *badgeBackgroundView; // Background view for the badge

/**
 
 This method update number of unread messages 
 
 @param unreadCount number of unread messages, possible values: -1(no unread emssage), 0(many unread message), a positive integer
 
 */

- (void)updateNewMessageCount:(NSInteger)unreadCount;

@end
