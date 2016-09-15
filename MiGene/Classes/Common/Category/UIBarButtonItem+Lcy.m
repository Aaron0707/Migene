//
//  UIBarButtonItem+Lcy.m
//  LUSIR
//
//  Created by lusir on 14-9-18.
//  Copyright (c) 2014年 Yuanwei Chen. All rights reserved.
//

#import "UIBarButtonItem+Lcy.h"

@implementation UIBarButtonItem (Lcy)
+(UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
    return barButtonItem;
}

+(UIBarButtonItem *)barButtonItemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlight target:(id)target action:(SEL)action
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:highlight forState:UIControlStateHighlighted];
    backBtn.bounds = (CGRect){CGPointZero, normalImage.size};
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return barButtonItem;
}

+(UIBarButtonItem *)barButtonItemWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [backBtn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    backBtn.adjustsImageWhenHighlighted = NO;
    backBtn.bounds = (CGRect){CGPointZero, normalImage.size};
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return barButtonItem;
}
@end
