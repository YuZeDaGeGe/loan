//
//  MineCustomViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MineCustomViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@interface MineCustomViewCell ()

@property (nonatomic,strong)UIImageView *right;
@property (nonatomic,strong)UIView *line;

@end

@implementation MineCustomViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_tipImage) {
            _tipImage = [UIImageView new];
            [self.contentView addSubview:_tipImage];
            _tipImage.whc_CenterY(0).whc_LeftSpace(20).whc_Width(18).whc_Height(18);
        }
        if (!_tipLabel) {
            _tipLabel = [UILabel new];
            [self.contentView addSubview:_tipLabel];
            _tipLabel.whc_CenterY(0).whc_LeftSpaceToView(20, self.tipImage);
            _tipLabel.textColor = [UIColor textColorWithType:0];
            _tipLabel.font = [UIFont systemFontOfSize:16];
            _tipLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (!_right) {
            _right = [UIImageView new];
            _right.image = [UIImage imageNamed:@"Next step_icon"];
            [self.contentView addSubview:_right];
            _right.whc_RightSpace(24).whc_CenterY(0).whc_Width(6).whc_Height(11);
        }
        if (!_line) {
            self.line = [UIView new];
            [self.contentView addSubview:_line];
            _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
            _line.whc_LeftSpace(0).whc_RightSpace(0).whc_Height(1).whc_TopSpaceToView(50, self.contentView);
        }
    }
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setValueForCell:(NSInteger)row{
    if (row == 0) {
        _tipLabel.text = @"我的账户";
        _tipImage.image = [UIImage imageNamed:@"Account_icon"];
        _tipImage.whc_Width(20).whc_Height(16);
    }
    if (row == 1) {
        _tipLabel.text = @"我的设置";
        _tipImage.image = [UIImage imageNamed:@"sit_icon"];
    }
    if (row == 2) {
        _tipLabel.text = @"意见反馈";
        _tipImage.image = [UIImage imageNamed:@"opinion_icon"];
    }
    if (row == 3) {
        _tipLabel.text = @"关于我们";
        _tipImage.image = [UIImage imageNamed:@"about us_icon"];
    }
}

@end
