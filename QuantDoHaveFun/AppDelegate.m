//
//  AppDelegate.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "AppDelegate.h"
#import "QDHomeViewController.h"
#import "QDPlayingViewController.h"
#import "QDTradingViewController.h"
#import "QDMineViewController.h"
#import "BulgeCircularTabBarVC.h"
#import "TABAnimated.h"
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import "HcdGuideView.h"
#import "CCAppManager.h"
#import "CCGotoUpDateViewController.h"
#import "OpenShareHeader.h"
#import <AMapFoundationKit/AMapFoundationKit.h>


@interface AppDelegate ()
@end

@implementation AppDelegate

- (void)configureAPIKey{
    if ([APIKey length] == 0) {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[TABViewAnimated sharedAnimated] initWithDefaultAnimated];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [[RTRootNavigationController alloc] initWithRootViewController:[BulgeCircularTabBarVC new]];
    [self.window makeKeyAndVisible];
    
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:@"320be9855052141fc3935e8c2213c49e"];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:@"320be9855052141fc3935e8c2213c49e"];
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    
    //引导页
    NSMutableArray *images = [NSMutableArray new];
    
    [images addObject:[UIImage imageNamed:@"ggps_1_bg"]];
    [images addObject:[UIImage imageNamed:@"ggps_2_bg"]];
    [images addObject:[UIImage imageNamed:@"ggps_3_bg"]];
    
    HcdGuideView *guideView = [HcdGuideView sharedInstance];
    guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"立即体验"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]];
    
    
    [OpenShare connectQQWithAppId:@"101559247"];
    [OpenShare connectWeiboWithAppKey:@"402180334"];
    [OpenShare connectWeixinWithAppId:@"wx2f631a50a1c2b9c5" miniAppId:@"gh_d43f693ca31f"];
    [QDServiceClient startMonitoringNetworking];
    return YES;
}

- (void)shouldUpdateApp:(NSNotification *)notification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        id userInfo = notification.object;
        CCGotoUpDateViewController *updateVC = [[CCGotoUpDateViewController alloc] init];
        updateVC.urlStr = [userInfo objectForKey:@"URI"];
        [self.window setRootViewController:updateVC];
    });
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([OpenShare handleOpenURL:url]) {
        return YES;
    }
    //这里可以写上其他OpenShare不支持的客户端的回掉,比如支付宝等
    return YES;
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
