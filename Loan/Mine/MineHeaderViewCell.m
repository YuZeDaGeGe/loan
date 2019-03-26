//
//  MineHeaderViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MineHeaderViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIView+CornerRadiusLayer.h"
#import "UIColor+Category.h"

@interface MineHeaderViewCell ()

@property (nonatomic,strong)UIView *back;

@end

@implementation MineHeaderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_backImage) {
            _backImage = [UIImageView new];
            [self.contentView addSubview:_backImage];
            _backImage.userInteractionEnabled = YES;
            [_backImage setImage:[[UIImage imageNamed:@"pic-1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            _backImage.whc_TopSpace(0).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(150 *ScaleHeight);
        }
        if (!_title) {
            _title = [[UILabel alloc] init];
            [self.contentView addSubview:_title];
            _title.whc_TopSpace(StatusBarHeight *ScaleHeight).whc_CenterX(0);
            _title.textColor = [UIColor mainColor];
            _title.font = [UIFont systemFontOfSize:18];
            _title.text = @"我的";
        }
        if (!_back) {
            _back = [[UIView alloc] init];
            _back.userInteractionEnabled = YES;
            [self.contentView addSubview:_back];
            _back.whc_TopSpace(95 * ScaleHeight).whc_LeftSpace(24).whc_RightSpace(24).whc_BottomSpace(0);
            [_back setLayerCornerRadius:16 borderWidth:0 borderColor:nil];
            _back.backgroundColor = [UIColor mainColor];
        }
        if (!_header) {
            _header = [UIImageView new];
            _header.image = [UIImage imageNamed:@"WechatIMG115"];
            [self.contentView addSubview:self.header];
            _header.whc_CenterX(0).whc_TopSpaceToView(15, _title).whc_Width(83).whc_Height(83);
            [_header setLayerCornerRadius:83 / 2 borderWidth:0 borderColor:nil];
            _header.userInteractionEnabled = YES;
        }
        if (!_name) {
            _name = [UILabel new];
            [self.back addSubview:_name];
            _name.whc_CenterX(0).whc_TopSpaceToView(15, self.header);
            _name.text = @"请注册/登陆";
            _name.textColor = [UIColor textColorWithType:0];
            _name.font = [UIFont systemFontOfSize:16];
            _name.textAlignment = NSTextAlignmentCenter;
            _name.userInteractionEnabled = YES;
        }
        if (!_tip) {
            _tip = [UILabel new];
            [self.back addSubview:_tip];
            _tip.whc_CenterX(0).whc_TopSpaceToView(10,self.name);
            _tip.textColor = [UIColor textColorWithType:1];
            _tip.font = [UIFont systemFontOfSize:12];
            _tip.text = @"欢迎来到数字期货通";
            _tip.textAlignment = NSTextAlignmentCenter;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

@end
