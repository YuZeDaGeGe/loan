//
//  BaseViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+Toast.h"
#import "UIColor+Category.h"
#import <JGProgressHUD/JGProgressHUD.h>

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) JGProgressHUD *hud;
@property (nonatomic, strong) JGProgressHUD *prototypeHud;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#191919"]};
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

//#pragma mark - Navigationbar
//- (void)setNavigationTitle:(NSString *)title LeftBtnHidden:(BOOL )left RightBtnHidden:(BOOL )right lineHidden:(BOOL)lineHidden{
//    if (!_navigationBar) {
//        _navigationBar = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight) withTitle:title withLeftBtnHidden:left withRightBtnHidden:right lineHidden:lineHidden];
//    }
//    [self.view addSubview:_navigationBar];
//}

#pragma mark - Hud method
- (void)showHudWithMsg:(NSString *)msg {
    self.hud.textLabel.text = msg;
    [self.hud showInView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)showHudWithMsg:(NSString *)msg inView:(UIView *)view {
    self.hud.textLabel.text = msg;
    [self.hud showInView:view animated:YES];
}

- (void)showProgressHudWithMsg:(NSString *)msg precentage:(CGFloat)precentage {
    if (precentage>1) {
        precentage = 1;
    }else if (precentage<=0.01) {
        precentage = 0;
    }
    JGProgressHUD *hud = self.prototypeHud;
    if(precentage != 1) {
        hud.textLabel.text = msg;
        hud.indicatorView = [[JGProgressHUDRingIndicatorView alloc] initWithHUDStyle:hud.style];
        hud.layoutChangeAnimationDuration = 0.0;
        [hud setProgress:precentage animated:NO];
        hud.detailTextLabel.text = [NSString stringWithFormat:@"%@: %.f%% ",@"完成", precentage*100];
    } else {
        hud.textLabel.text = @"成功";
        hud.detailTextLabel.text = nil;
        hud.layoutChangeAnimationDuration = 0.3;
        hud.indicatorView = [[JGProgressHUDSuccessIndicatorView alloc] init];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud dismiss];
        });
    }
    
    if (!hud.isVisible){
        [hud showInView:self.view];
    }
}

- (void)hideHuds {
    [self hideMsgHud];
    [self hideProgressHud];
}

- (void)hideMsgHud {
    if (self.hud.isVisible) {
        [self.hud dismiss];
    }
}

- (void)hideProgressHud {
    if (self.prototypeHud.isVisible) {
        [self.prototypeHud dismiss];
    }
}

#pragma mark - Toast method
- (void)showToast:(NSString *)msg {
    [[UIApplication sharedApplication].keyWindow makeToast:msg];
}

#pragma mark - lazy load
- (JGProgressHUD *)hud {
    if (!_hud) {
        _hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    }
    return _hud;
}

- (JGProgressHUD *)prototypeHud {
    if (!_prototypeHud){
        _prototypeHud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
        _prototypeHud.interactionType = JGProgressHUDInteractionTypeBlockNoTouches;
    }
    return _prototypeHud;
}


@end

