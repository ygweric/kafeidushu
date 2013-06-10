//
//  BookMark.h
//  Paging
//
//  Created by Eric Yang on 13-6-10.
//  Copyright (c) 2013年 Eric Yang. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface BookMark : NSObject

@property  long long offset;
@property (nonatomic,retain) NSString* desc;
@property NSTimeInterval time;

#pragma mark coding
-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;
@end
