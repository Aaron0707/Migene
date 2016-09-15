//
//  ImageEditView.h
//  SuperCard
//
//  Created by x1371 on 15/2/9.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClearBlock)(NSInteger index);
@interface ImageEditView : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) UIButton *clearBtn;
@property (nonatomic, copy) ClearBlock clearBlock;
-(void)registerClearBlock:(ClearBlock) clearBlock;
@end
