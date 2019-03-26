//
//  NewsViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/13.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NewsViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "UIView+CornerRadiusLayer.h"

@implementation NewsViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_top) {
            _top = [[UILabel alloc] init];
            [self.contentView addSubview:_top];
            _top.whc_TopSpace(0).whc_LeftSpace(22).whc_Width(1).whc_Height(30);
            _top.backgroundColor = [UIColor colorWithHexString:@"#DDDBDB"];
        }
        if (!_tipImage) {
            _tipImage = [[UIImageView alloc] init];
            [self.contentView addSubview:_tipImage];
            _tipImage.whc_CenterXToView(0, _top).whc_TopSpaceToView(0, _top).whc_Width(11).whc_Height(11);
            _tipImage.image = [UIImage imageNamed:@"point_icon"];
        }
        if (!_bottomLabel) {
            _bottomLabel = [[UILabel alloc] init];
            [self.contentView addSubview:_bottomLabel];
            _bottomLabel.whc_CenterXToView(0, _tipImage).whc_TopSpaceToView(0, _tipImage).whc_Width(1).whc_BottomSpace(0);
            _bottomLabel.backgroundColor = [UIColor colorWithHexString:@"#DDDBDB"];
        }
        if (!_mid) {
            _mid = [[UILabel alloc] init];
            [self.contentView addSubview:_mid];
            _mid.whc_CenterYToView(0, _tipImage).whc_LeftSpaceToView(0, _tipImage).whc_Width(15).whc_Height(1);
            _mid.backgroundColor = [UIColor colorWithHexString:@"#DDDBDB"];
        }
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] init];
            [self.contentView addSubview:_timeLabel];
            _timeLabel.whc_CenterYToView(0, _mid).whc_LeftSpaceToView(0, _mid).whc_Width(54).whc_Height(20);
            _timeLabel.backgroundColor = [UIColor colorWithHexString:@"#DDDBDB"];
            _timeLabel.text = @"23:23";
            _timeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
            _timeLabel.font = [UIFont systemFontOfSize:12];
//            _timeLabel.layer.cornerRadius = 9;
            _timeLabel.textAlignment = NSTextAlignmentCenter;
            [_timeLabel setLayerCornerRadius:9];
//            _timeLabel.layer.masksToBounds = YES;
        }
        if (!_content) {
            _content = [UILabel new];
            [self.contentView addSubview:_content];
            _content.whc_TopSpaceToView(-20, _timeLabel).whc_LeftSpaceToView(10, _timeLabel).whc_RightSpace(12).whc_HeightAuto();
            _content.numberOfLines = 0;
            _content.textColor = [UIColor textColorWithType:0];
            _content.font = [UIFont systemFontOfSize:16];
        }
        if (!_newsInfo) {
            _newsInfo = [[UILabel alloc] init];
            [self.contentView addSubview:_newsInfo];
            _newsInfo.whc_TopSpaceToView(0, _content).whc_LeftSpaceToView(10, _timeLabel).whc_RightSpace(12).whc_HeightAuto();
            _newsInfo.numberOfLines = 0;
            _newsInfo.textColor = [UIColor colorWithHexString:@"#666666"];
            _newsInfo.font = [UIFont systemFontOfSize:12];

        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setValueForCell:(NewsModel *)model;{
    _newsInfo.text = model.summary;
    _newsInfo.whc_HeightAuto();
    
    _content.text = model.title;
    _content.whc_HeightAuto();
    _timeLabel.text = model.time;
}

@end
