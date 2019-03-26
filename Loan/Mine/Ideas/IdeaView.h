//
//  IdeaView.h
//  Loan
//
//  Created by tangfeimu on 2019/3/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IdeaViewDelegate <NSObject>

- (void)sendValueForText:(NSString *)text;

@end

@interface IdeaView : UIView

@property (nonatomic,weak)id<IdeaViewDelegate>delegate;

@end

