//
//  HomeTypeViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTypeViewCell : UITableViewCell

- (void)setValueForCell:(HomeModel *)model which:(NSInteger)which;

@end

NS_ASSUME_NONNULL_END
