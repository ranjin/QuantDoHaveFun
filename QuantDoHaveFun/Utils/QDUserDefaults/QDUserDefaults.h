//
//  QDUserDefaults.h
//  QDINFI
//
//  Created by ZengTark on 2017/12/5.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UserLogonCookie @"UserLogonCookie"

@interface QDUserDefaults : NSObject

#pragma mark - Cookie
+ (void)setCookies:(NSString *)cookie;

+ (NSString *)getCookies;

+ (void)removeCookies;

+ (void)setColorTheme:(NSString *)colorTheme;
+ (NSString *)getColorTheme;
+ (void)removeColorTheme;

+ (void)setObject:(id)obj forKey:(NSString *)key;

+ (void)removeObjectForKey:(NSString *)key;

+ (id)getObjectForKey:(NSString *)key;

@end
