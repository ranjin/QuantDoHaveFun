//
//  NSObject+LDCategory.m
//  carDV
//
//  Created by lidi on 2018/12/23.
//  Copyright © 2018 rc. All rights reserved.
//

#import "NSObject+LDCategory.h"
#import <objc/runtime.h>

@implementation NSObject (LDCategory)
- (void)LD_printPropertyList {
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++){
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        NSLog(@"%@",propName);
    }
    free(props);
}
- (void)LD_printPropertyListAndValue {
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([self class], &propsCount);
    for(int i = 0;i < propsCount; i++){
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [self valueForKey:propName];
        NSLog(@"%@ : %@",propName,value);
    }
    free(props);
}

- (void)LD_printIvarList {
    unsigned int count;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for(int i = 0;i < count; i++){
        Ivar * ivar = &ivars[i];
        const char * name = ivar_getName(*ivar);
        NSString * nameStr = [[NSString stringWithCString:name encoding:NSUTF8StringEncoding] substringFromIndex:1];
        NSLog(@"%@",nameStr);
    }
    free(ivars);
}
- (void)LD_printIvarListAndValue {
    unsigned int count;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for(int i = 0;i < count; i++){
        Ivar * ivar = &ivars[i];
        const char * name = ivar_getName(*ivar);
        NSString * nameStr = [[NSString stringWithCString:name encoding:NSUTF8StringEncoding] substringFromIndex:1];
        id value = [self valueForKey:nameStr];
        NSLog(@"%@ : %@",nameStr,value);
    }
    free(ivars);
}
@end
