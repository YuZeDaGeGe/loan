//
//  answerView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "answerView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "Tools.h"
#import "UIView+CornerRadiusLayer.h"

@interface answerView ()

{
    NSInteger num;
}

@end

@implementation answerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSub];
    }
    return self;
}

- (void)createSub{
    if (!_jifen) {
        _jifen = [UIButton buttonWithType:UIButtonTypeCustom];
        _jifen.backgroundColor = [UIColor clearColor];
        [_jifen setTitle:@"当前积分" forState:UIControlStateNormal];
        _jifen.titleLabel.font = [UIFont systemFontOfSize:14];
        [_jifen setLayerCornerRadius:18 borderWidth:2 borderColor:[UIColor colorWithHexString:@"FEE62F"]];
        _jifen.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_jifen setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [self addSubview:_jifen];
        _jifen.whc_TopSpace(28 *ScaleHeight).whc_LeftSpace(25).whc_Width(258 / 2).whc_Height(66 / 2);
    }
    if (!_minu) {
        _minu = [[UILabel alloc] init];
        [self addSubview:_minu];
         [Tools startWithTime:59 label:_minu title:@"0s" countDownTitle:@"s" mainColor:[UIColor redColor] countColor:[UIColor clearColor]];
        _minu.whc_TopSpace(28 *ScaleHeight).whc_RightSpace(20).whc_Width(25).whc_Height(20);
        _minu.textAlignment = NSTextAlignmentCenter;
        _minu.textColor = [UIColor mainColor];
        _minu.font = [UIFont systemFontOfSize:14];
    }
    if (!_title) {
        _title = [[UILabel alloc] init];
        [self addSubview:_title];
        _title.whc_TopSpaceToView(44 *ScaleHeight, self.jifen).whc_LeftSpace(24).whc_RightSpace(24);
        _title.textColor = [UIColor mainColor];
        _title.font = [UIFont systemFontOfSize:16];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.numberOfLines = 0;
    }
    for (int i = 0; i < 4; i++) {
        _questionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_questionBtn];
        _questionBtn.whc_TopSpaceToView(40 + i * 50, self.title).whc_RightSpace(24).whc_HeightAuto().whc_LeftSpace(24);
        _questionBtn.tag = 10000+ i ;
        _questionBtn.backgroundColor = [UIColor colorWithHexString:@"#FFF3CB"];
        [_questionBtn setLayerCornerRadius:20];
//        _questionBtn.layer.cornerRadius = 20;
//        _questionBtn.layer.masksToBounds = YES;
        [_questionBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _flagImage = [[UIImageView alloc] init];
        [_questionBtn addSubview:_flagImage];
        _flagImage.image = [UIImage imageNamed:@"Circle"];
        _flagImage.tag = 10000+i;
        [_flagImage setLayerCornerRadius:15 / 2];
//        _flagImage.layer.cornerRadius = 15 /2;
//        _flagImage.layer.masksToBounds = YES;
        _flagImage.whc_CenterY(0).whc_LeftSpace(16).whc_Width(15).whc_Height(15);
        
        _content = [[UILabel alloc] init];
        [_questionBtn addSubview:_content];
        _content.whc_CenterY(0).whc_LeftSpace(40).whc_HeightAuto();
        _content.tag = 30000+i;
        _content.numberOfLines = 0;
//        _content.text = @"假设你问了问题";
        _content.font = [UIFont systemFontOfSize:16];
        _content.textColor = [UIColor colorWithHexString:@"#FF4539"];
    }
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_nextBtn];
        _nextBtn.whc_TopSpaceToView(44 *ScaleHeight, _questionBtn).whc_LeftSpace(24).whc_RightSpace(24).whc_Height(40);
        _nextBtn.backgroundColor = [UIColor colorWithHexString:@"#FD9503"];
        [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"#FF4539"] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_nextBtn setLayerCornerRadius:20];
//        _nextBtn.layer.cornerRadius = 20;
//        _nextBtn.layer.masksToBounds = YES;
    }
    
//    if (!_tipImage) {
//        _tipImage = [[UIImageView alloc] init];
//        _tipImage.layer.cornerRadius = 56 / 4;
//        _tipImage.layer.masksToBounds = YES;
//        _tipImage.hidden = NO;
//        _tipImage.backgroundColor = [UIColor colorWithHexString:@"#47A22C"];
//        [_questionBtn addSubview:_tipImage];
//        _tipImage.whc_CenterY(0).whc_Width(56 / 2).whc_Height(56 / 2).whc_RightSpace(24);
//
//    }
    
}

- (void)sendValue:(Value)value{
    value(num);
}

- (void)clickAction:(UIButton *)btn{
    num = btn.tag;
    UIButton *btn0 = [(UIButton *)self viewWithTag:10000];
    UIButton *btn1 = [(UIButton *)self viewWithTag:10001];
    UIButton *btn2 = [(UIButton *)self viewWithTag:10002];
    UIButton *btn3 = [(UIButton *)self viewWithTag:10003];
    if (btn.tag == 10000) {
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }else if (btn.tag == 10001){
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }else if (btn.tag == 10002){
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }else if (btn.tag == 10003){
        for (UIImageView *tmp in btn3.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle_press"];
            }
        }
        for (UIImageView *tmp in btn1.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn2.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
        for (UIImageView *tmp in btn0.subviews) {
            if ([tmp isKindOfClass:[UIImageView class]]) {
                tmp.image = [UIImage imageNamed:@"Circle"];
            }
        }
    }
}

@end
