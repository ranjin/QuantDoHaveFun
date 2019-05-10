//
//  QDRegisterViewController.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/10.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDRegisterViewController.h"

@interface QDRegisterViewController ()

@end

@implementation QDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(barButtinItemLogin)];
    
    
    
}
- (void)barButtinItemLogin {
    
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
