//
//  RJCommentView.m
//  RJTxtReader
//
//  Created by Zeng Qingrong on 12-8-23.
//
//

#import "RJCommentView.h"


@implementation RJCommentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadTableView];
    }
    return self;
}






-(void) loadTableView
{
    //加上背景
    CGRect rect = CGRectMake(0, 0, 320, 480-45);
    UIImageView* backView = [[UIImageView alloc]initWithFrame:rect];
    backView.image = [UIImage imageNamed:@"background.jpg"];
    //显示推荐列表
    dataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-45)];
    [dataTable setDelegate:self];
    [dataTable setDataSource:self];
    [dataTable setBackgroundView:backView];
    [self addSubview:dataTable];
    [backView release];
    [dataTable release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [name count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"placeholder"]];
    cell.textLabel.text=[name objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

//选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url objectAtIndex:indexPath.row]]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
