//
//  CCLeftSideBarViewController.m
//  GiMiHelper
//
//  Created by Hydom03 on 15-1-6.
//  Copyright (c) 2015年 Jenury Cheng. All rights reserved.
//

#import "CCLeftSideBarViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "MineViewController.h"
#import "MyHistoryViewController.h"
#import "BaseNavigationController.h"

#define HEADERIMAGE_HEIGHT (150.f)

@interface CCLeftSideBarViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UIView *_headerView;
    UIImageView *_headerImageView;
    UILabel *_nameLabel;
    
    NSArray *_dataSourceArray;
}

@property(nonatomic, strong)UITableViewCell *selectedCell;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)ViewController *homeViewController;
@property(nonatomic, strong)MineViewController *mineViewController;
@property(nonatomic, strong)MyHistoryViewController *myHistoryViewController;

@end

@implementation CCLeftSideBarViewController

- (void)loadView
{
    self.view = [[UIView alloc] init];
    self.view.frame = CGRectMake(0, 0, MOVE_INSTANCE_X, kMainScreenHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSourceArray = @[
                        @{@"name":@"我的信息", @"icon":@"left"},
                        @{@"name":@"我的👣", @"icon":@"left"},
                         ];

    _selectedCell = nil;
    self.view.backgroundColor = [UIColor blueColor];
    
    //background image view
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"splash_bg"];
    [self.view addSubview:bgImageView];
    
    //header
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEADERIMAGE_HEIGHT + 30)];
    _headerView.alpha = 1;
    [self.view addSubview:_headerView];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, MOVE_INSTANCE_X, HEADERIMAGE_HEIGHT)];
    _headerImageView.backgroundColor = [UIColor greenColor];
    _headerImageView.clipsToBounds = YES;
    [_headerView addSubview:_headerImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, HEADERIMAGE_HEIGHT + 25, MOVE_INSTANCE_X - 20, 20)];
    _nameLabel.numberOfLines = 0;

    _nameLabel.text = @"某某人的名字";
    _nameLabel.font = Chinese_Font_15_Bold;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nameLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:_nameLabel];
    
    //tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEADERIMAGE_HEIGHT + 50, self.view.frame.size.width, self.view.frame.size.height - HEADERIMAGE_HEIGHT - 50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)topViewPanned:(float)x
{
    if (x > 100)
    {
//        NSLog(@"%f",x);
    }
    
}

- (void)topViewPanEnd:(float)x
{
    
}

- (void)menuBtnClicked:(UIButton *)btn
{
    if (_delegate &&[_delegate respondsToSelector:@selector(showMenu:show:)]) {
         [_delegate showMenu:self show:YES];
    }
}

- (void)loadFirst
{
    [self selectedIndexPath:2];
}

#pragma mark -- TableView DataSourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *dic = [_dataSourceArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 30, 30)];
    imageView.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    [cell addSubview:imageView];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, MOVE_INSTANCE_X - 80, 40)];
    text.text = [dic objectForKey:@"name"];
    text.font = Chinese_Font_14;
    text.textColor = [UIColor whiteColor];
    [cell addSubview:text];
    
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectedIndexPath:indexPath.row];
}

- (void)selectedIndexPath:(NSUInteger )index
{
    if (index == 0)
    {
        [_delegate showMenu:self show:NO];
        _mineViewController = [[MineViewController alloc] init];
        BaseNavigationController * nav = [[BaseNavigationController alloc]initWithRootViewController:_mineViewController];
        [_homeViewController.navigationController presentViewController:nav animated:YES completion:^{
        }];
    }
    else if(index == 1)
    {
        [_delegate showMenu:self show:NO];
        _myHistoryViewController = [[MyHistoryViewController alloc] init];
        BaseNavigationController * nav = [[BaseNavigationController alloc]initWithRootViewController:_myHistoryViewController];
        [_homeViewController.navigationController presentViewController:nav animated:YES completion:^{
        }];
    }else{
        _homeViewController = [[ViewController alloc] init];
        __weak typeof(self) weakSelf = self;
        _homeViewController.back = ^(void){
            [weakSelf.delegate showMenu:weakSelf show:YES];
        };
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:_homeViewController];
        if (_delegate != nil && [_delegate respondsToSelector:@selector(leftSideBar:viewControllerDidSelected:)]) {
            [_delegate leftSideBar:self viewControllerDidSelected:nav];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
