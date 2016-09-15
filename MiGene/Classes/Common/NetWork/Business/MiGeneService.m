//
//  MiGeneService.m
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "MiGeneService.h"
#import "HttpTool.h"
#import "ApiPath.h"
#import "Tools.h"
#import "UserSingleton.h"

@implementation MiGeneService

+(void)userSuccess:(void (^)(User *))success
           failure:(void (^)(NSError *))failure{
    [HttpTool GET:API_USER_PROFILE_ME parameters:[NSDictionary new] success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)userWithUserId:(NSInteger)userId
              Success:(void (^)(User *))success
              failure:(void (^)(NSError *))failure{
    NSDictionary *para = @{
                           @"userId":@(userId)
                           };
    
    [HttpTool GET:API_USER_PROFILE_ME parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}


+(void)verifyWithPhone:(NSString *)phone
               Success:(void (^)(id))success
               failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"phone":phone
                            };
    [HttpTool GET:API_USER_VERIFY parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)registerWithPhone:(NSString *)phone
              verifyCode:(NSString *)code
                password:(NSString *)password
                nickname:(NSString *)nickname
                     sex:(NSString *)sex
                 Success:(void (^)(User *))success
                 failure:(void (^)(NSError *))failure{
    
    NSDictionary * para = @{
                            @"phone":phone,
                            @"verifyCode":code,
                            @"password":password,
                            @"nickname":nickname,
                            @"sex":sex
                            };
    [HttpTool POST:API_USER_REGISTER parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        UserSingleton *detailInstance = [UserSingleton defaultManager];
        detailInstance.accessToken = [NSString stringWithFormat:@"%@", responseObject[@"token"][@"accessToken"]];
        NSLog(@"accessToken == %@", responseObject[@"token"][@"accessToken"]);
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)loginWithPhone:(NSString *)phone
             password:(NSString *)password
              Success:(void (^)(User *))success
              failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"phone":phone,
                            @"password":password
                            };
    [HttpTool POST:API_USER_LOGIN parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        
        UserSingleton *detailInstance = [UserSingleton defaultManager];
        detailInstance.accessToken = [NSString stringWithFormat:@"%@", responseObject[@"token"][@"accessToken"]];
        NSLog(@"accessToken == %@", responseObject[@"token"][@"accessToken"]);
        
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)updateUserAvatar:(NSString *)avatar
                Success:(void (^)(User *))success
                failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"avatar":avatar
                            };
    [HttpTool POST:API_USER_UPDATE_AVATAR parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)updateUserNickname:(NSString *)nickname
                  Success:(void (^)(User *))success
                  failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"nickname":nickname
                            };
    [HttpTool POST:API_USER_UPDATE_NICKNAME parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)updateUserSex:(NSString *)sex
             Success:(void (^)(User *))success
             failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"sex":sex
                            };
    [HttpTool POST:API_USER_UPDATE_SEX parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)updateUserSignature:(NSString *)signature
                   Success:(void (^)(User *))success
                   failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"signature":signature
                            };
    [HttpTool POST:API_USER_UPDATE_SIGNATURE parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"user"];
        User * user = [[User alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(user);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}


+(void)createMiGene:(MiGene *)migene
           Success:(void (^)(MiGene *))success
           failure:(void (^)(NSError *))failure{
    NSDictionary * para = [migene toDictionary];
    [HttpTool POST:API_MiGene_CREATE parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"migene"];
        MiGene * result = [[MiGene alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(result);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}


+(void)deleteMiGeneWithMiGeneId:(NSInteger)migeneId
                      Success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId)
                            };
    [HttpTool POST:API_MiGene_DELETE parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)ignoreMiGeneWithMiGeneId:(NSInteger)migeneId
                      Success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId)
                            };
    [HttpTool POST:API_MiGene_IGNORE parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)reportMiGeneWithMiGeneId:(NSInteger)migeneId
                      Success:(void (^)(id))success
                      failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId)
                            };
    [HttpTool POST:API_MiGene_REPORT parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)likeMiGeneWithMiGeneId:(NSInteger)migeneId
                    Success:(void (^)(id))success
                    failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId)
                            };
    [HttpTool POST:API_MiGene_LIKE parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)cancelLikeMiGeneWithMiGeneId:(NSInteger)migeneId
                          Success:(void (^)(id))success
                          failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId)
                            };
    [HttpTool POST:API_MiGene_LIKE_CANCEL parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

+(void)MiGeneCommentListWithMiGeneId:(NSInteger)migeneId
                              page:(NSInteger)page
                           Success:(void (^)(MiGeneCommentDatas *))success
                           failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId),
                            @"page":@(page)
                            };
    [HttpTool POST:API_MiGene_COMMENT_LIST parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"comments"];
        MiGeneCommentDatas * datas = [[MiGeneCommentDatas alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(datas);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];

}



+(void)createMiGeneCommentWithMiGeneId:(NSInteger)migeneId
                             content:(NSString *)conent
                             Success:(void (^)(MiGeneComment *))success
                             failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId),
                            @"content":conent
                            };
    [HttpTool POST:API_MiGene_COMMENT_CREATE parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"comment"];
        MiGeneComment * comment = [[MiGeneComment alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(comment);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}

+(void)nearMiGeneWithMinLat:(double)minlat
                    minLng:(double)minLng
                    maxLat:(double)maxLat
                    maxLng:(double)maxLng
                   Success:(void (^)(MiGeneDatas *))success
                   failure:(void (^)(NSError *))failure{
    
    NSDictionary * para = @{
                            @"minLat":@(minlat),
                            @"minLng":@(minLng),
                            @"maxLat":@(maxLat),
                            @"maxLng":@(maxLng),
                            };
    [HttpTool POST:API_MiGene_LIST_NEARBY parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"migenes"];
        MiGeneDatas * datas = [[MiGeneDatas alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(datas);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}


+(void)popularMiGeneWithMinLat:(double)minlat
                       minLng:(double)minLng
                       maxLat:(double)maxLat
                       maxLng:(double)maxLng
                    centerLat:(double)centerLat
                    centerLng:(double)centerLng
                         page:(NSInteger)page
                      Success:(void (^)(MiGeneDatas *))success
                      failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"minLat":@(minlat),
                            @"minLng":@(minLng),
                            @"maxLat":@(maxLat),
                            @"maxLng":@(maxLng),
                            @"centerLat":@(centerLat),
                            @"centerLng":@(centerLng),
                            @"page":@(page)
                            };
    [HttpTool POST:API_MiGene_LIST_POPULAR parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"migenes"];
        MiGeneDatas * datas = [[MiGeneDatas alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(datas);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];

}

+(void)mineMiGeneWithPage:(NSInteger)page
                 Success:(void (^)(MiGeneDatas *))success
                 failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"page":@(page)
                            };
    [HttpTool POST:API_MiGene_LIST_POPULAR parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"migenes"];
        MiGeneDatas * datas = [[MiGeneDatas alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(datas);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];

    
}

+(void)MiGeneWithMiGeneId:(NSInteger)migeneId
                Success:(void (^)(MiGene *MiGene))success
                failure:(void (^)(NSError *))failure{
    NSDictionary * para = @{
                            @"migeneId":@(migeneId)
                            };
    [HttpTool POST:API_MiGene_LIST_POPULAR parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary * dic = [responseObject valueForKey:@"migene"];
        MiGene * data = [[MiGene alloc] initWithDictionary:dic error:nil];
        if (success) {
            success(data);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error) {
            failure(error);
        }
    }];

}

@end
