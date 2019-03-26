//
//  CustomViewController.m
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ReloadViewController.h"
#import <WebKit/WebKit.h>
#import <SVProgressHUD.h>
#import <WHC_AutoLayout.h>
#import "UIColor+Category.h"
#import "AllRequest.h"
#import "LocalCache.h"
#import "UIView+CornerRadiusLayer.h"
#import "LoginViewController.h"
#import <AFNetworking.h>

@interface ReloadViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong)WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic,strong)UIProgressView *progressView;

@property (nonatomic,strong)UIImageView *image;

@end

@implementation ReloadViewController

- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
        _wkConfig.allowsPictureInPictureMediaPlayback = YES;
    }
    return _wkConfig;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavigationHeight , ScreenWidth, ScreenHeight + 10) configuration:self.wkConfig];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, NavigationHeight ,  [[UIScreen mainScreen] bounds].size.width, 2)];
        _progressView.backgroundColor = [UIColor blueColor];
        //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.view addSubview:self.progressView];
    }
    return _progressView;
}

- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)getUrl{
    [AllRequest requestFromNet:VersionAPI params:nil succ:^(NSDictionary *data) {
        if ([data[@"status"] isEqualToString:@"success"]) {
            [self startLoad:data[@"data"][@"link"]];
        }
    } fault:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络异常,请稍后重试"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getUrl];
    NSLog(@"%@",self.url);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Splash screen"]];
    
    self.navigationItem.title = @"详情";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_black_icon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBtn)];
    
    [self setupToolView];
    
    /*
     *3.添加KVO，WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以监听这个属性。
     */
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    if (!_image) {
        _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Splash screen"]];
        _image.frame = self.view.bounds;
        [self.wkWebView  addSubview:_image];
    }
    self.wkWebView.frame = self.view.bounds;
    self.progressView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.navigationController.navigationBar.hidden = YES;
    
    //网络状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifi:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"afnStatus"] isEqualToString:@"noAfn"]) {
        NSLog(@"------");
    }
    
}

- (void)notifi:(NSNotification *)noti{
    NSLog(@"=======%@",noti);
    [self startLoad:@"http://baidu.com/"];
}



- (void)clickLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupToolView {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
    [self.view addSubview:toolBar];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBackAction)];
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForwardAction)];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
    
    [toolBar setItems:@[backButton,fixedSpace,forwardButton,fixedSpace,refreshButton] animated:YES];
}

#pragma mark - start load web
- (void)startLoad:(NSString *)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 15.0f;
    [self.wkWebView loadRequest:request];
}
#pragma mark - 监听

/*
 *4.在监听方法中获取网页加载的进度，并将进度赋给progressView.progress
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKWKNavigationDelegate Methods

/*
 *5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_image removeFromSuperview];
    _image = nil;
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    //    self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    [_image removeFromSuperview];
    _image = nil;
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = NO;
    
    
}

//页面跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //允许页面跳转
    //    NSLog(@"%@",navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - Tool bar item action

- (void)goBackAction {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    }
}

- (void)goForwardAction {
    if ([self.wkWebView canGoForward]) {
        [self.wkWebView goForward];
    }
}

- (void)refreshAction {
    [self.wkWebView reload];
}



@end
