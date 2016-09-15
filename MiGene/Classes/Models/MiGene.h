//
//  MiGene.h
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "BaseModel.h"
#import "User.h"
#import "MiGeneContent.h"

@protocol MiGene <NSObject>@end
@interface MiGene : BaseModel
@property (nonatomic, assign) NSInteger  migeneId;
@property (nonatomic, assign) double  lat;
@property (nonatomic, assign) double  lng;
@property (nonatomic, assign) NSInteger  level;
@property (nonatomic, strong) User  *user;
@property (nonatomic, assign) NSInteger   likeCount;
@property (nonatomic, assign) NSInteger   commentCount;
@property (nonatomic, assign) NSInteger   viewCount;//浏览量
@property (nonatomic, strong) NSArray<MiGeneContent>   *content;
@property (nonatomic, strong) NSString *visible;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) BOOL currentUserIsLike;

@property (nonatomic, strong) NSURL<Optional> *voiceUrl;
@property (nonatomic, strong) NSArray<Optional> *images;
@end
