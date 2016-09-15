//
//  HttpTool.m
//  MiGene
//
//  Created by x1371 on 15/1/20.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "HttpTool.h"
#import "Tools.h"
#import "LcyHTTPSessionManager.h"
#define kRetCode @"errorCode"
#define kRetMsg @"errorMessage"
@implementation HttpTool
static LcyHTTPSessionManager *manaegr;
+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manaegr = [LcyHTTPSessionManager sharedManager];
        ((AFJSONResponseSerializer *)manaegr.responseSerializer).removesKeysWithNullValues = YES;
    });
}

+(void)GET:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [manaegr GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![self isHaveErrorWithResponseObject:responseObject] && success) {
                success(task, responseObject);
            }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [HttpTool errorHandleWithError:error];
        if (failure) {
            failure(task, error);
        }
    }];
}

+(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [manaegr POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (![self isHaveErrorWithResponseObject:responseObject] && success) {
            success(task, responseObject);
        }else if(failure){
            failure(task,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [HttpTool errorHandleWithError:error];
        if (failure) {
            failure(task, error);
        }
    }];
}

+(void)errorHandleWithError:(NSError *)error
{
    [Tools showToastWithMessage:@"网络错误，请稍后再试"];
    //        [Tools showToastWithMessage:[error.userInfo objectForKey:NSLocalizedDescriptionKey]];
    ProLog(@"===============error-----%@", error);
    if([error.userInfo valueForKey:@"com.alamofire.serialization.response.error.data"])
    {
        NSString *responseData = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        ProLog(@"===============responseData-----%@", responseData);
    }
}

+(void)startMonitoring
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
                [Tools showToastWithMessage:@"网络连接已断开"];
                break;
            default:
//                [Tools showToastWithMessage:@"网络连接已恢复"];
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+(BOOL)isHaveErrorWithResponseObject:(id)responseObject
{
    if ([[responseObject valueForKey:kRetCode] intValue] != 0)
    {
        [Tools showToastWithMessage:[responseObject valueForKey:kRetMsg]];
        return true;
    }
    return false;
}
@end
