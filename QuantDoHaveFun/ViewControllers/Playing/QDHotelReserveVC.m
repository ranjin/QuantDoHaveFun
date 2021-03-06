//
//  QDHotelReserveVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHotelReserveVC.h"
#import "QDHotelReserveTableHeaderView.h"
#import "QDHotelTableViewCell.h"
#import "TFDropDownMenu.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDGifRefreshHeader.h"
#import "QDBridgeViewController.h"
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "QDOrderField.h"
#import <TYAlertView.h>
#import "AppDelegate.h"
#import "QDPriceRangeView.h"
#import "QDCitySelectedViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "QDCalendarViewController.h"

//预定酒店 定制游 商城
@interface QDHotelReserveVC ()<UITableViewDelegate, UITableViewDataSource, TFDropDownMenuViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, CLLocationManagerDelegate, UITextFieldDelegate, getChoosedAreaDelegate>{
    UITableView *_tableView;
    TFDropDownMenuView *_menu;
    QDHotelReserveTableHeaderView *_headerView;    
    NSMutableArray *_hotelListInfoArr;
    NSMutableArray *_hotelImgArr;
    QD_LOCATION_STATUS _locationStatus;
    QDEmptyType _emptyType;
    QDPriceRangeView *_priceRangeView;
    int _totalPage;
    int _pageNum;
    int _pageSize;
    NSMutableArray *_hotelLevelArr;
    NSMutableArray *_hotelTypeIdArr;
    NSMutableArray *_levelArr;
    NSString *_cityName;
}

@end

@implementation QDHotelReserveVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstLaunch:) name:@"FirstLaunch" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FirstLaunch" object:nil];
}

