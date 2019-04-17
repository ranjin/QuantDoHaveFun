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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBack:(BOOL)show
{
    if (show) {
        UIImage *backImage = [UIImage imageNamed:@"icon_return"];
        UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(navBack:)];
        [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
    }
}

- (void)showBackWithMark{
    
}

- (void)popToLast{
    UIImage *backImage = [UIImage imageNamed:@"back"];
    UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(popTheLast:)];
    [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
}

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
