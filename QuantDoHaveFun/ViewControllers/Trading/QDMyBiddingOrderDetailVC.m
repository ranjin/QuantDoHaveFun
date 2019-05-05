//
//  QDOrderDetailVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMyBiddingOrderDetailVC.h"
#import "QDMyBiddingOrderView.h"
#import "QDDateUtils.h"
#import "QDOrderField.h"
#import <TYAlertView.h>
#import "QDBridgeViewController.h"
#import "YUTimer.h"
@interface QDMyBiddingOrderDetailVC(){
    QDMyBiddingOrderView *_biddingOrderView;
    NSString *_postersId;
    NSString *_balance;
}

@property (nonatomic, strong) YUTimer * timer;

@property (nonatomic, assign) NSInteger currentEditStatusTime;

@end

@implementation QDMyBiddingOrderDetailVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
//    [self requestBiddingOrderDetail];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    QDLog(@"viewWillDisappear");
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

#pragma mark - 查看挂单(报单)详情
- (void)requestBiddingOrderDetail{
    NSDictionary * paramsDic = @{@"orderNumber":_posterDTO.postersId,
                                 @"orderType":@4
                                 };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetBiddingPosterByPosterId params:paramsDic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            QDLog(@"123");
            NSDictionary *dic = responseObject.result;
            _postersId = [dic objectForKey:@"postersId"];
            _biddingOrderView.bdNum.text = _postersId;
            _biddingOrderView.bdTime.text = [QDDateUtils timeStampConversionNSString:[dic objectForKey:@"createTime"]];
            
            _biddingOrderView.deal.text = [NSString stringWithFormat:@"%d", [[dic objectForKey:@"tradedVolume"] intValue]];
            _biddingOrderView.frozen.text = [NSString stringWithFormat:@"%d", [[dic objectForKey:@"frozenVolume"] intValue]];
            _biddingOrderView.lab5.text =[NSString stringWithFormat:@"%d", [[dic objectForKey:@"volume"] intValue]];
            _biddingOrderView.lab7.text = [NSString stringWithFormat:@"¥%.2lf", [[dic objectForKey:@"price"] doubleValue]];
            _biddingOrderView.lab3.text = [NSString stringWithFormat:@"%.2lf", [[dic objectForKey:@"volume"] intValue] * [[dic objectForKey:@"price"] doubleValue]];
            if ([[dic objectForKey:@"postersType"] intValue] == 0) {
                //分买入与卖出挂单手续费
                if ([dic objectForKey:@"bidFee"] == nil || [[dic objectForKey:@"bidFee"] isEqual:[NSNull null]]) {
                    _biddingOrderView.lab9.text = @"0.0";
                }else{
                    _biddingOrderView.lab9.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"bidFee"]];
                }
            }else{
                if ([dic objectForKey:@"askFee"] == nil || [[dic objectForKey:@"bidFee"] isEqual:[NSNull null]]) {
                    _biddingOrderView.lab9.text = @"0.0";
                }else{
                    _biddingOrderView.lab9.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"askFee"]];
                }
            }
            if ([_posterDTO.postersStatus intValue] == 0) {  //待付款情况
            }else{
                //未成交与部分成交的时候 并且
                switch ([_posterDTO.postersStatus integerValue]) {
                    case QD_ORDERSTATUS_NOTTRADED:
                        _biddingOrderView.statusLab.text = @"未成交";
                        _biddingOrderView.withdrawBtn.hidden = NO;
                        break;
                    case QD_ORDERSTATUS_PARTTRADED:
                        _biddingOrderView.statusLab.text = @"部分成交";
                        _biddingOrderView.withdrawBtn.hidden = NO;
                        break;
                    case QD_ORDERSTATUS_ALLTRADED:
                        _biddingOrderView.statusLab.text = @"全部成交";
                        _biddingOrderView.withdrawBtn.hidden = YES;
                        break;
                    case QD_ORDERSTATUS_ALLCANCELED:
                        _biddingOrderView.statusLab.text = @"全部撤单";
                        _biddingOrderView.withdrawBtn.hidden = YES;
                        break;
                    case QD_ORDERSTATUS_PARTCANCELED:
                        _biddingOrderView.statusLab.text = @"部分成交部分撤单";
                        _biddingOrderView.withdrawBtn.hidden = YES;
                        break;
                    case QD_ORDERSTATUS_ISCANCELED:
                        _biddingOrderView.statusLab.text = @"已取消";
                        _biddingOrderView.withdrawBtn.hidden = YES;
                        break;
                    case QD_ORDERSTATUS_INTENTION:
                        _biddingOrderView.statusLab.text = @"意向单";
                        _biddingOrderView.withdrawBtn.hidden = YES;
                        break;
                    default:
                        break;
                }
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 取消订单
- (void)cancelOrderForm{
    NSDictionary *dic = @{@"postersId":_postersId};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_CancelBiddingPosters params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [WXProgressHUD showSuccessWithTittle:@"订单超时取消"];
//            [self requestOrderDetail];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}
- (void)setLeftBtnItem{
    UIImage *backImage = [UIImage imageNamed:@"icon_return"];
    UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
}
- (void)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布详情";
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [self setLeftBtnItem];
    _biddingOrderView = [[QDMyBiddingOrderView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _biddingOrderView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    [_biddingOrderView.withdrawBtn addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
    [_biddingOrderView loadViewWithModel:_posterDTO];
    [self.view addSubview:_biddingOrderView];
}

- (void)payAction:(UIButton *)sender{
    QDLog(@"payAction");
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"付款" message:@"您确定要对这笔订单进行付款吗?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        QDLog(@"取消付款");
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?amount=%@&&id=%@", QD_JSURL, JS_PAYACTION, _balance, _postersId];
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }]];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

#pragma mark - 撤单操作
- (void)withdrawAction:(UIButton *)sender{
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"撤销订单" message:@"您确定要撤销这笔订单吗?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        [WXProgressHUD hideHUD];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        NSDictionary *dic = @{@"postersId":_posterDTO.postersId};
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_CancelBiddingPosters params:dic successBlock:^(QDResponseObject *responseObject) {
            if (responseObject.code == 0) {
                [WXProgressHUD showSuccessWithTittle:@"撤单成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [WXProgressHUD showErrorWithTittle:@"网络异常"];
        }];
    }]];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

- (YUTimer *)timer {
    if (_timer == nil) {
        _timer = [[YUTimer alloc] init];
    }
    return _timer;
}


@end
