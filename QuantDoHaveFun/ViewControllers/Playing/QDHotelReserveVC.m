//
//  QDHotelReserveVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHotelReserveVC.h"
#import "QDSegmentControl.h"
#import "QDHotelReserveTableHeaderView.h"
#import "QDHotelTableViewCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDLocationTopSelectView.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDGifRefreshHeader.h"
#import "QDCalendarViewController.h"
#import "QDCitySelectedViewController.h"
#import "QDBridgeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "QDKeyWordsSearchVC.h"
#import "QDSearchViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "QDOrderField.h"
#import <TYAlertView.h>
//预定酒店 定制游 商城
@interface QDHotelReserveVC ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, CLLocationManagerDelegate, SendDateStrDelegate, UITextFieldDelegate, getChoosedAreaDelegate>{
    UITableView *_tableView;
    QDHotelReserveTableHeaderView *_headerView;    
    NSMutableArray *_hotelListInfoArr;
    NSMutableArray *_hotelImgArr;
    NSMutableArray *_dzyListInfoArr;
    NSMutableArray *_dzyImgArr;
    NSMutableArray *_mallInfoArr;
    QD_LOCATION_STATUS _locationStatus;
    QDEmptyType _emptyType;
    int _totalPage;
    int _pageNum;
    int _pageSize;
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, getter=isLoading) BOOL loading;

@end

@implementation QDHotelReserveVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];    //停止定位
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    _hotelListInfoArr = [[NSMutableArray alloc] init];
    _hotelImgArr = [[NSMutableArray alloc] init];
    _pageNum = 1;
    _pageSize = 10;
    [self initTableView];
    _totalPage = 0; //总页数默认
    //请求酒店数据
    [self requestHotelInfoIsPushVC:NO];
    [self locate];
}

#pragma mark - locate
- (void)locate{
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 10;
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8){
            [_locationManager requestWhenInUseAuthorization];
        }
        [_locationManager startUpdatingLocation];   //开启定位
    }else{
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

#pragma mark - 请求酒店头部数据
- (void)requestHotelHeaderData{
    _pageNum = 1;
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"hotelName":_headerView.locationTF.text,
                            @"cityName":_headerView.locationLab.text,
                            @"pageNum":[NSNumber numberWithInt:_pageNum],
                            @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetHotelCondition params:dic1 successBlock:^(QDResponseObject *responseObject) {
        self.loading = NO;
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
        self.loading = NO;
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [self endRefreshing];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}


#pragma mark - 请求酒店信息
- (void)requestHotelInfoIsPushVC:(BOOL)pushVC{
//    self.loading = NO;
//    if (_hotelListInfoArr.count) {
//        [_hotelListInfoArr removeAllObjects];
//        [_hotelImgArr removeAllObjects];
//    }
    
    if (_totalPage != 0) {
        if (_pageNum > _totalPage) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    NSDictionary * dic1 = @{@"hotelName":_headerView.locationTF.text,
                            @"cityName":_headerView.locationLab.text,
                            @"pageNum":[NSNumber numberWithInt:_pageNum],
                            @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetHotelCondition params:dic1 successBlock:^(QDResponseObject *responseObject) {
        [self endRefreshing];
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
                if (pushVC) {
                    QDKeyWordsSearchVC *keyVC = [[QDKeyWordsSearchVC alloc] init];
                    keyVC.playShellType = QDHotelReserve;    //酒店预订的类型
                    NSString *ss = _headerView.dateIn.titleLabel.text;
                    NSString *sss = _headerView.dateOut.titleLabel.text;
                    if(ss.length >= 10 && sss.length >= 10){
                        keyVC.dateInStr = [_headerView.dateIn.titleLabel.text substringWithRange:NSMakeRange(5, 5)];
                        keyVC.dateOutStr = [_headerView.dateOut.titleLabel.text substringWithRange:NSMakeRange(5, 5)];
                    }else{
                        keyVC.dateInStr = [_headerView.dateIn.titleLabel.text substringWithRange:NSMakeRange(0, 5)];
                        keyVC.dateOutStr = [_headerView.dateOut.titleLabel.text substringWithRange:NSMakeRange(0, 5)];
                    }
                    keyVC.keyWords = _headerView.locationTF.text;
                    keyVC.cityName = _headerView.locationLab.text;
                    [self.navigationController pushViewController:keyVC animated:YES];
                }else{
                    [_tableView reloadData];
                }
            }else{
                [WXProgressHUD showInfoWithTittle:@"无数据返回,请重试"];
            }
            [_tableView tab_endAnimation];
        }
    } failureBlock:^(NSError *error) {
        _emptyType = QDNetworkError;
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_tableView tab_endAnimation];
        [self endRefreshing];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
    }];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = APP_WHITECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView tab_startAnimation];
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _headerView = [[QDHotelReserveTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.41)];
    QDLog(@"%@ %@", _headerView.dateInStr, _headerView.dateOutStr);
    _headerView.backgroundColor = [UIColor colorWithHexString:@"#C0C5CD"];
    [_headerView.dateIn addTarget:self action:@selector(chooseRoomInOrOut:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.dateOut addTarget:self action:@selector(chooseRoomInOrOut:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.locateBtn addTarget:self action:@selector(myLocation:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.searchBtn addTarget:self action:@selector(startSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    _dateInPassedVal = _headerView.dateInPassVal;
    _dateOutPassedVal = _headerView.dateOutPassVal;
    _headerView.backgroundColor = [UIColor colorWithHexString:@"#F0F0F0"];
    _tableView.tableHeaderView = _headerView;
//    [self.view addSubview:_tableView];
    self.view = _tableView;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    QDGifRefreshHeader *header = [QDGifRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
//
//    // 马上进入刷新状态
//    [header beginRefreshing];
//
//    // 设置header
//    _tableView.mj_header = header;
    
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        [self requestHotelHeaderData];
    }];
    //手动刷新请求最新数据
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        QDLog(@"sss");
//        [self endRefreshing];
//        [_tableView.mj_footer endRefreshingWithNoMoreData];
        QDLog(@"上拉刷新");
        _pageNum++;
        [self requestHotelInfoIsPushVC:NO];
    }];
}

- (void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)startSearch:(UIButton *)sender{
    QDKeyWordsSearchVC *keyVC = [[QDKeyWordsSearchVC alloc] init];
    keyVC.playShellType = QDHotelReserve;    //酒店预订的类型
    NSString *ss = _headerView.dateIn.titleLabel.text;
    NSString *sss = _headerView.dateOut.titleLabel.text;

    keyVC.dateInPassedVal = _dateInPassedVal;
    keyVC.dateOutPassedVal =_dateOutPassedVal;
    keyVC.dateInStr = ss;
    keyVC.dateOutStr = sss;
    keyVC.keyWords = _headerView.locationTF.text;
    keyVC.cityName = _headerView.locationLab.text;
    [self.navigationController pushViewController:keyVC animated:YES];
}

- (void)endRefreshing
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
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
        _headerView.locationLab.text = cityName;
    };
    [self presentViewController:locationVC animated:YES completion:nil];
}

