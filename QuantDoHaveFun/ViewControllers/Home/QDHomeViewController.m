//
//  QDHomeViewController.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDHomeViewController.h"
#import "RankFirstViewController.h"
#import "RankSecondViewController.h"
#import "RankThirdViewController.h"
@interface QDHomeViewController ()
@end

@implementation QDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    self.progressViewIsNaughty = YES;
    self.progressWidth = 10;
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
    return APP_BLACKCOLOR;
}

- (CGFloat)titleSizeNormal{
    return 15;
}

- (CGFloat)titleSizeSelected{
    return 16;
}

- (WMMenuViewStyle)menuViewStyle{
    return WMMenuViewStyleLine;
}

- (UIColor *)titleColorNormal{
    return APP_GRAYTEXTCOLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 3;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"这好玩";
        case 1: return @"那座城";
        case 2: return @"一键启程";
    }
    return @"NONE";
}

//- (UIColor *)titleColorNormal{
//    return APP_BLUECOLOR;
//}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [[RankFirstViewController alloc] init];
        case 1: return [[RankSecondViewController alloc] init];
        case 2: return [[RankThirdViewController alloc] init];
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
    return CGRectMake(leftMargin, SafeAreaTopHeight-40, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    //    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
    //        originY += self.redView.frame.size.height;
    //    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    QDLog(@"didEnterViewController");
}

-(void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    QDLog(@"willEnterViewController");
}

- (void)pageController:(WMPageController *)pageController willCachedViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    QDLog(@"willEnterViewController");
}
@end
