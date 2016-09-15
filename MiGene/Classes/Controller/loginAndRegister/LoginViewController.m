//
//  LoginViewController.m
//  MiGene
//
//  Created by 0001 on 15/7/24.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "LoginViewController.h"
#import "MiGeneService.h"
#import "RegisterViewController.h"
#import "CCSideBarViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_phoneNumTextField;//手机号
    
    __weak IBOutlet UITextField *_passwordTextField;//密码
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//登陆
- (IBAction)loginAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [MiGeneService loginWithPhone:_phoneNumTextField.text password:_passwordTextField.text Success:^(User *user) {
        CCSideBarViewController *viewController = [[CCSideBarViewController alloc] init];
        weakSelf.navigationController.navigationBarHidden = YES;
        [weakSelf.navigationController pushViewController:viewController animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

//注册
- (IBAction)registerAction:(id)sender {
    RegisterViewController *viewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
