//
//  QDGlobalFunc.m
//  QDINFI
//
//  Created by 冉金 on 2019/1/14.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDGlobalFunc.h"

@implementation QDGlobalFunc

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f); //宽高 1.0只要有值就够了
    UIGraphicsBeginImageContext(rect.size); //在这个范围内开启一段上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);//在这段上下文中获取到颜色UIColor
    CGContextFillRect(context, rect);//用这个颜色填充这个上下文
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//从这段上下文中获取Image属性,,,结束
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSMutableDictionary *)getDataByFileName:(NSString *)fileName ofType:(NSString *)type
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    return data;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)priceDecimalBitNum:(int)num price:(double)price
{
    NSString *string=@"";
    if (num==0)
    {
        string=[NSString stringWithFormat:@"%.0f",price];
    }
    else if (num==1)
    {
        string=[NSString stringWithFormat:@"%.1f",price];
    }
    else if (num==2)
    {
        string=[NSString stringWithFormat:@"%.2f",price];
    }
    else if (num==3)
    {
        string=[NSString stringWithFormat:@"%.3f",price];
    }
    else if (num==4)
    {
        string=[NSString stringWithFormat:@"%.4f",price];
    }
    else if (num==5)
    {
        string=[NSString stringWithFormat:@"%.5f",price];
    }
    return string;
}

+ (double)changeData:(double)value num:(int)num
{
    double newV=0;
    NSString *string=@"";
    if (num==0)
    {
        string=[NSString stringWithFormat:@"%.0f",value];
    }
    else if (num==1)
    {
        string=[NSString stringWithFormat:@"%.1f",value];
    }
    else if (num==2)
    {
        string=[NSString stringWithFormat:@"%.2f",value];
    }
    else if (num==3)
    {
        string=[NSString stringWithFormat:@"%.3f",value];
    }
    else if (num==4)
    {
        string=[NSString stringWithFormat:@"%.4f",value];
    }
    else if (num==5)
    {
        string=[NSString stringWithFormat:@"%.5f",value];
    }
    newV=[string doubleValue];
    return newV;
}

+ (SInt64)getTimeFormatFromData:(NSString *)dateString updateTime:(NSString *)timeString
{
    NSString *time = timeString;
    if (!timeString || [timeString isEqualToString:@""]) {
        time = @"09:00:00";
    }
    SInt64 timeNum = 0;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:[NSString stringWithFormat:@"%@ %@", dateString, time]];
    timeNum = [date timeIntervalSince1970];
    return timeNum;
}


+ (NSInteger)getDecimalPointLengthByPriceTick:(NSString *)priceTick
{
    NSInteger decimalPoint = 0;
    if (priceTick) {
        if ([self isPureInt:priceTick]) {
            return decimalPoint;
        }else{
            NSArray *nums = [priceTick componentsSeparatedByString:@"."];
            NSString *lastObj = [nums lastObject];
            decimalPoint = [lastObj length];
        }
    }
    return decimalPoint;
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

+ (NSString *)getVerificationValue:(NSString *)value placeholder:(NSString *)placeholder withDecimalPointLength:(NSInteger)decimalPointLength
{
    NSString *returnValue = @"";
    if (placeholder) {
        returnValue = placeholder;
    }
    if (value) {
        if ([value doubleValue] >= 0.0000000001 && [value doubleValue] <= -0.0000000001) {
            return returnValue;
        }
        else {
            switch (decimalPointLength) {
                case 0:
                {
                    returnValue = [NSString stringWithFormat:@"%.0f", [value doubleValue]];
                }
                    break;
                case 1:
                {
                    returnValue = [NSString stringWithFormat:@"%.1f", [value doubleValue]];
                }
                    break;
                case 2:
                {
                    returnValue = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
                }
                    break;
                case 3:
                {
                    returnValue = [NSString stringWithFormat:@"%.3f", [value doubleValue]];
                }
                    break;
                case 4:
                {
                    returnValue = [NSString stringWithFormat:@"%.4f", [value doubleValue]];
                }
                    break;
                case 5:
                {
                    returnValue = [NSString stringWithFormat:@"%.5f", [value doubleValue]];
                }
                    break;
                case 6:
                {
                    returnValue = [NSString stringWithFormat:@"%.6f", [value doubleValue]];
                }
                    break;
                default:
                {
                    returnValue = [NSString stringWithFormat:@"%.2f", [value doubleValue]];
                }
                    break;
            }
            returnValue = value;
        }
    }
    return returnValue;
}

@end


