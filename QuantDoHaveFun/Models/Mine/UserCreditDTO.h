//
//  UserCreditDTO.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/23.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//用户资金账户金额
@interface UserCreditDTO : NSObject

@property (nonatomic, strong) NSString *userId;             //用户ID
@property (nonatomic, assign) NSInteger userType;           //用户类型
@property (nonatomic, strong) NSString *creditCode;         //积分代码
@property (nonatomic, assign) NSDecimalNumber *balance;     //总积分
@property (nonatomic, assign) NSDecimalNumber *available;   //可用积分
@property (nonatomic, assign) NSInteger applyState;         //是否第一次获取积分为申购
@property (nonatomic, assign) NSDecimalNumber *frozenTrading;     //冻结交易积分
@property (nonatomic, assign) NSDecimalNumber *frozenConsume;     //冻结消费积分
@property (nonatomic, assign) NSDecimalNumber *frozenMargin;      //冻结保障金积分
@property (nonatomic, assign) NSDecimalNumber *totalFrozen;       //总冻结
@property (nonatomic, assign) NSDecimalNumber *totalReward;       //总共奖励积分

@end

NS_ASSUME_NONNULL_END
