//
//  QDKeyWordsSearchVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDKeyWordsSearchVC.h"
#import "QDKeyWordsSearchHeaderView.h"
#import "QDHotelTableViewCell.h"
#import "TFDropDownMenu.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDCustomTourCell.h"
#import "QDMallTableCell.h"
#import "QDRefreshFooter.h"
#import "QDBridgeViewController.h"
#import "QDSearchViewController.h"
#import "QDCalendarViewController.h"
#import "QDKeyWordsSearchViewT.h"
#import "AppDelegate.h"
#import "QDPriceRangeView.h"
#import "QDSegmentControl.h"
@interface QDKeyWordsSearchVC ()<UITableViewDelegate, UITableViewDataSource, TFDropDownMenuViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, GetSearchStrDelegate, SendDateStrDelegate>{
    UITableView *_tableView;
    QDKeyWordsSearchHeaderView *_headView;
    QDKeyWordsSearchViewT *_headViewT;
    QDPriceRangeView *_priceRangeView;
    TFDropDownMenuView *_menu;
    QDSegmentControl *_segmentControl;
    NSMutableArray *_array1;
    NSMutableArray *_array2;
    NSMutableArray *_array3;
    
}
@property (nonatomic, strong) QDSegmentControl *segmentControl;

@end

@implementation QDKeyWordsSearchVC

- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return UIReturnKeySearch;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    QDLog(@"%@%@", _dateInStr, _dateOutStr);
    _hotelTypeId = @"";
    _hotelLevel = @"";
    _minPrice = @"";
    _maxPrice = @"";
    self.view.backgroundColor = APP_WHITECOLOR;
    if (_hotelListInfoArr == nil) {
        _hotelListInfoArr = [[NSMutableArray alloc] init];
    }
    if (_hotelImgArr == nil) {
        _hotelImgArr = [[NSMutableArray alloc] init];
    }
    if (_dzyListInfoArr == nil) {
        _dzyListInfoArr = [[NSMutableArray alloc] init];
    }
    if (_hotelImgArr == nil) {
        _hotelImgArr = [[NSMutableArray alloc] init];
    }
    
    //设置筛选header
//    _array1 = [[NSMutableArray alloc] initWithObjects:@"全部区域", nil];
    _array2 = [[NSMutableArray alloc] init];
    _array3 = [[NSMutableArray alloc] init];
