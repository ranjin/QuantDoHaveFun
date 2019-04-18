//
//  AppDelegate.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "AppDelegate.h"
#import "QDTabBar.h"
#import "QDHomeViewController.h"
#import "QDPlayingViewController.h"
#import "QDTradingViewController.h"
#import "QDMineViewController.h"
@interface AppDelegate ()<QDTabBarDelegate, UIActionSheetDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self setRootVC];
    return YES;
}

- (void)setRootVC{
    QDHomeViewController *homeVC = [[QDHomeViewController alloc] init];
    QDPlayingViewController *playVC = [[QDPlayingViewController alloc] init];
    
    QDTradingViewController *tradeVC = [[QDTradingViewController alloc] init];
    
    QDMineViewController *mineVC = [[QDMineViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[homeVC, playVC, tradeVC, mineVC];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    QDTabBar *tabBar = [[QDTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    
    tabBar.tabBarItemAttributes = @[@{QDTabBarItemAttributeTitle : @"首页", QDTabBarItemAttributeNormalImageName : @"home_normal", QDTabBarItemAttributeSelectedImageName : @"home_highlight", QDTabBarItemAttributeType : @(QDTabBarItemNormal)},
                                    @{QDTabBarItemAttributeTitle : @"去玩", QDTabBarItemAttributeNormalImageName : @"mycity_normal", QDTabBarItemAttributeSelectedImageName : @"mycity_highlight", QDTabBarItemAttributeType : @(QDTabBarItemNormal)},
                                    @{QDTabBarItemAttributeTitle : @"", QDTabBarItemAttributeNormalImageName : @"post_normal", QDTabBarItemAttributeSelectedImageName : @"post_normal", QDTabBarItemAttributeType : @(QDTabBarItemRise)},
                                    @{QDTabBarItemAttributeTitle : @"玩贝", QDTabBarItemAttributeNormalImageName : @"message_normal", QDTabBarItemAttributeSelectedImageName : @"message_highlight", QDTabBarItemAttributeType : @(QDTabBarItemNormal)},
                                    @{QDTabBarItemAttributeTitle : @"我的", QDTabBarItemAttributeNormalImageName : @"account_normal", QDTabBarItemAttributeSelectedImageName : @"account_highlight", QDTabBarItemAttributeType : @(QDTabBarItemNormal)}];
    tabBar.delegate = self;
    [tabBarController.tabBar addSubview:tabBar];
    self.window.rootViewController = tabBarController;
}

#pragma mark - QDTabBarDelegate
- (void)tabBarDidSelectedRiseButton{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %ld", buttonIndex);
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
