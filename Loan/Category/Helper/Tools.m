//
//  Tools.m
//  Loan
//
//  Created by tangfeimu on 2019/3/6.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "Tools.h"
#import "AllRequest.h"
#import <WHC_AutoLayout.h>


@implementation Tools

+ (UIViewController *)getCurrentViewController{
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews]objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
//    ErrorView *err = [[ErrorView alloc] init];
//    [result.view addSubview:err];
//    err.whc_TopSpace(0).whc_LeftSpace(0).whc_BottomSpace(0).whc_RightSpace(0);
    return result;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)startWithTime:(NSInteger)timeLine label:(UILabel *)label title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                label.backgroundColor = [UIColor clearColor];
                label.text = title;
            });
            
        }else{
            
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                label.backgroundColor = color;
                label.text = [NSString stringWithFormat:@"%@%@",timeStr,subTitle];
            });
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}

+ (UIAlertController *)returnAlert;{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                             message:@"您没有联网,请检查下网络"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:@"prefs:root=General"];
        if ([[UIApplication sharedApplication] canOpenURL:url])
        {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            NSLog(@"can not open");
        }
    }];
    
    [alertController addAction:okAction];
    return alertController;
}

@end
