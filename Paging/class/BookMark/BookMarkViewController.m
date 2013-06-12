//
//  BookMarkViewController.m
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookMarkViewController.h"
#import "BookMark.h"
#import "BookMarkManage.h"

@interface BookMarkViewController ()

@end

@implementation BookMarkViewController
@synthesize bookMarks=_bookMarks,tbvBookMarks=_tbvBookMarks;
@synthesize readerVC=_readerVC;


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
    self.wantsFullScreenLayout=NO;
    self.tbvBookMarks=[[[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height)]autorelease];
    _tbvBookMarks.delegate=self;
    _tbvBookMarks.dataSource=self;
    [self.view addSubview:_tbvBookMarks];
    
     [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"返回"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = flipButton;
    
}
-(void)goBack:(id)sender{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _bookMarks.count;
}
#define TAG_PERCENT 101
#define TAG_TIME 102
#define TAG_DESC 103
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"bookmark";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];    
    if (cell==nil) {
        cell=[[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 46)]autorelease];
        UILabel *lbPercent=[[[UILabel alloc]initWithFrame:CGRectMake(10, 2, 100, 22)]autorelease];
        lbPercent.font=[UIFont systemFontOfSize:10];
        lbPercent.tag=TAG_PERCENT;
        [cell addSubview:lbPercent];
        UILabel *lbTime=[[[UILabel alloc]initWithFrame:CGRectMake(200, 2, 100, 22)]autorelease];
        lbTime.font=[UIFont systemFontOfSize:10];
        lbTime.tag=TAG_TIME;
        [cell addSubview:lbTime];
        UILabel *lbDesc=[[[UILabel alloc]initWithFrame:CGRectMake(5, 24, 310, 22)]autorelease];
        lbDesc.font=[UIFont systemFontOfSize:12];
        lbDesc.tag=TAG_DESC;
        [cell addSubview:lbDesc];
    }
    BookMark* bm= [ _bookMarks objectAtIndex:indexPath.row];
    UILabel* lbPercent=(UILabel*)[cell viewWithTag:TAG_PERCENT];
    lbPercent.text=[NSString stringWithFormat:@"%0.2f %@",bm.percent*100,@"%"];
    
    UILabel* lbTime=(UILabel*)[cell viewWithTag:TAG_TIME];
    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init]autorelease];
    [dateFormatter setDateFormat:@"MM-dd h:MM:ss a"];
    NSString* dataStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:bm.time]];
    lbTime.text=dataStr;
    

    UILabel* lbDesc=(UILabel*)[cell viewWithTag:TAG_DESC];
    
    lbDesc.text=bm.desc;

    
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_bookMarks removeObjectAtIndex:indexPath.row];
        [[BookMarkManage share]cacheBookMarks];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
        
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    BookMark* bi=[_bookMarks objectAtIndex:indexPath.row];
    [_readerVC jumpToOffsetWithLeaves:bi.offset];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
