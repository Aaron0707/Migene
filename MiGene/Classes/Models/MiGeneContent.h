//
//  MiGeneContent.h
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "BaseModel.h"

@protocol MiGeneContent <NSObject>@end
@interface MiGeneContent : BaseModel
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSString * value;
@property (nonatomic, strong) NSString * size;
@end
