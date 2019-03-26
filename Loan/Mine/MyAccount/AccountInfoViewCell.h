//
//  AccountInfoViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccountInfoViewCell : UITableViewCell

- (void)setValueForCell:(MyAccountModel *)model;

@end

NS_ASSUME_NONNULL_END
