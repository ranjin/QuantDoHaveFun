//
//  NSString+QDDecimalNumberHandler.h
//  QDINFI
//
//  Created by ZengTark on 2018/2/6.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QDDecimalNumberHandler)


/**
 数字字符比较

 @param numberString 数字字符
 @return NSComparisonResult
 NSOrderedAscending 小于, NSOrderedSame 相等, NSOrderedDescending 大于
 */
- (NSComparisonResult)numberStringCompare:(NSString *)numberString;

/**
 加法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果,
 roundingModel决定四舍五入的方式，scale决定保留小数个数
 @param stringNumber 被加数
 @return 返回结果
 */
- (NSString *)stringByAdding:(NSString *)stringNumber;
- (NSString *)stringByAdding:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel;
- (NSString *)stringByAdding:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale;

// 减
/**
 减法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果
 roundingModel决定四舍五入的方式，scale决定保留小数个数
 @param stringNumber 减数
 @return 返回结果
 */
- (NSString *)stringBySubtracting:(NSString *)stringNumber;
- (NSString *)stringBySubtracting:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel;
- (NSString *)stringBySubtracting:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale;

// 乘
/**
 乘法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果
 roundingModel决定四舍五入的方式，scale决定保留小数个数
 @param stringNumber 减数
 @return 返回结果
 */
- (NSString *)stringByMultiplyingBy:(NSString *)stringNumber;
- (NSString *)stringByMultiplyingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel;
- (NSString *)stringByMultiplyingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale;

// 除
/**
 除法计算，默认保留两位小数，默认采用四舍五入的方式处理计算结果
 roundingModel决定四舍五入的方式，scale决定保留小数个数
 @param stringNumber 减数
 @return 返回结果
 */
- (NSString *)stringByDividingBy:(NSString *)stringNumber;
- (NSString *)stringByDividingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel;
- (NSString *)stringByDividingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale;

@end
