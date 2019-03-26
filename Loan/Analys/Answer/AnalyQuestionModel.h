//
//  AnalyQuestionModel.h
//  Loan
//
//  Created by tangfeimu on 2019/3/14.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AnalyAnswerModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *is_true;

@end

@interface AnalyQuestionModel : NSObject

@property (nonatomic,strong)NSArray *answers;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)AnalyAnswerModel *answerModel;

@end



