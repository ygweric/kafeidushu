//
//  UMUFPGridView.h
//  UFP
//
//  Created by liu yu on 7/23/12.
//  Updated by liu yu on 05/09/13.
//  Copyright 2010-2013 Umeng.com. All rights reserved.
//  Version 3.5.5

#import <UIKit/UIKit.h>
#import "UMUFPGridCell.h"
#import "UMUFPTableView.h"

@class IndexPath;
@class UMUFPDataLoader;

@protocol GridViewDelegate;
@protocol GridViewDataSource;
@protocol GridViewDataLoadDelegate;

/**
 
 The UMUFPGridView class defines a container that can show multi columns of cells in a single view.
 
 */

@interface UMUFPGridView : UIView <UITableViewDelegate,UITableViewDataSource> {
@private
    NSInteger _mColumnCountPerPage; 
    
    id<GridViewDelegate> _delegate;
    id<GridViewDataSource> _datasource;
    id<GridViewDataLoadDelegate> _dataLoadDelegate;
}

@property (nonatomic, copy) NSString *mKeywords;  //keywords for the promoters data, promoter list will return according to this property, default is @""
@property (nonatomic)           BOOL mAutoFill;   //shows whether automatic add other promoters when data of this position is not enough

@property (nonatomic, readonly) NSInteger mAppsCountPerPage;                 //maximum number of apps per page, default is 15
@property (nonatomic, readonly) NSInteger mColumnCountPerPage;               //number of columns per page
@property (nonatomic, assign) id<GridViewDelegate>   delegate;               //delegate for view
@property (nonatomic, assign) id<GridViewDataSource> datasource;             //delegate for data
@property (nonatomic, assign) id<GridViewDataLoadDelegate> dataLoadDelegate; //dataLoadDelegate for gridview

@property (nonatomic, retain) UMUFPDataLoader  *mDataLoder;
@property (nonatomic, readonly) NSMutableArray *mPromoterDatas;              //loaded promoters data

/** 
 
 This method return a UMUFPGridView object
 
 @param  frame frame for the UMUFPGridView 
 @param  appkey appkey get from www.umeng.com, if you want use ufp service only, set this parameter empty
 @param  slotId slotId get from ufp.umeng.com
 @param  controller view controller releated to the view that the table view added into
 
 @return a UMUFPGridView object
 
 */

- (id)initWithFrame:(CGRect)frame appkey:(NSString *)appkey slotId:(NSString *)slotId currentViewController:(UIViewController *)controller;

/** 
 
 This method start the promoter data load in background, promoter data will be load until this method called
 
 */

- (void)requestPromoterDataInBackground;

/** 
 
 This method request more promoter data in background, should called after requestPromoterDataInBackground, as some initialization should be done in requestPromoterDataInBackground
 
 */

- (void)requestMorePromoterInBackground;

/** 
 
 This method will reload promoter data for gridview
 
 */

- (void)reloadData;  

/** 
 
 This method return index of promoter data in the promoters array
 
 @param  indexPath indexpath of the promoter to be checked
 
 @return a NSInteger value
 
 */

- (NSInteger)arrayIndexForIndexPath:(IndexPath*)indexPath;

@end

/**
 
 GridViewDelegate is a protocol that defines display releated methods for UMUFPGridView
 Optional methods of the protocol allow the delegate to manage selections, configure cell height, and perform other actions.
 
 */

@protocol GridViewDelegate <NSObject>

@optional

- (void)gridView:(UMUFPGridView *)gridView didSelectRowAtIndexPath:(IndexPath *)indexPath;    //called when item at indexPath clicked
- (CGFloat)gridView:(UMUFPGridView *)gridView heightForRowAtIndexPath:(IndexPath *)indexPath; //default is 80.0f

@end

/**
 
 The GridViewDataSource protocol is adopted by an object that mediates the application's data model for a UMUFPGridView object. The data source provides the grid-view object with the information it needs to construct and modify a grid view.
 
 */

@protocol GridViewDataSource <NSObject>

@required

- (NSInteger)numberOfColumsInGridView:(UMUFPGridView *)gridView; //number of columns per page
- (UIView *)gridView:(UMUFPGridView *)gridView cellForRowAtIndexPath:(IndexPath *)indexPath; //view for indexPath, has reuse mechanism
- (void)gridView:(UMUFPGridView *)gridView relayoutCellSubview:(UIView *)view withIndexPath:(IndexPath *)indexPath; //content for the releated cell

@optional

- (NSInteger)numberOfAppsPerPage:(UMUFPGridView *)gridView;

@end

/**
 
 GridViewDataLoadDelegate is a protocol that defines data loading releated methods for UMUFPGridView
 Optional methods of the protocol allow the delegate to capture data loading releated events, and perform other actions.
 
 */

@protocol GridViewDataLoadDelegate <NSObject>

@optional

- (void)UMUFPGridViewDidLoadDataFinish:(UMUFPGridView *)gridView promotersAmount:(NSInteger)promotersAmount; //called when promoter list loaded, [Attention:reloadData will called automaticlly on this point]
- (void)UMUFPGridView:(UMUFPGridView *)gridView didLoadDataFailWithError:(NSError *)error; //called when promoter list loaded failed for some reason

@end
