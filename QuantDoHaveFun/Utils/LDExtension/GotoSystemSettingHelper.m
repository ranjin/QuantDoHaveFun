//
//  GotoSystemSettingHelper.m
//  carDV
//
//  Created by lidi on 2018/7/2.
//  Copyright © 2018年 rc. All rights reserved.
//

#import "GotoSystemSettingHelper.h"

@implementation GotoSystemSettingHelper
+(void)gotoWiFiList{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString * urlString = @"App-Prefs:root=WIFI";
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
            }
        }
    });
}
@end
