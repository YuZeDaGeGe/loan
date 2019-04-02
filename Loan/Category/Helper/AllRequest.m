//
//  AllRequest.m
//  Loan
//
//  Created by tangfeimu on 2019/3/13.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "AllRequest.h"
#import "NetworkSingleton.h"
#import <MJExtension.h>
#import "MyAccountModel.h"
#import "AnalyQuestionModel.h"
#import "HomeModel.h"
#import "NewsModel.h"
#import <SVProgressHUD.h>

@implementation AllRequest
//
+ (void)requestFromNet:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;{
    [NetworkSingleton postWithURLString:url parameters:params success:^(NSDictionary *data) {
        succ(data);
    } failure:^(NSError *error) {
        fault(error);
    }];
}
//首页
+ (void)requestForHome:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;{
    [NetworkSingleton getWithURLString:url parameters:params success:^(NSDictionary *data) {
        NSArray *hotArr = [HomeHotModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"result_hot"]];
        NSArray *arr = [HomeModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"result_list"]];
        NSDictionary *dic = @{@"hot":hotArr,@"list":arr,@"status":data[@"status"]};
        succ(dic);
    } failure:^(NSError *error) {
        fault(error);
    }];
}

//行情
+ (void)requestForRank:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;{
    [NetworkSingleton getWithURLString:url parameters:params success:^(NSDictionary *data) {
        NSArray *upArr= [HomeModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"result_rise"]];
        NSArray *lowArr = [HomeModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"result_fall"]];
        NSArray *favoArr = [HomeModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"result_favo"]];
        NSDictionary *dic = @{@"result_rise":upArr,@"result_fall":lowArr,@"favo":favoArr,@"status":data[@"status"]};
        succ(dic);
    } failure:^(NSError *error) {
        fault(error);
    }];
}

//快讯
+ (void)requestForNews:(NSString *)url parmas:(NSDictionary *)parmas succ:(Success)succ fault:(Fault)fault;{
    [NetworkSingleton postWithURLString:url parameters:parmas success:^(NSDictionary *data) {
        NSArray *arr= [NewsModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"datalist"]];
        NSDictionary *dic = @{@"datalist":arr,@"status":data[@"status"]};
        succ(dic);
    } failure:^(NSError *error) {
        fault(error);
//        NSLog(@"%@",error);
    }];
}

//趣味答题列表
+ (void)requestForQuestion:(NSString *)url params:(NSDictionary *)parmas succ:(Success)succ fault:(Fault)fault;{
    [NetworkSingleton postWithURLString:url parameters:parmas success:^(NSDictionary *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[NSString stringWithFormat:@"%@",data[@"errcode"]]isEqualToString:@"1"]) {
                succ(data);
            }else{
                NSArray *arr = [AnalyQuestionModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"questions"]];
                NSDictionary *dic = @{@"data":arr,@"score":data[@"data"][@"score"],@"status":data[@"status"]};
                if(succ){
                    succ(dic);
                }
            }
        });
    } failure:^(NSError *error) {
        fault(error);
    }];
}

//我的账户
+ (void)requestForAccount:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;{
    [NetworkSingleton postWithURLString:url parameters:params success:^(NSDictionary *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[NSString stringWithFormat:@"%@",data[@"errcode"]]isEqualToString:@"1"]) {
                succ(data);
            }else{
                NSArray *arr = [MyAccountModel mj_objectArrayWithKeyValuesArray:data[@"data"][@"datalist"]];
                NSDictionary *dic = @{@"list":arr,@"score":data[@"data"][@"score"],@"status":data[@"status"],@"errcode":data[@"errcode"]};
                if(succ){
                    succ(dic);
                }
            }
        });
    } failure:^(NSError *error) {
        fault(error);
    }];
}
@end
