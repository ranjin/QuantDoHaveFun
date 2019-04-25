//
//  QDShellRecommendVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDShellRecommendVC.h"
#import "RootTableCell.h"
#import "QDBuyOrSellViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDBridgeViewController.h"
@interface QDShellRecommendVC ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, RootCellDelegate>{
    UITableView *_tableView;
    UIButton *_recommendBtn;
    NSString *_postersId;   //挂单编号
    NSMutableArray *_recommendList;
}

@property (nonatomic, strong) NSMutableDictionary *dicH;

@end

@implementation QDShellRecommendVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
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
    [self setLeftBtnItem];
    //生成意向单
    _recommendList = [[NSMutableArray alloc] init];
    if (_recommendModel == nil) {
        _recommendModel = [[BiddingPostersDTO alloc] init];
        _recommendModel.creditCode = @"10001";
    }
    _isPartialDeal = @"1";  //默认为允许部分成交
    [self initTableView];
    [self saveIntentionPosters];
    self.title = @"这好玩";
    self.view.backgroundColor = APP_WHITECOLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviga"] forBarMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

#pragma mark - 请求挂单编号
- (void)saveIntentionPosters{
    NSDictionary * paramsDic = @{@"creditCode":@"10001",
                                 @"price":[NSNumber numberWithDouble:[_price doubleValue]],
                                 @"postersType":[_postersType isEqualToString:@"0"] ? @"1": @"0",
                                 @"volume":[NSNumber numberWithInt:[_volume intValue]],
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
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
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
                [WXProgressHUD showErrorWithTittle:@"无满足条件的挂单数据"];
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }else{
                for (NSDictionary *dic in arr) {
                    BiddingPostersDTO *infoModel = [BiddingPostersDTO yy_modelWithDictionary:dic];
                    [_recommendList addObject:infoModel];
                }
                [_tableView reloadData];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_tableView reloadData];
        [_tableView emptyDataSetSource];
        [_tableView emptyDataSetDelegate];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.12);
    }];
    
    _recommendBtn = [[UIButton alloc] init];
    if ([_postersType isEqualToString:@"0"]) {
        [_recommendBtn setTitle:@"跳过推荐，直接购买" forState:UIControlStateNormal];
    }else{
        [_recommendBtn setTitle:@"跳过推荐，直接卖出" forState:UIControlStateNormal];
    }
    [_recommendBtn addTarget:self action:@selector(toBuyVC:) forControlEvents:UIControlEventTouchUpInside];
    [_recommendBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.89, SCREEN_HEIGHT*0.08);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
    [_recommendBtn.layer addSublayer:gradientLayer];
    _recommendBtn.titleLabel.font = QDFont(19);
    [self.view addSubview:_recommendBtn];
    [_recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(SCREEN_WIDTH*0.05);
        make.right.equalTo(self.view.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.bottom.equalTo(self.view.mas_bottom).offset(-(SCREEN_HEIGHT*0.03));
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.08);
    }];
}

- (void)toBuyVC:(UIButton *)sender{
    QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
    NSString *balance = [NSString stringWithFormat:@"%.2f", [_volume doubleValue] * [_price doubleValue]];
    bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?amount=%@&&id=%@", QD_JSURL, JS_PAYACTION, balance, _postersId];
    [self.navigationController pushViewController:bridgeVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark -- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dicH[indexPath]) {
        QDLog(@"dicH = %@", self.dicH);
        NSNumber *num = self.dicH[indexPath];
        return [num floatValue] + 60;
    } else {
        return 60;
    }}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerClass:[RootTableCell class] forCellReuseIdentifier:@"RootTableCell"];
    RootTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootTableCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.delegate = self;
    cell.indexPath = indexPath;
    if (_recommendList.count) {
        cell.dataAry = _recommendList;
//        cell.typeStr = [_postersType isEqualToString:@"0"] ? @"1": @"0";
        [cell.collectionView reloadData];
    }
    return cell;
}

#pragma mark ====== RootTableCellDelegate ======
- (void)updateTableViewCellHeight:(RootTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
        [_tableView reloadData];
    }
}


//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSMutableDictionary *)dicH {
    if (!_dicH) {
        _dicH = [[NSMutableDictionary alloc] init];
    }
    return _dicH;
}

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"emptySource"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"未找到相关数据,请重试";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
