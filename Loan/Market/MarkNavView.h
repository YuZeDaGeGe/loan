//
//  MarkNavView.h
//  Loan
//
//  Created by tangfeimu on 2019/3/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MarkNavViewDelegate <NSObject>

- (void)sendValue:(NSString *)which;

@end

@interface MarkNavView : UIView

@property (nonatomic,weak)id<MarkNavViewDelegate>deleagte;

@end

NS_ASSUME_NONNULL_END
