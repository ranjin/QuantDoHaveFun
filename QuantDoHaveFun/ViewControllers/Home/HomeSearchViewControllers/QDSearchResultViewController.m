//
//  QDSearchResultViewController.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/21.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDSearchResultViewController.h"
#import "QDHomeRankListVC.h"
#import "QDHomeZDYListVC.h"
#import "QDHomeHotelListVC.h"
#import "QDHomeMallListVC.h"
#import "QDKeyWordsSearchViewT.h"
#import "QDHomeSearchVC.h"
@interface QDSearchResultViewController (){
    QDKeyWordsSearchViewT *_headViewT;
}

@end

@implementation QDSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    _headViewT = [[QDKeyWordsSearchViewT alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight-44, SCREEN_WIDTH, 49)];
//    [_headViewT.toSearchVCBtn addTarget:self action:@selector(toSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    [_headViewT.toSearchVCBtn setTitle:_keyStr forState:UIControlStateNormal];
    [_headViewT.returnBtn addTarget:self action:@selector(returnActiion:) forControlEvents:UIControlEventTouchUpInside];
    _headViewT.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:_headViewT];
    // Do any additional setup after loading the view.
}

- (void)returnActiion:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)toSearchVC:(UIButton *)sender{
    QDHomeSeachVC *searchVC = [[QDHomeSeachVC alloc] init];
    [self presentViewController:searchVC animated:YES completion:nil];
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

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 4;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return @"排行榜";
        case 1: return @"酒店";
        case 2: return @"定制游";
        case 3: return @"商城";
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0: return [[QDHomeRankListVC  alloc] init];
        case 1: return [[QDHomeHotelListVC alloc] init];
        case 2: return [[QDHomeZDYListVC alloc] init];
        case 3: return [[QDHomeMallListVC alloc] init];
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
    return CGRectMake(leftMargin, SafeAreaTopHeight-44+49, self.view.frame.size.width - 2*leftMargin, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
