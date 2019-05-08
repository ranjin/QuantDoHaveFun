//
//  LDLocationManager.m
//  carDV
//
//  Created by lidi on 2018/8/28.
//  Copyright © 2018年 rc. All rights reserved.
//

#import "LDLocationManager.h"

@interface LDLocationManager()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@end
@implementation LDLocationManager
static LDLocationManager *instance;

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LDLocationManager alloc]init];
        instance.locationManager = [[CLLocationManager alloc]init];
        instance.locationManager.delegate = instance;
        instance.locationManager.distanceFilter=10.0f;
        [instance.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    });
    return instance;
}

#pragma 定位
- (void)startLocation:(void (^)(CLPlacemark *, BOOL))placemark{
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization");
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.block = placemark;
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
    NSLog(@"start gps");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //    [self.locationmanager stopUpdatingHeading];
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //    //打印当前的经度与纬度
        NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    __weak typeof(self) weakSelf = self;
    //反地理编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            //获取地标
            CLPlacemark *placemark=[placemarks firstObject];
            if (weakSelf.block) {
                weakSelf.block(placemark,NO);
            }
        }
    }];
    [manager stopUpdatingLocation];
}
/*
 |  Location Fail ;
 |  定位失败 ;
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.block) {
        self.block(nil,YES);
    }
    NSLog(@"定位失败");
}

@end
