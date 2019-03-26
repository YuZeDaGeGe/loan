//
//  AdvertiseView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/25.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AdvertiseView.h"
#import <WHC_AutoLayout.h>
#import "UIView+CornerRadiusLayer.h"
#import "UIColor+Category.h"

@implementation AdvertiseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!_backView) {
            _backView = [UIView new];
            _backView.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
            [self addSubview:_backView];
            _backView.whc_CenterY(0).whc_CenterX(0).whc_LeftSpace(50).whc_RightSpace(50).whc_Height(300);
            [_backView setLayerCornerRadius:10 borderWidth:1 borderColor:[UIColor whiteColor]];
        }
        if (!_title) {
            _title = [UILabel new];
            [_backView addSubview:_title];
            _title.whc_TopSpaceToView(20, _backView).whc_CenterX(0);
            _title.textColor = [UIColor colorWithHexString:@"#333333"];
            _title.font = [UIFont systemFontOfSize:18];
        }
        if (!_contentLabel) {
            _contentLabel = [UILabel new];
            [self.backView addSubview:_contentLabel];
            _contentLabel.textColor = [UIColor colorWithHexString:@"#8c8c8c"];
            _contentLabel.font = [UIFont systemFontOfSize:16];
            _contentLabel.numberOfLines = 0;
            _contentLabel.whc_TopSpaceToView(50, _backView).whc_HeightAuto().whc_RightSpaceToView(20, self.backView).whc_LeftSpaceToView(20, _backView);
        }
        if (!_closeBtn) {
            _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_closeBtn];
            _closeBtn.whc_TopSpaceToView(20, _backView).whc_CenterX(0).whc_Width(30).whc_Height(30);
            [_closeBtn setLayerCornerRadius:15 borderWidth:1 borderColor:[UIColor mainColor]];
            _closeBtn.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"28"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
    }
    return self;
}


@end
