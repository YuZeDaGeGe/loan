//
//  MainTabBarController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "MainTabBarController.h"
#import "UIColor+Category.h"
#import "Tools.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "MarketViewController.h"
#import "AnalysViewController.h"
#import "MineViewController.h"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBar appearance]setTintColor:[UIColor colorWithHexString:@"#EB4B2B"]];
    [UITabBar appearance].translucent = NO;
    
    [self setupChildViewControllers];
    
    self.selectedIndex = 0;
    
}

- (void)setupChildViewControllers{
    HomeViewController *home = [[HomeViewController alloc] init];
    home.is_valid = NO;
    [self childViewController:home imageName:@"home_icon" selectedImageName:@"home_press_icon" withTitle:HOME];
    
    NewsViewController *news = [[NewsViewController alloc] init];
    [self childViewController:news imageName:@"Newsletter_icon" selectedImageName:@"Newsletter_press_icon" withTitle:NEWS];
    
    MarketViewController *market = [[MarketViewController alloc] init];
    [self childViewController:market imageName:@"Quotes_icon" selectedImageName:@"Quotes_press_icon" withTitle:MARKET];
    
    AnalysViewController *analys = [[AnalysViewController alloc] init];
    [self childViewController:analys imageName:@"analysis_icon" selectedImageName:@"analysis_press_icon" withTitle:ANALYS];
    
    MineViewController *mine = [[MineViewController alloc] init];
    [self childViewController:mine imageName:@"mine_icon" selectedImageName:@"mine_press_icon" withTitle:MINE];
    
}

- (void)childViewController:(UIViewController *)vc imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName withTitle:(NSString *)title {
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationItem.title = title;
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    [self addChildViewController:nav];
}
@end
