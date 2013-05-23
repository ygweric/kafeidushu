//
//  ViewController.h
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *lbContent;
@property (retain, nonatomic) IBOutlet UILabel *pageInfoLabel;


- (IBAction)actionPrevious:(id)sender ;

////////////////////////////////////////////////////////////////////////////////////////
// 下一页
- (IBAction)actionNext:(id)sender ;
@end
