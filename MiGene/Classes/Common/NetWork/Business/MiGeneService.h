//
//  MiGeneService.h
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "MiGene.h"
#import "MiGeneCommentDatas.h"
#import "MiGeneDatas.h"

@interface MiGeneService : NSObject

//============用户相关======================================================================

//查询用户
+(void)userSuccess:(void (^)(User *user))success
                      failure:(void (^)(NSError *error))failure;

+(void)userWithUserId:(NSInteger)userId
              Success:(void (^)(User *user))success
              failure:(void (^)(NSError *error))failure;

//获取验证码
+(void)verifyWithPhone:(NSString *)phone
              Success:(void (^)(id response))success
              failure:(void (^)(NSError *error))failure;

//注册
+(void)registerWithPhone:(NSString *)phone
              verifyCode:(NSString *)code
                password:(NSString *)password
                nickname:(NSString *)nickname
                     sex:(NSString *)sex
               Success:(void (^)(User *user))success
               failure:(void (^)(NSError *error))failure;

//登陆
+(void)loginWithPhone:(NSString *)phone
             password:(NSString *)password
               Success:(void (^)(User *user))success
               failure:(void (^)(NSError *error))failure;

//修改头像
+(void)updateUserAvatar:(NSString *)avatar
              Success:(void (^)(User *user))success
              failure:(void (^)(NSError *error))failure;
//修改签名
+(void)updateUserSignature:(NSString *)signature
                Success:(void (^)(User *user))success
                failure:(void (^)(NSError *error))failure;

//修改性别
+(void)updateUserSex:(NSString *)sex
                Success:(void (^)(User *user))success
                failure:(void (^)(NSError *error))failure;

//修改昵称
+(void)updateUserNickname:(NSString *)nickname
                Success:(void (^)(User *user))success
                failure:(void (^)(NSError *error))failure;



//============MiGene相关================================================================================


+(void)createMiGene:(MiGene *)MiGene
                  Success:(void (^)(MiGene *MiGene))success
                  failure:(void (^)(NSError *error))failure;

+(void)deleteMiGeneWithMiGeneId:(NSInteger )migeneId
           Success:(void (^)(id response))success
           failure:(void (^)(NSError *error))failure;

+(void)ignoreMiGeneWithMiGeneId:(NSInteger )migeneId
                      Success:(void (^)(id response))success
                      failure:(void (^)(NSError *error))failure;


+(void)reportMiGeneWithMiGeneId:(NSInteger )migeneId
                      Success:(void (^)(id response))success
                      failure:(void (^)(NSError *error))failure;



+(void)likeMiGeneWithMiGeneId:(NSInteger )migeneId
                      Success:(void (^)(id response))success
                      failure:(void (^)(NSError *error))failure;

+(void)cancelLikeMiGeneWithMiGeneId:(NSInteger )migeneId
                      Success:(void (^)(id response))success
                      failure:(void (^)(NSError *error))failure;

+(void)createMiGeneCommentWithMiGeneId:(NSInteger )migeneId
                             content:(NSString *)conent
                      Success:(void (^)(MiGeneComment *comment))success
                      failure:(void (^)(NSError *error))failure;


+(void)MiGeneCommentListWithMiGeneId:(NSInteger )migeneId
                              page:(NSInteger)page
                      Success:(void (^)(MiGeneCommentDatas *datas))success
                      failure:(void (^)(NSError *error))failure;

+(void)nearMiGeneWithMinLat:(double )minlat
                    minLng:(double )minLng
                    maxLat:(double)maxLat
                    maxLng:(double)maxLng
                      Success:(void (^)(MiGeneDatas *datas))success
                      failure:(void (^)(NSError *error))failure;

+(void)popularMiGeneWithMinLat:(double )minlat
                    minLng:(double )minLng
                    maxLat:(double)maxLat
                    maxLng:(double)maxLng
                    centerLat:(double)centerLat
                    centerLng:(double)centerLng
                         page:(NSInteger)page
                   Success:(void (^)(MiGeneDatas *datas))success
                   failure:(void (^)(NSError *error))failure;

+(void)mineMiGeneWithPage:(NSInteger)page
                   Success:(void (^)(MiGeneDatas *datas))success
                   failure:(void (^)(NSError *error))failure;

+(void)MiGeneWithMiGeneId:(NSInteger )migeneId
                   Success:(void (^)(MiGene *MiGene))success
                   failure:(void (^)(NSError *error))failure;




@end
