//
//  NewsHeaderViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/13.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsHeaderViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *month;
@property (nonatomic,strong)UILabel *day;
@property (nonatomic,strong)UILabel *today;
@property (nonatomic,strong)UILabel *week;

@end

NS_ASSUME_NONNULL_END
