//
//  UIImage+Image.m
//  UISearchBar
//
//  Created by lujh on 2017/3/2.
//  Copyright © 2017年 lujh. All rights reserved.
//
//QQ:287929070
#import "UIImage+Image.h"

@implementation UIImage (Image)
//取消searchbar背景色
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
