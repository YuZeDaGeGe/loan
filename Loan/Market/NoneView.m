//
//  NoneView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/15.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NoneView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@implementation NoneView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!_image) {
            _image = [UIImageView new];
            _image.image = [UIImage imageNamed:@"no data_icon"];
            [self addSubview:_image];
            _image.whc_CenterX(0).whc_TopSpace(161).whc_Width(130).whc_Height(130);
        }
        if (!_tipLabel) {
            _tipLabel = [UILabel new];
            [self addSubview:_tipLabel];
            _tipLabel.whc_TopSpaceToView(26, _image).whc_CenterX(0);
            _tipLabel.text = @"暂无数据";
            _tipLabel.textColor = [UIColor colorWithHexString:@"#8c8c8c"];
            _tipLabel.font = [UIFont systemFontOfSize:16];
        }
    }
    return self;
}

@end
