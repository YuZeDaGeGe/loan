//
//  NewsViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsHeaderViewCell.h"
#import "NewsViewCell.h"
#import <WHC_AutoLayout.h>
#import "AllRequest.h"
#import "NewsModel.h"
#import "NetworkSingleton.h"
#import <SVProgressHUD.h>
#import "UIColor+Category.h"
#import "AppDelegate.h"
#import <AFNetworking.h>

@interface NewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic,strong)ErrorView *err;

@end

@implementation NewsViewController

- (NSArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSArray array];
    }
    return _dataArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   

}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"24h快讯";
    
    [self createSub];
    
     [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
}

- (void)notifi:(NSNotification *)noti{
     [self requestData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestData{
    [SVProgressHUD show];
    [AllRequest requestForNews:NewsAPI parmas:nil succ:^(NSDictionary *data) {
        [self.err removeFromSuperview];
        self.err = nil;
        if (!self.tableView) {
            [self createSub];
        }
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            self.dataArr = data[@"datalist"];
            [self.tableView reloadData];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.dataArr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else{
            [self.tableView removeFromSuperview];
            self.tableView = nil;
            [self createError];
        }
    }];
}

- (void)createSub{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth,ScreenHeight - NavigationHeight - self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    }
    [self.view addSubview:_tableView];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        NewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"info"];
        if (!cell) {
            cell = [[NewsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info"];
        }
        if (indexPath.row == 1) {
            cell.tipImage.image = [UIImage imageNamed:@"point_press_icon"];
            cell.tipImage.whc_Width(10).whc_Height(10);
        }else{
            cell.tipImage.whc_Width(6).whc_Height(6);
        }
        NewsModel *model = self.dataArr[indexPath.row - 1];
        [cell setValueForCell:model];
        return cell;
    }
    NewsHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (!cell) {
        cell = [[NewsHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }
    return [NewsViewCell whc_CellHeightForIndexPath:indexPath tableView:tableView] + 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
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

@end
