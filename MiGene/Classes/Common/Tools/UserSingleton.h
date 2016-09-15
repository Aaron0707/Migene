//
//  UserSingleton.h
//  MiGene
//
//  Created by 0001 on 15/7/27.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSingleton : NSObject

@property (nonatomic, strong) NSString *accessToken;

+ (UserSingleton *)defaultManager;

@end
