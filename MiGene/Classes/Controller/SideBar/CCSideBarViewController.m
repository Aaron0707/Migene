//
//  CCSideBarViewController.m
//  GiMiHelper
//
//  Created by Hydom03 on 15-1-6.
//  Copyright (c) 2015年 Jenury Cheng. All rights reserved.
//

#import "CCSideBarViewController.h"
#import "CCLeftSideBarViewController.h"

@interface CCSideBarViewController ()<LeftSideBarDelegate>
{
    CCLeftSideBarViewController *_leftSideBar;
    UIViewController *_currentViewController;
    
//    UIView *_bottomLayerView;
    UIView *_topLayerView;
    
    UITapGestureRecognizer *_viewTapGesture;
    UIPanGestureRecognizer *_pan;
    UIView *_leftView;
    UIView *_coverView;
    BOOL isFirst;
}

@end


@implementation CCSideBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _topLayerView = [[UIView alloc] initWithFrame:self.view.bounds];
    _topLayerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topLayerView];
    

    
    _viewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topLayerViewTapped:)];
    
    [self initLeftSideBar];
    
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topLayerViewPanned:)];
    [_topLayerView addGestureRecognizer:_pan];
    
    [_leftSideBar loadFirst];
    [self initCoverView];
    isFirst = YES;
}

- (void)initCoverView
{
    _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _coverView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5];
    _coverView.alpha = 0;
    _coverView.userInteractionEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)initLeftSideBar
{
    _leftSideBar = [[CCLeftSideBarViewController alloc] init];
    _leftSideBar.delegate = self;
    _leftSideBar.isLeftShow = NO;
    [self addChildViewController:_leftSideBar];
    [_leftSideBar willMoveToParentViewController:self];
//    [_bottomLayerView addSubview:_leftSideBar.view];
    _leftView = _leftSideBar.view;
    _leftView.frame = CGRectMake(-MOVE_INSTANCE_X, 0, MOVE_INSTANCE_X, kMainScreenHeight);
    [self.view addSubview:_leftView];
    _leftView.layer.shadowPath   = [UIBezierPath bezierPathWithRect:_leftView.bounds].CGPath;
    _leftView.layer.shadowOffset = CGSizeMake(0, 0);
    _leftView.layer.shadowColor = [UIColor blackColor].CGColor;
    _leftView.layer.shadowOpacity = 0;
//    [[UIApplication sharedApplication].keyWindow addSubview:_leftView];
}

- (void)addPanGesture
{
    [_topLayerView addGestureRecognizer:_pan];
}

- (void)removePanGesture
{
    [_topLayerView removeGestureRecognizer:_pan];
}

