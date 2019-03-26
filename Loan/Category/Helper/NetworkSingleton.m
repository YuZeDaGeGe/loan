//
//  NetworkSingleton.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "NetworkSingleton.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "Tools.h"
#import "LoginViewController.h"

@implementation NetworkSingleton

static id _instance = nil;

+ (instancetype)shareInstance{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

//网络判断
- (instancetype)init{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        _instance = [super init];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring]; //开启网络监控
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                {
                    //未知网络
                    NSLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    //无法联网
                    NSLog(@"无法联网");
//                    [Tools getCurrentViewController];
                   
                    
                }
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    //手机自带网络
                    NSLog(@"当前使用的是3g/4g网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    //WIFI
                    NSLog(@"========当前在WIFI网络下");
                }
                default:
                    break;
            }
        }];
//    });
    return _instance;
}

#pragma Mark ------------ get请求
+ (void)getWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //可以接受的类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求队列的最大并发数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/xml", nil];
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma Mark ---------------- post请求
+ (void)postWithURLString:(NSString *)URLString parameters:(id )parameters success:(Success)success failure:(fault)failure;   {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //可以接受的类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求队列的最大并发数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",@"application/xml", nil];
    
//    //验证证书
//    AFSecurityPolicy * policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    manager.securityPolicy = policy;
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"=====%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}

#pragma mark  ----------------post/get网络请求
+ (void)requestWithURLString:(NSString *)URLString parameters:(id)parameters type:(HttpRequestType)type success:(Success)success failyre:(fault)failure;{
    
    AFHTTPSessionManager *manager= [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    switch (type) {
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            
    }
    
}

#pragma mark ------------- 版本更新 --
+ (void)requestBundleVersionWithURL:(NSString *) URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //可以接受的类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //请求超时的时间
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
