//
//  IdeaView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "IdeaView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "UIView+CornerRadiusLayer.h"
#import <SVProgressHUD.h>

@interface IdeaView ()<UITextViewDelegate>
{
    NSString *text;
}

@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *num;
@property (nonatomic,strong)UIButton *submitBtn;

@end

@implementation IdeaView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        if (!_textView) {
            self.textView = [UITextView new];
            [self addSubview:_textView];
            _textView.whc_TopSpace(0 *ScaleHeight).whc_LeftSpace(24).whc_RightSpace(24).whc_Height(200);
            [self.textView setLayerCornerRadius:4 borderWidth:1 borderColor:[UIColor colorWithHexString:@"#cccccc"]];
            _textView.delegate = self;
        }
        if (!_tip) {
            _tip = [UILabel new];
            [self.textView addSubview:_tip];
            _tip.whc_TopSpace(6).whc_LeftSpace(2);
            _tip.text = @"请写下您的建议和反馈，请输入最多150字";
            _tip.textAlignment = NSTextAlignmentCenter;
            _tip.font = [UIFont systemFontOfSize:15];
            _tip.textColor = [UIColor colorWithHexString:@"#cccccc"];
        }
        if (!_num) {
            _num = [UILabel new];
            [self.textView addSubview:_num];
            _num.whc_TopSpaceToView(155, self.tip).whc_RightSpaceToView(-ScreenWidth + 48, self.textView);
            _num.textColor = [UIColor textColorWithType:1];
            _num.textAlignment = NSTextAlignmentCenter;
            _num.text = @"0/150";
            _num.font = [UIFont systemFontOfSize:15];
        }
        if (!_submitBtn) {
            _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_submitBtn];
            _submitBtn.whc_TopSpaceToView(64, self.textView).whc_LeftSpace(25).whc_RightSpace(25).whc_Height(45);
            _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#EB4B2B"];
            [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
            [_submitBtn setTitleColor:[UIColor mainColor ] forState:UIControlStateNormal];
            _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

#pragma mark 点击传值
- (void)submitAction{
    if ([_delegate respondsToSelector:@selector(sendValueForText:)]) {
        [_delegate sendValueForText:text];
    }
}

#pragma mark textViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        _tip.hidden = NO;
    }else if (textView.text > 0){
        _tip.hidden = YES;
        if (textView.text.length > 150) {
            [SVProgressHUD showErrorWithStatus:@"最多只能输入150个字呢"];
            _num.text = @"150/150";
            return;
        }
        if (textView.text.length < 150 || textView.text.length == 150) {
            text = textView.text;
            _num.text = [NSString stringWithFormat:@"%ld/150",textView.text.length];
        }
    }
}



@end
