//
//  SerialLocationViewController.m
//  officialDemoLoc
//
//  Created by 刘博 on 15/9/21.
//  Copyright © 2015年 AutoNavi. All rights reserved.
//

#import "QDHomeVC.h"
#import "QDHomeTopView.h"
#import "RadialCircleAnnotationView.h"
#import "QDCitySelectedViewController.h"
#import "QDHotelsInAreaViewController.h"
@interface QDHomeVC ()<MAMapViewDelegate, AMapLocationManagerDelegate, UISearchBarDelegate, getChoosedAreaDelegate>

@property (nonatomic, strong) UISegmentedControl *showSegment;
@property (nonatomic, strong) UISegmentedControl *headingSegment;
@property (nonatomic, strong) MAPointAnnotation *annotation;
@property (nonatomic, assign) BOOL headingCalibration;
@property (nonatomic, strong) MAPinAnnotationView *annotationView;
@property (nonatomic, assign) CGFloat annotationViewAngle;
@property (nonatomic, strong) CLHeading *heading;
@property (nonatomic, strong) QDHomeTopView *homeTopView;

@property (nonatomic, strong) NSMutableArray *regions;
@property (nonatomic, strong) UIButton *gpsButton;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;

@end

@implementation QDHomeVC

#pragma mark - Action Handle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingHeading];
    [self.locationManager stopUpdatingLocation];
}

- (void)configLocationManager
{
    _headingCalibration = NO;
    
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    //    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    
    [self.locationManager startUpdatingLocation];
}

- (void)showsHeadingAction:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex)
    {
        _headingCalibration = YES;
    }
    else
    {
        _headingCalibration = NO;
    }
}

- (void)startHeadingLocation
{
    //开始进行连续定位
    [self.locationManager startUpdatingLocation];
    
    if ([AMapLocationManager headingAvailable] == YES)
    {
        [self.locationManager startUpdatingHeading];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _headingCalibration = YES;
        [self startHeadingLocation];
    }
    else
    {
        _headingCalibration = NO;
        [self startHeadingLocation];
    }
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f, reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //连续定位中, 添加地理围栏
    if (self.regions.count) {
        [self.regions removeAllObjects];
    }
    
    [self.mapView setCenterCoordinate:location.coordinate];
    [self.annotation setCoordinate:location.coordinate];
    [self.mapView setZoomLevel:15.1 animated:NO];
}

- (BOOL)amapLocationManagerShouldDisplayHeadingCalibration:(AMapLocationManager *)manager
{
    return _headingCalibration;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (_annotationView != nil)
    {
        CGFloat angle = newHeading.trueHeading*M_PI/180.0f + M_PI - _annotationViewAngle;
        NSLog(@"################### heading : %f - %f", newHeading.trueHeading, newHeading.magneticHeading);
        _annotationViewAngle = newHeading.trueHeading*M_PI/180.0f + M_PI;
        _heading = newHeading;
        _annotationView.transform =  CGAffineTransformRotate(_annotationView.transform ,angle);
    }
}

#pragma mark - Initialization

- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.11, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //罗盘
        self.mapView.showsCompass = NO;
        //        self.mapView.showsUserLocation = YES;
        [self.mapView setDelegate:self];
        [self.view addSubview:self.mapView];
    }
}

- (void)popReturn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    _homeTopView = [[QDHomeTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.3)];
    _homeTopView.backgroundColor = APP_BLUECOLOR;
    [_homeTopView.returnBtn addTarget:self action:@selector(popReturn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_homeTopView];
    _homeTopView.searchBar.delegate = self;
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(SCREEN_HEIGHT*0.85);
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"发行计划";
    lab.font = QDFont(13);
    [_bottomView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_left).offset(SCREEN_WIDTH*0.027);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = APP_GRAYCOLOR;
    [_bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_left).offset(SCREEN_WIDTH*0.2);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.02);
        make.width.mas_equalTo(SCREEN_WIDTH*0.008);
    }];
    
    UILabel *desc = [[UILabel alloc] init];
    desc.text = @"发行计划说明文字";
    desc.font = QDFont(11);
    desc.textColor = APP_GRAYCOLOR;
    [_bottomView addSubview:desc];
    [desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.left.equalTo(_bottomView.mas_left).offset(SCREEN_WIDTH*0.23);
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"home_dropDown"];
    [_bottomView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView);
        make.right.equalTo(_bottomView.mas_right).offset(-(SCREEN_WIDTH*0.027));
    }];
}

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.regions = [[NSMutableArray alloc] init];
    
    [self initMapView];
    [self initUI];
    
    [self configLocationManager];
    [self addOneAnnotation];
    [self getCurrentLocation];
    
    //    UIView *zoomPannelView = [self makeZoomPannelView];
    //    zoomPannelView.center = CGPointMake(self.view.bounds.size.width -  CGRectGetMidX(zoomPannelView.bounds) - 10,
    //                                        self.view.bounds.size.height -  CGRectGetMidY(zoomPannelView.bounds) - 10);
    //
    //    zoomPannelView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    //    [self.view addSubview:zoomPannelView];
    
    //    self.gpsButton = [self makeGPSButtonView];
    //    [self.view addSubview:self.gpsButton];
    //    self.gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    //    [self.gpsButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(_bottomView);
    //        make.bottom.equalTo(_bottomView.mas_top).offset(-(SCREEN_HEIGHT*0.03));
    //    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //    [self startHeadingLocation];
    //
    //    if ([AMapLocationManager headingAvailable] == NO)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备不支持方向功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    //        [alertView show];
    //    }
}

