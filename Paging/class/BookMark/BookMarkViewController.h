//
//  BookMarkViewController.h
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSArray* bookMarks;
@property (nonatomic,retain) UITableView* tbvBookMarks;

@end
