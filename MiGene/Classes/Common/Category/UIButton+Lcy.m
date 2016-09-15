//
//  UIButton+Lcy.m
//  仿聚美NavigationView滑动
//
//  Created by lusir on 14-9-27.
//  Copyright (c) 2014年 navigationView. All rights reserved.
//

#import "UIButton+Lcy.h"

@implementation UIButton (Lcy)
+(id)buttonWithUnderlineImage:(UIImage *)underlineImage normalUnderlineImage:(UIImage *)normalUnderlineImage title:(NSString *)title frame:(CGRect)frame
{
    CGSize underlineImageSize = underlineImage.size;
    CGFloat btnHeight = frame.size.height;
    UIButton *underlineBtn = [self buttonWithType:UIButtonTypeCustom];
    [underlineBtn setImage:underlineImage forState:UIControlStateDisabled];
    [underlineBtn setImage:normalUnderlineImage forState:UIControlStateNormal];
    
    [underlineBtn setTitle:title forState:UIControlStateNormal];
    [underlineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [underlineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    underlineBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    underlineBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    underlineBtn.imageEdgeInsets = UIEdgeInsetsMake(btnHeight - underlineImageSize.height, (frame.size.width - underlineImageSize.width)/2, 0, 0);
    underlineBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -underlineImageSize.width, underlineImageSize.height, 0);
    underlineBtn.frame = (CGRect){frame.origin, frame.size};
    return underlineBtn;
}

+(UIButton *)buttonItemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlight target:(id)target action:(SEL)action
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:highlight forState:UIControlStateHighlighted];
    backBtn.bounds = (CGRect){CGPointZero, normalImage.size};
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return backBtn;
}
@end
