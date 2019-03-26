//
//  RegisterView.h
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Value)(NSString *phone);

@protocol RegisterViewDelegate <NSObject>

- (void)sendValueForRegister:(NSDictionary *)dic;

@end

@interface RegisterView : UIView

@property (nonatomic,strong)UILabel *tip1;
@property (nonatomic,strong)UILabel *tip2;
@property (nonatomic,strong)UILabel *registe;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UITextField *text;
@property (nonatomic,strong)UILabel *code;
@property (nonatomic,strong)UIButton *registerBtn;


@property (nonatomic,strong)UIImageView *close;



@property (nonatomic,weak)id<RegisterViewDelegate>delegate;

- (void)sendValue:(Value)value;


@end

NS_ASSUME_NONNULL_END
