//
//  HomeTypeViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeTypeViewCell.h"
#import "UIColor+Category.h"
#import <WHC_AutoLayout.h>
#import "UIView+CornerRadiusLayer.h"

@interface HomeTypeViewCell ()

@property (nonatomic,strong)UILabel *type;
@property (nonatomic,strong)UILabel *point;
@property (nonatomic,strong)UIButton *margin;
@property (nonatomic,strong)UIView *line;

@end

@implementation HomeTypeViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_type) {
            _type = [UILabel new];
            [self.contentView addSubview:_type];
            _type.textColor = [UIColor textColorWithType:0];
            _type.textAlignment = NSTextAlignmentCenter;
            _type.font = [UIFont systemFontOfSize:16];
            _type.text = @"上证指数";
            _type.whc_LeftSpace(24).whc_CenterY(0);
        }
        if (!_point) {
            _point = [UILabel new];
            [self.contentView addSubview:_point];
            _point.textColor = [UIColor secondMainColor];
            _point.font = [UIFont systemFontOfSize:22];
            _point.textAlignment = NSTextAlignmentCenter;
            _point.text = @"2345.6";
            _point.whc_CenterY(0).whc_CenterX(0);
        }
        if (!_margin) {
            _margin = [UIButton buttonWithType:UIButtonTypeCustom];
            [_margin setTitle:@"33.9%" forState:UIControlStateNormal];
            _margin.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_margin];
            [_margin setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
            [_margin setLayerCornerRadius:4];
            _margin.whc_CenterY(0).whc_RightSpace(24).whc_Width(70).whc_Height(30);
            [_margin setBackgroundColor:[UIColor secondMainColor]];
            
        }
        if (!_line) {
            self.line = [UIView new];
            [self.contentView addSubview:_line];
            _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
            _line.whc_LeftSpace(0).whc_RightSpace(0).whc_Height(1).whc_TopSpaceToView(55, self.contentView);
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setValueForCell:(HomeModel *)model which:(NSInteger)which;{
    _type.text = model.instrument_id;
    _point.text = model.last;
    if (which == 0) {
        [_margin setBackgroundColor:[UIColor secondMainColor]];
    }else if (which == 1){
        [_margin setBackgroundColor:[UIColor colorWithHexString:@"#45b973"]];
    }else if (which == 2){
        if ([[model.range substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"-"]) {
            [_margin setBackgroundColor:[UIColor colorWithHexString:@"#45b973"]];
        }else{
            [_margin setBackgroundColor:[UIColor secondMainColor]];
        }
    }
    NSString *str = @"%";
    [_margin setTitle:[[NSString stringWithFormat:@"%@",model.range] stringByAppendingString:str] forState:UIControlStateNormal];
}

@end
