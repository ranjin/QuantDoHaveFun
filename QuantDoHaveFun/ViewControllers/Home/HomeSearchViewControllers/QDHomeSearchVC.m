//
//  QDSearchViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/23.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHomeSearchVC.h"
#import "QDSearchResultViewController.h"
#import "QDHomeTopCancelView.h"
#import "CustomTravelDTO.h"

@interface QDHomeSeachVC ()<UISearchBarDelegate, UITextFieldDelegate>{
    QDHomeTopCancelView *_topCancelView;
}
@end


@implementation QDHomeSeachVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}


- (void)searchAction:(UIButton *)sender{
    QDLog(@"点击了搜索");
    if (_topCancelView.inputTF.text == nil || [_topCancelView.inputTF.text isEqualToString:@""]) {
        [WXProgressHUD showErrorWithTittle:@"请输入关键词"];
    }else{
        //
        QDLog(@"_topCancelView.inputTF.tex = %@", _topCancelView.inputTF.text);
        [QDUserDefaults setObject:_topCancelView.inputTF.text forKey:@"homeKeyStr"];
        QDSearchResultViewController *searchResultVC = [[QDSearchResultViewController alloc] init];
        searchResultVC.keyStr = _topCancelView.inputTF.text;
        [self.navigationController pushViewController:searchResultVC animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    vv.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:vv];
    
    _topCancelView = [[QDHomeTopCancelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    _topCancelView.inputTF.returnKeyType = UIReturnKeySearch;
    _topCancelView.inputTF.delegate = self;
    _topCancelView.backgroundColor = APP_BLUECOLOR;
    [_topCancelView.cancelBtn addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    [_topCancelView.searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:_topCancelView];
}

- (void)dismissView:(UIButton *)sender{
    [_topCancelView.inputTF resignFirstResponder];
    //    [_delegate getSearchStr:_topCancelView.inputTF.text];
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [_topCancelView.inputTF resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    QDLog(@"点击了搜索");
    if (_topCancelView.inputTF.text == nil || [_topCancelView.inputTF.text isEqualToString:@""]) {
        [WXProgressHUD showErrorWithTittle:@"请输入关键词"];
    }else{
        //
        QDLog(@"_topCancelView.inputTF.tex = %@", _topCancelView.inputTF.text);
        [QDUserDefaults setObject:_topCancelView.inputTF.text forKey:@"homeKeyStr"];
        QDSearchResultViewController *searchResultVC = [[QDSearchResultViewController alloc] init];
        searchResultVC.keyStr = _topCancelView.inputTF.text;
        [self.navigationController pushViewController:searchResultVC animated:YES];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    //    [_topCancelView.inputTF resignFirstResponder];
}

@end
