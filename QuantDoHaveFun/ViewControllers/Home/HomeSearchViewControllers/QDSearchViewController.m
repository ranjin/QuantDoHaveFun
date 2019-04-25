//
//  QDSearchViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/23.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDSearchViewController.h"
#import "QDHomeTopCancelView.h"
#import "QDSegmentControl.h"
#import "QDHotelListInfoModel.h"
#import "QDKeyWordsSearchVC.h"
#import "CustomTravelDTO.h"
@interface QDSearchViewController ()<UISearchBarDelegate, UITextFieldDelegate>{
    QDHomeTopCancelView *_topCancelView;
    QDSegmentControl *_segmentControl;
    NSMutableArray *_hotelListInfoArr;
    NSMutableArray *_hotelImgArr;
    
    NSMutableArray *_dzyListInfoArr;
    NSMutableArray *_dzyImgArr;
    
}
@end


@implementation QDSearchViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}


- (void)searchAction:(UIButton *)sender{
    if (_topCancelView.inputTF.text == nil || [_topCancelView.inputTF.text isEqualToString:@""]) {
        [WXProgressHUD showErrorWithTittle:@"请输入关键词"];
    }else{
        [_delegate getSearchStr:_topCancelView.inputTF.text];
        if (_playShellType == QDHotelReserve) {
            [self requestHotelInfoWithURL:api_GetHotelCondition];
        }else if (_playShellType == QDCustomTour){
            [self requestDZYList:api_GetDZYList];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hotelListInfoArr = [[NSMutableArray alloc] init];
    _hotelImgArr = [[NSMutableArray alloc] init];
    
    _dzyListInfoArr = [[NSMutableArray alloc] init];
    _dzyImgArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = APP_BLUECOLOR;
    _topCancelView = [[QDHomeTopCancelView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    _topCancelView.inputTF.returnKeyType = UIReturnKeySearch;
    _topCancelView.inputTF.delegate = self;
    _topCancelView.backgroundColor = APP_BLUECOLOR;
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    vv.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:vv];
    [_topCancelView.cancelBtn addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    [_topCancelView.searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:_topCancelView];
}

- (void)getHotelList:(SearchHotelListResult)block{
    self.searchHotelListResult = block;
}
#pragma mark - 请求酒店信息
- (void)requestHotelInfoWithURL:(NSString *)urlStr{
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"hotelName":_topCancelView.inputTF.text,
                            @"pageNum":@1,
                            @"pageSize":@20
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    QDHotelListInfoModel *infoModel = [QDHotelListInfoModel yy_modelWithDictionary:dic];
                    [_hotelListInfoArr addObject:infoModel];
                    
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    NSString *urlStr = [dic objectForKey:@"imageFullUrl"];
                    QDLog(@"urlStr = %@", urlStr);
                    [_hotelImgArr addObject:urlStr];
                }
                QDKeyWordsSearchVC *ssVC = [[QDKeyWordsSearchVC alloc] init];
                ssVC.playShellType = _playShellType;
                ssVC.dateInStr = _dateInStr;
                ssVC.dateOutStr = _dateOutStr;
                ssVC.hotelImgArr = _hotelImgArr;
                ssVC.hotelListInfoArr = _hotelListInfoArr;
                ssVC.keyWords = _topCancelView.inputTF.text;
                if (self.searchHotelListResult != nil) {
                    self.searchHotelListResult(_hotelListInfoArr, _hotelImgArr);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [WXProgressHUD showErrorWithTittle:@"暂无酒店信息,请重新搜索"];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 请求定制游列表信息
- (void)requestDZYList:(NSString *)urlStr{
    if (_dzyListInfoArr.count) {
        [_dzyListInfoArr removeAllObjects];
        [_dzyImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"travelName":_topCancelView.inputTF.text,
                            @"pageNum":@1,
                            @"pageSize":@20
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    CustomTravelDTO *infoModel = [CustomTravelDTO yy_modelWithDictionary:dic];
                    [_dzyListInfoArr addObject:infoModel];
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    [_dzyImgArr addObject:[dic objectForKey:@"url"]];
                }
                QDKeyWordsSearchVC *ssVC = [[QDKeyWordsSearchVC alloc] init];
                ssVC.playShellType = _playShellType;
                ssVC.dzyImgArr = _dzyImgArr;
                ssVC.dzyListInfoArr = _dzyListInfoArr;
                ssVC.keyWords = _topCancelView.inputTF.text;
                [self.navigationController pushViewController:ssVC animated:YES];
            }else{
                [WXProgressHUD showErrorWithTittle:@"暂无定制游信息,请重新搜索"];
            }
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 请求榜单列表列表信息
//- (void)requestDZYList:(NSString *)urlStr{
//    if (_dzyListInfoArr.count) {
//        [_dzyListInfoArr removeAllObjects];
//        [_dzyImgArr removeAllObjects];
//    }
//    NSDictionary * dic1 = @{@"travelName":_topCancelView.inputTF.text,
//                            @"pageNum":@1,
//                            @"pageSize":@20
//                            };
//    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
//        if (responseObject.code == 0) {
//            NSDictionary *dic = responseObject.result;
//            NSArray *hotelArr = [dic objectForKey:@"result"];
//            if (hotelArr.count) {
//                for (NSDictionary *dic in hotelArr) {
//                    CustomTravelDTO *infoModel = [CustomTravelDTO yy_modelWithDictionary:dic];
//                    [_dzyListInfoArr addObject:infoModel];
//                    NSDictionary *dic = [infoModel.imageList firstObject];
//                    [_dzyImgArr addObject:[dic objectForKey:@"url"]];
//                }
//                QDKeyWordsSearchVC *ssVC = [[QDKeyWordsSearchVC alloc] init];
//                ssVC.playShellType = _playShellType;
//                ssVC.dzyImgArr = _dzyImgArr;
//                ssVC.dzyListInfoArr = _dzyListInfoArr;
//                ssVC.keyWords = _topCancelView.inputTF.text;
//                [self.navigationController pushViewController:ssVC animated:YES];
//            }else{
//                [WXProgressHUD showErrorWithTittle:@"暂无定制游信息,请重新搜索"];
//            }
//        }
//    } failureBlock:^(NSError *error) {
//        [WXProgressHUD showErrorWithTittle:@"网络异常"];
//    }];
//}

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
    [_delegate getSearchStr:_topCancelView.inputTF.text];
    if (_topCancelView.inputTF.text == nil || [_topCancelView.inputTF.text isEqualToString:@""]) {
        [WXProgressHUD showErrorWithTittle:@"请输入关键词"];
    }else{
        [_delegate getSearchStr:_topCancelView.inputTF.text];
        if (_playShellType == QDHotelReserve) {
            [self requestHotelInfoWithURL:api_GetHotelCondition];
        }else if (_playShellType == QDCustomTour){
            [self requestDZYList:api_GetDZYList];
        }else if (_playShellType == QDRankList){
            QDKeyWordsSearchVC *ssVC = [[QDKeyWordsSearchVC alloc] init];
            ssVC.playShellType = _playShellType;
            ssVC.rankList = _rankList;
            ssVC.keyWords = _topCancelView.inputTF.text;
            [self.navigationController pushViewController:ssVC animated:YES];
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
//    [_topCancelView.inputTF resignFirstResponder];
}

@end
