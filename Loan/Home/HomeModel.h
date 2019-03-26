//
//  HomeModel.h
//  Loan
//
//  Created by tangfeimu on 2019/3/14.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeModel : NSObject

@property (nonatomic,strong)NSString *detail_url;
@property (nonatomic,strong)NSString *last;
@property (nonatomic,strong)NSString *range;
@property (nonatomic,strong)NSString *instrument_id;
@property (nonatomic,strong)NSString *is_favo;

@end

@interface HomeHotModel : NSObject

@property (nonatomic,strong)NSString *detail_url;
@property (nonatomic,strong)NSString *instrument_id;
@property (nonatomic,strong)NSString *last;
@property (nonatomic,strong)NSString *range;
@property (nonatomic,strong)NSString *is_favo;

@end

