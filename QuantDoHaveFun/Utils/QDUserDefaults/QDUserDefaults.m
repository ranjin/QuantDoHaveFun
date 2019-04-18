//
//  QDUserDefaults.m
//  QDINFI
//
//  Created by ZengTark on 2017/12/5.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDUserDefaults.h"

static NSString * const QD_UserDefaults_ColorTheme = @"QD_UserDefaults_ColorTheme";


@implementation QDUserDefaults

#pragma mark - Cookie
+ (void)setCookies:(NSString *)cookie
{
    [QDUserDefaults setObject:cookie forKey:UserLogonCookie];
}

+ (NSString *)getCookies
{
    return (NSString *)[QDUserDefaults getObjectForKey:UserLogonCookie];
}

+ (void)removeCookies
{
    [QDUserDefaults removeObjectForKey:UserLogonCookie];
}

+ (void)setColorTheme:(NSString *)colorTheme
{
    if (colorTheme) {
        [QDUserDefaults setObject:colorTheme forKey:QD_UserDefaults_ColorTheme];
    }
}

+ (NSString *)getColorTheme
{
    return (NSString *)[QDUserDefaults getObjectForKey:QD_UserDefaults_ColorTheme];
}

+ (void)removeColorTheme
{
    [QDUserDefaults removeObjectForKey:QD_UserDefaults_ColorTheme];
}

+ (void)setObject:(id)obj forKey:(NSString *)key
{
    if (obj) {
        [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)removeObjectForKey:(NSString *)key
{
    if (key) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

+ (id)getObjectForKey:(NSString *)key
{
    if (key) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    else {
        return nil;
    }
}

@end
