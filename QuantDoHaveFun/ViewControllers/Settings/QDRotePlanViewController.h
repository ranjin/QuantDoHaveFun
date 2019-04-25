//
//  QDRotePlanViewController.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/1.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "QDHotelListInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDRotePlanViewController : UIViewController
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) NSString *cityStr;
@property (nonatomic, strong) NSString *addressStr;

@property (nonatomic, strong) NSString *currentAddressStr;

@property (nonatomic, strong) QDHotelListInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
