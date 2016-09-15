//
//  HttpTool.h
//  SuperCard
//
//  Created by x1371 on 15/1/20.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+(void)startMonitoring;
@end
