//
//  VipCardDTO.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipCardDTO : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *creditCode;             //积分卡id
@property (nonatomic, strong) NSString *vipTypeName;            //IP卡类型
@property (nonatomic, strong) NSString *vipMoney;               //VIP卡金额
@property (nonatomic, strong) NSString *isDefault;              //isDefault
@property (nonatomic, strong) NSString *basePrice;              //基准价
@property (nonatomic, strong) NSString *subscriptCount;         //申购数量

@end

NS_ASSUME_NONNULL_END
