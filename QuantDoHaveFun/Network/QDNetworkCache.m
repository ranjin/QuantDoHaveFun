//
//  QDNetworkCache.m
//  QDINFI
//
//  Created by 冉金 on 2017/10/26.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDNetworkCache.h"
#import <YYCache/YYCache.h>

static NSString *const kQDNetworkResponseCache = @"kQDNetworkResponseCache";

@implementation QDNetworkCache
static YYCache *_dataCache;

+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:kQDNetworkResponseCache];
}

+ (void)setHttpCache:(id)httpData URL:(NSString *)urlString paramenters:(id)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:urlString parameters:parameters];
    [_dataCache setObject:httpData forKey:cacheKey withBlock:^{
        
    }];
}

+ (id)httpCacheForURL:(NSString *)urlString parameters:(id)parameters
{
    NSString *cacheKey = [self cacheKeyWithURL:urlString parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

+ (NSInteger)getAllHttpCacheSize
{
    return [_dataCache.diskCache totalCost];
}

+ (void)removeAllHttpCache
{
    [_dataCache.diskCache removeAllObjects];
}

+ (void)setCustomCache:(id)cacheData forKey:(NSString *)cacheKey
{
    [_dataCache setObject:cacheData forKey:cacheKey withBlock:^{
        
    }];
}

+ (id)getCustomCacheByKey:(NSString *)cacheKey
{
    return [_dataCache objectForKey:cacheKey];
}

#pragma mark - private
+ (NSString *)cacheKeyWithURL:(NSString *)urlString parameters:(NSDictionary *)parameters
{
    if (!parameters || parameters.count == 0) {
        return urlString;
    }
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    NSString *cacheKey = [NSString stringWithFormat:@"%@%@", urlString, paraString];
    return cacheKey;
}

@end