- (void)firstLaunch:(NSNotification *)noti{
    if (_hotelLevelArr.count == 0 || _hotelListInfoArr.count == 0) {
        [self finAllMapDic];
        [self requestHotelData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _hotelListInfoArr = [[NSMutableArray alloc] init];
    _hotelImgArr = [[NSMutableArray alloc] init];
    _pageNum = 1;
    _pageSize = 10;
    _totalPage = 0; //总页数默认
    
    _hotelTypeId = @"";
    _hotelLevel = @"";
    _minPrice = @"";
    _maxPrice = @"";
    _cityName = @"";
    _hotelLevelArr = [[NSMutableArray alloc] init];
    _hotelTypeIdArr = [[NSMutableArray alloc] init];
    _levelArr = [[NSMutableArray alloc] init];

    [self finAllMapDic];
    [self requestHotelData];
}

- (void)finAllMapDic{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindAllMapDict params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            if ([[dic allKeys] containsObject:@"hotelLevel"]) {
                if (_hotelLevelArr.count) {
                    [_hotelLevelArr removeAllObjects];
                }
                if (_hotelTypeIdArr.count) {
                    [_hotelTypeIdArr removeAllObjects];
                }
                if (_levelArr.count) {
                    [_levelArr removeAllObjects];
                }
                NSArray *aaa = [dic objectForKey:@"hotelLevel"];
                for (NSDictionary *dd in aaa) {
                    [_hotelLevelArr addObject:[dd objectForKey:@"dictName"]];
                }
                NSArray *bbb = [dic objectForKey:@"hotelTypeId"];
                for (NSDictionary *dd in bbb) {
                    [_hotelTypeIdArr addObject:[dd objectForKey:@"dictName"]];
                }
                if (_hotelTypeIdArr.count) {
                    if (![_hotelTypeIdArr[0] isEqualToString:@"酒店类型"]) {
                        [_hotelTypeIdArr insertObject:@"酒店类型" atIndex:0];
                    }
                }
                if (_hotelLevelArr.count) {
                    if (![_hotelLevelArr[0] isEqualToString:@"星级"]) {
                        [_hotelLevelArr insertObject:@"星级" atIndex:0];
                    }
                }
                [self setDropMenu];
                [self initTableView];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
        [self setDropMenu];
        [self initTableView];
    }];
}

- (void)setCenterView{
    _headerView = [[QDHotelReserveTableHeaderView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 200)];
    _headerView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [self.view addSubview:_headerView];
    [_headerView.dateIn addTarget:self action:@selector(chooseRoomInOrOut:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.dateOut addTarget:self action:@selector(chooseRoomInOrOut:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.locateBtn addTarget:self action:@selector(myLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.searchBtn addTarget:self action:@selector(startSearch:) forControlEvents:UIControlEventTouchUpInside];
    _dateInPassedVal = _headerView.dateInPassVal;
    _dateOutPassedVal = _headerView.dateOutPassVal;
}

- (void)startSearch:(UIButton *)sender{
    [_headerView.locationTF resignFirstResponder];
    _cityName = _headerView.locationTF.text;
    [self requestHotelHeaderData];
}
#pragma mark - 选择入住时间(自定义日历)
- (void)chooseRoomInOrOut:(UIButton *)sender{
    QDCalendarViewController * calendar = [[QDCalendarViewController alloc] init];
    calendar.delegate = self;
    calendar.dateInStr = _headerView.dateInStr;
    calendar.dateOutStr = _headerView.dateOutStr;
    [calendar returnDate:^(NSString * _Nonnull startDate, NSString * _Nonnull endDate, NSString * _Nonnull dateInPassedVal, NSString * _Nonnull dateOutPassedVal, int totayDays) {
        [self sendDateStr:startDate andDateOutStr:endDate andDateInPassedVal:dateInPassedVal andDateOutPassedVal:dateOutPassedVal andTotalDays:totayDays];
    }];
    [self presentViewController:calendar animated:YES completion:nil];
}

- (void)sendDateStr:(NSString *)dateInStr andDateOutStr:(NSString *)dateOutStr andDateInPassedVal:(NSString *)dateInPassedStr andDateOutPassedVal:(NSString *)dateOutPassedStr andTotalDays:(int)totalDays{
    QDLog(@"dateInStr = %@", dateInStr);
    [_headerView.dateIn setTitle:dateInStr forState:UIControlStateNormal];
    [_headerView.dateOut setTitle:dateOutStr forState:UIControlStateNormal];
    //
    _dateInStr = dateInStr;
    _dateOutStr = dateOutStr;
    _dateInPassedVal = dateInPassedStr;
    _dateOutPassedVal = dateOutPassedStr;
    _headerView.dateInStr = dateInStr;
    _headerView.dateOutStr = dateOutStr;
    _headerView.totalDayLab.text = [NSString stringWithFormat:@"%d晚", totalDays];
}

#pragma mark - 定位:我的位置
- (void)myLocation:(UIButton *)sender{
    QDCitySelectedViewController *locationVC = [[QDCitySelectedViewController alloc] init];
    locationVC.delegate = self;
    locationVC.selectCity = ^(NSString * _Nonnull cityName) {
        QDLog(@"cityName");
        _headerView.locationTF.text = cityName;
    };
    [self presentViewController:locationVC animated:YES completion:nil];
}

- (void)getChoosedAreaName:(NSString *)areaStr{
    _headerView.locationTF.text = areaStr;
}

#pragma mark - 请求酒店头部数据
- (void)requestHotelHeaderData{
    _pageNum = 1;
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{
                            @"hotelName":_cityName,          //城市名称
                            @"hotelTypeId":_hotelTypeId,    //酒店类型
                            @"hotelLevel":_hotelLevel,      //星级
                            @"minPrice":_minPrice,
                            @"maxPrice":_maxPrice,
                            @"pageNum":[NSNumber numberWithInt:_pageNum],
                            @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetHotelCondition params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            if (hotelArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSMutableArray *imgarr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in hotelArr) {
                    QDHotelListInfoModel *infoModel = [QDHotelListInfoModel yy_modelWithDictionary:dic];
                    [arr addObject:infoModel];
                    
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    NSString *urlStr = [dic objectForKey:@"imageFullUrl"];
                    QDLog(@"urlStr = %@", urlStr);
                    [imgarr addObject:urlStr];
                }
                if (arr.count) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_hotelListInfoArr addObjectsFromArray:arr];
                        [_hotelImgArr addObjectsFromArray:imgarr];
                        _tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        [_tableView reloadData];
                    }else{
                        [_hotelListInfoArr addObjectsFromArray:arr];
                        [_hotelImgArr addObjectsFromArray:imgarr];
                        _tableView.mj_footer.state = MJRefreshStateIdle;
                        [_tableView reloadData];
                    }
                    if ([_tableView.mj_header isRefreshing]) {
                        [_tableView.mj_header endRefreshing];
                    }
                }else{
                    [_tableView reloadData];
                    [_tableView.mj_header endRefreshing];
                }
            }else{
                _emptyType = QDNODataError;
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
                [_tableView.mj_header endRefreshing];
            }
        }else{
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
            [self endRefreshing];
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        _emptyType = QDNetworkError;
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [self endRefreshing];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 请求酒店信息
- (void)requestHotelData{
    if (_totalPage != 0) {
        if (_pageNum > _totalPage) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    NSDictionary * dic1 = @{
                            @"hotelName":_cityName,          //城市名称
                            @"hotelTypeId":_hotelTypeId,    //酒店类型
                            @"hotelLevel":_hotelLevel,      //星级
                            @"minPrice":_minPrice,
                            @"maxPrice":_maxPrice,
                            @"pageNum":[NSNumber numberWithInt:_pageNum],
                            @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetHotelCondition params:dic1 successBlock:^(QDResponseObject *responseObject) {
//        [_tableView tab_endAnimation];
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            if (hotelArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSMutableArray *imgarr = [[NSMutableArray alloc] init];

                for (NSDictionary *dic in hotelArr) {
                    QDHotelListInfoModel *infoModel = [QDHotelListInfoModel yy_modelWithDictionary:dic];
                    [arr addObject:infoModel];
                    
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    NSString *urlStr = [dic objectForKey:@"imageFullUrl"];
                    QDLog(@"urlStr = %@", urlStr);
                    [imgarr addObject:urlStr];
                }
                if (arr.count) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_hotelListInfoArr addObjectsFromArray:arr];
                        [_hotelImgArr addObjectsFromArray:imgarr];
                        [_tableView reloadData];
                        if ([_tableView.mj_footer isRefreshing]) {
                            [self endRefreshing];
                            _tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        }
                    }else{
                        [_hotelListInfoArr addObjectsFromArray:arr];
                        [_hotelImgArr addObjectsFromArray:imgarr];
                        _tableView.mj_footer.state = MJRefreshStateIdle;
                        [_tableView reloadData];
                    }
                }
                [_tableView reloadData];
            }else{
                _emptyType = QDNODataError;
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
        }
//        [_tableView tab_endAnimation];
        [self endRefreshing];
    } failureBlock:^(NSError *error) {
        _emptyType = QDNetworkError;
        [self endRefreshing];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
//        [_tableView tab_endAnimation];
    }];
}

