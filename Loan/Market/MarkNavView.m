//
//  MarkNavView.m
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MarkNavView.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@interface MarkNavView()

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UIView *line;

@end

@implementation MarkNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        for (int i = 0; i < 3; i ++) {
                _typeLabel = [[UILabel alloc] init];
                [self addSubview:_typeLabel];
                _typeLabel.whc_TopSpace(20).whc_BottomSpace(0).whc_LeftSpace(ScreenWidth / 3 *i ).whc_Width(ScreenWidth / 3);
                if (i == 0) {
                    _typeLabel.text = @"涨幅榜";
                }else if (i == 1){
                    _typeLabel.text = @"跌幅榜";
                }else if (i == 2){
                    _typeLabel.text = @"自选";
                }
                _typeLabel.tag = 10000 + i;
                _typeLabel.userInteractionEnabled = YES;
                [_typeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)]];
                _typeLabel.textAlignment = NSTextAlignmentCenter;
                _typeLabel.backgroundColor = [UIColor mainColor];
                _typeLabel.textColor = [UIColor textColorWithType:0];
                
                _line = [[UIView alloc] init];
                [self.typeLabel addSubview:_line];
                _line.tag = 10000+i;
                _line.whc_TopSpace(NavigationHeight - 10).whc_CenterX(0).whc_Width(60).whc_Height(3);
                _line.backgroundColor = [UIColor secondMainColor];
                if (i != 2) {
                    _line.hidden = YES;
                }
            }
        }
    return self;
}

- (void)clickAction:(UITapGestureRecognizer *)tap{
    UILabel *type1 = [(UILabel *)self viewWithTag:10000];
    UILabel *type2 = [(UILabel *)self viewWithTag:10001];
    UILabel *type3 = [(UILabel *)self viewWithTag:10002];
    if (tap.view.tag == 10000) {
        for (UIView *line in type1.subviews) {
            line.hidden = NO;
        }
        for (UIView *line in type2.subviews) {
            line.hidden = YES;
        }
        for (UIView *line in type3.subviews) {
            line.hidden = YES;
        }
    }else if (tap.view.tag == 10001){
        for (UIView *line in type2.subviews) {
            line.hidden = NO;
        }
        for (UIView *line in type1.subviews) {
            line.hidden = YES;
        }
        for (UIView *line in type3.subviews) {
            line.hidden = YES;
        }
    }else if (tap.view.tag == 10002){
        for (UIView *line in type3.subviews) {
            line.hidden = NO;
        }
        for (UIView *line in type1.subviews) {
            line.hidden = YES;
        }
        for (UIView *line in type2.subviews) {
            line.hidden = YES;
        }
    }
    
    if ([_deleagte respondsToSelector:@selector(sendValue:)]) {
        [_deleagte sendValue:[NSString stringWithFormat:@"%ld",tap.view.tag]];
    }
}

@end
