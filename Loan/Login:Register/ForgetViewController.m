//
//  ForgetViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/14.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ForgetViewController.h"
#import "BaseNavigationBar.h"
#import "UIColor+Category.h"
#import "RegisterView.h"
#import "Tools.h"
#import "AllRequest.h"
#import <SVProgressHUD.h>

@interface ForgetViewController ()<RegisterViewDelegate>

@property (nonatomic,strong)BaseNavigationBar *nav;
@property (nonatomic,strong)RegisterView *registe;

@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_black_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(returnAction)];
    
    [self createSub];
}

- (void)createSub{
    if (!_registe) {
        _registe = [RegisterView new];
        _registe.delegate = self;
        _registe.userInteractionEnabled = YES;
        [self.view addSubview:_registe];
        _registe.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    _registe.tip2.text = @"欢迎来到数字期货通";;
    _registe.registe.hidden = YES;
    [_registe.registerBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    [_registe.code addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeAction)]];
}

- (void)returnAction{
    [self dismissViewControllerAnimated:YES completion:^{
    
    }];
}

#pragma mark 获取验证码
- (void)codeAction{
    //    __weak typeof (_registe) weak = _registe;
    [_registe sendValue:^(NSString * _Nonnull phone) {
        if ([phone length] == 0) {
            [self showToast:@"请输入手机号"];
            
            return ;
        }
        [Tools startWithTime:59 label:self->_registe.code title:@"重新获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithHexString:@"#EB4B2B"] countColor:[UIColor mainColor]];
        
        NSDictionary *dic = @{@"mobile":phone};
        [AllRequest requestFromNet:RestCodeAPI params:dic succ:^(NSDictionary *data) {
            if ([data[@"status"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"验证码获取成功"];
            }else{
                [SVProgressHUD showErrorWithStatus:data[@"message"]];
            }
        } fault:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
        }];
    }];
}

#pragma 注册回调
- (void)sendValueForRegister:(NSDictionary *)dic{
    if ([dic[@"phone"] length] == 0) {
        [self showToast:@"请输入手机号"];
        return;
    }
    if ([dic[@"pwd"] length] == 0) {
        [self showToast:@"请输入密码"];
        return;
    }
    if ([dic[@"code"] length] == 0) {
        [self showToast:@"请输入验证码"];
        return;
    }
     _registe.registerBtn.backgroundColor = [UIColor colorWithHexString:@"#EB4B2B"];
    NSDictionary *dics = @{@"mobile":dic[@"phone"],@"password":dic[@"pwd"],@"vercode":dic[@"code"]};
    [AllRequest requestFromNet:ResetPwdAPI params:dics succ:^(NSDictionary *data) {
        if ([data[@"status"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"密码重置成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
    
}

@end
