//
//  QDTradingOrder.h
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/8.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDTradingOrder : NSObject
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *userType;
@property(nonatomic,copy)NSString *tradingDate;  // 订单日期
@property(nonatomic,assign)NSInteger tradingDirection;
@property(nonatomic,assign)NSInteger tradingtype;   // 订单类型
@property(nonatomic,assign)NSInteger tradingCount;  // 交易数量
@property(nonatomic,assign)NSInteger tradingAmount;
@property(nonatomic,assign)NSInteger tradingFee;
@property(nonatomic,copy)NSString *orderId;
@property(nonatomic,copy)NSString *creditCode;
@property(nonatomic,copy)NSString *total;
@property(nonatomic,copy)NSString *pageNum;
@property(nonatomic,copy)NSString *pageSize;
@end

NS_ASSUME_NONNULL_END
