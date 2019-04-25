//
//  NSString+QDDecimalNumberHandler.m
//  QDINFI
//
//  Created by ZengTark on 2018/2/6.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import "NSString+QDDecimalNumberHandler.h"

// QDCalculationType
typedef NS_ENUM(NSInteger, QDCalculationType){
    QDCalculationAdding,
    QDCalculationSubtracting,
    QDCalculationMultiplying,
    QDCalculationDividing,
};

@implementation NSString (QDDecimalNumberHandler)
// Compare
- (NSComparisonResult)numberStringCompare:(NSString *)numberString {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *calcuationNumber = [NSDecimalNumber decimalNumberWithString:numberString];
    return [selfNumber compare:calcuationNumber];
}
// Adding
- (NSString *)stringByAdding:(NSString *)stringNumber {
    return [self stringByAdding:stringNumber withRoundingMode:NSRoundPlain scale:2];
}
- (NSString *)stringByAdding:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self stringByAdding:stringNumber withRoundingMode:roundingModel scale:2];
}
- (NSString *)stringByAdding:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:QDCalculationAdding by:stringNumber roundingMode:roundingModel scale:scale];
}

// Substracting
- (NSString *)stringBySubtracting:(NSString *)stringNumber {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *result = [selfNumber decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:stringNumber]];
    return [result stringValue];
//    return [self stringBySubtracting:stringNumber withRoundingMode:NSRoundPlain scale:2];
}
- (NSString *)stringBySubtracting:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self stringBySubtracting:stringNumber withRoundingMode:roundingModel scale:2];
}
- (NSString *)stringBySubtracting:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:QDCalculationSubtracting by:stringNumber roundingMode:roundingModel scale:scale];
}

// Multiplying
- (NSString *)stringByMultiplyingBy:(NSString *)stringNumber {
    return [self stringByMultiplyingBy:stringNumber withRoundingMode:NSRoundPlain scale:2];
}
- (NSString *)stringByMultiplyingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self stringByMultiplyingBy:stringNumber withRoundingMode:roundingModel scale:2];
}
- (NSString *)stringByMultiplyingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:QDCalculationMultiplying by:stringNumber roundingMode:roundingModel scale:scale];
}

// Dividing
- (NSString *)stringByDividingBy:(NSString *)stringNumber {
    return [self stringByDividingBy:stringNumber withRoundingMode:NSRoundPlain scale:2];
}
- (NSString *)stringByDividingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self stringByDividingBy:stringNumber withRoundingMode:roundingModel scale:2];
}
- (NSString *)stringByDividingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:QDCalculationDividing by:stringNumber roundingMode:roundingModel scale:scale];
}


- (NSString *)stringByCalculationType:(QDCalculationType)type by:(NSString *)stringNumber roundingMode:(NSRoundingMode)roundingModel scale:(NSUInteger)scale{
    
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *calcuationNumber = [NSDecimalNumber decimalNumberWithString:stringNumber];
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:roundingModel scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *result = nil;
    switch (type) {
        case QDCalculationAdding:
            result = [selfNumber decimalNumberByAdding:calcuationNumber withBehavior:handler];
            break;
        case QDCalculationSubtracting:
            result =  [selfNumber decimalNumberBySubtracting:calcuationNumber withBehavior:handler];
            break;
        case QDCalculationMultiplying:
            result = [selfNumber decimalNumberByMultiplyingBy:calcuationNumber withBehavior:handler];
            break;
        case QDCalculationDividing:
            result =[selfNumber decimalNumberByDividingBy:calcuationNumber withBehavior:handler];
            break;
    }
    
    //  使用自定义formatter
    NSNumberFormatter *numberFormatter = [self numberFormatterWithScale:scale];
    return [numberFormatter stringFromNumber:result];
}

- (NSNumberFormatter *)numberFormatterWithScale:(NSInteger)scale{
    static NSNumberFormatter *numberFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.minimumIntegerDigits = 1;
        numberFormatter.numberStyle = kCFNumberFormatterNoStyle;
    });
    numberFormatter.alwaysShowsDecimalSeparator = !(scale == 0);
    numberFormatter.minimumFractionDigits = scale;
    return numberFormatter;
}
@end
