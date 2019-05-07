//
//  QDCreditOrder.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/6.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDCreditOrder.h"

@implementation QDCreditOrder

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
