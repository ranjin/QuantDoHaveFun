//
//  QDTradingOrder.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/8.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDTradingOrder.h"

@implementation QDTradingOrder
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = [value integerValue];
    }
}
- (void)setNilValueForKey:(NSString *)key {
    
}
@end
