//
//  BaseNavigationController.m
//  MiGene
//
//  Created by 0001 on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "BaseNavigationController.h"
#ifdef iOS7
#define NavigationBarStyle NSForegroundColorAttributeName : [UIColor whiteColor], \
NSShadowAttributeName : shadow
#else
#define NavigationBarStyle UITextAttributeTextColor : [UIColor whiteColor],\
UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
#endif

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (UIView *view in self.navigationBar.subviews) {
        for (UIView *view2 in view.subviews) {
            if ([view2 isKindOfClass:[UIImageView class]]) {
                [view2 removeFromSuperview];
                break;
            }
        }
    }
}

+(void)initialize
{
    [self setNavigationBar];
    [self setBarItem];
}

#pragma mark 设置导航背景，标题属性
+(void)setNavigationBar
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBarTintColor:MiGene_Color_Purple];
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSShadowAttributeName : shadow,
                                  NSFontAttributeName : Chinese_Font_18_Bold
                                  }];
}

#pragma mark 设置barItem的样式
+(void) setBarItem
{
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTintColor:[UIColor whiteColor]];
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor whiteColor],
                                      NSShadowAttributeName :
                                          shadow,
                                      NSFontAttributeName:[UIFont systemFontOfSize:15]
                                      
                                      } forState:UIControlStateNormal];
    
}

-(void)popself
{
    [self popViewControllerAnimated:YES];
}

-(UIBarButtonItem*) createBackButton
{
    
    return [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
