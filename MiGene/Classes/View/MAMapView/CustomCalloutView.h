//
//  CustomCalloutView.h
//  MiGene
//
//  Created by Aaron on 15/7/22.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView
@property (nonatomic, strong) UIImageView *portraitView; //商户图
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址
@end
