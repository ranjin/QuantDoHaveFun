//
//  QDGlobalFunc.h
//  QDINFI
//
//  Created by 冉金 on 2019/1/14.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface QDGlobalFunc : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSMutableDictionary *)getDataByFileName:(NSString *)fileName ofType:(NSString *)type;


/**
 把JSON格式的String转字典

 @param jsonString JSON格式的String
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString *)priceDecimalBitNum:(int)num price:(double)price;

+ (double)changeData:(double)value num:(int)num;


/**
 将日期+时间转为时间戳

 @param dateString 日期
 @param timeString 时间
 @return 时间戳
 */
+ (SInt64)getTimeFormatFromData:(NSString *)dateString updateTime:(NSString *)timeString;


/**
 根据合约信息中priceTick获取需显示小数点后几位小数

 @param priceTick 价格tick
 @return 位数
 */
+ (NSInteger)getDecimalPointLengthByPriceTick:(NSString *)priceTick;

+ (NSString *)getVerificationValue:(NSString *)value placeholder:(NSString *)placeholder withDecimalPointLength:(NSInteger)decimalPointLength;

@end
