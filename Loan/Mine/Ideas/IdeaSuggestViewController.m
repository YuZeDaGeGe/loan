//
//  IdeaSuggestViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "IdeaSuggestViewController.h"
#import "UIColor+Category.h"
#import "IdeaView.h"
#import <WHC_AutoLayout.h>
#import "BaseNavigationBar.h"
#import "AllRequest.h"
#import "LocalCache.h"
#import <SVProgressHUD.h>
#import "LoginViewController.h"

@interface IdeaSuggestViewController ()<IdeaViewDelegate>

@property (nonatomic,strong)IdeaView *ideaView;
@property (nonatomic,strong)BaseNavigationBar *nav;

@end

@implementation IdeaSuggestViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self createNav];
    [self.view addSubview:self.ideaView];
}

- (void)createNav{
    if (!_nav) {
        _nav = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight )];
        _nav.titleLable.text = @"意见反馈";
        [_nav.leftBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_nav];
    }
}
- (void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IdeaView *)ideaView{
    if (!_ideaView) {
        _ideaView = [IdeaView new];
        [self.view addSubview:_ideaView];
        _ideaView.whc_TopSpace(15 + NavigationHeight).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(ScreenHeight);
    }
    _ideaView.backgroundColor = [UIColor mainColor];
    _ideaView.delegate = self;
    return _ideaView;
}

#pragma mark ideaViewDelegate
- (void)sendValueForText:(NSString *)text{
    [NetworkSingleton new];
     [SVProgressHUD show];
    if ([text length] == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您宝贵的意见"];
        return;
    }
    NSDictionary *dic = @{@"content":text,@"token":[LocalCache objectWithKey:@"token"]};
    [AllRequest requestFromNet:FeedBackAPI params:dic succ:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",data[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"意见反馈成功"];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}


@end
