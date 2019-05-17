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
    self.progressWidth = 14;
    self.progressHeight = 3;
//    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(50, SafeAreaTopHeight-64+55, 25, 28)];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 28)];
    img.image = [UIImage imageNamed:@"icon_map"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.menuView);
        make.right.equalTo(self.menuView.mas_left);
    }];
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

- (UIColor *)titleColorNormal{
    return APP_BLACKCOLOR;
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
    return width + 10;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    menuView.style = WMMenuViewStyleFloodHollow;
    self.menuView.style = WMMenuViewStyleLine;
    return CGRectMake(SCREEN_WIDTH*0.17, SafeAreaTopHeight-64+20, SCREEN_WIDTH*0.75, 50);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
