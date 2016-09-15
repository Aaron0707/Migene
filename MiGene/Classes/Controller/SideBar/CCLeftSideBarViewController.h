//
//  CCLeftSideBarViewController.h
//  GiMiHelper
//
//  Created by Hydom03 on 15-1-6.
//  Copyright (c) 2015年 Jenury Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define MOVE_INSTANCE_X     (kMainScreenWidth - 100.f)

@class CCLeftSideBarViewController;
@protocol LeftSideBarDelegate <NSObject>

- (void)leftSideBar:(CCLeftSideBarViewController *)sideBar viewControllerDidSelected:(UIViewController *)controller;
- (void)showMenu:(CCLeftSideBarViewController *)sideBar show:(BOOL)show;

@end

@interface CCLeftSideBarViewController : UIViewController

- (void)loadFirst;
- (void)topViewPanned:(float)x;
- (void)topViewPanEnd:(float)x;
@property(nonatomic, assign) BOOL isLeftShow;
@property(nonatomic, weak)id<LeftSideBarDelegate> delegate;

@end
