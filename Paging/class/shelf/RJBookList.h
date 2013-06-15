//
//  RJBookList.h
//  RJTxtReader
//
//  Created by Zeng Qingrong on 12-8-23.
//
//

#import <UIKit/UIKit.h>
#import "RJCommentView.h"
#import "RJBookData.h"
//#import "RJBookListViewController.h"


@interface RJBookList : UIScrollView <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

{
    UIScrollView* FirstView;
    RJCommentView* SecondView;
    RJBookData* bookData;
    UITableView* bookTableView;
    BOOL isTableViewShow;
    UINavigationController* nc;
    UIViewController* blVC;
}

@property(nonatomic,assign) UINavigationController* nc;
@property (nonatomic,retain) UIViewController* blVC;
-(void) initView;
-(void) doReadBook:(id)sender;
-(void) readBook:(NSInteger)i;
-(void) doTableViewShowOrHide;
-(void) readBookWithPath:(NSString*)bookPath;

@end
