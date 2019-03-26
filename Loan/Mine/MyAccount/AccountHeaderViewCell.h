//
//  AccountHeaderViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountHeaderViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *amount;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *total;

@end

NS_ASSUME_NONNULL_END
