//
//  WMCustomizedPageController.m
//  WMPageControllerExample
//
//  Created by Mark on 2017/6/21.
//  Copyright © 2017年 Mark. All rights reserved.
//

#import "QDTradingViewController.h"
#import "QDFirstViewController.h"
#import "QDSecondViewController.h"
#import "QDThirdViewController.h"
#import "QDFourViewController.h"

@interface QDTradingViewController ()
@end

@implementation QDTradingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    self.progressViewIsNaughty = YES;
    self.progressWidth = 17;
    self.progressHeight = 2;
    //    self.selectIndex = 1;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (UIColor *)progressColor{
    return APP_BLUECOLOR;
}

- (UIColor *)titleColorSelected{
    return APP_BLUECOLOR;
}

- (CGFloat)titleSizeNormal{
    return 14;
}

- (CGFloat)titleSizeSelected{
    return 18;
}

- (WMMenuViewStyle)menuViewStyle{
    return WMMenuViewStyleLine;
}

- (UIColor *)titleColorNormal{
    return APP_GRAYCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 4;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"买买";
        case 1: return @"卖卖";
        case 2: return @"我的发布";
        case 3: return @"我的摘单";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [[QDFirstViewController alloc] init];
        case 1: return [[QDSecondViewController alloc] init];
        case 2: return [[QDThirdViewController alloc] init];
        case 3: return [[QDFourViewController alloc] init];
    }
    return [[UIViewController alloc] init];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.style = WMMenuViewStyleFloodHollow;
    self.menuView.style = WMMenuViewStyleLine;
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    return CGRectMake(leftMargin, SafeAreaTopHeight-64+10, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

@end