- (void)topLayerViewPanned:(UIPanGestureRecognizer *)pan
{
    if (isFirst) {
        [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
        isFirst = NO;
    }
    float x = [pan translationInView:self.view].x;
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        
    }
    else if(pan.state == UIGestureRecognizerStateChanged)
    {
        if (!_leftSideBar.isLeftShow) {
            [_leftSideBar topViewPanned:x];
        }
        if (_leftSideBar.isLeftShow)
        {
            CGRect rect = _leftView.frame;
            rect.origin.x = x;
            if (x > 0) {
                rect.origin.x = 0;
            }else if (x < -MOVE_INSTANCE_X)
            {
                rect.origin.x = -MOVE_INSTANCE_X;
            }
            [UIView animateWithDuration:0.1 animations:^{
                _leftView.frame = rect;
                _leftView.layer.shadowOpacity = 1;
                _coverView.alpha = 1 - rect.origin.x / -MOVE_INSTANCE_X;
                _coverView.frame = CGRectMake(rect.origin.x + MOVE_INSTANCE_X, 0, kMainScreenWidth - (rect.origin.x + MOVE_INSTANCE_X), kMainScreenHeight);
                
            }completion:^(BOOL finished) {
                if (_leftView.frame.origin.x == -MOVE_INSTANCE_X) {
                    _leftView.layer.shadowOpacity = 0;
                }else
                {
                    _leftView.layer.shadowOpacity = 1;
                }
            }];
            
        }else
        {
            CGRect rect = _leftView.frame;
            rect.origin.x = x - MOVE_INSTANCE_X;
            if (x < 0) {
                rect.origin.x = -MOVE_INSTANCE_X;
            }
            else if (x > MOVE_INSTANCE_X)
            {
                rect.origin.x = 0;
            }
            [UIView animateWithDuration:0.1 animations:^{
                _leftView.frame = rect;
                _leftView.layer.shadowOpacity = 1;
                _coverView.alpha = 1 - rect.origin.x / -MOVE_INSTANCE_X;
                _coverView.frame = CGRectMake(rect.origin.x + MOVE_INSTANCE_X, 0, kMainScreenWidth - (rect.origin.x + MOVE_INSTANCE_X), kMainScreenHeight);
            }completion:^(BOOL finished) {
                if (_leftView.frame.origin.x == -MOVE_INSTANCE_X) {
                    _leftView.layer.shadowOpacity = 0;
                }else
                {
                    _leftView.layer.shadowOpacity = 1;
                }
            }];
        }
    }
    else if(pan.state == UIGestureRecognizerStateEnded)
    {
        if (!_leftSideBar.isLeftShow) {
            [_leftSideBar topViewPanEnd:x];
        }
        if ((x < -MOVE_INSTANCE_X/2.0 && _leftSideBar.isLeftShow == YES)
            || (x < 0 && _leftSideBar.isLeftShow == NO)
            || (x < MOVE_INSTANCE_X/2.0 && _leftSideBar.isLeftShow == NO)) {
            [self showSidebar:NO];
        }
        else
        {
            [self showSidebar:YES];
        }
    }
}

- (void)showSidebar:(BOOL)b
{
    _leftSideBar.isLeftShow = b;
    float x = -MOVE_INSTANCE_X;
    if (b) {
        x = 0.0;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _leftView.frame;
        rect.origin.x = x;
        _leftView.frame = rect;
        _leftView.layer.shadowOpacity = 1;
        _coverView.alpha = 1 - rect.origin.x / -MOVE_INSTANCE_X;
        _coverView.frame = CGRectMake(rect.origin.x + MOVE_INSTANCE_X, 0, kMainScreenWidth - (rect.origin.x + MOVE_INSTANCE_X), kMainScreenHeight);
    }completion:^(BOOL finished) {
        if (_leftView.frame.origin.x == -MOVE_INSTANCE_X) {
            _leftView.layer.shadowOpacity = 0;
//            [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
        }else
        {
//            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
            _leftView.layer.shadowOpacity = 1;
        }
    }];
    
    if (b) {
        [self addTapGesture];
    }else
    {
        [self removeTapGesture];
    }
}

- (void)addTapGesture
{
    if (_viewTapGesture.view) {
        [self removeTapGesture];
    }
    UIView *view = [[UIView alloc] initWithFrame:_topLayerView.bounds];
    [_topLayerView addSubview:view];
    
    [view addGestureRecognizer:_viewTapGesture];
}

- (void)removeTapGesture
{
    [_viewTapGesture.view removeFromSuperview];
    [_topLayerView removeGestureRecognizer:_viewTapGesture];
}

- (void)topLayerViewTapped:(UIGestureRecognizer *)ges
{
    [self showSidebar:NO];
}

- (void)leftSideBar:(CCLeftSideBarViewController *)sideBar viewControllerDidSelected:(UIViewController *)controller
{
    [self showSidebar:NO];
//    if (!controller) {
//        return;
//    }
//    
//    if (_currentViewController && [_currentViewController isEqual:controller]) {
//        return;
//    }
//    
//    if (_currentViewController)
//    {
//        [_currentViewController willMoveToParentViewController:nil];
//        [_currentViewController removeFromParentViewController];
//        [_currentViewController.view removeFromSuperview];
//    }
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    [_topLayerView addSubview:controller.view];
    
    _currentViewController = controller;
}

- (void)showMenu:(CCLeftSideBarViewController *)sideBar show:(BOOL)show
{
    if (isFirst) {
        [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
        isFirst = NO;
    }
    [self showSidebar:show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
