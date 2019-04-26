//
//  QDBaseViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelReserveVC : QDBaseViewController
@property (nonatomic, strong) NSString *hotelTypeId;    //酒店类型
@property (nonatomic, strong) NSString *hotelLevel;     //酒店星级
@property (nonatomic, strong) NSString *minPrice;       //最小价格
@property (nonatomic, strong) NSString *maxPrice;       //最大价格
@end

NS_ASSUME_NONNULL_END
