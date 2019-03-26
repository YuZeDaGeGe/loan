//
//  BaseNavigationBar.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseNavigationBar.h"
#import "UIColor+Category.h"
#import <WHC_AutoLayout.h>


@implementation BaseNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor mainColor];
        if (!_titleLable) {
            self.titleLable = [[UILabel alloc] init];
            [self addSubview:self.titleLable];
            _titleLable.whc_TopSpace(20).whc_BottomSpace(0).whc_CenterX(0).whc_CenterY(0).whc_Width(100);
            [self addSubview:self.titleLable];
            self.titleLable.backgroundColor = [UIColor clearColor];
            self.titleLable.textColor = [UIColor textColorWithType:0];
            self.titleLable.font = [UIFont systemFontOfSize:18.0f];
            self.titleLable.textAlignment = NSTextAlignmentCenter;
            
        }
        if (!_leftBtn) {
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_leftBtn];
            self.leftBtn.whc_LeftSpace(10).whc_CenterYToView(0, self.titleLable).whc_Width(16).whc_Height(27);
            [self.leftBtn setImage:[UIImage imageNamed:@"back_black_icon"] forState:UIControlStateNormal];
            [self addSubview:self.leftBtn];
        }
        if (!_line) {
            _line = [[UILabel alloc] init];
            [self addSubview:_line];
            _line.whc_LeftSpace(0).whc_RightSpace(0).whc_BottomSpace(0).whc_Height(1);
            _line.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        }
    }
    return self;
}




@end
