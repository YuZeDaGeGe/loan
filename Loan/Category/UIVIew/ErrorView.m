//
//  ErrorView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/21.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ErrorView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@implementation ErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        if (!_image) {
            _image = [[UIImageView alloc] init];
            [self addSubview:_image];
            _image.userInteractionEnabled = YES;
            _image.image = [UIImage imageNamed:@"wifi_icon"];
            _image.whc_CenterX(0).whc_CenterY(0).whc_Height(135).whc_Width(135);
        }
        if (!_tip) {
            _tip = [[UILabel alloc] init];
            [self addSubview:_tip];
            _tip.whc_CenterX(0).whc_TopSpaceToView(0, _image);
            _tip.text = @"暂无网络, 联网后请点击重试";
            _tip.textColor = [UIColor colorWithHexString:@"#8c8c8c"];
            _tip.font = [UIFont systemFontOfSize:12];
        }
    }
    return self;
}

@end
