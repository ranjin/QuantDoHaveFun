//
//  QDTradingShellsVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDSecondViewController.h"
#import "QDTradeShellsSectionHeaderView.h"
#import "MyTableCell.h"
#import "TFDropDownMenu.h"
#import "SnailQuickMaskPopups.h"
#import "QDFilterTypeOneView.h"
#import "QDFindSatifiedDataVC.h"
#import "QDMySaleOrderCell.h"
#import "QDPickUpOrderCell.h"
#import "QDOrderDetailVC.h"
#import <TYAlertView/TYAlertView.h>
#import "BiddingPostersDTO.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "RootCollectionCell.h"
#import "RootFirstCollectionCell.h"
#import "WaterLayou.h"
#import "QDBuyOrSellViewController.h"
#import "QDLoginAndRegisterVC.h"
#import "QDBridgeViewController.h"
#define K_T_Cell @"t_cell"
#define K_C_Cell @"c_cell"

@interface QDSecondViewController ()<UITableViewDelegate, UITableViewDataSource, SnailQuickMaskPopupsDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UICollectionViewDelegate, UICollectionViewDataSource>{
    QDTradeShellsSectionHeaderView *_sectionHeaderView;
    UIView *_backView;
    UIButton *_optionBtn;    //要玩贝操作按钮
    NSMutableArray *_ordersArr;
    int _pageNum;
    int _pageSize;
    int _totalPage;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) QDFilterTypeOneView *typeOneView;

@property (nonatomic, strong) NSString *postersType;
@property (nonatomic, strong) NSString *minVolume;      //最低量
@property (nonatomic, strong) NSString *maxVolume;      //最高量
@property (nonatomic, strong) NSString *minPrice;       //最低价
@property (nonatomic, strong) NSString *maxPrice;       //最高价
@property (nonatomic, strong) NSString *sortColumn;     //数量排序：volume，价格排序：price
@property (nonatomic, strong) NSString *sortType;       //排序方式：desc降序，asc升序
@property (nonatomic, strong) NSString *isPartialDeal;  //是否部分成交0:允许 1:不允许

@end

@implementation QDSecondViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceUp) name:Notification_PriceUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceDown) name:Notification_PriceDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amuntUp) name:Notification_AmountUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amountDown) name:Notification_AmountDown object:nil];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_PriceUp object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_PriceDown object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_AmountUp object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_AmountDown object:nil];
}

- (void)priceUp{
    QDLog(@"priceUp");
    _sortColumn = @"price";
    _sortType = @"asc";
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self requestZWBHeaderTopData];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
    
}
- (void)priceDown{
    QDLog(@"priceDown");
    _sortColumn = @"price";
    _sortType = @"desc";
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self requestZWBHeaderTopData];
    //    [_tableView reloadData];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];

}
- (void)amuntUp{
    _sortColumn = @"volume";
    _sortType = @"asc";
    [self requestZWBHeaderTopData];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    //    [_tableView reloadData];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];

}
- (void)amountDown{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    _sortColumn = @"volume";
    _sortType = @"desc";
    [self requestZWBHeaderTopData];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _postersType = @"0";
    _isPartialDeal = @"";
    _minPrice = @"";
    _maxPrice = @"";
    _minVolume = @"";
    _maxVolume = @"";
    _sortColumn = @"";
    _sortType = @"";
    _pageNum = 1;
    _pageSize = 30;
    _totalPage = 0; //总页数默认为1
    _ordersArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    
    [self setTopView];
    [self initTableView];
    _optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 140, 44)];
    [_optionBtn addTarget:self action:@selector(operateAction:) forControlEvents:UIControlEventTouchUpInside];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 140, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
    [_optionBtn.layer addSublayer:gradientLayer];
    [_optionBtn setTitle:@"卖卖" forState:UIControlStateNormal];
    _optionBtn.layer.cornerRadius = 22;
    _optionBtn.layer.masksToBounds = YES;
    _optionBtn.titleLabel.font = QDFont(18);
    [self.view addSubview:_optionBtn];
    [_optionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(44);
    }];
    [self requestZWBData];
}

