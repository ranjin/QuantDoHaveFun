//
//  ViewController.m
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import "QDRecommendViewController.h"
#import "WaterLayou.h"
#import "RootCollectionCell.h"
#import "QDBuyOrSellViewController.h"
#import "BiddingPostersDTO.h"
#import "QDBridgeViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
@interface QDRecommendViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>{
    UIButton *_recommendBtn;
    NSString *_postersId;   //挂单编号
    NSMutableArray *_recommendList;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation QDRecommendViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    UIView *ss = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    ss.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [self.view addSubview:ss];
    _recommendList = [[NSMutableArray alloc] init];
    if (_recommendModel == nil) {
        _recommendModel = [[BiddingPostersDTO alloc] init];
        _recommendModel.creditCode = @"10001";
    }
    if (_isPartialDeal == nil) {
        _isPartialDeal = @"1";  //如果为空,默认选择不允许全部成交
    }
    //创建瀑布流布局
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    backView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:backView];
    
    UIButton *returnBtn = [[UIButton alloc] init];
    [returnBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:returnBtn];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(SafeAreaTopHeight-50);
        make.width.and.height.mas_equalTo(45);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    if ([_postersType isEqualToString:@"0"]) {
        titleLab.text = @"卖卖";
    }else{
        titleLab.text = @"买买";
    }
    titleLab.textColor = APP_BLACKCOLOR;
    titleLab.font = QDFont(17);
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(returnBtn);
    }];
    WaterLayou *layou = [[WaterLayou alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+6, SCREEN_WIDTH, SCREEN_HEIGHT- SCREEN_HEIGHT*0.06-50) collectionViewLayout:layou];
    self.collectionView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [self.collectionView registerClass:[RootCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.emptyDataSetSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    [ss addSubview:self.collectionView];
    [self saveIntentionPosters];

    _recommendBtn = [[UIButton alloc] init];
    if ([_postersType isEqualToString:@"1"]) {
        [_recommendBtn setTitle:@"跳过推荐，直接买入" forState:UIControlStateNormal];
        [_recommendBtn addTarget:self action:@selector(buyOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_recommendBtn setTitle:@"跳过推荐，直接卖掉" forState:UIControlStateNormal];
        [_recommendBtn addTarget:self action:@selector(sellOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_recommendBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 316, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
    [_recommendBtn.layer addSublayer:gradientLayer];
    _recommendBtn.titleLabel.font = QDFont(16);
    _recommendBtn.layer.cornerRadius = 25;
    _recommendBtn.layer.masksToBounds = YES;
    [ss addSubview:_recommendBtn];
    [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
        make.width.mas_equalTo(316);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - 跳过推荐 直接购买
- (void)buyOrderAction:(UIButton *)sender{
    //直接购买
    if (_postersId == nil) {
        [WXProgressHUD showErrorWithTittle:@"该用户未开通资金账户,无法交易"];
    }else{
        NSDictionary *paramsDic = @{@"postersId":_postersId};
        [WXProgressHUD showHUD];
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_saveBiddingPosters params:paramsDic successBlock:^(QDResponseObject *responseObject) {
            if (responseObject.code == 0) {
                [WXProgressHUD hideHUD];
                [WXProgressHUD showSuccessWithTittle:@"发布成功"];
                NSString *str = responseObject.result;
                QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
                NSString *balance = [NSString stringWithFormat:@"%.2f", [_volume doubleValue] * [_price doubleValue]];
                bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?amount=%@&&postersId=%@", QD_JSURL, JS_PAYACTION, balance, str];
                [self.navigationController pushViewController:bridgeVC animated:YES];
            }else{
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [WXProgressHUD showErrorWithTittle:@"网络请求失败"];
        }];
    }
}

#pragma mark - 跳过推荐 直接卖出 生成卖单
- (void)sellOrderAction:(UIButton *)sender{
    //直接卖出
    if (_postersId == nil) {
        [WXProgressHUD showErrorWithTittle:@"该用户未开通资金账户,无法交易"];
    }
    NSDictionary *paramsDic = @{@"postersId":_postersId};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_saveBiddingPosters params:paramsDic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [WXProgressHUD showSuccessWithTittle:@"发布成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络请求失败"];
    }];
}

#pragma mark - 请求挂单编号
- (void)saveIntentionPosters{
    NSDictionary * paramsDic = @{@"creditCode":@"10001",
                                 @"price":_price,
                                 @"postersType":[_postersType isEqualToString:@"1"] ? @"0": @"1",
                                 @"volume":_volume,
                                 @"isPartialDeal": _isPartialDeal
                                 };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_SaveIntentionPosters params:paramsDic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            if ([[dic allKeys] containsObject:@"postersId"]) {
                _postersId = [dic objectForKey:@"postersId"];
                [self getRecommendList:api_GetRecommendLists];
            }else{
                [WXProgressHUD showErrorWithTittle:@"挂单ID无法获取"];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_collectionView reloadData];
        [_collectionView reloadEmptyDataSet];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 请求挂单列表
- (void)getRecommendList:(NSString *)urlStr{
    if (_recommendList.count) {
        [_recommendList removeAllObjects];
    }
    NSDictionary * paramsDic = @{@"postersId":_postersId};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:paramsDic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *arr = [dic objectForKey:@"commentList"];
            if (!arr.count) {
                [_collectionView reloadData];
                [_collectionView reloadEmptyDataSet];
            }else{
                for (NSDictionary *dic in arr) {
                    BiddingPostersDTO *infoModel = [BiddingPostersDTO yy_modelWithDictionary:dic];
                    [_recommendList addObject:infoModel];
                }
                [_collectionView reloadData];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_collectionView reloadData];
        [_collectionView emptyDataSetSource];
        [_collectionView emptyDataSetDelegate];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _recommendList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell loadDataWithDataArr:_recommendList[indexPath.row] andTypeStr:_postersType];
    cell.sell.tag = indexPath.row;
    QDLog(@"cell.sell.tag = %ld", (long)cell.tag);
    [cell.sell addTarget:self action:@selector(buyOrSellAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)buyOrSellAction:(UIButton *)sender{
    QDBuyOrSellViewController *vc = [[QDBuyOrSellViewController alloc] init];
    QDLog(@"cell.sell.tag = %ld", (long)sender.tag);
    vc.operateModel = _recommendList[sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"icon_nodata"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无数据";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
