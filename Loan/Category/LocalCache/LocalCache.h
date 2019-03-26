//
//  LocalCache.h
//  
//
//  Created by yangaichun on 14-12-25.
//  Copyright (c) 2014年 weiba66. All rights reserved.
//  本地数据缓存基类

#import <Foundation/Foundation.h>


@interface LocalCache : NSObject

/*!
 *  @brief  根据key从本地缓存中取出对象
 *
 *  @param key 对象在缓存中的标识
 *
 *  @return object or nil
 */
+ (id)objectWithKey:(NSString *)key;

/*!
 *  @brief  保存对象到本地缓存
 *
 *  @param object          要保存的对象
 *  @param key             对象在缓存中的标识
 *  @param toKeyChainStore 是否保存到钥匙串
 */
+ (void)saveObject:(id)object Forkey:(NSString *)key ToKeyChainStore:(BOOL)toKeyChainStore;

/*!
 *  @brief  按keys清除本地缓存中多个对象
 *
 *  @param keys 对象标识组
 */
+ (void)clearObjects:(NSArray *)keys;


@end
