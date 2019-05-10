//
//  QDBaseViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/14.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDBaseViewController.h"

@interface QDBaseViewController ()

@end

@implementation QDBaseViewController


-(instancetype)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.navigationController.navigationBar.tintColor = LD_colorRGBValue(0xa0a0a0);
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target
                                          action:(SEL)action
{
    UIImage *backImage = [UIImage imageNamed:@"icon_return"];
    return [[UIBarButtonItem alloc] initWithImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
}
//- (void)showBack:(BOOL)show
//{
//    if (show) {
//        UIImage *backImage = [UIImage imageNamed:@"icon_return"];
//        UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(navBack:)];
//        [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
//    }
//}


- (void)navBack:(UIBarButtonItem *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popTheLast:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
