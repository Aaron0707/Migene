//
//  LcyHTTPSessionManager.m
//  SuperCard
//
//  Created by x1371 on 15/1/20.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "LcyHTTPSessionManager.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
@implementation LcyHTTPSessionManager
static LcyHTTPSessionManager *shareManager = nil;
+(instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:AppServerBaseURLString];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        [config setHTTPAdditionalHeaders:@{}];
//        [config setURLCache:<#(NSURLCache *)#>]
        shareManager = [[LcyHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:config];
        shareManager.requestSerializer = [AFJSONRequestSerializer serializer];
        shareManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    return shareManager;
}
@end