- (void)priceRangeRest:(UIButton *)sender{
    QDLog(@"reset");
    _priceRangeView.slider.currentMinValue = 0;
    _priceRangeView.slider.currentMaxValue = 900;
    _maxPrice = @"";
}

- (void)confirmToSelectPrice:(UIButton *)sender{
    [_menu animateForIndicator:_menu.currentIndicatorLayers[2] titlelayer: _menu.currentTitleLayers[2] show:NO complete:^{
        _menu.isShow = false;
    }];
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    _pageNum = 1;
    [self requestHotelData];
}
- (void)setDropMenu{
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:_hotelTypeIdArr, @[@"价格"], _hotelLevelArr, nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[], @[], @[], nil];
    _menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 50) firstArray:data1 secondArray:data2];
    _menu.bottomLineView.backgroundColor = APP_WHITECOLOR;
    _menu.backgroundColor = APP_WHITECOLOR;
    _menu.delegate = self;
    _menu.ratioLeftToScreen = 0.35;
    
    /*风格*/
    _menu.menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], nil];
    _priceRangeView = [[QDPriceRangeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.38)];
    _priceRangeView.backgroundColor = APP_WHITECOLOR;
    [_priceRangeView.resetBtn addTarget:self action:@selector(priceRangeRest:) forControlEvents:UIControlEventTouchUpInside];
    [_priceRangeView.confirmBtn addTarget:self action:@selector(confirmToSelectPrice:) forControlEvents:UIControlEventTouchUpInside];
    _priceRangeView.slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        if (maxValue < 900) {
            _minPrice = [NSString stringWithFormat:@"%.f", minValue];
            _maxPrice = [NSString stringWithFormat:@"%.f", maxValue];
            _priceRangeView.priceDetailLab.text = [NSString stringWithFormat:@"%.f-%.f", minValue, maxValue];
            
        }else{
            _minPrice = [NSString stringWithFormat:@"%.f", minValue];
            _maxPrice = @"";
            _priceRangeView.priceDetailLab.text = [NSString stringWithFormat:@"%.f-不限", minValue];
        };
        NSLog(@"minValue = %.f, maxValue = %.f", minValue, maxValue);
    };
    _menu.customViews = [NSMutableArray arrayWithObjects:[NSNull null], _priceRangeView, [NSNull null], nil];
    [self.view addSubview:_menu];
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, -200, 0);
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    [_tableView tab_startAnimation];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT*0.2, 0);
    _tableView.estimatedRowHeight = 140;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _headerView = [[QDHotelReserveTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 235)];
    _headerView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
