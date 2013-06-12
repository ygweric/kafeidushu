//
//  UMUFPGridCell.h
//  UFP
//
//  Created by liu yu on 7/23/12.
//  Updated by liu yu on 05/09/13.
//  Copyright 2010-2013 Umeng.com. All rights reserved.
//  Version 3.5.5

#import <UIKit/UIKit.h>

@class IndexPath;

/**
 
 The UMUFPGridCell class defines the attributes and behavior of the cells that appear in UMUFPGridView objects.
 
 */

@interface UMUFPGridCell : UIView
{
    int _columnCount; 
    IndexPath *_indexPath; 
    NSString  *_strReuseIndentifier; 
}

@property (nonatomic) int     columnCount; 
@property (nonatomic, retain) IndexPath *indexPath;
@property (nonatomic, retain) NSString  *strReuseIndentifier;

/**
 
 This method return a UMUFPGridCell object
 
 @param  indentifier indentifier for cell reuse
 
 @return a UMUFPGridCell object
 
 */

- (id)initWithIdentifier:(NSString *)indentifier;
- (void)relayoutViews;

@end

/**
 
 The IndexPath class defines position of cells that appear in UMUFPGridView objects.
 
 */

@interface IndexPath : NSObject
{
    int _row;       
    int _column;   
}

@property(nonatomic) int row; //row number, start from 0
@property(nonatomic) int column; //column number, start from 0

/**
 
 This method return a IndexPath object
 
 @param  indexRow row number
 @param  indexColumn column number
 
 @return a IndexPath object
 */

+ (IndexPath *)initWithRow:(int)indexRow withColumn:(int)indexColumn;

@end