//
//  QDReadyToCreateOrderVC.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDReadyToCreateOrderVC.h"
#import "QDReadyToPayViewCell.h"
#import "QDSalesInfo.h"
#import "CWActionSheet.h"
#import "QDBridgeViewController.h"
#import "QDLoginAndRegisterVC.h"
@interface QDReadyToCreateOrderVC ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
}
@property (nonatomic, strong) NSArray *cellTitleArr;
@property (nonatomic, strong) QDSalesInfo *currentSale;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *returnBtn;

//代销申购时需要的参数
@property (nonatomic, strong) NSString *planCode;
@property (nonatomic, strong) NSString *subscriptCount;

@end

@implementation QDReadyToCreateOrderVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
//    self.tabBarController.tabBar.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
}

#pragma mark - 积分充值卡查询
- (void)readyToCreateOrder:(NSString *)urlStr{
    //判空 如果没有选择卡片 则进来的时候 model为nil
    [WXProgressHUD showHUD];
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
        loginVC.pushVCTag = @"0";
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        /*
         {
         id = 21;
         vipMoney = "0.03";
         vipTypeName = "青铜卡";
         }
         */
        NSDictionary *paramsDic = @{@"id":[NSNumber numberWithInteger:_vipModel.id],
                                     @"vipTypeName":_vipModel.vipTypeName,
                                     @"vipMoney":[NSNumber numberWithDouble:[_vipModel.vipMoney doubleValue]]
                                     };
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:paramsDic successBlock:^(QDResponseObject *responseObject) {
            [WXProgressHUD hideHUD];
            if (responseObject.code == 0) {
                NSDictionary *dic = responseObject.result;
                _planCode = [dic objectForKey:@"planCode"];
                NSArray *saleInfoArr = [dic objectForKey:@"salesInfo"];
                if (saleInfoArr.count) {
                    NSDictionary *dic = saleInfoArr.firstObject;
                    _currentSale = [QDSalesInfo yy_modelWithDictionary:dic];
                }
            }else if (responseObject.code == 2){
                [QDUserDefaults removeCookies];
                QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
                loginVC.pushVCTag = @"0";
                [self presentViewController:loginVC animated:YES completion:nil];
            }else{
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [WXProgressHUD hideHUD];
            [_tableView reloadData];
            [WXProgressHUD showErrorWithTittle:@"网络异常"];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyToCreateOrder:api_ReadyToCreateOrder];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    backView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:backView];
    
    _returnBtn = [[UIButton alloc] init];
    [_returnBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [_returnBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_returnBtn];
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(SafeAreaTopHeight-50);
        make.width.and.height.mas_equalTo(45);
    }];
    _titleLab = [[UILabel alloc] init];
    _titleLab.text = @"确认支付";
    _titleLab.textColor = APP_BLACKCOLOR;
    _titleLab.font = QDFont(17);
    [backView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.centerY.equalTo(_returnBtn);
    }];
    
    self.view.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    _cellTitleArr = [[NSArray alloc] initWithObjects:@"卡名",@"金额",@"重要性参考",@"奖励玩贝", nil];
    [self initTableView];
    UIButton *recommendBtn = [[UIButton alloc] init];
    [recommendBtn setTitle:@"确认并支付" forState:UIControlStateNormal];
    [recommendBtn addTarget:self action:@selector(conformToPayAction:) forControlEvents:UIControlEventTouchUpInside];
    [recommendBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 316, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
    [recommendBtn.layer addSublayer:gradientLayer];
    recommendBtn.titleLabel.font = QDFont(16);
    recommendBtn.layer.cornerRadius = 25;
    recommendBtn.layer.masksToBounds = YES;
    [_tableView addSubview:recommendBtn];
    [recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_tableView);
        make.top.equalTo(self.view.mas_top).offset(347+SafeAreaTopHeight-SCREEN_HEIGHT*0.075);
        make.width.mas_equalTo(316);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - 代销申购
- (void)conformToPayAction:(UIButton *)sender{
    if (_currentSale == nil) {
        QDSalesInfo *salesInfo = [[QDSalesInfo alloc] init];
        salesInfo.saleCode = @"";
        _planCode = @"";
        _currentSale = salesInfo;
    }
    [self showCurrentSaleViewInfo];
}

- (void)popAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.015 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.dataSource = self;
    _tableView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.estimatedRowHeight = SCREEN_HEIGHT*0.075;
    [self.view addSubview:_tableView];
}

#pragma mark -- tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _cellTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_HEIGHT*0.12;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT*0.075;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QDReadyToPayViewCell";
    QDReadyToPayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDReadyToPayViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.titleLab.text = _cellTitleArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.detailLab.hidden = NO;
        cell.cxsBtn.hidden = YES;
        cell.detailLab.text = _vipModel.vipTypeName;
        cell.detailLab.textColor = APP_BLACKCOLOR;
    }else if (indexPath.row == 1){
        cell.detailLab.hidden = NO;
        cell.cxsBtn.hidden = YES;
        cell.detailLab.text = [NSString stringWithFormat:@"¥%@",_vipModel.vipMoney];
        cell.detailLab.textColor = APP_BLUECOLOR;
    }else if (indexPath.row == 2){
        cell.detailLab.hidden = NO;
        cell.cxsBtn.hidden = YES;
        cell.detailLab.text = [NSString stringWithFormat:@"%.2lf", [_vipModel.basePrice doubleValue]];
        cell.detailLab.textColor = APP_BLUECOLOR;
    }else{
        cell.detailLab.hidden = NO;
        cell.cxsBtn.hidden = YES;
        cell.detailLab.text = _vipModel.subscriptCount;
        cell.detailLab.textColor = APP_GRAYTEXTCOLOR;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 弹出承销商选择视图111
- (void)showCurrentSaleViewInfo{
    //先查询全部
    [WXProgressHUD showHUD];
    NSDecimalNumber *subscribeCountNum = [NSDecimalNumber decimalNumberWithString:_vipModel.subscriptCount];
    NSDecimalNumber *subscribePriceNum = [NSDecimalNumber decimalNumberWithString:_vipModel.basePrice];
    NSDecimalNumber *subscribeTotalPriceNum = [NSDecimalNumber decimalNumberWithString:_vipModel.vipMoney];
    NSDecimalNumber *actualPriceNum = [NSDecimalNumber decimalNumberWithString:_vipModel.subscriptCount];
    
    NSDictionary *paramsDic = @{@"creditCode":@"10001",
                                @"planCode":_planCode,
                                @"subscribeCount":subscribeCountNum,
                                @"subscribePrice":subscribePriceNum,  //基准价
                                @"subscribeTotalPrice":subscribeTotalPriceNum,
                                @"saleCode":_currentSale.saleCode,
                                @"rewardCount":@0,
                                @"actualPrice":subscribeTotalPriceNum,
                                @"subscriptionUnit":actualPriceNum
                                };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_SaleByProxyApply params:paramsDic successBlock:^(QDResponseObject *responseObject) {
        [WXProgressHUD hideHUD];
        if (responseObject.code == 0) {
            NSString *resultNum = responseObject.result;
            QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
            bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?amount=%@&id=%@", QD_JSURL, JS_PAYACTION,[subscribeTotalPriceNum stringValue], resultNum];
            QDLog(@"urlStr = %@", bridgeVC.urlStr);
            [self.navigationController pushViewController:bridgeVC animated:YES];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
        [_tableView reloadData];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}
@end
