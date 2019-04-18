//
//  QDNetworkCache.h
//  QDINFI
//
//  Created by 冉金 on 2017/10/26.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDNetworkCache : NSObject


/**
 设置缓存

 @param httpData 数据
 @param urlString 请求url地址
 @param parameters 请求参数
 */
+ (void)setHttpCache:(id)httpData URL:(NSString *)urlString paramenters:(id)parameters;


/**
 获取缓存

 @param urlString 请求url地址
 @param parameters 请求参数
 @return 缓存数据
 */
+ (id)httpCacheForURL:(NSString *)urlString parameters:(id)parameters;


/**
 获取所有缓存大小

 @return 缓存大小
 */
+ (NSInteger)getAllHttpCacheSize;


/**
 删除所有缓存
 */
+ (void)removeAllHttpCache;

+ (void)setCustomCache:(id)cacheData forKey:(NSString *)cacheKey;

+ (id)getCustomCacheByKey:(NSString *)cacheKey;

@end
