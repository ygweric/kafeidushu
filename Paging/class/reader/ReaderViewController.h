//
//  ViewController.h
//  Paging
//
//  Created by Eric Yang on 13-5-23.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeavesViewController.h"
#import "Utilities.h"


@interface ReaderViewController : LeavesViewController
@property (retain, nonatomic) UILabel *lbContent;
@property (retain, nonatomic) UIView *vPageBg;
@property (retain, nonatomic) UILabel *lbContentAdapter;
@property (retain, nonatomic) UILabel *pageInfoLabel;
@property (retain, nonatomic) NSString* text;
@property (retain, nonatomic) NSString *filePath;
@property (retain, nonatomic) NSString *fileName;
@property (retain, nonatomic) UITextField *tvJumpTo;
@property (retain, nonatomic) NSString* pagingContent; //解析出来的string

@property (retain, nonatomic) UIView* vMenu;
@property (retain,nonatomic)UIButton* btMenuTool;
@property (retain,nonatomic)UIButton* btMenuSet;

@property (retain, nonatomic) UIView* vMenuTool;
@property (retain, nonatomic) UIView* vMenuJump;
@property (retain, nonatomic) UIView* vMenuSetting;
@property (retain, nonatomic) UIView* vJump;
@property (retain, nonatomic) UIView* vTheme;
@property (retain, nonatomic) UIView* vFont;



- (IBAction)jumpTo:(id)sender;

- (IBAction)actionPrevious:(id)sender ;

////////////////////////////////////////////////////////////////////////////////////////
// 下一页
- (IBAction)actionNext:(id)sender ;

-(void)jumpToOffsetWithLeaves:(long long)offset;

@end
