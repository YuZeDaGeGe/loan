//
//  AccountHeaderViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AccountHeaderViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@implementation AccountHeaderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_amount) {
            self.amount = [UILabel new];
            [self.contentView addSubview:self.amount];
            _amount.text = @"*";
            self.amount.whc_CenterX(0).whc_TopSpace(30);
            self.amount.textColor = [UIColor mainColor];
            self.amount.font = [UIFont systemFontOfSize:40];
            self.amount.textAlignment = NSTextAlignmentCenter;
        }
        if (!_tip) {
            _tip = [UILabel new];
            [self.contentView addSubview:_tip];
            _tip.text = @"积分";
            _tip.whc_CenterYToView(0, self.amount).whc_LeftSpaceToView(5, self.amount);
            self.tip.textColor = [UIColor mainColor];
            self.tip.font = [UIFont systemFontOfSize:12];
            self.tip.textAlignment = NSTextAlignmentCenter;
        }
        if (!_total) {
            _total = [UILabel new];
            [self.contentView addSubview:_total];
            _total.text = @"总积分";
            _total.whc_CenterX(0).whc_TopSpaceToView(5, self.amount);
            self.total.textColor = [UIColor mainColor];
            self.total.font = [UIFont systemFontOfSize:12];
            self.total.textAlignment = NSTextAlignmentCenter;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithHexString:@"#FF6952"];
    return self;
}

@end
