//
//  Tools.h
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ErrorView.h"

@interface Tools : NSObject

#pragma mark ------获取当前呈现的viewcontroller
+ (UIViewController *)getCurrentViewController;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (void)startWithTime:(NSInteger)timeLine label:(UILabel *)label title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;


+ (UIAlertController *)returnAlert;

@end

