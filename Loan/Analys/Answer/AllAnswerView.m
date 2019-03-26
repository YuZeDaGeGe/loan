//
//  AllAnswerView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/12.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AllAnswerView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "UIView+CornerRadiusLayer.h"


@implementation AllAnswerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!_all) {
            _all = [[UILabel alloc] init];
            [self addSubview:_all];
            _all.whc_TopSpace(230 *ScaleHeight).whc_CenterX(0);
            _all.textColor = [UIColor colorWithHexString:@"#FDC403"];
            _all.text = @"400";
            _all.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:50];
            _all.textAlignment = NSTextAlignmentCenter;
        }
        if (!_againBtn) {
            _againBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_againBtn];
            _againBtn.whc_CenterX(0).whc_TopSpaceToView(80, _all).whc_LeftSpace(80).whc_RightSpace(80).whc_Height(40);
            [_againBtn setLayerCornerRadius:20];
//            _againBtn.layer.cornerRadius = 20;
//            _againBtn.layer.masksToBounds = YES;
            [_againBtn setBackgroundColor:[UIColor colorWithHexString:@"#FDC403"]];
            [_againBtn setTitle:@"再来一次" forState:UIControlStateNormal];
            [_againBtn setTitleColor:[UIColor colorWithHexString:@"#FF4539"] forState:UIControlStateNormal];
            _againBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    return self;
}

@end
