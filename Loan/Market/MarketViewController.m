//
//  MarketViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MarketViewController.h"
#import "MarkNavView.h"
#import "UIColor+Category.h"
#import "MarkHeaderViewCell.h"
#import "HomeTypeViewCell.h"
#import "CustomViewController.h"
#import "AllRequest.h"
#import "LocalCache.h"
#import "NoneView.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>

@interface MarketViewController ()<MarkNavViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger num; //判断是涨幅还是跌幅
    NSInteger fromWhich;
}

@property (nonatomic,strong)MarkNavView *navView;
@property (nonatomic,strong)UITableView *tabView;
@property (nonatomic,strong)NoneView *noneView;


@property (nonatomic,strong)NSMutableArray *upArr;
@property (nonatomic,strong)NSMutableArray *lowArr;
@property (nonatomic,strong)NSMutableArray *favoArr;
@property (nonatomic,strong)NSMutableArray *arr;

@property (nonatomic,strong)ErrorView *err;

@end

@implementation MarketViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handle:) name:@"handle" object:nil];
}

- (void)handle:(NSNotification *)noti{
    if (noti.object) {
        fromWhich = 0;
        [self judest];
    }
}

- (NSArray *)upArr{
    if (!_upArr) {
        self.upArr = [NSMutableArray array];
    }
    return _upArr;
}
- (NSArray *)lowArr{
    if (!_lowArr) {
        self.lowArr = [NSMutableArray array];
    }
    return _lowArr;
}
- (NSArray *)favoArr{
    if (!_favoArr) {
        self.favoArr = [NSMutableArray array];
    }
    return _favoArr;
}
- (NSMutableArray *)arr{
    if (!_arr) {
        self.arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSub];
    
    self->num = 2;
    
    
    [self judest];
    
    //网络监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
}

- (void)notifi:(NSNotification *)noti{
    [self judest];
}

- (void)createSub{
    if (!_navView) {
        _navView = [[MarkNavView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavigationHeight)];
        [self.view addSubview:_navView];
        self.navView.deleagte = self;
    }
}

- (void)createNone{
    if (!_noneView) {
        _noneView = [[NoneView alloc] initWithFrame:CGRectMake(0, NavigationHeight + 15, ScreenWidth, ScreenHeight - NavigationHeight - 10)];
        self.noneView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_noneView];
    }
}

- (void)createTable{
    if (!_tabView) {
        self.tabView = [[UITableView alloc] initWithFrame:CGRectMake(0,NavigationHeight + 15, ScreenWidth, ScreenHeight - NavigationHeight - StatusBarHeight - self.tabBarController.tabBar.frame.size.height) style:UITableViewStylePlain];
    }
    [self.view addSubview:self.tabView];
    self.tabView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
    _tabView.separatorStyle = UITableViewCellStyleDefault;
    _tabView.backgroundColor = [UIColor whiteColor];
//    _tabView.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    _tabView.delegate = self;
    _tabView.dataSource = self;
}

- (void)createError{
    if (!_err) {
        _err = [[ErrorView alloc] init];
        [self.view addSubview:_err];
        _err.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight - self.tabBarController.tabBar.frame.size.height);
        [_err addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loan)]];
        self.view.userInteractionEnabled = YES;
    }
}

- (void)loan{
    [NetworkSingleton new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}


- (void)judest{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"]isEqualToString:@"YES"]) {
         NSDictionary *dic =@{@"token":[LocalCache objectWithKey:@"token"]};
         [self requestData:dic];
     }else{
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self requestData:nil];
         });
     }
}

- (void)requestData:(NSDictionary *)dic{
    if (fromWhich != 0) {
         [SVProgressHUD show];
    }
     //RankAPI
    [AllRequest requestForRank:RankAPI params:dic succ:^(NSDictionary *data) {
        [self.err removeFromSuperview];
        self.err = nil;
        self.noneView = nil;
        [self.noneView removeFromSuperview];
        if (!self.tabView) {
            [self createSub];
        }
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            
            
            [self.upArr removeAllObjects];
            [self.upArr addObjectsFromArray: data[@"result_rise"]];
            
            [self.lowArr removeAllObjects];
            [self.lowArr addObjectsFromArray: data[@"result_fall"]];
            
            [self.favoArr removeAllObjects];
            [self.favoArr addObjectsFromArray: data[@"favo"]];
            
            [self.arr removeAllObjects];
            
            if (self->num == 0) {
                [self.arr addObjectsFromArray: self.upArr];
            }else if (self->num == 1){
                [self.arr addObjectsFromArray: self.lowArr];
            }else {
                [self.arr addObjectsFromArray: self.favoArr];
                self->num = 2;
            }
            if (self.arr.count > 0) {
                self->_noneView = nil;
                [self->_noneView removeFromSuperview];
                [self.tabView removeFromSuperview];
                self.tabView = nil;
                [self createTable];
                [self.tabView reloadData];
            }else{
                [self.tabView reloadData];
//                self.tabView = nil;
//                [self.tabView removeFromSuperview];
                [self createNone];
            }
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
        if (self.arr.count > 0) {
            self.err = nil;
            [self.err removeFromSuperview];
        }else{
            self->_noneView = nil;
            [self->_noneView removeFromSuperview];
            [self.tabView removeFromSuperview];
            self.tabView = nil;
//            [self createError];
        }
    }];
}

#pragma mark tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MarkHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
        if (!cell) {
            cell = [[MarkHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
        }
        return cell;
    }
    HomeTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"type"];
    if (!cell) {
        cell = [[HomeTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"type"];
    }
    HomeModel *model = self.arr[indexPath.row - 1];
    [cell setValueForCell:model which:num];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 35;
    }
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        HomeModel *model = self.arr[indexPath.row - 1];
        CustomViewController *custom = [[CustomViewController alloc] init];
        custom.url = model.detail_url;
        custom.instrument_id = model.instrument_id;
        custom.is_favo = model.is_favo;
//        NSLog(@"======%@",model.instrument_id);
        custom.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:custom animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y <= 0) {
        self.tabView.bounces = NO;
    }else{
        self.tabView.bounces = YES;
    }
}

#pragma mark MarkNavDelegate
- (void)sendValue:(NSString *)which{
    if ([which integerValue] == 10000) {
        [self.tabView removeFromSuperview];
        self.tabView = nil;
        [self.tabView reloadData];
        [self.arr removeAllObjects];
        [self.arr addObjectsFromArray: self.upArr];
        num = 0;
        [self createTable];
    }else if ([which integerValue] == 10001){
        [self.tabView removeFromSuperview];
        self.tabView = nil;
        [self.tabView reloadData];
        [self.arr removeAllObjects];
        [self.arr addObjectsFromArray: self.lowArr];
        num = 1;
        [self createTable];
    }else{
        [self.tabView removeFromSuperview];
        self.tabView = nil;
        [self.tabView reloadData];
        [self.arr removeAllObjects];
        [self.arr addObjectsFromArray: self.favoArr];
        num = 2;
        [self createTable];
    }
    if (self.arr.count == 0) {
        [self.tabView removeFromSuperview];
        self.tabView = nil;
        [self createNone];
    }else{
        [self.noneView removeFromSuperview];
        self.noneView = nil;
        [self.tabView reloadData];
        [self createTable];
    }
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
