//
//  AllRequest.h
//  Loan
//
//  Created by tangfeimu on 2019/3/13.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Success)(NSDictionary *data);
typedef void (^Succ)(NSArray *arr);
typedef void (^Fault)(NSError *error);

@interface AllRequest : NSObject

//通用
+ (void)requestFromNet:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;

//首页
+ (void)requestForHome:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;

//行情
+ (void)requestForRank:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;

//快讯
+ (void)requestForNews:(NSString *)url parmas:(NSDictionary *)parmas succ:(Success)succ fault:(Fault)fault;

//趣味答题列表
+ (void)requestForQuestion:(NSString *)url params:(NSDictionary *)parmas succ:(Success)succ fault:(Fault)fault;


//我的账户
+ (void)requestForAccount:(NSString *)url params:(NSDictionary *)params succ:(Success)succ fault:(Fault)fault;

@end


