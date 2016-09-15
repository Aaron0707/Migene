//
//  UINavigationController+Lcyu.h
//  Wallet
//
//  Created by Lcyu on 14-7-25.
//  Copyright (c) 2014年 BoEn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Lcyu)
/**
 *  跳转指定class的vc
 *
 *  @param vcClass vc的class
 *  @param animated            是否动画效果
 *
 *  @return 返回vc集合
 */
- (NSArray *)popToViewControllerWithClass:(Class)vcClass animated:(BOOL)animated;

/**
 *  返回rootvc后，push到新vc
 *
 *  @param vc  目标控制器
 */
-(void)pushToVC:(UIViewController *)vc;

/**
 *  返回rootvc后，push到新VC（动画板）
 *
 *  @param StoryId vc对应storyboardId
 */
-(void)pushToVCStoryId:(NSString *)StoryId;

/**
 *  返回rootvc后，push到新VC（vc类名）
 *
 *  @param vcClassName vc类名
 */
-(void)pushToVCClassName:(NSString *)vcClassName;
@end