- (void)requestZWBData{
    if (_totalPage != 0) {
        if (_pageNum >= _totalPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
//    NSDictionary * dic1 = @{@"postersStatus":@"",   //挂单状态  默认全部
//                            @"postersType":@"0",    //挂单类型，0买入挂单，1-卖出挂单
//                            @"pageNum":[NSNumber numberWithInt:_pageNum],
//                            @"pageSize":[NSNumber numberWithInt:_pageSize],
//                            };
    NSDictionary * dic1 = @{@"postersStatus":@"",
                            @"postersType":_postersType,
                            @"pageNum":@1,
                            @"pageSize":[NSNumber numberWithInt:_pageSize],
                            @"minVolume":_minVolume,
                            @"maxVolume":_maxVolume,
                            @"minPrice":_minPrice,
                            @"maxPrice":_maxPrice,
                            @"sortColumn":_sortColumn,
                            @"sortType":_sortType,
                            @"isPartialDeal":_isPartialDeal
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindCanTrade params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            if (hotelArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in hotelArr) {
                    BiddingPostersDTO *infoModel = [BiddingPostersDTO yy_modelWithDictionary:dic];
                    [arr addObject:infoModel];
                }
                if (arr) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_ordersArr addObjectsFromArray:arr];
                        [self.tableView reloadData];
                        if ([self.tableView.mj_footer isRefreshing]) {
                            [self endRefreshing];
                            self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        }
                    }else{
                        [_ordersArr addObjectsFromArray:arr];
                        [self.tableView reloadData];
                        self.tableView.mj_footer.state = MJRefreshStateIdle;
                        [self endRefreshing];
                        QDLog(@"count = %ld", (long)_ordersArr.count);
                    }
                }
            }else{
                [self endRefreshing];
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_tableView reloadData];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}


- (void)endRefreshing
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
}

- (void)setTopView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.17)];
    topView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"转贝";
    titleLab.font = QDFont(17);
    [topView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SCREEN_HEIGHT*0.046);
        make.centerX.equalTo(self.view);
    }];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_WHITECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.estimatedRowHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
//    self.view = _tableView;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 135)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headerView;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"shellBanner"];
    [headerView addSubview:imgView];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wbscAction)];
    [imgView addGestureRecognizer:ges];


    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        QDLog(@"下拉刷新");
        [self requestZWBHeaderTopData];
    }];
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        QDLog(@"上拉刷新");
        _pageNum++;
        [self requestZWBData];
    }];
}

#pragma mark - 点击玩贝手册
- (void)wbscAction{
    NSDictionary *dic = @{@"noticeType":@"11"};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_otherProtocols params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSString *urlStr = responseObject.result;
            QDLog(@"urlStr = %@", urlStr);
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
    bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?noticeType=11", QD_TESTJSURL, JS_WBSC];
    QDLog(@"urlStr = %@", bridgeVC.urlStr);
    [self.navigationController pushViewController:bridgeVC animated:YES];
}

#pragma mark - 下拉刷新数据  只请求第一页的数据
- (void)requestZWBHeaderTopData{
    if (_ordersArr.count) {
        [_ordersArr removeAllObjects];
    }
    
    NSDictionary * dic1 = @{@"postersStatus":@"",
                            @"postersType":_postersType,
                            @"pageNum":@1,
                            @"pageSize":[NSNumber numberWithInt:_pageSize],
                            @"minVolume":_minVolume,
                            @"maxVolume":_maxVolume,
                            @"minPrice":_minPrice,
                            @"maxPrice":_maxPrice,
                            @"sortColumn":_sortColumn,
                            @"sortType":_sortType,
                            @"isPartialDeal":_isPartialDeal
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindCanTrade params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            NSArray *hotelArr = [dic objectForKey:@"result"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    BiddingPostersDTO *infoModel = [BiddingPostersDTO yy_modelWithDictionary:dic];
                    [_ordersArr addObject:infoModel];
                }
                if ([self.tableView.mj_header isRefreshing]) {
                    [self.tableView.mj_header endRefreshing];
                }
                [_tableView reloadData];
            }else{
                [_tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            }
        }else{
            [self endRefreshing];
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [self endRefreshing];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_ordersArr.count % 2 == 0) {
        return _ordersArr.count /2  * 220 + _ordersArr.count/2 * 10 + 10;
    }else{
        return (_ordersArr.count /2 + 1) * 220 + (_ordersArr.count/2 + 1) * 10 + 10;
    }}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建瀑布流布局
        WaterLayou *layou = [[WaterLayou alloc] init];
        //创建collectionView
        CGFloat y = 0;
        if (_ordersArr.count % 2 == 0) {
            y = _ordersArr.count /2  * 220 + _ordersArr.count/2 * 10 + 10;
        }else{
            y = (_ordersArr.count /2 + 1) * 220 + (_ordersArr.count/2 + 1) * 10 + 10;
        }
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, y) collectionViewLayout:layou];
        self.collectionView.backgroundColor = APP_WHITECOLOR;
        self.collectionView.scrollEnabled = NO;
        //注册单元格
        [_collectionView registerClass:[RootCollectionCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[RootFirstCollectionCell class] forCellWithReuseIdentifier:@"RootFirstCollectionCell"];

        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
    }
    return _collectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = APP_WHITECOLOR;
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CGFloat y = 0;
    if (_ordersArr.count % 2 == 0) {
        y = _ordersArr.count /2  * 220 + _ordersArr.count/2 * 10 + 10;
    }else{
        y = (_ordersArr.count /2 + 1) * 220 + (_ordersArr.count/2 + 1) * 10 + 10;
    }
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, y);
    if (_ordersArr.count) {
        [self.collectionView reloadData];
    }
    [cell.contentView addSubview:self.collectionView];
    return cell;
}