- (void)getCurrentLocation{
    //终点地名
    NSString *oreillyAddress = [NSString stringWithFormat:@"%@, %@", _cityStr, _addressStr];
    CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
    [myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0 && error == nil) {
            NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
            CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
            
            NSLog(@"Longitude = %f", firstPlacemark.location.coordinate.longitude);
            NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
            self.destinationCoordinate  = CLLocationCoordinate2DMake(firstPlacemark.location.coordinate.latitude, firstPlacemark.location.coordinate.longitude);
        }
        else if ([placemarks count] == 0 && error == nil) {
            NSLog(@"Found no placemarks.");
        } else if (error != nil) {
            NSLog(@"An error occurred = %@", error);
        }
    }];
}

- (void)addOneAnnotation{
    _annotation = [[MAPointAnnotation alloc] init];
    _annotation.coordinate = self.mapView.centerCoordinate;
    [self.mapView addAnnotation:self.annotation];
}
#pragma mark - MAMapView Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIdentifier = @"pointReuseIdentifier";
        RadialCircleAnnotationView *annotationView = (RadialCircleAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIdentifier];
        if (annotationView == nil)
        {
            annotationView = [[RadialCircleAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIdentifier];
            annotationView.canShowCallout = YES;
            
            //脉冲圈个数
            annotationView.pulseCount = 2;
            //单个脉冲圈动画时长
            annotationView.animationDuration = 8.0;
            //单个脉冲圈起始直径
            annotationView.baseDiameter = 8.0;
            //单个脉冲圈缩放比例
            annotationView.scale = 30.0;
            //单个脉冲圈fillColor
            annotationView.fillColor = APP_BLUECOLOR;
            //单个脉冲圈strokeColor
            annotationView.strokeColor = [UIColor colorWithHexString:@"#E0EDDA"];
            
            //更改设置后重新开始动画
            [annotationView startPulseAnimation];
        }
        return annotationView;
    }
    
    return nil;
}


#pragma mark - MAMapViewDelegate
//
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolygon class]])
    {
        MAPolygonRenderer *polylineRenderer = [[MAPolygonRenderer alloc] initWithPolygon:overlay];
        polylineRenderer.lineWidth = 5.0f;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    else if ([overlay isKindOfClass:[MACircle class]])
    {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        circleRenderer.lineWidth = 0.2;
        circleRenderer.strokeColor = [UIColor colorWithHexString:@"#C9F0C1"];
        circleRenderer.alpha = 0.08;
        return circleRenderer;
    }
    
    return nil;
}

#pragma mark - 定位按钮
- (UIButton *)makeGPSButtonView {
    UIButton *ret = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ret.backgroundColor = [UIColor whiteColor];
    ret.layer.cornerRadius = 4;
    
    [ret setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return ret;
}

- (UIView *)makeZoomPannelView
{
    UIView *ret = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 98)];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    
    return ret;
}

- (void)zoomPlusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
}

- (void)zoomMinusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
}

- (void)gpsAction {
    
    //    11
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    [self.gpsButton setSelected:YES];
    //    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
    //        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    //        [self.gpsButton setSelected:YES];
    //    }
}

#pragma mark - 城市选择其
- (void)getChoosedAreaName:(NSString *)areaStr{
    QDLog(@"areaStr = %@", areaStr);
    QDHotelsInAreaViewController *areaVC = [[QDHotelsInAreaViewController alloc] init];
    [self.navigationController pushViewController:areaVC animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    QDLog(@"searchBarTextDidBeginEditing");
    QDCitySelectedViewController *cityVC = [[QDCitySelectedViewController alloc] init];
    cityVC.delegate = self;
    cityVC.selectCity = ^(NSString * _Nonnull cityName) {
        QDLog(@"%@", cityName);
        QDHotelsInAreaViewController *areaVC = [[QDHotelsInAreaViewController alloc] init];
        [self.navigationController pushViewController:areaVC animated:YES];
    };
    [self presentViewController:cityVC animated:YES completion:nil];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [_homeTopView.searchBar resignFirstResponder];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //    [_homeTopView.searchBar resignFirstResponder];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        [_homeTopView.searchBar resignFirstResponder];
    }else{
    }
}
@end
