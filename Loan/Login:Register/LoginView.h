//
//  LoginView.h
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginViewDelegate <NSObject>

- (void)sendValueForLogin:(NSDictionary *)dic;

@end

@interface LoginView : UIView

@property (nonatomic,strong)UILabel *tip1;
@property (nonatomic,strong)UILabel *tip2;
@property (nonatomic,strong)UILabel *registe;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,strong)UITextField *text;
@property (nonatomic,strong)UILabel *forget;
@property (nonatomic,strong)UIButton *loginBtn;

@property (nonatomic,strong)UIImageView *close;

@property (nonatomic,weak)id<LoginViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
