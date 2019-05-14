//
//  NSObject+coding.m
//  WYXURLSession
//
//  Created by Wangyongxin on 2016/11/23.
//  Copyright © 2016年 Wangyongxin. All rights reserved.
//

#import "NSObject+coding.h"
#import <objc/runtime.h>
@implementation NSObject (coding)
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int count = 0;
    //利用runtime获取实例变量的列表
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        //取出下标对应额实例变量
        Ivar * ivar = &ivars[i];
        const char * name = ivar_getName(*ivar);
        NSString * nameStr = [[NSString stringWithCString:name encoding:NSUTF8StringEncoding] substringFromIndex:1];
        id value = [self valueForKey:nameStr];
        //归档
        [aCoder encodeObject:value forKey:nameStr];
    }
    //c语言中的copy出来的要进行释放
    free(ivars);
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if ([self init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar * ivar = &ivars[i];
            const char * name = ivar_getName(*ivar);
            NSString * nameStr = [[NSString stringWithCString:name encoding:NSUTF8StringEncoding] substringFromIndex:1];
            id value = [aDecoder decodeObjectForKey:nameStr];
            NSLog(@"%@ : %@",nameStr,value);
            if (value == nil) continue;
            [self setValue:value forKey:nameStr];
        }
        free(ivars);
    }
   return  self;
}

@end