//    AppDelegate *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (_array2.count) {
//        [_array2 removeAllObjects];
//    }
//    _array2 = appD.hotelTypeId;
//    if (![_array2[0] isEqualToString:@"酒店类型"]) {
//        [_array2 insertObject:@"酒店类型" atIndex:0];
//    }
//    if (_array3.count) {
//        [_array3 removeAllObjects];
//    }
//    _array3 = appD.hotelLevel;
//    if (![_array3[0] isEqualToString:@"星级"]) {
//        [_array3 insertObject:@"星级" atIndex:0];
//    }
    _headView = [[QDKeyWordsSearchHeaderView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    NSString *final = [NSString stringWithFormat:@"住%@\n离%@", _dateInStr, _dateOutStr];
    [_headView.selectDateBtn setTitle:final forState:UIControlStateNormal];
    [_headView.selectDateBtn addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView.toSearchVCBtn addTarget:self action:@selector(toSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    NSString *ss;
    if ([_keyWords isEqualToString:@""] || _keyWords == nil) {
        ss = @"关键词:无";
    }else{
        ss = [NSString stringWithFormat:@"关键词:%@",_keyWords];
    }
    [_headView.toSearchVCBtn setTitle:ss forState:UIControlStateNormal];
    [_headView.returnBtn addTarget:self action:@selector(returnActiion:) forControlEvents:UIControlEventTouchUpInside];
    _headView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:_headView];
    
    _headViewT = [[QDKeyWordsSearchViewT alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
    [_headViewT.toSearchVCBtn addTarget:self action:@selector(toSearchVC:) forControlEvents:UIControlEventTouchUpInside];
    [_headViewT.toSearchVCBtn setTitle:_keyWords forState:UIControlStateNormal];
    [_headViewT.returnBtn addTarget:self action:@selector(returnActiion:) forControlEvents:UIControlEventTouchUpInside];
    _headViewT.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:_headViewT];
    
    if (_playShellType == QDHotelReserve) {
        [self requestHotelInfoWithURL];
    }else if (_playShellType == QDCustomTour){
        [self requestDZYList:api_GetDZYList];
    }
    
    if (_playShellType == QDHotelReserve) {
        [_headView setHidden:NO];
        [_headViewT setHidden:YES];
    }else{
        [_headView setHidden:YES];
        [_headViewT setHidden:NO];
    }
    //这里是DropMenu或者Segment
    [self setDropMenu];
    
//    [self setSegments];
    [self initTableView];
}

- (void)segmentedClicked:(QDSegmentControl *)segmentControl{
    
}
- (QDSegmentControl *)segmentControl{
    if (!_segmentControl) {
        //分段选择按钮
        NSArray *segmentedTitles = @[@"榜单",@"酒店",@"定制游",@"商品",@"攻略"];
        _segmentControl = [[QDSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.89, SCREEN_HEIGHT*0.07)];
        _segmentControl.sectionTitles = segmentedTitles;
        [_segmentControl addTarget:self action:@selector(segmentedClicked:) forControlEvents:UIControlEventValueChanged];
        _segmentControl.selectionIndicatorColor = APP_BLUECOLOR;
        _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: APP_BLACKCOLOR, NSFontAttributeName: QDFont(16)};
        _segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName: APP_GRAYCOLOR, NSFontAttributeName: QDFont(15)};
        [self.view addSubview:_segmentControl];
    }
    return _segmentControl;
}

#pragma mark - 调用日历控件
- (void)chooseDate:(UIButton *)sender{
    QDCalendarViewController * calendar = [[QDCalendarViewController alloc] init];
    calendar.delegate = self;
    calendar.returnDateBlock = ^(NSString * _Nonnull startDate, NSString * _Nonnull endDate, NSString * _Nonnull dateInPassedVal, NSString * _Nonnull dateOutPassedVal, int totayDays) {
        [_headView.selectDateBtn setTitle:[NSString stringWithFormat:@"住%@\n离%@", startDate, endDate] forState:UIControlStateNormal];
    };
    [self presentViewController:calendar animated:YES completion:nil];
}

- (void)sendDateStr:(NSString *)dateInStr andDateOutStr:(NSString *)dateOutStr andTotalDays:(int)totalDays{
    QDLog(@"dateInStr = %@", dateInStr);
    NSString *inStr = [dateInStr substringWithRange:NSMakeRange(5, 5)];
    NSString *outStr = [dateOutStr substringWithRange:NSMakeRange(5, 5)];
    [_headView.selectDateBtn setTitle:[NSString stringWithFormat:@"住%@\n离%@", inStr, outStr] forState:UIControlStateNormal];
    QDLog(@"inStr = %@", inStr);
}

#pragma mark - QDSearchVC
- (void)toSearchVC:(UIButton *)sender{
    QDSearchViewController *searchVC = [[QDSearchViewController alloc] init];
    searchVC.delegate = self;
    searchVC.searchHotelListResult = ^(NSMutableArray * _Nonnull hotelList, NSMutableArray * _Nonnull imgList) {
        _hotelListInfoArr = hotelList;
        _hotelImgArr = imgList;
        [_tableView reloadData];
    };
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)getSearchStr:(NSString *)searchKeyWords{
    [_headView.toSearchVCBtn setTitle:searchKeyWords forState:UIControlStateNormal];
}

- (void)searchInfo:(UIButton *)sender{
//    [_headView.keyWordsTF resignFirstResponder];
    [self requestHotelInfoWithURL];
}

#pragma mark - 请求酒店信息
- (void)requestHotelInfoWithURL{
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{
                            @"hotelName":_keyWords,         //酒店名,关键词
//                            @"cityName":_cityName,          //城市名称
                            @"hotelTypeId":_hotelTypeId,    //酒店类型
                            @"hotelLevel":_hotelLevel,      //星级
                            @"minPrice":_minPrice,
                            @"maxPrice":_maxPrice,
                            @"pageNum":@1,                  //
                            @"pageSize":@20
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetHotelCondition params:dic1 successBlock:^(QDResponseObject *responseObject) {
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
                _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
                    QDLog(@"sss");
                    [self endRefreshing];
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }];
                [_tableView reloadData];
            }else{
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_menu setHidden:YES];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
    }];
}

