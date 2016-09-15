//
//  LcyHTTPSessionManager.h
//  SuperCard
//
//  Created by x1371 on 15/1/20.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface LcyHTTPSessionManager : AFHTTPSessionManager
+(instancetype)sharedManager;
@end
