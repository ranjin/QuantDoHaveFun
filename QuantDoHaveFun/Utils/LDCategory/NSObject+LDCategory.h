//
//  NSObject+LDCategory.h
//  carDV
//
//  Created by lidi on 2018/12/23.
//  Copyright © 2018 rc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LDCategory)

/**
 打印属性列表
 */
- (void)LD_printPropertyList;
/**
 打印属性列表和对应的值。慎用，易崩溃！
 */
- (void)LD_printPropertyListAndValue;
/**
 打印实例变量列表
 */
- (void)LD_printIvarList;
/**
 打印实例变量列表和对应的值。慎用，易崩溃！
 */
- (void)LD_printIvarListAndValue;
@end

NS_ASSUME_NONNULL_END
