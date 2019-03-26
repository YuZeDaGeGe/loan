//
//  HomeCustomViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeCustomViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import <UIKit/UIKit.h>


@implementation HomeCustomViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSub];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    return self;
}
- (void)createSub{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        [self.contentView addSubview:_tipLabel];
        _tipLabel.font = [UIFont systemFontOfSize:18];
        _tipLabel.text = @"热门";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor textColorWithType:0];
        _tipLabel.whc_LeftSpace(24).whc_CenterY(0);
    }
//    if (!_allLabel) {
//        _allLabel = [UILabel new];
//        [self.contentView addSubview:_allLabel];
//        _allLabel.font = [UIFont systemFontOfSize:12];
//        _allLabel.text = @"全部 >";
//        _allLabel.textColor = [UIColor textColorWithType:1];
//        _allLabel.textAlignment = NSTextAlignmentCenter;
//        _allLabel.whc_RightSpace(24).whc_CenterY(0);
//    }
   
}
- (void)setValueForCell:(NSInteger)section{
    if (section == 0) {
        
        self.tipLabel.text = @"热门";
    }else{
        self.tipLabel.text = @"涨跌榜";
    }
}

- (void)setValueForAccount{
    self.tipLabel.text = @"积分纪录";
    self.tipLabel.textColor = [UIColor textColorWithType:0];
    self.tipLabel.font = [UIFont systemFontOfSize:18];
    self.allLabel.hidden = YES;
}

@end

