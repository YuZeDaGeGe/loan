//
//  MarkHeaderViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MarkHeaderViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "UIColor+Category.h"

@interface MarkHeaderViewCell ()

@property (nonatomic,strong)UILabel *type;
@property (nonatomic,strong)UIView *line;

@end

@implementation MarkHeaderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (int  i = 0; i < 3; i ++) {
            _type = [[UILabel alloc] init];
            [self.contentView addSubview:_type];
            self.type.textAlignment = NSTextAlignmentCenter;
            self.type.textColor = [UIColor colorWithHexString:@"#999999"];
            self.type.font = [UIFont systemFontOfSize:12];
            _type.whc_CenterY(0).whc_LeftSpace(ScreenWidth / 3 *i ).whc_Width(ScreenWidth / 3).whc_TopSpace(0).whc_BottomSpace(0);
            if (i == 0) {
                _type.text = @"名称";
            }else if (i == 1){
                _type.text = @"最新价";
            }else{
                _type.text = @"涨跌(24)";
            }
        }
        if (!_line) {
            _line = [[UIView alloc] init];
            [self.contentView addSubview:_line];
            _line.whc_BottomSpace(0).whc_LeftSpace(20).whc_RightSpace(0).whc_Height(1);
            _line.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
        }
    }
    return self;
}


@end
