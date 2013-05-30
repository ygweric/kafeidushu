//
//  PageInfoManage.m
//  Paging
//
//  Created by Eric Yang on 13-5-30.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//

#import "PageInfoManage.h"


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

-(void)setPI:(PageInfo*)pi index:(int)index offset:(unsigned long long)offset{
    pi.pageIndex=index;
    pi.dataOffset=offset;
    pi.isValid=YES;
}
-(void)invalidPI:(PageInfo*)pi {
    pi.isValid=NO;
}
#pragma mark setPI
-(void)setPICurrentMIndex:(int)index offset:(unsigned long long)offset{
    [self setPI:currentPI_M index:index offset:offset];
}
-(void)setPICurrentMMIndex:(int)index offset:(unsigned long long)offset{
    [self setPI:currentPI_MM index:index offset:offset];
}
-(void)setPICurrentIndex:(int)index offset:(unsigned long long)offset{
    [self setPI:currentPI index:index offset:offset];
}
-(void)setPICurrentAIndex:(int)index offset:(unsigned long long)offset{
    [self setPI:currentPI_A index:index offset:offset];
}
-(void)setPICurrentAAIndex:(int)index offset:(unsigned long long)offset{
    [self setPI:currentPI_AA index:index offset:offset];
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

@end
