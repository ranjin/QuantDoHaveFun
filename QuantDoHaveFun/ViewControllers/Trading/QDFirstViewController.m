//
//  QDTradingShellsVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDFirstViewController.h"
#import "QDTradeShellsSectionHeaderView.h"
#import "MyTableCell.h"
#import "TFDropDownMenu.h"
#import "SnailQuickMaskPopups.h"
#import "QDFilterTypeOneView.h"
#import "QDFilterTypeTwoView.h"
#import "QDFilterTypeThreeView.h"
#import "QDMySaleOrderCell.h"
#import "QDPickUpOrderCell.h"
#import "QDOrderDetailVC.h"
#import <TYAlertView/TYAlertView.h>
#import "BiddingPostersDTO.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "RootCollectionCell.h"
#import "WaterLayou.h"
#import "QDBuyOrSellViewController.h"
#import "QDFindSatifiedDataVC.h"
#import "QDLoginAndRegisterVC.h"
#import "QDOrderField.h"
#import "QDBridgeViewController.h"
#define K_T_Cell @"t_cell"
#define K_C_Cell @"c_cell"

// 买买  卖卖  我的发布  我的摘单
typedef enum : NSUInteger {
    QDPlayShells = 0,
    QDTradeShells = 1,
    QDMyOrders = 2,
    QDPickUpOrders = 3
} QDShellType;

@interface QDFirstViewController ()<UITableViewDelegate, UITableViewDataSource, SnailQuickMaskPopupsDelegate, UICollectionViewDelegate, UICollectionViewDataSource>{
    QDTradeShellsSectionHeaderView *_sectionHeaderView;
    QDShellType _shellType;
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

@implementation QDFirstViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceUp) name:Notification_PriceUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceDown) name:Notification_PriceDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amuntUp) name:Notification_AmountUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amountDown) name:Notification_AmountDown object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
    [self requestYWBHeaderTopData];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
    
}
- (void)priceDown{
    QDLog(@"priceDown");
    _sortColumn = @"price";
    _sortType = @"desc";
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self requestYWBHeaderTopData];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
    
}
- (void)amuntUp{
    _sortColumn = @"volume";
    _sortType = @"asc";
    [self requestYWBHeaderTopData];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
    
}
- (void)amountDown{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    _sortColumn = @"volume";
    _sortType = @"desc";
    [self requestYWBHeaderTopData];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _postersType = @"1";
    _isPartialDeal = @"";
    _minPrice = @"";
    _maxPrice = @"";
    _minVolume = @"";
    _maxVolume = @"";
    _sortColumn = @"";
    _sortType = @"";
    _pageNum = 1;
    _pageSize = 6;
    _totalPage = 0; //总页数默认为1
    _ordersArr = [[NSMutableArray alloc] init];
    [self initTableView];
    _optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 104, 34)];
    [_optionBtn addTarget:self action:@selector(operateAction:) forControlEvents:UIControlEventTouchUpInside];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 104, 34);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
    [_optionBtn.layer addSublayer:gradientLayer];
    [_optionBtn setTitle:@"买买" forState:UIControlStateNormal];
    _optionBtn.layer.cornerRadius = 17;
    _optionBtn.layer.masksToBounds = YES;
    _optionBtn.titleLabel.font = QDFont(16);
    [self.view addSubview:_optionBtn];
    [_optionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(81+(SafeAreaTopHeight-64)));
        make.width.mas_equalTo(104);
        make.height.mas_equalTo(34);
    }];
    [self requestYWBData];
}

/**
 NO_TRADED(0,"未成交"), // 未成交
 PART_TRADED(1,"部分成交"), // 部分成交
 ALL_TRADED(2,"全部成交"), // 全部成交
 ALL_CANCELED(3,"全部撤单"), // 全部撤单
 PART_CANCELED(4,"部分成交部分撤单"), // 部分成交部分撤单
 IS_CANCELED(5,"已取消"), // 已取消
 INTENTION(6,"意向单") ; // 意向单
 */
#pragma 要玩贝数据与上拉刷新数据请求
- (void)requestYWBData{
    if (_totalPage != 0) {
        if (_pageNum > _totalPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
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
        [self endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 下拉刷新数据  只请求第一页的数据
- (void)requestYWBHeaderTopData{
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
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in hotelArr) {
                    BiddingPostersDTO *infoModel = [BiddingPostersDTO yy_modelWithDictionary:dic];
                    [arr addObject:infoModel];
                }
                if (arr) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_ordersArr addObjectsFromArray:arr];
                        [self.tableView reloadData];
                    }else{
                        [_ordersArr addObjectsFromArray:arr];
                        [self.tableView reloadData];
                    }
                    if ([self.tableView.mj_header isRefreshing]) {
                        [self.tableView.mj_header endRefreshing];
                    }
                }
            }else{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_tableView reloadData];
        [self endRefreshing];
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

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
//    self.view = _tableView;
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headerView;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    imgView.userInteractionEnabled = YES;
    imgView.image = [UIImage imageNamed:@"shellBanner"];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wbscAction)];
    [imgView addGestureRecognizer:ges];
    [headerView addSubview:imgView];
    
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        QDLog(@"下拉刷新");
        [self requestYWBHeaderTopData];
    }];
    
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        QDLog(@"上拉刷新");
        _pageNum++;
        [self requestYWBData];
    }];
}

