//
//  RJBookList.m
//  RJTxtReader
//
//  Created by Zeng Qingrong on 12-8-23.
//
//

#import "RJBookList.h"
#import "ReaderViewController.h"


@implementation RJBookList
@synthesize nc;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        isTableViewShow = NO;
        [self initView];
    }
    return self;
}

-(void) initView
{
    bookData = [RJBookData sharedRJBookData];
    


    CGRect rect = CGRectMake(0, 44, 320, 145*7);
    
    FirstView = [[[UIScrollView alloc]initWithFrame:rect]autorelease];

    UIImage* rowImage = [UIImage imageNamed:@"shelf_row.png"];
    
    for (int i=-2; i<5; i++) {
        rect = CGRectMake(0, 138*i, 320, 145);
        UIImageView * row = [[[UIImageView alloc] initWithFrame:rect]autorelease];
        row.image = rowImage;
        [FirstView addSubview:row];
    }
    
   

    int bookCount= [bookData.books count];
   int rowCount=(bookCount-1)/3 + 1;
    
    FirstView.contentSize=CGSizeMake(320, 145*8);
    if(rowCount>4)
    {        
        FirstView.contentSize = CGSizeMake(320, (rowCount+4)*145);
        for (int i=4; i<rowCount+4; i++) {
            rect = CGRectMake(0, 138*i, 320, 145);
            UIImageView * rowN = [[[UIImageView alloc] initWithFrame:rect]autorelease];
            rowN.image = rowImage;
            [FirstView addSubview:rowN];
        }        
    }
    
    [self addSubview:FirstView];
    
    
    for(int i=0;i<[bookData.books count];i++)
    {
        
        RJSingleBook* singleBook = [bookData.books objectAtIndex:i];
        
        rect = CGRectMake(20+(i%3*100), 35+(i/3)*138, 65, 85);
        UIButton* button= [[[UIButton alloc]initWithFrame:rect]autorelease];
        button.tag = i;
        [button setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:singleBook.icon ofType:nil]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doReadBook:) forControlEvents:UIControlEventTouchUpInside];
        [FirstView addSubview:button];
        [FirstView bringSubviewToFront:button];
        
        rect = CGRectMake(20+(i%3*100), 35+(i/3)*138-35, 65, 40);
//        rect = CGRectMake(20+(i%3*100), 35+(i/3)*138+85, 65, 20);
        UILabel* lbTitle= [[[UILabel alloc]initWithFrame:rect]autorelease];
        lbTitle.text=singleBook.name;
        lbTitle.backgroundColor=[UIColor clearColor];
        lbTitle.font=[UIFont systemFontOfSize:12];
        lbTitle.numberOfLines=0;
        lbTitle.lineBreakMode=NSLineBreakByWordWrapping;
        lbTitle.textAlignment = UITextAlignmentCenter;
        [FirstView addSubview:lbTitle];
        [FirstView bringSubviewToFront:lbTitle];
        
    }
    
    /*
    imageView = [[UIImageView alloc] initWithImage:
                 [UIImage imageNamed:@"background.jpg"]];
    rect = CGRectMake(320, 0, 320, 45);
    imageView.frame =rect;
    [self addSubview:imageView];
    [imageView release];
    
    rect = CGRectMake(320, 45, 320, 480-45);
    SecondView = [[RJCommentView alloc]initWithFrame:rect];
    [self addSubview:SecondView];
     */

}

-(void) doReadBook:(id)sender
{
    UIButton* but = (UIButton*)sender;
    NSInteger i = but.tag;
	[self readBook:i];
}

-(void) readBook:(NSInteger)i
{
    
    ReaderViewController *readerVC = [[[ReaderViewController alloc]init]autorelease];
     RJSingleBook* singleBook = [bookData.books objectAtIndex:i];
    readerVC.filePath=singleBook.bookPath;
    UINavigationController* navVC=[[[UINavigationController alloc]initWithRootViewController:readerVC]autorelease];
//	[self.nc pushViewController:readerVC animated:YES];
    [self.nc presentModalViewController:navVC animated:YES];
}

-(void) doTableViewShowOrHide
{
    if(isTableViewShow == NO)
    {
        isTableViewShow = YES;
        if(bookTableView == nil)
        {
            bookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 320, 480-45)];
            [bookTableView setDelegate:self];
            [bookTableView setDataSource:self];
            bookTableView.hidden = YES;
            [self addSubview:bookTableView];
            [bookTableView release];
        }
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.8f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
        
        bookTableView.hidden = NO;
        FirstView.hidden = YES;
        [UIView commitAnimations];
        

    }
    else{
        isTableViewShow = NO;

        
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:0.8f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
        
        bookTableView.hidden = YES;
        FirstView.hidden = NO;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [bookData.books count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier] autorelease];
    }
    RJSingleBook* singleBook = [bookData.books objectAtIndex:indexPath.row];
    
    [cell.imageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:singleBook.icon ofType:nil]]];
    cell.textLabel.text=singleBook.name;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    return cell;
}

//选择事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self readBook:indexPath.row];
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
