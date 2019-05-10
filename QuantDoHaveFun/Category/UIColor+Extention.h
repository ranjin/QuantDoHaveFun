//
//  UIColor+Extension.h
//  AutoOwnersHome
//
//  Created by mac on 17-10-23.
//  Copyright (c) 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface UIColor(Extenstion)

+ (UIColor *)colorWithHexValue:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexValue:(NSInteger)hex;
+ (CGFloat)redColorFromHexRGBColor:(NSInteger)hex;
+ (CGFloat)greenColorFromRGBColor:(NSInteger)hex;
+ (CGFloat)blueColorFromRGBColor:(NSInteger)hex;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

- (void)getColorComponentsWithRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;


@end
