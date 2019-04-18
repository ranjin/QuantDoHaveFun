//
//  UIColor+Extension.m
//  AutoOwnersHome
//
//  Created by mac on 17-10-23.
//  Copyright (c) 2017年 mac. All rights reserved.
//

#import "UIColor+Extention.h"

@implementation UIColor(Extenstion)

+ (CGFloat)redColorFromHexRGBColor:(NSInteger)color {
    return (((color & 0xff0000) >> 16) / 255.0);
}

+ (CGFloat)greenColorFromRGBColor:(NSInteger)color {
    return (((color & 0x00ff00) >> 8) / 255.0);
}

+ (CGFloat)blueColorFromRGBColor:(NSInteger)color {
    return ((color & 0x0000ff) / 255.0);
}

+ (UIColor *)colorWithHexValue:(NSInteger)color alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:[UIColor redColorFromHexRGBColor:color]
                           green:[UIColor greenColorFromRGBColor:color]
                            blue:[UIColor blueColorFromRGBColor:color]
                           alpha:alpha];
}

+ (UIColor *)colorWithHexValue:(NSInteger)color {
    return [UIColor colorWithRed:[UIColor redColorFromHexRGBColor:color]
                           green:[UIColor greenColorFromRGBColor:color]
                            blue:[UIColor blueColorFromRGBColor:color]
                           alpha:1.0f];
}

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    
    return hexComponent / 255.0;
    
}


- (void)getColorComponentsWithRed:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:red green:green blue:blue alpha:alpha];
    }else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        *red = components[0];
        *green = components[1];
        *blue = components[2];
        *alpha = components[3];
    }
}

@end
