//
//  QDBridgeViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/16.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHotelListInfoModel.h"
#import "CustomTravelDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDBridgeTViewController : UIViewController

@property (nonatomic, strong) QDHotelListInfoModel *infoModel;
@property (nonatomic, strong) CustomTravelDTO *customTravelModel;

@property (nonatomic, strong) NSString *urlStr;

@end

NS_ASSUME_NONNULL_END
