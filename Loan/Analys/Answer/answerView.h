//
//  answerView.h
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Value)(NSInteger which);

@interface answerView : UIView

@property (nonatomic,strong)UIButton *jifen;
@property (nonatomic,strong)UILabel *minu;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UIButton *questionBtn;
@property (nonatomic,strong)UIImageView *flagImage;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UIButton *nextBtn;

@property (nonatomic,strong)UIImageView *tipImage;

- (void)sendValue:(Value)value;

@end

NS_ASSUME_NONNULL_END
