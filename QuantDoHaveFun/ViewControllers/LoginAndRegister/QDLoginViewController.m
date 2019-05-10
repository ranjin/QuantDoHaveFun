//
//  QDLoginViewController.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/10.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDLoginViewController.h"

@interface QDLoginViewController ()

@end

@implementation QDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(barButtinItemRegister)];
    
//    UIImage *backImage = [UIImage imageNamed:@"icon_return"];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(<#selector#>)];
    
}
- (void)barButtinItemRegister {
    
}
- (void)QDLeftBarButtonItemAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
