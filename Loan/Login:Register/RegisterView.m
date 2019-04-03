//
//  RegisterView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "RegisterView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import <SVProgressHUD.h>

@interface RegisterView ()<UITextFieldDelegate>
{
    NSString *phone;
    NSString *pwd;
    NSString *codes;
}
@end

@implementation RegisterView

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
            _registe.text = @"登录";
            _registe.userInteractionEnabled = YES;
            _registe.textColor = [UIColor colorWithHexString:@"#EB4B2B"];
            _registe.font = [UIFont systemFontOfSize:16];
        }
        for (int i = 0; i < 1; i ++) {
            for (int j = 0; j <3; j ++) {
                _text = [UITextField new];
                _text.clearButtonMode = YES;
                _text.tag = 10000 + j;
                _text.delegate = self;
                [self addSubview:_text];
                _text.whc_BottomSpaceToView(100+j *50, self.tip2).whc_LeftSpace(50).whc_RightSpace(50);
                _text.textColor = [UIColor textColorWithType:0];
                _text.font = [UIFont systemFontOfSize:16];
                _text.tag = 10000+j;
                if (j == 0) {
                    _text.placeholder = @"请输入手机号";
                    _text.keyboardType = UIKeyboardTypeNumberPad;
                }else if (j == 1){
                    _text.placeholder = @"请输入验证码";
                }else{
                    _text.placeholder = @"请输入6-12位密码";
                }
                [_text addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                _line = [UILabel new];
                [self addSubview:_line];
                _line.whc_LeftSpace(54).whc_RightSpaceToView(54, self).whc_Height(1).whc_BottomSpaceToView(110 + (j *50),self.tip2);
                _line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
                if (j == 1) {
                    if (!_code) {
                        _code = [UILabel new];
                        [self addSubview:_code];
                        _code.userInteractionEnabled = YES;
                        _code.whc_RightSpace(54).whc_CenterYToView(0, _text);
                        _code.text = @"发送验证码";
                        _code.textColor = [UIColor secondMainColor];
                        _code.font = [UIFont systemFontOfSize:16];
                    }
                }
                if (j == 2) {
                    if (!_tip) {
                        _tip = [UILabel new];
                        [self addSubview:_tip];
                        _tip.whc_LeftSpace(54).whc_TopSpaceToView(5, _line);
                        _tip.text = @"阅读并同意数字期货通";
                        _tip.textColor = [UIColor colorWithHexString:@"#333333"];
                        _tip.font = [UIFont systemFontOfSize:13];
                    }
                    if (!_url) {
                        _url = [UILabel new];
                        [self addSubview:_url];
                        _url.whc_LeftSpaceToView(0, _tip).whc_TopSpaceToView(5, _line);
                        _url.textColor = [UIColor colorWithHexString:@"#EB4B2B"];
                        _url.text = @"注册相关协议";
                        _url.userInteractionEnabled = YES;
                        _url.font = [UIFont systemFontOfSize:13];
                    }
                }
            }
        }
        if (!_registerBtn) {
            _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_registerBtn];
            _registerBtn.whc_BottomSpaceToView(120, self.line).whc_LeftSpace(55).whc_RightSpace(55).whc_Height(45);
            [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
            [_registerBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            _registerBtn.backgroundColor = [UIColor colorWithHexString:@"#999999"];
            _registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            [_registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

#pragma mark textfieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.tag == 10000) {
        phone = textField.text;
    }else if (textField.tag == 10001){
        codes = textField.text;
    }else if (textField.tag == 10002){
        pwd = textField.text;
    }
    _registerBtn.backgroundColor = [UIColor secondMainColor];
}

- (void)sendValue:(Value)val{
    val(phone);
}


- (void)registerAction{
    if ([_delegate respondsToSelector:@selector(sendValueForRegister:)]) {
        if ([phone length] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
            return;
        }
        if ([pwd length] == 0) {
             [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        if ([codes length] == 0) {
             [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        NSDictionary *dic = @{@"phone":phone,@"pwd":pwd,@"code":codes};
        [_delegate sendValueForRegister:dic];
    }
}



@end
