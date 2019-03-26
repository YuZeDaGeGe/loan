//
//  HomeHotViewCell.h
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface HomeHotViewCell : UITableViewCell

@property (nonatomic,strong)UIView *backView1;
@property (nonatomic,strong)UILabel *type1;
@property (nonatomic,strong)UILabel *point1;
@property (nonatomic,strong)UILabel *margin1;
@property (nonatomic,strong)UIView *line1;

@property (nonatomic,strong)UIView *backView2;
@property (nonatomic,strong)UILabel *type2;
@property (nonatomic,strong)UILabel *point2;
@property (nonatomic,strong)UILabel *margin2;
@property (nonatomic,strong)UIView *line2;

@property (nonatomic,strong)UIView *backView3;
@property (nonatomic,strong)UILabel *type3;
@property (nonatomic,strong)UILabel *point3;
@property (nonatomic,strong)UILabel *margin3;
@property (nonatomic,strong)UIView *line3;


- (void)setValue:(NSArray *) arr;

@end

NS_ASSUME_NONNULL_END
