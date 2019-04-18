//
//  UserMoneyDTO.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/23.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//资金信息
@interface UserMoneyDTO : NSObject
@property (nonatomic, strong) NSString *userId;             //用户ID
@property (nonatomic, assign) NSInteger userType;           //用户类型
@property (nonatomic, strong) NSString *currencyId;         //币种
@property (nonatomic, assign) NSDecimalNumber *balance;     //总资金
@property (nonatomic, assign) NSDecimalNumber *available;   //可提现资金
@property (nonatomic, assign) NSInteger applyState;         //是否第一次获取积分为申购
@property (nonatomic, assign) NSDecimalNumber *frozenTrading;     //冻结资金
@property (nonatomic, assign) NSDecimalNumber *frozenWithdraw;     //冻结消费积分
@end

NS_ASSUME_NONNULL_END