#pragma mark - 点击玩贝手册
- (void)wbscAction{
    NSDictionary *dic = @{@"noticeType":@"11"};
//    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_otherProtocols params:dic successBlock:^(QDResponseObject *responseObject) {
//        if (responseObject.code == 0) {
//            NSString *urlStr = responseObject.result;
//            QDLog(@"urlStr = %@", urlStr);
//        }
//    } failureBlock:^(NSError *error) {
//
//    }];
    
    QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
    bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?noticeType=11", QD_TESTJSURL, JS_WBSC];
    QDLog(@"urlStr = %@", bridgeVC.urlStr);
    [self.navigationController pushViewController:bridgeVC animated:YES];
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
        return _ordersArr.count /2  * 185 + _ordersArr.count/2 * 10 + 10;
    }else{
        return (_ordersArr.count /2 + 1) * 185 + (_ordersArr.count/2 + 1) * 10 + 10;
    }}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建瀑布流布局
        WaterLayou *layou = [[WaterLayou alloc] init];
        //创建collectionView
        CGFloat y = 0;
        if (_ordersArr.count % 2 == 0) {
            y = _ordersArr.count /2  * 185 + _ordersArr.count/2 * 10 + 10;
        }else{
            y = (_ordersArr.count /2 + 1) * 185 + (_ordersArr.count/2 + 1) * 10 + 10;
        }
        QDLog(@"123y= %lf", y);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, y) collectionViewLayout:layou];
        self.collectionView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        self.collectionView.scrollEnabled = NO;
        //注册单元格
        [_collectionView registerClass:[RootCollectionCell class] forCellWithReuseIdentifier:@"cell"];
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
        y = _ordersArr.count /2  * 185 + _ordersArr.count/2 * 10 + 10;
    }else{
        y = (_ordersArr.count /2 + 1) * 185 + (_ordersArr.count/2 + 1) * 10 + 10;
    }
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, y);
    if (_ordersArr.count) {
        [self.collectionView reloadData];
    }
    [cell.contentView addSubview:self.collectionView];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.sectionHeaderView;
}

- (QDTradeShellsSectionHeaderView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[QDTradeShellsSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_sectionHeaderView.filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
        _sectionHeaderView.backgroundColor = APP_WHITECOLOR;
    }
    return _sectionHeaderView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_shellType == QDMyOrders) {
        QDOrderDetailVC *detailVC = [[QDOrderDetailVC alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (QDFilterTypeOneView *)typeOneView{
    if (_typeOneView) {
        _typeOneView = [[QDFilterTypeOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 282)];
        _typeOneView.backgroundColor = APP_WHITECOLOR;
        _typeOneView.sdIsPartialBlock = ^(NSString * _Nonnull directionID) {
            _isPartialDeal = directionID;
        };
    }
    return _typeOneView;
}

- (void)confirmOptions:(UIButton *)sender{
    _minPrice = _typeOneView.lowPrice.text;
    _maxPrice = _typeOneView.hightPrice.text;
    _minVolume = _typeOneView.lowAmount.text;
    _maxVolume = _typeOneView.hightAmount.text;
    [self requestYWBHeaderTopData];
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
        satifiedVC.typeStr = @"1";  //请求市场上的卖单数据
        [self.navigationController pushViewController:satifiedVC animated:YES];
    }
}

- (void)resetAction:(UIButton *)sender{
    _isPartialDeal = @"";
    [self requestYWBHeaderTopData];
}

- (void)filterAction:(UIButton *)sender{
    QDLog(@"filter");
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    if (!_typeOneView) {
        _typeOneView = [[QDFilterTypeOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 282)];
        [_typeOneView.confirmBtn addTarget:self action:@selector(confirmOptions:) forControlEvents:UIControlEventTouchUpInside];
        [_typeOneView.resetbtn addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        _typeOneView.backgroundColor = APP_WHITECOLOR;
        _typeOneView.sdIsPartialBlock = ^(NSString * _Nonnull directionID) {
            _isPartialDeal = directionID;
        };
    }
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_typeOneView];
    _popups.presentationStyle = PresentationStyleTop;
    
    _popups.delegate = self;
    [_popups presentInView:self.tableView animated:YES completion:NULL];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _ordersArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    BiddingPostersDTO *dto = _ordersArr[indexPath.row];
    [cell loadDataWithDataArr:dto andTypeStr:dto.postersType];
    cell.sell.tag = indexPath.row;
    [cell.sell addTarget:self action:@selector(buyOrSellAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
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
        QDLog(@"cell.sell.tag = %ld", (long)sender.tag);
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