- (QDTradeShellsSectionHeaderView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[QDTradeShellsSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        [_sectionHeaderView.filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
        _sectionHeaderView.backgroundColor = APP_WHITECOLOR;
    }
    return _sectionHeaderView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)confirmOptions:(UIButton *)sender{
    _minPrice = _typeOneView.lowPrice.text;
    _maxPrice = _typeOneView.hightPrice.text;
    _minVolume = _typeOneView.lowAmount.text;
    _maxVolume = _typeOneView.hightAmount.text;
    [self requestZWBHeaderTopData];
    [_popups dismissAnimated:YES completion:nil];
}


#pragma mark - 要/转玩贝操作按钮
- (void)operateAction:(UIButton *)sender{
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
        loginVC.pushVCTag = @"0";
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        QDFindSatifiedDataVC *satifiedVC = [[QDFindSatifiedDataVC alloc] init];
        satifiedVC.typeStr = @"0";  //请求市场上的买单数据
        [self.navigationController pushViewController:satifiedVC animated:YES];
    }
}
#pragma mark - 筛选重置按钮
- (void)resetOptions:(UIButton *)sender{
    _postersType = @"";
    _sortType = @"";
    _isPartialDeal = @"";
    _sortColumn = @"";
    _minVolume = @"";
    _maxVolume = @"";
    _minPrice = @"";
    _maxPrice = @"";

}
- (void)filterAction:(UIButton *)sender{
    QDLog(@"filter");
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    if (!_typeOneView) {
        _typeOneView = [[QDFilterTypeOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.57)];
        [_typeOneView.confirmBtn addTarget:self action:@selector(confirmOptions:) forControlEvents:UIControlEventTouchUpInside];
        _typeOneView.backgroundColor = APP_WHITECOLOR;
        [_typeOneView.resetbtn addTarget:self action:@selector(resetOptions:) forControlEvents:UIControlEventTouchUpInside];
        //数量价格
        _typeOneView.sdIsPartialBlock = ^(NSString * _Nonnull directionID) {
            _isPartialDeal = directionID;
        };
    }
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_typeOneView];
    _popups.presentationStyle = PresentationStyleTop;
    
    _popups.delegate = self;
    [_popups presentInView:self.tableView animated:YES completion:NULL];
}

- (void)snailQuickMaskPopupsWillPresent:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsWillPresent");
}

- (void)snailQuickMaskPopupsWillDismiss:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsWillDismiss");
}

- (void)snailQuickMaskPopupsDidPresent:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsDidPresent");
}

- (void)snailQuickMaskPopupsDidDismiss:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsDidDismiss");
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

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _ordersArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RootFirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RootFirstCollectionCell" forIndexPath:indexPath];
        BiddingPostersDTO *dto = _ordersArr[0];
        [cell loadDataWithDataArr:dto andTypeStr:dto.postersType];
        cell.sell.tag = indexPath.row;
        [cell.sell addTarget:self action:@selector(buyOrSellAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        RootCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        BiddingPostersDTO *dto = _ordersArr[indexPath.row];
        [cell loadDataWithDataArr:dto andTypeStr:dto.postersType];
        cell.sell.tag = indexPath.row;
        [cell.sell addTarget:self action:@selector(buyOrSellAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QDLog(@"%ld", (long)indexPath.row);
}

- (void)buyOrSellAction:(UIButton *)sender{
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
        loginVC.pushVCTag = @"0";
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        QDBuyOrSellViewController *vc = [[QDBuyOrSellViewController alloc] init];
        vc.operateModel = _ordersArr[sender.tag];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.3 animations:^{
        _optionBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [_optionBtn setHidden:YES];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.3 animations:^{
        _optionBtn.alpha = 1;
    } completion:^(BOOL finished) {
        [_optionBtn setHidden:NO];
    }];
}

@end
