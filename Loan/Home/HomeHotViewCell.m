//
//  HomeHotViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeHotViewCell.h"
#import "UIColor+Category.h"
#import <WHC_AutoLayout.h>

@interface HomeHotViewCell ()

@end

@implementation HomeHotViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        for (int i = 0 ; i < 3; i ++) {
        _backView1 = [UIView new];
        [self.contentView addSubview:_backView1];
       _backView1.userInteractionEnabled = YES;
        _backView1.tag = 10001;
        _backView1.backgroundColor = [UIColor mainColor];
        _backView1.frame = CGRectMake(0 , 0, ScreenWidth / 3, 123 );
        _type1 = [UILabel new];
        [_backView1 addSubview:_type1];
        _type1.whc_TopSpace(20).whc_CenterX(0);
        _type1.textColor = [UIColor textColorWithType:0];
        _type1.font = [UIFont systemFontOfSize:12];
        _type1.textAlignment = NSTextAlignmentCenter;
        
        _point1 = [UILabel new];
        [_backView1 addSubview:_point1];
        _point1.textColor = [UIColor secondMainColor];
        _point1.font = [UIFont systemFontOfSize:22];
        _point1.textAlignment = NSTextAlignmentCenter;
        _point1.whc_CenterX(0).whc_TopSpaceToView(8, _type1);
        
        _margin1 = [UILabel new];
        [_backView1 addSubview:_margin1];
        _margin1.textAlignment = NSTextAlignmentCenter;
        _margin1.textColor = [UIColor textColorWithType:1];
        _margin1.whc_CenterX(0).whc_TopSpaceToView(8, _point1);
        
        _line1 = [UIView new];
        [_backView1 addSubview:_line1];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        _line1.whc_CenterY(0).whc_Height(60).whc_Width(1).whc_RightSpace(0);
        
        _backView2 = [UIView new];
        [self.contentView addSubview:_backView2];
        _backView2.tag = 10002;
        _backView2.userInteractionEnabled = YES;
        _backView2.backgroundColor = [UIColor mainColor];
        _backView2.frame = CGRectMake(ScreenWidth /3 , 0, ScreenWidth / 3, 123 );
        _type2 = [UILabel new];
        [_backView2 addSubview:_type2];
        _type2.whc_TopSpace(20).whc_CenterX(0);
        _type2.textColor = [UIColor textColorWithType:0];
        _type2.font = [UIFont systemFontOfSize:12];
        _type2.textAlignment = NSTextAlignmentCenter;
        
        _point2 = [UILabel new];
        [_backView2 addSubview:_point2];
        _point2.textColor = [UIColor secondMainColor];
        _point2.font = [UIFont systemFontOfSize:22];
        _point2.textAlignment = NSTextAlignmentCenter;
        _point2.whc_CenterX(0).whc_TopSpaceToView(8, _type2);
        
        _margin2 = [UILabel new];
        [_backView2 addSubview:_margin2];
        _margin2.textAlignment = NSTextAlignmentCenter;
        _margin2.textColor = [UIColor textColorWithType:1];
        _margin2.whc_CenterX(0).whc_TopSpaceToView(8, _point2);
        
        _line2 = [UIView new];
        [_backView2 addSubview:_line2];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        _line2.whc_CenterY(0).whc_Height(60).whc_Width(1).whc_RightSpace(0);
        
        _backView3 = [UIView new];
        [self.contentView addSubview:_backView3];
        _backView3.tag = 10003;
        _backView3.userInteractionEnabled = YES;
        _backView3.backgroundColor = [UIColor mainColor];
        _backView3.frame = CGRectMake(ScreenWidth /3 *2 , 0, ScreenWidth / 3, 123 );
        _type3 = [UILabel new];
        [_backView3 addSubview:_type3];
        _type3.whc_TopSpace(20).whc_CenterX(0);
        _type3.textColor = [UIColor textColorWithType:0];
        _type3.font = [UIFont systemFontOfSize:12];
        _type3.textAlignment = NSTextAlignmentCenter;
        
        _point3 = [UILabel new];
        [_backView3 addSubview:_point3];
        _point3.textColor = [UIColor secondMainColor];
        _point3.font = [UIFont systemFontOfSize:22];
        _point3.textAlignment = NSTextAlignmentCenter;
        _point3.whc_CenterX(0).whc_TopSpaceToView(8, _type3);
        
        _margin3 = [UILabel new];
        [_backView3 addSubview:_margin3];
        _margin3.textAlignment = NSTextAlignmentCenter;
        _margin3.textColor = [UIColor textColorWithType:1];
        _margin3.whc_CenterX(0).whc_TopSpaceToView(8, _point3);
        
        _line3 = [UIView new];
        [_backView3 addSubview:_line3];
        _line3.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        _line3.whc_CenterY(0).whc_Height(60).whc_Width(1).whc_RightSpace(0);
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)setValue:(NSArray *)arr{
    for (int i = 0; i < arr.count; i ++) {
        HomeHotModel *model = arr[i];
        if (i == 0) {
            _type1.text = model.instrument_id;
            _point1.text = model.last;
             NSString *str = @"%";
            _margin1.text = [[NSString stringWithFormat:@"%@",model.range] stringByAppendingString:str] ;
        }else if (i == 1){
            _type2.text = model.instrument_id;
            _point2.text = model.last;
             NSString *str = @"%";
            _margin2.text = [[NSString stringWithFormat:@"%@",model.range] stringByAppendingString:str] ;
        }else if (i == 2){
            _type3.text = model.instrument_id;
            _point3.text = model.last;
            NSString *str = @"%";
            _margin3.text = [[NSString stringWithFormat:@"%@",model.range] stringByAppendingString:str] ;
        }
    }
}

@end
