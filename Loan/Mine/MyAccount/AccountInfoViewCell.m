//
//  AccountInfoViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AccountInfoViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@interface AccountInfoViewCell ()

@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UILabel *detail;
@property (nonatomic,strong)UIView *line;

@end

@implementation AccountInfoViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_time) {
            _time = [UILabel new];
            _time.text = @"2018-09-22  18:00";
            [self.contentView addSubview:_time];
            _time.whc_CenterY(0).whc_LeftSpace(20);
            _time.textColor = [UIColor textColorWithType:0];
            _time.font = [UIFont systemFontOfSize:16];
            _time.textAlignment = NSTextAlignmentCenter;
        }
        if (!_detail) {
            _detail = [UILabel new];
            _detail.text = @"+20积分";
            [self.contentView addSubview:_detail];
            _detail.whc_CenterY(0).whc_RightSpace(20);
            _detail.textColor = [UIColor colorWithHexString:@"#EF5148"];
            _detail.font = [UIFont systemFontOfSize:16];
            _detail.textAlignment = NSTextAlignmentCenter;
        }
        if (!_line) {
            _line = [UIView new];
            [self.contentView addSubview:_line];
            _line.whc_LeftSpace(20).whc_TopSpaceToView(50, self.contentView).whc_RightSpace(20).whc_Height(1);
            _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        }
    }
    return self;
}

- (void)setValueForCell:(MyAccountModel *)model;{
    _time.text = model.time;
    _detail.text = model.desc;
    if ([model.opt isEqualToString:@"+"]) {
        _detail.textColor = [UIColor colorWithHexString:@"#EF5148"];
    }else{
        _detail.textColor = [UIColor colorWithHexString:@"#45B973"];
    }
}

@end
