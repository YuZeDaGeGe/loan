//
//  MineViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MineViewController.h"
#import "UIColor+Category.h"
#import "MineHeaderViewCell.h"
#import "MineCustomViewCell.h"
#import "MyAccountViewController.h"
#import "IdeaSuggestViewController.h"
#import "SetViewController.h"
#import "LoginViewController.h"
#import "BaseNavigationBar.h"
#import "LocalCache.h"
#import <SVProgressHUD.h>

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)BaseNavigationBar *nav;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadAction:) name:@"isLoad" object:nil];
}

#pragma mark
- (void)reloadAction:(NSNotification *)noti{
    if (noti.object) {
        [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        MineHeaderViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
        cell.name.userInteractionEnabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
       MineCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"custom"];
        if (!cell) {
            cell = [[MineCustomViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"custom"];
            [cell setValueForCell:indexPath.row];
        }
        return cell;
    }
    MineHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"header"];
    if (!cell) {
        cell = [[MineHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"] isEqualToString:@"YES"]) {
        cell.name.text = [LocalCache objectWithKey:@"mobile"];
        cell.name.userInteractionEnabled = NO;
        cell.header.userInteractionEnabled = NO;
        cell.header.backgroundColor = [UIColor colorWithHexString:@"#FF6952"];
    }else{
        cell.name.userInteractionEnabled = YES;
        cell.header.userInteractionEnabled = YES;
    }
    [cell.header addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpLogin)]];
    [cell.name addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpLogin)]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 210 *ScaleHeight;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10.0f;
    }
    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isLogin"]isEqualToString:@"YES"]) {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                MyAccountViewController *account = [[MyAccountViewController alloc] init];
                account.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:account animated:YES];
            }
            if (indexPath.row == 2) {
                IdeaSuggestViewController *idea = [[IdeaSuggestViewController alloc] init];
                idea.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:idea animated:YES];
            }
            if (indexPath.row == 1) {
                SetViewController *set = [[SetViewController alloc] init];
                set.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:set animated:YES];
            }
        }
    }else if(indexPath.section != 0){
        [SVProgressHUD showErrorWithStatus:@"登录后才可以操作哟"];
        return;
    }
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, - StatusBarHeight, ScreenWidth, ScreenHeight-self.tabBarController.tabBar.frame.size.height + StatusBarHeight) style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f1f3f5"];
    }
  return _tableView;
}

#pragma mark 登陆界面
- (void)jumpLogin{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

@end
