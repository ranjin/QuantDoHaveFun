//
//  NSObject+LDCopying.m
//  carDV
//
//  Created by lidi on 2019/1/25.
//  Copyright © 2019 rc. All rights reserved.
//

#import "NSObject+LDCopying.h"
#import <objc/runtime.h>

@implementation NSObject (LDCopying)
/*
 如果对象重写了该方法，就走重写的方法。
 如果没有，就按对象类型进行相应的处理，对子元素或属性进行递归调用。
 */
- (id)LDDeepCopy {
    if (self == nil) {
        return nil;
    } else if(![self isSystemClass]){
        return [self copyCustomClassObject];
    }else if ([self isCollectionObject]) {
        return [self copyCollectionObject];
    }else if([self isKindOfClass:[NSNumber class]]){
        return self;
    }else {
        return [self copySystemObject];
    }
}
- (id)copyCustomClassObject {
    Class self_class = [self class];
    NSObject *object = [[self_class alloc]init];
    unsigned int count = 0;
    //利用runtime获取实例变量的列表
    Ivar * ivars = class_copyIvarList(self_class, &count);
    for (int i = 0; i < count; i ++) {
        //取出下标对应额实例变量
        Ivar * ivar = &ivars[i];
        const char * name = ivar_getName(*ivar);
        NSString * nameStr = [[NSString stringWithCString:name encoding:NSUTF8StringEncoding] substringFromIndex:1];
        id value = [self valueForKey:nameStr];
        // 赋值，对实例变量值进行递归深拷贝
        [object setValue:[value LDDeepCopy] forKey:nameStr];
    }
    //c语言中copy出来的要进行释放
    free(ivars);
    return object;
}
// 枚举集合对象，对各个元素进行递归深拷贝
- (id)copyCollectionObject{
    id object;
    if([self isKindOfClass:[NSArray class]]) {
        __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
        [(NSArray *)self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[obj LDDeepCopy]];
        }];
        if ([self isKindOfClass:[NSMutableArray class]]) {
            object = array;
        } else {
            object = [NSArray arrayWithArray:array];
        }
    }else if([self isKindOfClass:[NSDictionary class]]) {
        __block NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
        [(NSDictionary *)self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [dic setObject:[obj LDDeepCopy] forKey:key];
        }];
        if ([self isKindOfClass:[NSMutableDictionary class]]) {
            object = dic;
        } else {
            object = [NSDictionary dictionaryWithDictionary:dic];
        }
    }else  if([self isKindOfClass:[NSSet class]]) {
        __block NSMutableSet *set = [NSMutableSet setWithCapacity:10];
        [(NSSet *)self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            [set addObject:[obj LDDeepCopy]];
        }];
        if ([set isKindOfClass:[NSMutableSet class]]) {
            object = set;
        }else{
            object = [NSSet setWithSet:set];
        }
    }
    return object;
}
- (BOOL)isCollectionObject {
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSSet class]]) {
        return YES;
    }else {
        return NO;
    }
}
- (BOOL)isSystemClass {
    BOOL isSystemClass = NO;
    NSBundle *mainB = [NSBundle bundleForClass:[self class]];
    if (mainB == [NSBundle mainBundle]) {
        isSystemClass = NO;
//        NSLog(@"自定义的类");
    }else{
        isSystemClass = YES;
//        NSLog(@"系统的类");
    }
    return isSystemClass;
}
- (id)copySystemObject{
    // 对于系统对象类型，如果实现了copy相关方法，就优先获取拷贝值
    if ([self conformsToProtocol:@protocol(NSMutableCopying)]) {
        return [self mutableCopy];
    } else if([self conformsToProtocol:@protocol(NSCopying)]){
        return [self copy];
    }else {
        return self;
    }
}
@end