#pragma mark - 请求定制游列表信息
- (void)requestDZYList:(NSString *)urlStr{
    if (_dzyListInfoArr.count) {
        [_dzyListInfoArr removeAllObjects];
        [_dzyImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"travelName":_keyWords,
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
                _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
                    QDLog(@"sss");
                    [self endRefreshing];
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }];
                [_tableView reloadData];
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

- (void)returnActiion:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 请求定制游列表信息
//- (void)requestDZYList:(NSString *)urlStr{
//    if (_dzyListInfoArr.count) {
//        [_dzyListInfoArr removeAllObjects];
//        [_dzyImgArr removeAllObjects];
//    }
//    NSDictionary * dic1 = @{@"travelName":@"",
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
//                QDLog(@"_dzyImgArr = %@", _dzyImgArr);
//                [_tableView reloadData];
//            }
//        }
//    } failureBlock:^(NSError *error) {
//        [_tableView reloadData];
//        [_tableView reloadEmptyDataSet];
//        [WXProgressHUD showErrorWithTittle:@"网络异常"];
//    }];
//}


#pragma mark - 查询商城列表信息
//- (void)requestMallList:(NSString *)urlStr{
//    if (_mallInfoArr.count) {
//        [_mallInfoArr removeAllObjects];
//    }
//    NSDictionary * dic1 = @{@"sortColumn":@"",
//                            @"sortType":@"desc",
//                            @"pageNum":@1,
//                            @"pageSize":@20
//                            };
//    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
//        if (responseObject.code == 0) {
//            NSDictionary *dic = responseObject.result;
//            NSArray *mallArr = [dic objectForKey:@"result"];
//            if (mallArr.count) {
//                for (NSDictionary *dic in mallArr) {
//                    QDMallModel *mallModel = [QDMallModel yy_modelWithDictionary:dic];
//                    [_mallInfoArr addObject:mallModel];
//                }
//                QDLog(@"_mallInfoArr = %@", _mallInfoArr);
//                [_tableView reloadData];
//            }
//        }
//    } failureBlock:^(NSError *error) {
//        [_tableView reloadData];
//        [_tableView reloadEmptyDataSet];
//        [WXProgressHUD showErrorWithTittle:@"网络异常"];
//    }];
//}

#pragma mark - 针对榜单页面的
- (void)setSegments{
    //分段选择按钮
    NSArray *segmentedTitles = @[@"榜单",@"酒店",@"定制游",@"商品",@"攻略"];
    _segmentControl = [[QDSegmentControl alloc] initWithSectionTitles:segmentedTitles];
    _segmentControl = [[QDSegmentControl alloc] initWithFrame:CGRectMake(0, 20+SCREEN_HEIGHT*0.1, SCREEN_WIDTH, 50)];
    _segmentControl.sectionTitles = segmentedTitles;
    [_segmentControl addTarget:self action:@selector(segmentedClicked:) forControlEvents:UIControlEventValueChanged];
    _segmentControl.selectionIndicatorColor = APP_BLACKCOLOR;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [self.view addSubview:_segmentControl];
}

- (void)setDropMenu{
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:_array2, @[@"价格"], _array3, nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[], @[], @[], nil];
    _menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 20+SCREEN_HEIGHT*0.1, SCREEN_WIDTH, 50) firstArray:data1 secondArray:data2];
    _menu.backgroundColor = APP_WHITECOLOR;
    _menu.delegate = self;
    _menu.ratioLeftToScreen = 0.35;
    [self.view addSubview:_menu];
    
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.1+20+50, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_WHITECOLOR;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT*0.2, 0);
    [self.view addSubview:_tableView];
    //手动刷新请求最新数据
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        QDLog(@"sss");
        [self endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }];
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
    switch (_playShellType) {
        case QDHotelReserve:
            return _hotelListInfoArr.count;
            break;
        case QDCustomTour:
            return _dzyListInfoArr.count;
            break;
        case QDMall:
            return _mallInfoArr.count;
            break;
        default:
            break;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_playShellType) {
        case QDHotelReserve:
            return SCREEN_HEIGHT*0.21;
            break;
        case QDCustomTour:
            return SCREEN_HEIGHT*0.57;
            break;
        case QDMall:
            return SCREEN_HEIGHT*0.225;
            break;
        default:
            break;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (_playShellType) {
        case QDHotelReserve:
            return 0.01;
            break;
        case QDCustomTour:
            return SCREEN_HEIGHT*0.01;
            break;
        case QDMall:
            return SCREEN_HEIGHT*0.08;
            break;
        default:
            break;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)priceRangeRest:(UIButton *)sender{
    QDLog(@"reset");
    _priceRangeView.slider.currentMinValue = 0;
    _priceRangeView.slider.currentMaxValue = 900;
}

- (void)confirmToSelectPrice:(UIButton *)sender{
    [_menu animateForIndicator:_menu.currentIndicatorLayers[2] titlelayer: _menu.currentTitleLayers[2] show:NO complete:^{
        _menu.isShow = false;
    }];
    [self requestHotelInfoWithURL];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_playShellType == QDHotelReserve) {
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
    }else if (_playShellType == QDCustomTour){
        static NSString *identifier = @"QDCustomTourCell";
        QDCustomTourCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[QDCustomTourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (_dzyListInfoArr.count > 0) {
//            [cell fillCustomTour:_dzyListInfoArr[indexPath.row] andImgURL:_dzyImgArr[indexPath.row]];
//        }
        return cell;
    }else{
        static NSString *identifier = @"QDMallTableCell";
        QDMallTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[QDMallTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (_mallInfoArr.count > 0) {
            [cell fillContentWithModel:_mallInfoArr[indexPath.row]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = APP_WHITECOLOR;
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_playShellType == QDHotelReserve) {
        if (_hotelListInfoArr.count) {
            QDHotelListInfoModel *model = _hotelListInfoArr[indexPath.row];
            //传递ID
            QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
            bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld&&startDate=%@&&endDate=%@", QD_JSURL, JS_HOTELDETAIL, (long)model.id, _dateInPassedVal, _dateOutPassedVal];
            QDLog(@"urlStr = %@", bridgeVC.urlStr);
            bridgeVC.infoModel = model;
            self.tabBarController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bridgeVC animated:YES];
        }
    }else if (_playShellType == QDCustomTour){
        CustomTravelDTO *model = _dzyListInfoArr[indexPath.section];
        //传递ID
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld", QD_JSURL, JS_CUSTOMERTRAVEL, (long)model.id];
        QDLog(@"urlStr = %@", bridgeVC.urlStr);
        bridgeVC.customTravelModel = model;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }else{
        QDMallModel *model = _mallInfoArr[indexPath.row];
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld", QD_JSURL, JS_SHOPPING, (long)model.id];
        QDLog(@"urlStr = %@", bridgeVC.urlStr);
        bridgeVC.mallModel = model;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"emptySource"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -90;
}

#pragma mark - TFDropDownMenuView Delegate
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index{
    QDLog(@"第%ld列 第%ld个", (long)index.column, (long)index.section);
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
    [self requestHotelInfoWithURL];
}

- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column{
    QDLog(@"column:%ld", (long)column);
    //让tableView滚动到顶部位置
    [_tableView setContentOffset:CGPointZero animated:YES];
//    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [_tableView scrollToRowAtIndexPath:scrollIndexPath
//                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
