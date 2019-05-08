//
//  LDLocationManager.h
//  carDV
//
//  Created by lidi on 2018/8/28.
//  Copyright © 2018年 rc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationResult)(CLPlacemark *placemark,BOOL fail);

@interface LDLocationManager : NSObject
@property(nonatomic,copy)LocationResult block;
+(instancetype)shareManager;
-(void)startLocation:(void(^)(CLPlacemark *placemark,BOOL fail))placemark;
@end
