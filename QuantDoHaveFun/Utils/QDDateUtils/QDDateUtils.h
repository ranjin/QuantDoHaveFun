//
//  QDDateUtils.h
//  WXIOS
//
//  Created by 🐟猛 on 2018/7/28.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDDateUtils : NSObject

+ (NSDateComponents*)dateComponentsWithDate:(NSDate*)date;

+ (NSDateComponents*)dateComponentsWithTime:(NSString*)time;

+ (NSString*)today;

+ (NSString*)tomorrow;
/**
 *  格式化时间
 *
 *  @param formate 格式化的规则
 *  @param date    时间
 *
 *  @return 字符串类型的时间
 */
+(NSString*)dateFormate:(NSString*)formateStr WithDate:(NSDate*)date;
/**
 *  将字符串时间转成NSDate
 *
 *  @param pstrDate 字符串时间
 *  @paramformat@"yyyy-MM-dd'T'HH:mm:ssZ"
 */
+(NSDate *)getDateFromString:(NSString *)pstrDate format:(NSString*)format;
/**
 *  java时间戳格式化
 *
 */
+(NSString*)javaTimestamp:(NSString*)timestamp format:(NSString*)format;

+ (NSString *)getTimestamp:(NSString *)stringTime format:(NSString *)format;

/**
 *  当期时间和给定的java时间相差天数
 *
 *  @param javaDate java类型时间戳
 */
+(long)dayDiffrentNowBetweenWithJavaDate:(double)javaDate;

+ (NSString*)getSeconds:(NSString *)stringTime format:(NSString *)format;


/**
 根据已知接口返回的tradingDay 和 time 获取对应的秒值

 @param tradingDay 年月日 20180728
 @param time 时间  16:32:03
 @return 秒数
 */
+ (NSString *)getSecondsWithTradingDay:(NSString *)tradingDay andTime:(NSString *)time;



/**
 去掉秒数

 @param completeTime HH:mm:ss
 @return HH:mm:00
 */
+ (NSString *)noSecondsTime:(NSString *)completeTime;

/**
 一小时的毫秒值
 @return 一小时的毫秒值
 */
+ (double)oneHoursSeconds;

/**
 一天的毫秒值
 
 @return 一天的毫秒值
 */
+ (double)oneDaySeconds;


/**
 一周的毫秒值

 @return 一周的毫秒值
 */
+ (double)oneWeekSeconds;


/**
 seconds to 13:24:23

 @param seconds 秒
 @return 13:24:23
 */
+ (NSString *)getTimeWithSeconds:(double)seconds;


+ (BOOL)isValidDate:(NSString *)time;

/**
 计算两个日期之间的天数
 */
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;

/**
 计算两个日期之间的天数
 */
+ (NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;

/**
 根据年月日判断星期几
 */
+ (NSString*)weekDayStr:(NSString*)format;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

/**
 时间戳转字符串
 */
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp;

+ (NSString *)getMMSSFromSS:(NSString *)totalTime;

+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
@end
