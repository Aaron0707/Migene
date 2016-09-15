//
//  UserSingleton.m
//  MiGene
//
//  Created by 0001 on 15/7/27.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "UserSingleton.h"

static UserSingleton *detailInstance = nil;

@implementation UserSingleton

+ (UserSingleton *)defaultManager
{
    static dispatch_once_t once_t;
    
    dispatch_once(&once_t, ^{
        detailInstance = [[UserSingleton alloc] init];
    });
    return detailInstance;
}

@end
