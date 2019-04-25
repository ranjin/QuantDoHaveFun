//
//  UIColor+QDColor.h
//  QDINFI
//
//  Created by ZengTark on 2017/10/20.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (QDColor)

// 从十六进制字符串获取颜色，
// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;
    
/*** 主要颜色 ***/
//APP主要颜色
+ (UIColor *)mainColor;
//APP主要颜色（加深）
+ (UIColor *)mainColorDeep;
//重要文字信息，内容标题等
+ (UIColor *)mainTextColor;
//渐变色 主要icon和顶部导航栏等
+ (UIColor *)gradientColor;
//涨幅时的数据颜色/卖出/报错信息
+ (UIColor *)sellOutColor;
//跌幅时的数据颜色/买入
+ (UIColor *)buyInColor;
    
/*** 次要颜色 ***/
+ (UIColor *)lessImportantColorFirst;
+ (UIColor *)lessImportantColorSecond;
+ (UIColor *)lessImportantColorThird;
@end
