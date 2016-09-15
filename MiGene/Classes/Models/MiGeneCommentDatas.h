//
//  MiGeneCommentDatas.h
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiGeneComment.h"
@interface MiGeneCommentDatas : BaseModel
@property (nonatomic, strong) NSArray<MiGeneComment> * comments;
@end
