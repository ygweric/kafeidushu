//
//  PageInfoManage.m
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "PageInfoManage.h"

@implementation PageInfoScale

@synthesize maxPageInfo,minPageInfo;

@end
@implementation PageInfoManage
@synthesize currentPI,currentPI_A,currentPI_AA,currentPI_M,currentPI_MM;

-(id)init{
    if ([super init]) {
        self.currentPI=[[[PageInfo alloc]init]autorelease];
        self.currentPI_A=[[[PageInfo alloc]init]autorelease];
        self.currentPI_AA=[[[PageInfo alloc]init]autorelease];
        self.currentPI_M=[[[PageInfo alloc]init]autorelease];
        self.currentPI_MM=[[[PageInfo alloc]init]autorelease];
    }
    return self;
}

-(void)setPI:(PageInfo*)pi index:(int)index offset:(unsigned long long)offset length:(int)length{
    pi.pageIndex=index;
    pi.dataOffset=offset;
    pi.pageLength=length;
    pi.isValid=YES;
}
-(void)invalidPI:(PageInfo*)pi {
    pi.isValid=NO;
}
#pragma mark setPI
-(void)setPICurrentMIndex:(int)index offset:(unsigned long long)offset length:(int)length{
    [self setPI:currentPI_M index:index offset:offset length:length];
}
-(void)setPICurrentMMIndex:(int)index offset:(unsigned long long)offset length:(int)length{
    [self setPI:currentPI_MM index:index offset:offset length:length];
}
-(void)setPICurrentIndex:(int)index offset:(unsigned long long)offset length:(int)length{
    [self setPI:currentPI index:index offset:offset length:length];
}
-(void)setPICurrentAIndex:(int)index offset:(unsigned long long)offset length:(int)length{
    [self setPI:currentPI_A index:index offset:offset length:length];
}
-(void)setPICurrentAAIndex:(int)index offset:(unsigned long long)offset length:(int)length{
    [self setPI:currentPI_AA index:index offset:offset length:length];
}
#pragma mark invalid
-(void)invalidPICurrent{
    [self invalidPI:currentPI];
}
-(void)invalidPICurrentM{
    [self invalidPI:currentPI_M];
}
-(void)invalidPICurrentMM{
    [self invalidPI:currentPI_MM];
}
-(void)invalidPICurrentA{
    [self invalidPI:currentPI_A];
}
-(void)invalidPICurrentAA{
    [self invalidPI:currentPI_AA];
}
#pragma mark -
-(PageInfo*)getPageInfoAtIndex:(int)index{
    if (currentPI.isValid && currentPI.pageIndex==index) {
        return currentPI;
    } else if(currentPI_A.isValid && currentPI_A.pageIndex==index){
        return currentPI_A;
    } else if(currentPI_AA.isValid && currentPI_AA.pageIndex==index){
        return currentPI_AA;
    } else if(currentPI_M.isValid && currentPI_M.pageIndex==index){
        return currentPI_M;
    } else if(currentPI_MM.isValid && currentPI_MM.pageIndex==index){
        return currentPI_MM;
    } else {
        return nil;
    }
}
-(void)printAllPageInfos{
//    NSLog(@"printAllPageInfos----\n\
          +++++++++++++++++++ start ++++\n\
          currentPI_MM:%@,\ncurrentPI_M:%@,\ncurrentPI:%@,\ncurrentPI_A:%@,\ncurrentPI_AA:%@\n\
          +++++++++++++++++++ end ++++",currentPI_MM,currentPI_M,currentPI,currentPI_A,currentPI_AA);
}


-(PageInfoScale*)getPageInfoScale{
    [self printAllPageInfos];
    PageInfoScale* pis=[[[PageInfoScale alloc]init]autorelease];
    pis.maxPageInfo=currentPI;
    pis.minPageInfo=currentPI;
    
    
    if (currentPI_A.isValid) {
        pis.maxPageInfo=currentPI_A;
    }
    if(currentPI_AA.isValid){
        pis.maxPageInfo=currentPI_AA;
    }
    if (currentPI_M.isValid) {
        pis.minPageInfo=currentPI_M;
    }
    if(currentPI_MM.isValid){
        pis.minPageInfo=currentPI_MM;
    }
    return pis;
}

-(PageInfo*)getPageInfoByType:(PageInfoType) pit{
    switch (pit) {
        case e_current:
            return currentPI;
            break;
        case e_current_a:
            return currentPI_A;
            break;
        case e_current_aa:
            return currentPI_AA;
            break;
        case e_current_m:
            return currentPI_M;
            break;
        case e_current_mm:
            return currentPI_MM;
            break;
    }
}

-(PageInfo*)getPageInfoByIndex:(int)index{
    [self printAllPageInfos];

    if (currentPI.isValid && currentPI.pageIndex==index) {
        return currentPI;
    }
    if (currentPI_A.isValid && currentPI_A.pageIndex==index) {
        return currentPI_A;
    }
    if(currentPI_AA.isValid && currentPI_AA.pageIndex==index){
        return currentPI_AA;
    }
    if (currentPI_M.isValid && currentPI_M.pageIndex==index) {
        return currentPI_M;
    }
    if(currentPI_MM.isValid && currentPI_MM.pageIndex==index){
        return currentPI_MM;
    }
    return nil;


}



@end


