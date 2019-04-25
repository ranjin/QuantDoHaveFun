//
//  QDNavigationService.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/1.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface QDNavigationService : NSObject

/**
 打开第三方地图导航
 */

+(void)navWithViewController:(UIViewController *)viewController WithEndLocation:(CLLocationCoordinate2D)endLocation andAddress:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
