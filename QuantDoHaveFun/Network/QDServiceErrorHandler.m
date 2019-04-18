//
//  QDServiceErrorHandler.m
//  QDINFI
//
//  Created by 冉金 on 2017/10/24.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDServiceErrorHandler.h"
#import "AppDelegate.h"
//#import "QDLoginAndRegisterVC.h"
@implementation QDServiceErrorHandler

+ (void)handleError:(NSInteger)errorCode
{
    __block NSString *errorMsg;
    NSDictionary *error = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QDError" ofType:@"plist"]];
    NSDictionary *serviceError = [error objectForKey:@"ServiceError"];
    if (serviceError) {
        [serviceError enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([key integerValue] == errorCode && errorCode != 1) {
                errorMsg = [NSString stringWithFormat:@"%@", obj];
            }
        }];
    }
    if (errorCode == 1) {
        //未登录，跳转至登录页面
//        [QDUserDefaults setObject:@"0" forKey:@"loginType"];
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
//        delegate.window.rootViewController = loginVC;
    }else{
        NSString *errorString = [NSString stringWithFormat:@"Code:%ld, Msg:%@", errorCode, errorMsg];
        QDLog(@"errorString = %@", errorString);
    }

//    if (errorMsg != nil) {
//    }
}

@end
