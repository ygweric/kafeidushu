//
//  BookMarkViewController.m
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "BookMarkViewController.h"
#import "BookMark.h"

@interface BookMarkViewController ()

@end

@implementation BookMarkViewController
@synthesize bookMarks=_bookMarks,tbvBookMarks=_tbvBookMarks;


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
    
    self.tbvBookMarks=[[[UITableView alloc]initWithFrame:self.view.frame]autorelease];
    _tbvBookMarks.delegate=self;
    _tbvBookMarks.dataSource=self;
    [self.view addSubview:_tbvBookMarks];
    

    
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"bookmark";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];    
    if (cell==nil) {
        cell=[[[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 320, 22)]autorelease];
    }
    BookMark* bm= [ _bookMarks objectAtIndex:indexPath.row];
    cell.textLabel.text=bm.desc;
    return cell;
    
}


@end
