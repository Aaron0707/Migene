//
//  UINavigationController+Lcyu.m
//  Wallet
//
//  Created by Lcyu on 14-7-25.
//  Copyright (c) 2014年 BoEn. All rights reserved.
//

#import "UINavigationController+Lcyu.h"

@implementation UINavigationController (Lcyu)
- (NSArray *)popToViewControllerWithClass:(Class)vcClass animated:(BOOL)animated
{
    NSArray *vcs = self.viewControllers;
    if (vcs) {
        for (int i=0; i<vcs.count -1; i++) {
            if ([vcs[i] class] == vcClass) {
                vcs = [self popToViewController:vcs[i] animated:animated];
                break;
            }
        }
    }
    else
    {
        @throw [[NSException alloc] initWithName:@"跳转bug" reason:@"vc堆栈不存在" userInfo:nil];
    }
    return vcs;
}

-(void)pushToVCStoryId:(NSString *)StoryId
{
    NSArray *ns = self.viewControllers;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:StoryId];
    NSArray *new = @[ns[0], vc];
    [self setViewControllers:new animated:YES];
}

-(void)pushToVCClassName:(NSString *)vcClassName
{
    Class vc = NSClassFromString(vcClassName);
    [self pushToVC:[[vc alloc] init]];
}

-(void)pushToVC:(UIViewController *)vc
{
    NSArray *ns = self.viewControllers;
    NSArray *new = @[ns[0], vc];
    [self setViewControllers:new animated:YES];
}
@end
