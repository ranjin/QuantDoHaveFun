//
//  HotelCouponDetailDTO.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/28.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HotelCouponDetailDTO : NSObject
@property (nonatomic, assign) NSInteger houseCouponId;     //房券活动参数id
@property (nonatomic, assign) NSInteger count;     //房券个数
@property (nonatomic, strong) NSString *userId;    //用户ID
@property (nonatomic, strong) NSString *partakeDate;    //参与活动的日期
@property (nonatomic, strong) NSString *isUsed;    //是否使用过
@property (nonatomic, strong) NSString *notUseDate;    //不可参与日期
@property (nonatomic, strong) NSString *overdueDate;    //房券过期时间

@property (nonatomic, strong) NSString *hotelCode;    //预订的酒店代码

@property (nonatomic, strong) NSString *roomTypeId;     //房型
@property (nonatomic, strong) NSString *checkInDate;    //入住时间
@property (nonatomic, strong) NSString *checkOutDate;    //离店时间
@property (nonatomic, strong) NSString *beginDate;    //活动开始时间
@property (nonatomic, strong) NSString *endDate;      //活动结束时间
@property (nonatomic, strong) NSString *creditThreshold;    //活动积分阈值
@property (nonatomic, strong) NSString *hotelName;    //房型
@property (nonatomic, strong) NSString *roomTypeName;    //房型
@property (nonatomic, strong) NSString *canBeUse;    //是否可用,0-否,1-是
@property (nonatomic, strong) NSString *advanceDays;    //提前预定天数

@end

NS_ASSUME_NONNULL_END
