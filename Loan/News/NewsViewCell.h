//
//  NewsViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/13.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *top;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *mid;
@property (nonatomic,strong)UIImageView *tipImage;
@property (nonatomic,strong)UILabel *bottomLabel;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UILabel *newsInfo;

- (void)setValueForCell:(NewsModel *)model;

@end

NS_ASSUME_NONNULL_END
