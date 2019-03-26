//
//  HomeCustomViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeCustomViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *allLabel;


- (void)setValueForCell:(NSInteger)section;

- (void)setValueForAccount;



@end

