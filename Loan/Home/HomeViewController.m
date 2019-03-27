//
//  HomeViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCustomViewCell.h"
#import "UIColor+Category.h"
#import "HomeTypeViewCell.h"
#import "HomeHotViewCell.h"
#import "LocalCache.h"
#import "AllRequest.h"
#import "CustomViewController.h"
#import <SVProgressHUD.h>
#import "AdvertiseView.h"
#import <WHC_AutoLayout.h>

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)AdvertiseView *adver;
@property (nonatomic,strong)UIView *coverView;
@property (nonatomic,strong)UIWindow *window;

@property (nonatomic,strong)NSArray *hotArr;
@property (nonatomic,strong)NSArray *listArr;

@end

@implementation HomeViewController

- (NSArray *)hotArr{
    if (!_hotArr) {
        _hotArr = [NSArray array];
    }
    return _hotArr;
}

- (NSArray *)listArr{
    if (!_listArr) {
        _listArr = [NSArray array];
    }
    return _listArr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handle:) name:@"handle" object:nil];
}

- (void)handle:(NSNotification *)noti{
    if (noti.object) {
        [self requestForData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.is_valid) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Splash screen"]];
    }else{
        self.navigationItem.title = @"数字期货通";
        [self.view addSubview:self.tableView];
        
        [self requestForData];
        
        
        [self getContentFromNet];
        
    }
}

#pragma mark 网络数据请求
- (void)requestForData{
    [SVProgressHUD show];
    NSDictionary *dic;
     if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
         dic = @{@"token":[LocalCache objectWithKey:@"token"]};
     }else{
         dic = nil;
     }
    [AllRequest requestForHome:HomeAPI params:dic succ:^(NSDictionary *data) {
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"success"]) {
            self.hotArr = data[@"hot"];
            self.listArr = data[@"list"];
            [self.tableView reloadData];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self presentViewController:[Tools returnAlert] animated:YES completion:nil];
    }];
}

#pragma mark 弹窗请求
- (void)getContentFromNet{
    [AllRequest requestFromNet:VersionAPI params:nil succ:^(NSDictionary *data) {
         if ([data[@"status"] isEqualToString:@"success"]) {
             if ([data[@"data"][@"home_popup"][@"is_open"] isEqualToString:@"1"]) {
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self createAdvertise];
                     self->_adver.title.text = data[@"data"][@"home_popup"][@"title"];
                     self->_adver.contentLabel.text = data[@"data"][@"home_popup"][@"content"];
                     self->_adver.backView.whc_Height(self->_adver.title.frame.size.height + self->_adver.contentLabel.frame.size.height + 300);
                 });
             }
        }
    } fault:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1+self.listArr.count;
    }
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row !=0) {
            HomeTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"type"];
            if (!cell) {
                cell = [[HomeTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"type"];
            }
            HomeModel *model = self.listArr[indexPath.row - 1];
            [cell setValueForCell:model which:2];
            return cell;
        }
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            HomeHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hot"];
            if (!cell) {
                cell = [[HomeHotViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hot"];
            }
            [cell.backView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailAction:)]];
            [cell.backView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailAction:)]];
            [cell.backView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailAction:)]];
            [cell setValue:self.hotArr];
            return cell;
        }
    }
    HomeCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"custom"];
    if (!cell) {
        cell = [[HomeCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"custom"];
    }
    [cell setValueForCell:indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 123.f;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row != 0) {
            return 55.f;
        }
    }
    return 35.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row != 0) {
         HomeModel *model = self.listArr[indexPath.row - 1];
        if (indexPath.section == 1) {
            if (indexPath.row != 0) {
                CustomViewController *custom = [[CustomViewController alloc] init];
                custom.url = model.detail_url;
                custom.instrument_id = model.instrument_id;
                custom.is_favo = model.is_favo;
                custom.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:custom animated:YES];
            }
        }
    }
}


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationHeight, ScreenWidth, ScreenHeight-NavigationHeight-self.tabBarController.tabBar.frame.size.height ) style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    }
    return _tableView;
}
- (void)createAdvertise{
    if (!_adver) {

       _window  = [UIApplication sharedApplication].keyWindow;//注：keyWindow当前显示界面的window
        if (!_adver) {
            _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.7;
        _coverView.userInteractionEnabled = YES;
        [_window addSubview:_coverView];
        _adver = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_adver.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        _adver.userInteractionEnabled = YES;
        [_window addSubview:_adver];
        
    }
}

- (void)closeAction{
    
    [_coverView removeFromSuperview];
    [_adver removeFromSuperview];
    _coverView = nil;
    _adver = nil;
    
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

#pragma mark
- (void)detailAction:(UITapGestureRecognizer *)tap{
    HomeHotModel *model = self.hotArr[tap.view.tag - 10001];
    CustomViewController *custom = [[CustomViewController alloc] init];
    custom.url = model.detail_url;
    custom.is_favo = model.is_favo;
    custom.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:custom animated:YES];
}

@end