//    _headerView.backgroundColor = APP_BLUECOLOR;
    [_headerView.dateIn addTarget:self action:@selector(chooseRoomInOrOut:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.dateOut addTarget:self action:@selector(chooseRoomInOrOut:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.locateBtn addTarget:self action:@selector(myLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.searchBtn addTarget:self action:@selector(startSearch:) forControlEvents:UIControlEventTouchUpInside];
    _dateInPassedVal = _headerView.dateInPassVal;
    _dateOutPassedVal = _headerView.dateOutPassVal;
    _tableView.tableHeaderView = _headerView;
    [self.view addSubview:_tableView];
    
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        if (_hotelLevelArr.count == 0) {
            [self finAllMapDic];
        }
        [self requestHotelHeaderData];
    }];
    //手动刷新请求最新数据
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        _pageNum++;
        [self requestHotelData];
    }];
}

- (void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)endRefreshing
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
}

#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hotelListInfoArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QDHotelTableViewCell";
    QDHotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDHotelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_hotelListInfoArr.count) {
        [cell fillContentWithModel:_hotelListInfoArr[indexPath.row] andImgURLStr:_hotelImgArr[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_hotelListInfoArr.count) {
        QDHotelListInfoModel *model = _hotelListInfoArr[indexPath.row];
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld&&startDate=%@&&endDate=%@", QD_JSURL, JS_HOTELDETAIL, (long)model.id, _dateInPassedVal, _dateOutPassedVal];
        bridgeVC.infoModel = model;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

#pragma mark - emptyDataSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (_emptyType == QDNODataError) {
        return [UIImage imageNamed:@"icon_nodata"];
    }else if(_emptyType == QDNetworkError){
        return [UIImage imageNamed:@"icon_noConnect"];
    }
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text;
    if (_emptyType == QDNODataError) {
        text = @"暂无数据";
    }else{
        text = @"页面加载失败";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: APP_BLUECOLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"请检查您的手机网络后点击重试";
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
//                                 NSForegroundColorAttributeName: APP_GRAYLINECOLOR,
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return NO;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
}

#pragma mark - TFDropDownMenuView Delegate
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index{
    QDLog(@"第%ld列 第%ld个", (long)index.column, (long)index.section);
    _pageNum = 1;
    switch (index.column) {
        case 0:             //酒店类型
            QDLog(@"0");
            _hotelTypeId = (index.section == 0)? @"": ([NSString stringWithFormat:@"%ld", (long)index.section]);
            QDLog(@"_hotelTypeId = %@", _hotelTypeId);
            break;
        case 1:             //价格
            
            QDLog(@"1");
            break;
        case 2:             //星级
            _hotelLevel = (index.section == 0)? @"": ([NSString stringWithFormat:@"%ld", (long)index.section]);
            QDLog(@"_hotelLevel = %@", _hotelLevel);
            break;
        default:
            break;
    }
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    [self requestHotelData];
}

- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column{
    QDLog(@"column:%ld", (long)column);
    //让tableView滚动到顶部位置
    [_tableView setContentOffset:CGPointZero animated:YES];
    //    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [_tableView scrollToRowAtIndexPath:scrollIndexPath
    //                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark - CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _locationStatus = QD_LOCATION_SUCCESS;
    CLLocation *currentLocation = [locations lastObject];
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error) {
        for (CLPlacemark * placemark in array) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            //  Country(国家)  State(省)  City（市）
            NSLog(@"#####%@",address);
            
            NSLog(@"%@", [address objectForKey:@"Country"]);
            
            NSLog(@"%@", [address objectForKey:@"State"]);
            
            NSLog(@"%@", [address objectForKey:@"City"]);
            _headerView.locationTF.text = [address objectForKey:@"City"];
            //发送通知
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    _locationStatus = QD_LOCATION_FAILED;
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"尚未打开定位" message:@"是否在设置中打开定位?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        [WXProgressHUD hideHUD];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
    }]];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
        [WXProgressHUD showErrorWithTittle:@"位置访问被拒绝"];
        _headerView.locationTF.text = @"定位失败";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        [WXProgressHUD showErrorWithTittle:@"无法获取位置信息"];
        _headerView.locationTF.text = @"定位失败";
        QDLog(@"kCLErrorLocationUnknown");
    }
}
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return -70;
//}
@end
