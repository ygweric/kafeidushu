//
//  PageInfoManage.h
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageInfo.h"

typedef enum{
    e_current_mm=101,
    e_current_m,
    e_current,
    e_current_a,
    e_current_aa,
}PageInfoType ;

@interface  PageInfoScale: NSObject
@property (nonatomic,retain) PageInfo* maxPageInfo;
@property (nonatomic,retain) PageInfo* minPageInfo;
@end

@interface PageInfoManage : NSObject
@property (retain,nonatomic) PageInfo* currentPI_MM; //minus
@property (retain,nonatomic) PageInfo* currentPI_M;
@property (retain,nonatomic) PageInfo* currentPI;
@property (retain,nonatomic) PageInfo* currentPI_A;
@property (retain,nonatomic) PageInfo* currentPI_AA; //add


//-(void)setPI:(PageInfo*)pi index:(int)index offset:(unsigned long long)offset;
//-(void)invalidPI:(PageInfo*)pi ;

/*
-(void)setPICurrentMIndex:(int)index offset:(unsigned long long)offset;
-(void)setPICurrentMMIndex:(int)index offset:(unsigned long long)offset;
-(void)setPICurrentIndex:(int)index offset:(unsigned long long)offset;
-(void)setPICurrentAIndex:(int)index offset:(unsigned long long)offset;
-(void)setPICurrentAAIndex:(int)index offset:(unsigned long long)offset;
#pragma mark invalid
-(void)invalidPICurrent;
-(void)invalidPICurrentM;
-(void)invalidPICurrentMM;
-(void)invalidPICurrentA;
-(void)invalidPICurrentAA;
 //*/


-(PageInfo*)getPageInfoAtIndex:(int)index;
-(PageInfoScale*)getPageInfoScale;
-(PageInfo*)getPageInfoByType:(PageInfoType) pit;
-(PageInfo*)getPageInfoByIndex:(int)index;
@end








