//
//  MineCustomViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MineCustomViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *tipImage;
@property (nonatomic,strong)UILabel *tipLabel;

- (void)setValueForCell:(NSInteger)row;

@end

