//
//  UIButton+Lcy.h
//  仿聚美NavigationView滑动
//
//  Created by lusir on 14-9-27.
//  Copyright (c) 2014年 navigationView. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Lcy)
+(id)buttonWithUnderlineImage:(UIImage *)underlineImage normalUnderlineImage:(UIImage *)normalUnderlineImage title:(NSString *)title frame:(CGRect)frame;

+(UIButton *)buttonItemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlight target:(id)target action:(SEL)action;
@end
