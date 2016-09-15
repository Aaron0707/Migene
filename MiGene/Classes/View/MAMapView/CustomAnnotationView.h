//
//  CustomAnnotationView.h
//  MiGene
//
//  Created by Aaron on 15/7/22.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"
@interface CustomAnnotationView : MAAnnotationView
@property (nonatomic, readonly) CustomCalloutView *calloutView;
@property (nonatomic, strong) UIImageView * imageView;
@end
