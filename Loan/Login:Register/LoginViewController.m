//
//  LoginViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "AppDelegate.h"
#import "AllRequest.h"
#import <SVProgressHUD.h>
#import "LocalCache.h"
#import "ForgetViewController.h"
#import "UIColor+Category.h"
#import "MainTabBarController.h"
#import "Tools.h"
#import "CustomViewController.h"

@interface LoginViewController ()<LoginViewDelegate,RegisterViewDelegate>

@property (nonatomic,strong)LoginView *login;
@property (nonatomic,strong)RegisterView *registe;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSub];
    
//     [NetworkSingleton new];
    
}

- (void)createSub{
    if (!_login) {
        _login = [LoginView new];
        _login.delegate = self;
        [self.view addSubview:_login];
        _login.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    [_login.close addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
     [_login.forget addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetAction)]];
    [_login.registe addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registerAction)]];
}

- (void)createRegister{
    if (!_registe) {
        _registe = [RegisterView new];
        _registe.delegate = self;
        _registe.userInteractionEnabled = YES;
        [self.view addSubview:_registe];
        _registe.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }
    [_registe.close addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
    [_registe.code addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(codeAction)]];
    [_registe.registe addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction)]];
     [_registe.url addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(urlAction)]];
}

#pragma mark loginDelegate
- (void)sendValueForLogin:(NSDictionary *)dis{
    if ([dis[@"phone"] length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if ([dis[@"pwd"] length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    _login.loginBtn.backgroundColor = [UIColor colorWithHexString:@"#EB4B2B"];
    [SVProgressHUD show];
    NSDictionary *dic = @{@"username":dis[@"phone"],@"password":dis[@"pwd"]};
    [AllRequest requestFromNet:LoginAPI params:dic succ:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            [LocalCache saveObject:data[@"data"][@"user"][@"token"] Forkey:@"token" ToKeyChainStore:NO];
            [LocalCache saveObject:data[@"data"][@"user"][@"mobile"] Forkey:@"mobile" ToKeyChainStore:NO];

            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"isLogin"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"isLoad" object:@"YES"];
            
            //通知自选是否成功
            [[NSNotificationCenter defaultCenter]postNotificationName:@"handle" object:@"YES"];
            
            if ([data[@"status"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                MainTabBarController *tabViewController = (MainTabBarController *) appDelegate.window.rootViewController;
                
                [tabViewController setSelectedIndex:0];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }else{
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常，请稍后重试!"];
    }];
}

#pragma mark 注册界面
- (void)registerAction{
    [_login removeFromSuperview];
    _login = nil;
    [self createRegister];
}

#pragma mark 忘记密码
- (void)forgetAction{
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:forget];
    
    [self presentViewController:nav animated:YES completion:^{
    }];
}


//注册
#pragma mark 验证码获取
- (void)codeAction{
    [NetworkSingleton new];
    //    __weak typeof (_registe) weak = _registe;
    [_registe sendValue:^(NSString * _Nonnull phone) {
        if ([phone length] == 0) {
            [self showToast:@"请输入手机号"];
            return ;
        }
        [Tools startWithTime:59 label:self->_registe.code title:@"重新获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithHexString:@"#EB4B2B"] countColor:[UIColor mainColor]];
        
        NSDictionary *dic = @{@"mobile":phone};
        [SVProgressHUD show];
        [AllRequest requestFromNet:CodeAPI params:dic succ:^(NSDictionary *data) {
            [SVProgressHUD dismiss];
            if ([data[@"status"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"验证码获取成功"];
            }
        } fault:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
        }];
    }];
}

#pragma mark 注册delegate
- (void)sendValueForRegister:(NSDictionary *)dic{
    [NetworkSingleton new];
    if ([dic[@"phone"] length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if ([dic[@"pwd"] length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    if ([dic[@"code"] length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    NSDictionary *dics = @{@"mobile":dic[@"phone"],@"password":dic[@"pwd"],@"vercode":dic[@"code"]};
    [SVProgressHUD show];
    [AllRequest requestFromNet:RegisterAPI params:dics succ:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            [self->_registe removeFromSuperview];
            self->_registe = nil;
            [self createSub];
        }else{
            [SVProgressHUD showErrorWithStatus:data[@"message"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

#pragma mark 登录页面跳转
- (void)loginAction{
    [_registe removeFromSuperview];
    _registe = nil;
    [self createSub];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
- (void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)urlAction{
    CustomViewController *custom = [[CustomViewController alloc] init];
    custom.url = @"http://protocol.yuyanxt.com/shuziqihuotong.html";
    custom.fromWhich = @"register";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:custom];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
