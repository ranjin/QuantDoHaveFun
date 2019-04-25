//
//  QDCitySelectedViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/18.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYSearchController.h"
#import <CoreLocation/CoreLocation.h>
#import "SYChineseToPinyin.h"
#import "SYCitysCell.h"
#import "SYTableViewCell.h"
#import "SYHeaderView.h"
#import "SYHotCityHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

//代理
@protocol getChoosedAreaDelegate <NSObject>

- (void)getChoosedAreaName:(NSString *)areaStr;


@end

@interface QDCitySelectedViewController : UIViewController<CLLocationManagerDelegate>
//@property (nonatomic, strong) SYSearchController *searchVc;
//@property (nonatomic, strong) UITableViewController *resultVc;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) NSArray *indexArray;
@property (nonatomic, copy) NSArray *historyCitys;
@property (nonatomic, copy) NSMutableDictionary *cityDicts;
@property (nonatomic, copy) NSArray *cityNames;
@property (nonatomic, assign) NSInteger kCount;

/// 选择城市后回调
@property (nonatomic, copy) void(^selectCity)(NSString *cityName);

@property (nonatomic, strong) id<getChoosedAreaDelegate>delegate;


/*
 * 是否开启定位,默认为NO，请自行定位传当前位置进来
 * 当前，也可开启,开启后 currentCityName 设置无效
 *
 * 如需使用定位，请先在info.plist 配置 添加以下2个配置
 * NSLocationAlwaysUsageDescription
 * NSLocationWhenInUseUsageDescription
 */

/// 返回按钮图片
@property (nonatomic, copy) NSString *backImageName;

/// 返回按钮
@property (nonatomic, strong) UIView *backView;

/// 热门城市
@property (nonatomic, copy) NSArray *hotCitys;

/// 所有城市
@property (nonatomic, copy) NSArray *citys;

/// 自己的城市Dict (Key is 'A,B,C,D...')
@property (nonatomic, copy) NSDictionary *cityDict;

@end

NS_ASSUME_NONNULL_END
