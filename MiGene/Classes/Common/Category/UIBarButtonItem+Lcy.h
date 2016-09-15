//
//  UIBarButtonItem+Lcy.h
//  LongYuan
//
//  Created by lusir on 14-9-18.
//  Copyright (c) 2014年 Yuanwei Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Lcy)
+(UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+(UIBarButtonItem *)barButtonItemWithNormalImage:(UIImage *)normalImage highlightImage:(UIImage *)highlight target:(id)target action:(SEL)action;

+(UIBarButtonItem *)barButtonItemWithNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;
@end
