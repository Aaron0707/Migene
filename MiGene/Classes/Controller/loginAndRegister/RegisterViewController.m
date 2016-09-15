//
//  RegisterViewController.m
//  MiGene
//
//  Created by 0001 on 15/7/24.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "RegisterViewController.h"
#import "MiGeneService.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_phoneNumTextField;
    __weak IBOutlet UITextField *_verifyCodeTextField;
    __weak IBOutlet UITextField *_passwordTextField;
    
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//获取验证码
- (IBAction)getVerifyCodeAction:(UIButton *)sender {
    [MiGeneService verifyWithPhone:_phoneNumTextField.text Success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//注册
- (IBAction)registerAction:(UIButton *)sender {
    NSLog(@"%@",_phoneNumTextField.text);
    NSLog(@"%@",_verifyCodeTextField.text);
    NSLog(@"%@",_passwordTextField.text);
    [MiGeneService registerWithPhone:_phoneNumTextField.text verifyCode:_verifyCodeTextField.text password:_passwordTextField.text nickname:@"wj" sex:@"M" Success:^(User *user) {
        NSLog(@"%@",user);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
