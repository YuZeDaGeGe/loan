//
//  AnswerViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AnswerViewController.h"
#import "UIColor+Category.h"
#import <WHC_AutoLayout.h>
#import "answerView.h"
#import "AllAnswerView.h"
#import "BaseNavigationBar.h"
#import "AllRequest.h"
#import "LocalCache.h"
#import "AnalyQuestionModel.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "LoginViewController.h"
#import <AFNetworking.h>


@interface AnswerViewController ()
{
    NSString *scores;
    NSInteger num; //记录当前是第几次答题
    NSInteger rightNum; //答对了几道题
    BOOL  is_Choose;  //是否选择了答案
}

@property (nonatomic,strong)UIImageView *backImage;
@property (nonatomic,strong)answerView *answer;
@property (nonatomic,strong)AllAnswerView *allAnswer;
@property (nonatomic,strong)BaseNavigationBar *nav;

@property (nonatomic,strong)AnalyQuestionModel *model;

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)ErrorView *err;



@end

@implementation AnswerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [self request];
    
}

-(NSArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSub];
    

    num = 0;
    rightNum = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
}

- (void)notifi:(NSNotification *)noti{
    [self request];
}

- (void)request{
    [SVProgressHUD show];
    NSDictionary *dic = @{@"token":[LocalCache objectWithKey:@"token"]};
    [AllRequest requestForQuestion:QuestionAPI params:dic succ:^(NSDictionary *data) {
        [self.err removeFromSuperview];
        self.err = nil;
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",data[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            self.dataArr = data[@"data"];
            self->scores = data[@"score"];
            [self createAnswer:self->scores];
        }
        
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.dataArr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else{
            [self.answer removeFromSuperview];
            self.answer = nil;
            [self createError];
        }
        
    }];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)createSub{
    if (!_nav) {
        _nav = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        _nav.titleLable.text = @"趣味问答";
        _nav.titleLable.textColor = [UIColor mainColor];
        _nav.backgroundColor = [UIColor colorWithHexString:@"#F35940"];
        [_nav.leftBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
        [_nav.leftBtn setImage:[UIImage imageNamed:@"back_write_icon"] forState:UIControlStateNormal];
        _nav.line.hidden = YES;
        [self.view addSubview:_nav];
    }
    
    if (!_backImage) {
        self.backImage = [[UIImageView alloc]init];
        _backImage.image = [UIImage imageNamed:@"background"];
        _backImage.userInteractionEnabled = YES;
        [self.view addSubview:_backImage];
    } _backImage.whc_TopSpace(NavigationHeight).whc_LeftSpace(0).whc_RightSpace(0).whc_Height(ScreenHeight);
    ;
}
- (void)createAnswer:(NSString *)score{
    if (!_answer) {
        _answer = [[answerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight *ScaleHeight)];
        [self.backImage addSubview:_answer];
    }
    _answer.nextBtn.tag = 20000;
    [_answer.nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _model = self.dataArr[num];
    [_answer.jifen setTitle:[NSString stringWithFormat:@"当前积分 %@",score] forState:UIControlStateNormal];
    _answer.title.text = [NSString stringWithFormat:@"%ld.%@",num + 1,_model.name];
    NSArray *arr = [AnalyAnswerModel mj_objectArrayWithKeyValuesArray:_model.answers];
    for (UIButton *btn in _answer.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag >= 10000 && btn.tag < 20000) {
                for (UILabel *label in btn.subviews) {
                    if ([label isKindOfClass:[UILabel class]]) {
                        AnalyAnswerModel *model = arr[label.tag - 30000];
                        label.text = model.name;
                        label.whc_HeightAuto();
                        btn.whc_HeightAuto();
                    }
                }
            }
        }
    }
}

- (void)createAllAnswer:(NSString *)score{
    if (!_allAnswer) {
        _allAnswer = [[AllAnswerView alloc] init];
        [self.backImage addSubview:_allAnswer];
        _allAnswer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight *ScaleHeight);
    }
    _allAnswer.all.text = [NSString stringWithFormat:@"%@",score];
    [_allAnswer.againBtn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 下一题
- (void)nextAction:(UIButton *)btn{
    NSArray *arr = [AnalyAnswerModel mj_objectArrayWithKeyValuesArray:_model.answers];
    [_answer sendValue:^(NSInteger which) {
        if (which > 9999) {
            self->is_Choose = YES;
            AnalyAnswerModel *model = arr[which - 10000];
            if ([model.is_true integerValue] == 1) {
                self->rightNum ++;
            }else{
                self->rightNum --;
                if (self->rightNum < 0) {
                    self->rightNum = 0;
                }
            }
        }
    }];
    if (is_Choose) {
        is_Choose = NO;
        num ++;
        if (num == 4) {
            _backImage.image = [UIImage imageNamed:@"back"];
            self.navigationController.navigationBar.translucent = YES;
            [_answer removeFromSuperview];
            _answer = nil;
            [self getResult];
            
        }else{
            [_answer removeFromSuperview];
            _answer = nil;
            [self createAnswer:self->scores];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"请先选择答案才可以进行下一题哦"];
        return;
    }
    
}

#pragma mark 答题结果反馈
- (void)getResult{
    NSDictionary *dic = @{@"token":[LocalCache objectWithKey:@"token"],@"correct_num":[NSString stringWithFormat:@"%ld",(long)rightNum]};
    [SVProgressHUD show];
    [AllRequest requestFromNet:ResultBackAPI params:dic succ:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            [self createAllAnswer:data[@"data"][@"score"]];
            self->scores = data[@"data"][@"score"];
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"恭喜您答对了%ld道", (long)self->rightNum]];
        }
        
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

#pragma mark 再来一次
- (void)againAction{
    [self request];
    _backImage.image = [UIImage imageNamed:@"background"];
    self.navigationController.navigationBar.translucent = NO;
    [_allAnswer removeFromSuperview];
    _allAnswer = nil;
    num = 0;
    rightNum = 0;
    [self createAnswer:self->scores];
}

@end
