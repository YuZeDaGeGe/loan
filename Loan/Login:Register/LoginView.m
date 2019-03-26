//
//  LoginView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "LoginView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import <SVProgressHUD.h>
#import "UIView+CornerRadiusLayer.h"

@interface LoginView ()<UITextFieldDelegate>

{
    NSString *pwd;
    NSString *phone;
}

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        if (!_close) {
            _close = [[UIImageView alloc] init];
            [self addSubview:_close];
            _close.userInteractionEnabled = YES;
            _close.image = [UIImage imageNamed:@"28"];
            _close.whc_TopSpace(40).whc_RightSpace(24).whc_Width(15).whc_Height(20);
        }
        if (!_tip1) {
            _tip1 = [UILabel new];
            [self addSubview:_tip1];
            _tip1.whc_TopSpace(185).whc_LeftSpace(55);
            _tip1.text = @"您好,";
            _tip1.textColor = [UIColor textColorWithType:0];
            _tip1.font = [UIFont systemFontOfSize:30];
        }
        if (!_tip2) {
            _tip2 = [UILabel new];
            [self addSubview:_tip2];
            _tip2.whc_LeftSpace(55).whc_TopSpaceToView(15, self.tip1);
            _tip2.text = @"欢迎来到数字期货通,立即";
            _tip2.textColor = [UIColor textColorWithType:1];
            _tip2.font = [UIFont systemFontOfSize:16];
        }
        if (!_registe) {
            _registe = [UILabel new];
            [self addSubview:_registe];
            _registe.whc_LeftSpaceToView(5, self.tip2).whc_TopSpaceToView(15, self.tip1);
            _registe.text = @"注册";
            _registe.userInteractionEnabled = YES;
            _registe.textColor = [UIColor colorWithHexString:@"#EB4B2B"];
            _registe.font = [UIFont systemFontOfSize:16];
        }
        for (int i = 0; i < 1; i ++) {
            for (int j = 0; j <2; j ++) {
                    _text = [UITextField new];
                    _text.clearButtonMode = YES;
                    _text.tag = 10000 + j;
                    _text.delegate = self;
                    [self addSubview:_text];
                    _text.whc_BottomSpaceToView(100+j *50, self.tip2).whc_LeftSpace(50).whc_RightSpace(50).whc_Height(45);
                    _text.textColor = [UIColor textColorWithType:0];
                    _text.font = [UIFont systemFontOfSize:16];
                    if (j == 0) {
                        _text.placeholder = @"请输入手机号";
                        _text.keyboardType = UIKeyboardTypeNumberPad;
                    }else{
                        _text.placeholder = @"请输入密码";
                    }
                [_text addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                    _line = [UILabel new];
                    [self addSubview:_line];
                    _line.whc_LeftSpace(54).whc_RightSpaceToView(54, self).whc_Height(1).whc_BottomSpaceToView(110 + (j *50),self.tip2);
                    _line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
            }
            if (!_forget) {
                _forget = [UILabel new];
                [self addSubview:_forget];
                _forget.whc_RightSpace(54).whc_BottomSpaceToView(30, self.line);
                _forget.text = @"忘记密码";
                _forget.textColor = [UIColor textColorWithType:1];
                _forget.userInteractionEnabled = YES;
                _forget.font = [UIFont systemFontOfSize:16];
            }
        }
        if (!_loginBtn) {
            _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_loginBtn];
            _loginBtn.whc_BottomSpaceToView(113, self.forget).whc_LeftSpace(55).whc_RightSpace(55).whc_Height(45);
            [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
            [_loginBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#999999"];
            _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

#pragma mark textfieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.tag == 10000) {
        phone = textField.text;
    }else if (textField.tag == 10001){
        pwd = textField.text;
    }
    _loginBtn.backgroundColor = [UIColor secondMainColor];
}
#pragma mark 登录
- (void)loginAction{
    if ([_delegate respondsToSelector:@selector(sendValueForLogin:)]) {
        if ([phone length] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if ([pwd length] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        NSDictionary *dic = @{@"phone":phone,@"pwd":pwd};
        [_delegate sendValueForLogin:dic];
    }
}

@end
