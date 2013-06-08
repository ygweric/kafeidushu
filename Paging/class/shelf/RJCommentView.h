//
//  RJCommentView.h
//  RJTxtReader
//
//  Created by Zeng Qingrong on 12-8-23.
//
//

#import <UIKit/UIKit.h>

@interface RJCommentView : UIView <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* name;
    NSMutableArray* icon;
    NSMutableArray* url;
    UITableView* dataTable;
}


-(void) loadTableView;


@end
