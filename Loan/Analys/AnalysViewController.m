//
//  AnalysViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AnalysViewController.h"
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "AnswerViewController.h"
#import "AllRequest.h"
#import "LocalCache.h"
#import <SVProgressHUD.h>
#import "UIImageView+WebCache.h"
#import "NetworkSingleton.h"
#import <AFNetworking.h>

@interface AnalysViewController ()

@property (nonatomic,strong)UIImageView *backImage;
@property (nonatomic,strong)UIImageView *answerImage;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *num;
@property (nonatomic,strong)UILabel *right1;
@property (nonatomic,strong)UILabel *right2;

@property (nonatomic,strong)UIImageView *kImage;

@property (nonatomic,strong)NSDictionary *dic;

@property (nonatomic,strong)ErrorView *err;


@end

@implementation AnalysViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor mainColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor textColorWithType:0],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];

}

- (NSDictionary *)dic{
    if (!_dic) {
        self.dic = [NSDictionary dictionary];
    }
    return _dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"分析";
    [self getData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
}

- (void)notifi:(NSNotification *)noti{
    [self getData];
}

- (void)getData{
    [SVProgressHUD show];
    [AllRequest requestFromNet:AnalysisAPI params:nil succ:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            self.dic = data[@"data"];
            [self createSub:self.dic];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if ([self.dic[@"instrument_id"] length] > 0 ) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else{
            [self.backImage removeFromSuperview];
            self.backImage = nil;
            [self createError];
        }
    }];
}

- (void)createSub:(NSDictionary *)dic{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic"]];
        _backImage.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationHeight);
        [self.view addSubview:_backImage];
    }
    if (!_tip) {
        _tip = [[UILabel alloc] init];
        [self.backImage addSubview:_tip];
        _tip.textAlignment = NSTextAlignmentCenter;
        _tip.whc_TopSpaceToView(240 *ScaleHeight, self.backImage).whc_CenterX(0).whc_Height(20);
        _tip.text = @"趋势分析火热进行中";
        _tip.textColor = [UIColor textColorWithType:0];
        _tip.font = [UIFont systemFontOfSize:14];
        _tip.textAlignment = NSTextAlignmentCenter;
    }
    if (!_name) {
        _name = [[UILabel alloc] init];
        [self.backImage addSubview:_name];
        _name.whc_TopSpaceToView(25, self.tip).whc_LeftSpace(45);
        _name.text = _dic[@"instrument_id"];
        _name.textColor = [UIColor textColorWithType:0];
        _name.font = [UIFont systemFontOfSize:12];
        _name.textAlignment = NSTextAlignmentCenter;
    }
    if (!_right1) {
        _right1 = [[UILabel alloc] init];
        [self.backImage addSubview:_right1];
        _right1.whc_TopSpaceToView(25, self.tip).whc_RightSpace(45);
        _right1.text = _dic[@"range_value"];
        _right1.textColor = [UIColor textColorWithType:0];
        _right1.font = [UIFont systemFontOfSize:12];
        _right1.textAlignment = NSTextAlignmentCenter;
    }
    if (!_num) {
        _num = [[UILabel alloc] init];
        [self.backImage addSubview:_num];
        _num.whc_TopSpaceToView(2, self.name).whc_LeftSpace(45);
        _num.text = _dic[@"last"];
        _num.textColor = [UIColor colorWithHexString:@"#F55948"];
        _num.font = [UIFont systemFontOfSize:18];
        _num.textAlignment = NSTextAlignmentCenter;
    }
    if (!_right2) {
        _right2 = [[UILabel alloc] init];
        [self.backImage addSubview:_right2];
        _right2.whc_TopSpaceToView(2, self.name).whc_RightSpace(45);
        _right2.text = [NSString stringWithFormat:@"%.2f%%",[_dic[@"range"] floatValue]*100];
        _right2.textColor = [UIColor textColorWithType:0];
        _right2.font = [UIFont systemFontOfSize:12];
        _right2.textAlignment = NSTextAlignmentCenter;
    }
    if (!_kImage) {
        _kImage = [[UIImageView alloc] init];
    }
    [_kImage sd_setImageWithURL:[NSURL URLWithString:_dic[@"pic"]]];
    [self.backImage addSubview:_kImage];
    _kImage.whc_CenterX(0).whc_TopSpaceToView(15, self.num).whc_LeftSpace(45).whc_RightSpace(45).whc_Height(185 *ScaleHeight);
    if (!_answerImage) {
        _answerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Entrance"]];
        [self.view addSubview:_answerImage];
        _answerImage.whc_RightSpace(0).whc_BottomSpace(20).whc_Width(150 *ScaleWidth).whc_Height(150 *ScaleWidth);
        _answerImage.userInteractionEnabled = YES;
        [_answerImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(answerAction)]];
    }
}

- (void)createError{
    if (!_err) {
        _err = [[ErrorView alloc] init];
        [self.view addSubview:_err];
        _err.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight - self.tabBarController.tabBar.frame.size.height);
        [_err addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loan)]];
    }
}

- (void)loan{
    [NetworkSingleton new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

#pragma mark 问答
- (void)answerAction{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"]isEqualToString:@"YES"]) {
        AnswerViewController *answer = [[AnswerViewController alloc] init];
        [answer setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:answer animated:YES];
    }else{
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"登录后才可以答题哟"];
        return;
    }
}


@end
