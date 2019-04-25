//
//  AppDelegate.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "AppDelegate.h"
#import "HQMainTabbarVC.h"
#import "QDHomeViewController.h"
#import "QDPlayingViewController.h"
#import "QDTradingViewController.h"
#import "QDMineViewController.h"
#import "BulgeCircularTabBarVC.h"
@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    HQMainTabbarVC *tabVC = [[HQMainTabbarVC alloc]init];
//    self.window.rootViewController = tabVC;
    
    BulgeCircularTabBarVC *tabVC = [[BulgeCircularTabBarVC alloc]init];
    self.window.rootViewController = tabVC;
    [self findAllMapDict];
    [self getBasicPrice];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)findAllMapDict{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindAllMapDict params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            if ([[dic allKeys] containsObject:@"hotelLevel"]) {
                if (_hotelLevel.count) {
                    [_hotelLevel removeAllObjects];
                }
                if (_hotelTypeId.count) {
                    [_hotelTypeId removeAllObjects];
                }
                if (_level.count) {
                    [_level removeAllObjects];
                }
                NSArray *aaa = [dic objectForKey:@"hotelLevel"];
                for (NSDictionary *dd in aaa) {
                    [_hotelLevel addObject:[dd objectForKey:@"dictName"]];
                }
                NSArray *bbb = [dic objectForKey:@"hotelTypeId"];
                for (NSDictionary *dd in bbb) {
                    [_hotelTypeId addObject:[dd objectForKey:@"dictName"]];
                }
                NSArray *ccc = [dic objectForKey:@"Level"];
                for (NSDictionary *dd in ccc) {
                    [_level addObject:[dd objectForKey:@"dictName"]];
                }
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
    }];
}
#pragma mark - 个人积分账户详情
- (void)getBasicPrice{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetBasicPrice params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            self.basePirceRate = [responseObject.result doubleValue];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
