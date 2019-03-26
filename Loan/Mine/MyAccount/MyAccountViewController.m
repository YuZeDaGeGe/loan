//
//  MyAccountViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/7.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MyAccountViewController.h"
#import "UIColor+Category.h"
#import "AccountHeaderViewCell.h"
#import "AccountInfoViewCell.h"
#import "HomeCustomViewCell.h"
#import "BaseNavigationBar.h"
#import "AllRequest.h"
#import "LocalCache.h"
#import "NoneView.h"
#import <SVProgressHUD.h>
#import "LoginViewController.h"
#import <AFNetworking.h>


@interface MyAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *score;
}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)BaseNavigationBar *nav;
@property (nonatomic,strong)NoneView *none;

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)ErrorView *err;

@end

@implementation MyAccountViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
    
    [self getDataFromNet];
    
}

- (void)getDataFromNet{
    NSDictionary *dic = @{@"token":[LocalCache objectWithKey:@"token"]};
    [SVProgressHUD show];
    [AllRequest requestForAccount:AccountAPI params:dic succ:^(NSDictionary *data) {
        [self.err removeFromSuperview];
        self.err = nil;
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",data[@"errcode"]] isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:@"登录失效,请重新登录"];
            LoginViewController *login = [[LoginViewController alloc] init];
            [self presentViewController:login animated:YES completion:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }
        if ([data[@"status"] isEqualToString:@"success"]) {
            self.dataArr = data[@"list"];
            if (self.dataArr.count == 0) {
                [self.tableView removeFromSuperview];
                self.tableView = nil;
                [self createNone];
            }else{
                [self.none removeFromSuperview];
                self.none = nil;
                [self.view addSubview:self.tableView];
            }
            [self.tableView reloadData];
            self->score = [NSString stringWithFormat:@"%@",data[@"score"]];
            [self.tableView reloadData];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.dataArr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else if (!self.none){
            [self.tableView removeFromSuperview];
            self.tableView = nil;
            [self createError];
        }
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
}

- (void)notifi:(NSNotification *)noti{
    [self getDataFromNet];
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


- (void)createNav{
    if (!_nav) {
        _nav = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        _nav.titleLable.text = @"我的账户";
        _nav.titleLable.textColor = [UIColor mainColor];
        _nav.backgroundColor = [UIColor colorWithHexString:@"#FF6952"];
        [_nav.leftBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
        [_nav.leftBtn setImage:[UIImage imageNamed:@"back_write_icon"] forState:UIControlStateNormal];
        _nav.line.hidden = YES;
        [self.view addSubview:_nav];
    }
}
- (void)createNone{
    if (!_none) {
        self.none = [[NoneView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight - NavigationHeight)];
    }
    [self.view addSubview:_none];
}
- (void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataArr.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HomeCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
            if (!cell) {
                cell = [[HomeCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
                [cell setValueForAccount];
            }
            return cell;
        }
        AccountInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"info"];
        if (!cell) {
            cell = [[AccountInfoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info"];
        }
        if (self.dataArr.count > 0) {
            MyAccountModel *model = self.dataArr[indexPath.row - 1];
            [cell setValueForCell:model];
        }
        return cell;
    }
    AccountHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (!cell) {
        cell = [[AccountHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    }
    cell.amount.text = score;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    return 50;
}
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight-NavigationHeight-self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor mainColor];
    }
    return _tableView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y <= 0) {
        self.tableView.bounces = NO;
    }else{
        self.tableView.bounces = YES;
    }
}

- (NoneView *)none{
   
    return _none;
}

#pragma mark
- (void)clickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

