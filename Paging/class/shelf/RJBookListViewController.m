//
//  RJBookListViewController.m
//  RJTxtReader
//
//  Created by joey on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RJBookListViewController.h"


@interface RJBookListViewController ()

@end

@implementation RJBookListViewController

- (id)init
{

    self = [super init];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[RJBookData sharedRJBookData] loadBookList];
    // Do any additional setup after loading the view from its nib.
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"shelf_top.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController setToolbarHidden:YES animated:TRUE];

    CGRect rect = CGRectMake(140, 0, 40, 44);
    UILabel *titleView = [[UILabel alloc] initWithFrame:rect];
    titleView.opaque = YES;
    titleView.backgroundColor = [UIColor clearColor];
    titleView.text = @"书架";
    titleView.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleView;
    [titleView release];
    
    UIImage* image= [UIImage imageNamed:@"button.png"];
    CGRect frame_1= CGRectMake(5, 5, 80, 30);
    UIButton* leftButton= [[UIButton alloc] initWithFrame:frame_1];
    [leftButton setBackgroundImage:image forState:UIControlStateNormal];
    [leftButton setTitle:@"列表" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [leftButton addTarget:self action:@selector(doList:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"列表" style:UIBarButtonItemStylePlain target:self action:@selector(doList:)];
    leftItem.customView = leftButton;
    [leftButton release];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftItem release];
    

    UIButton* rightButton= [[UIButton alloc] initWithFrame:frame_1];
    [rightButton setBackgroundImage:image forState:UIControlStateNormal];
    [rightButton setTitle:@"刷新" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(refreshBooks:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] init];
    rightItem.customView = rightButton;
    [rightButton release];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
    
    
    [self showBookShelf];
    
//    rect = CGRectMake(150, 445, 20, 10);
//    pageControl = [[UIPageControl alloc] initWithFrame:rect];
//    pageControl.numberOfPages = 1;
//    pageControl.currentPage = 0;
//    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:pageControl];
    
//    [pageControl release];
}
-(void)showBookShelf{
    if (listView) {
        [listView removeFromSuperview];
        
    }
    
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.view.frame = rect;
    listView = [[[RJBookList alloc]initWithFrame:rect] autorelease];
    listView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    listView.pagingEnabled = YES;
    listView.delegate = self;
    listView.nc = self.navigationController;
    [self.view addSubview:listView];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = listView.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    pageControl.currentPage = page;//pagecontroll响应值的变化
    
    UIButton* rightButton = (UIButton*)self.navigationItem.rightBarButtonItem.customView;
    
    if(listView.contentOffset.x > 160)
    {
        [rightButton setTitle:@"返回" forState:UIControlStateNormal];
        ((UILabel*)self.navigationItem.titleView).text = @"推荐";
    }
    else
    {
        [rightButton setTitle:@"推荐" forState:UIControlStateNormal];
        ((UILabel*)self.navigationItem.titleView).text = @"书架";
    }
}

- (IBAction)doList:(id)sender
{
    if(listView.contentOffset.x > 0)
    {
        [self gotoPage:0];
    }
    [listView doTableViewShowOrHide];
    UILabel* titlView = (UILabel*)self.navigationItem.titleView;
    UIButton* leftButton = (UIButton*)self.navigationItem.leftBarButtonItem.customView;
    if([leftButton.titleLabel.text isEqualToString: @"书架"])
    {
        titlView.text = @"书架";
        [leftButton setTitle:@"列表" forState:UIControlStateNormal];
    }
    else
    {
        titlView.text = @"列表";
        [leftButton setTitle:@"书架" forState:UIControlStateNormal];
    }
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;//获取当前pagecontroll的值
    [self gotoPage:page];
}

- (IBAction)doComment:(id)sender
{
    if(listView.contentOffset.x /320 == 0)
        [self gotoPage:1];
    else
        [self gotoPage:0];
}

- (IBAction)refreshBooks:(id)sender
{
     [[RJBookData sharedRJBookData] loadBookList];
    [self showBookShelf];
}

- (void) gotoPage:(int) pageNum
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:YES];
    [listView setContentOffset:CGPointMake(320 * pageNum, 0)];
    [UIView commitAnimations];
    
}



@end
