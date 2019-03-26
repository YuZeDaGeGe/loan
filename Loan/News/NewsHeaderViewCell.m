//
//  NewsHeaderViewCell.m
//  Loan
//
//  Created by tangfeimu on 2019/3/13.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NewsHeaderViewCell.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"

@implementation NewsHeaderViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSDictionary *dic = [self setTime];
        if (!_month) {
            _month = [[UILabel alloc] init];
            [self.contentView addSubview:_month];
            _month.whc_TopSpace(20).whc_LeftSpace(12).whc_Width(38).whc_Height(15);
            _month.text = [NSString stringWithFormat:@"%@月",dic[@"month"]];
            _month.textColor = [UIColor colorWithHexString:@"#FE380F"];
            _month.font = [UIFont systemFontOfSize:10];
            _month.textAlignment = NSTextAlignmentCenter;
            _month.layer.borderColor = [UIColor colorWithHexString:@"#DDDBDB"].CGColor;
            _month.layer.borderWidth = 1;
            _month.layer.masksToBounds = YES;
        }
        if (!_day) {
            _day = [[UILabel alloc] init];
            [self.contentView addSubview:_day];
            _day.whc_TopSpaceToView(0, _month).whc_LeftSpace(12).whc_Width(38).whc_Height(15);
            _day.text = [NSString stringWithFormat:@"%@号",dic[@"day"]];
            _day.textColor = [UIColor mainColor];
            _day.font = [UIFont systemFontOfSize:10];
            _day.textAlignment = NSTextAlignmentCenter;
            _day.backgroundColor = [UIColor secondMainColor];
        }
        if (!_today) {
            _today = [[UILabel alloc] init];
            [self.contentView addSubview:_today];
            _today.whc_TopSpace(20).whc_LeftSpaceToView(0, _month).whc_Height(15).whc_Width(38).whc_CenterYToView(0, _month);
            _today.text = @"今天";
            _today.textColor = [UIColor textColorWithType:0];
            _today.textAlignment = NSTextAlignmentCenter;
            _today.font = [UIFont systemFontOfSize:12];
        }
        if (!_week) {
            _week = [[UILabel alloc] init];
            [self.contentView addSubview:_week];
            _week.whc_TopSpaceToView(0, _today).whc_LeftSpaceToView(5, _day).whc_Height(15).whc_Width(38).whc_CenterYToView(0, _day);
            _week.text = [self getCurrentWeekDay];
            _week.textColor = [UIColor colorWithHexString:@"#999999"];
            _week.textAlignment = NSTextAlignmentCenter;
            _week.font = [UIFont systemFontOfSize:12];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (NSDictionary *)setTime{
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | //年
    NSMonthCalendarUnit | //月份
    NSDayCalendarUnit | //日
    NSHourCalendarUnit |  //小时
    NSMinuteCalendarUnit |  //分钟
    NSSecondCalendarUnit;  // 秒
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:nowDate];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSDictionary *dataDic = @{@"month":[NSString stringWithFormat:@"%ld",month],@"day":[NSString stringWithFormat:@"%ld",day]};
    return dataDic;
}

- (NSString *)getWeekDayFordate:(NSTimeInterval)data {
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
- (NSString*)getCurrentWeekDay{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    return [self getWeekDayFordate:interval];
}

@end