- (void)getChoosedAreaName:(NSString *)areaStr{
    _headerView.locationLab.text = areaStr;
}

- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    [_tableView reloadEmptyDataSet];
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
    return SCREEN_HEIGHT*0.075;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 35)];
    lab.text = @"    为你推荐";
    lab.font = QDBoldFont(18);
    lab.textColor = APP_BLACKCOLOR;
    lab.backgroundColor = APP_WHITECOLOR;
    return lab;
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
        //传递ID
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld&&startDate=%@&&endDate=%@", QD_JSURL, JS_HOTELDETAIL, (long)model.id, _dateInPassedVal, _dateOutPassedVal];
        QDLog(@"urlStr = %@", bridgeVC.urlStr);
        bridgeVC.infoModel = model;
        self.tabBarController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

#pragma mark - emptyDataSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading_imgBlue" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    }
    else {
        if (_emptyType == QDNODataError) {
            return [UIImage imageNamed:@"icon_nodata"];
        }else if(_emptyType == QDNetworkError){
            return [UIImage imageNamed:@"icon_noConnect"];
        }
    }
    return nil;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 155;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"页面加载失败";
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
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    self.loading = YES;
    [self requestHotelInfoIsPushVC:NO];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    [self requestHotelInfoIsPushVC:NO];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
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
            _headerView.locationLab.text = [address objectForKey:@"City"];
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
        _headerView.locationLab.text = @"定位失败";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        [WXProgressHUD showErrorWithTittle:@"无法获取位置信息"];
        _headerView.locationLab.text = @"定位失败";
        QDLog(@"kCLErrorLocationUnknown");
    }
}

- (void)customerTourSearchAction:(UIButton *)sender{
    QDSearchViewController *searchVC = [[QDSearchViewController alloc] init];
    searchVC.playShellType = QDCustomTour;
    [self.navigationController pushViewController:searchVC animated:YES];
}


@end
