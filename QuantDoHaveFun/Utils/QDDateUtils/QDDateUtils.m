//
//  QDDateUtils.m
//  WXIOS
//
//  Created by 🐟猛 on 2018/7/28.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import "QDDateUtils.h"

@implementation QDDateUtils

+ (NSDateComponents*)dateComponentsWithDate:(NSDate*)date{
    NSDate *currentDate = date == nil ?  [NSDate date] : date;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    return components;
}


+ (NSDateComponents*)dateComponentsWithTime:(NSString*)time{
    NSDate *date = [QDDateUtils getDateFromString:time format:@"yyyyMMddHH:mm:ss"] ;
    NSDate *currentDate = date == nil ?  [NSDate date] : date;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate];
    return components;
}

+ (BOOL)isValidDate:(NSString *)time{
    return (long)[[QDDateUtils dateComponentsWithTime:time] year]  > 1970;
}


+ (NSString*)today{
    NSDateComponents *components = [self dateComponentsWithDate:[NSDate date]];
    return [NSString stringWithFormat:@"today=%ld",(long)[components day]];
}


+ (NSString*)tomorrow{
    int tomorrowTime = [[NSDate date] timeIntervalSince1970]+60*60*24;
    NSDate *tomorrowDate = [NSDate dateWithTimeIntervalSince1970:tomorrowTime];
    NSDateComponents *components = [self dateComponentsWithDate:tomorrowDate];
    return [NSString stringWithFormat:@"today=%ld",(long)[components day]];
}

/**
 *  格式化时间
 *
 *  @param formate 格式化的规则
 *  @param date    时间
 *
 *  @return 字符串类型的时间
 */
+(NSString*)dateFormate:(NSString*)formateStr WithDate:(NSDate*)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formateStr];
    return [dateFormat stringFromDate:date];
}

/**
 *  将字符串时间转成NSDate
 *
 *  @param pstrDate 字符串时间
 *  @paramformat@"yyyy-MM-dd'T'HH:mm:ssZ"
 */
+(NSDate *)getDateFromString:(NSString *)pstrDate format:(NSString*)format{
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];
    [df1 setDateFormat:format];
    NSDate *dtPostDate = [df1 dateFromString:pstrDate];
    return dtPostDate;
}


/**
 *  java时间戳格式化
 *
 */
+(NSString*)javaTimestamp:(NSString*)timestamp format:(NSString*)format{
    if (timestamp == nil || [timestamp isKindOfClass:[NSNull class]]||[timestamp doubleValue] == 0) {
        return @"";
    }
    double t = timestamp.doubleValue/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:t];
    return [QDDateUtils dateFormate:format WithDate:date];
}

+ (NSString *)getTimestamp:(NSString *)stringTime format:(NSString *)format {

    NSString *timeStamp = [QDDateUtils getSeconds:stringTime format:format];

    return [NSString stringWithFormat:@"%.f", [timeStamp doubleValue] * 1000.0];
}


+ (NSString*)getSeconds:(NSString *)stringTime format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:stringTime];
    double timeStamp = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.f", timeStamp];
}


/**
 *  当期时间和给定的java时间相差天数
 *
 *  @param javaDate java类型时间戳
 */
+(long)dayDiffrentNowBetweenWithJavaDate:(double)javaDate{
    float aDay = 86400.0;//60*60*24;
    
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:javaDate/1000.0];
    NSDate *date2 =  [NSDate date];
    NSString *formate = @"yyyy-MM-dd";
    NSString *ymd1= [QDDateUtils dateFormate:formate WithDate:date1];
    NSString *ymd2= [QDDateUtils dateFormate:formate WithDate:date2];
    
    NSTimeInterval time1 = [[QDDateUtils getDateFromString:ymd1 format:formate] timeIntervalSince1970];
    NSTimeInterval time2 = [[QDDateUtils getDateFromString:ymd2 format:formate] timeIntervalSince1970];
    
    CGFloat days = (time1-time2)/aDay;
    int absDay = ceil(ABS(days));
    
    if (days > 0) {
        return absDay;
    }else{
        return -absDay;
    }
}



//@"yyyyMMdd HH:mm:ss"
+ (NSString *)getSecondsWithTradingDay:(NSString *)tradingDay andTime:(NSString *)time{
    NSString *dateString = [NSString stringWithFormat:@"%@ %@",tradingDay,time];
    return [QDDateUtils getSeconds:dateString format:@"yyyyMMdd HH:mm:ss"];
}

//计算两个日期之间的天数
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}

+ (NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return dayComponents.day;
}

+ (NSString *)noSecondsTime:(NSString *)completeTime{
   NSMutableArray *array = [[completeTime componentsSeparatedByString:@":"] mutableCopy];
    
    if (array.count == 3) {
        [array replaceObjectAtIndex:2 withObject:@"00"];
    }
    NSLog(@"%@",[array componentsJoinedByString:@":"]) ;
    return [array componentsJoinedByString:@":"];
}

+ (double)oneHoursSeconds{
    return 3600;
}

+ (double)oneDaySeconds{
    return [QDDateUtils oneHoursSeconds] * 24;
}

+ (double)oneWeekSeconds{
    return [QDDateUtils oneDaySeconds] * 7;
}


+ (NSString *)getTimeWithSeconds:(double)seconds{
    return [QDDateUtils javaTimestamp:[NSString stringWithFormat:@"%@", @(seconds * 1000)] format:@"HH:mm:ss"];
    
}

+ (NSString*)weekDayStr:(NSString*)format{
    
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(format.length>=10) {
        NSString *nowString = [format substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if(array.count==0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        
        if(array.count>=3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取传入date
    NSDate *_date = [gregorian dateFromComponents:comps];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    switch(week) {
        case 1:
            weekDayStr =@"星期日";
            break;
        case 2:
            weekDayStr =@"星期一";
            break;
        case 3:
            weekDayStr =@"星期二";
            break;
        case 4:
            weekDayStr =@"星期三";
            break;
        case 5:
            weekDayStr =@"星期四";
            break;
        case 6:
            weekDayStr =@"星期五";
            break;
        case 7:
            weekDayStr =@"星期六";
            break;
        default:
            weekDayStr =@"";
            break;
    }
    return weekDayStr;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
}

+ (NSInteger)compareDate:(NSDate*)aDate withDate:(NSDate*)bDate
{
    NSInteger aa = 0;
    NSComparisonResult result = [aDate compare:bDate];
    if (result==NSOrderedSame)
    {
        //        相等  aa=0
        aa = 0;
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result == NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
    }
    return aa;
}

+(NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
    
}

+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}
@end
