//
//  QDCreditOrder.h
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/6.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDCreditOrder : NSObject
@property(nonatomic,assign)NSInteger ID;      // 唯一ID
@property(nonatomic,assign)NSInteger orderType;     // 订单类型
@property(nonatomic,copy)NSString *orderNumber;     // 订单号
@property(nonatomic,copy)NSString *userId;      // 用户代码
@property(nonatomic,copy)NSString *orderDate;  // 订单日期
@property(nonatomic,copy)NSString *sellerName; // 卖方名称
@property(nonatomic,copy)NSString *productName; // 商品名称
@property(nonatomic,assign)double price;    // 单价
@property(nonatomic,assign)NSInteger amount;  // 数量
@property(nonatomic,copy)NSString *rebatePrice; // 返佣
@property(nonatomic,assign)NSInteger orderStatus; //订单状态
@property(nonatomic,copy)NSString *startDate;   //入住，游览开始日期
@property(nonatomic,copy)NSString *endDate;  // 入住，游览结束日期
@property(nonatomic,copy)NSString *createDatetime;  //创建时间
@property(nonatomic,copy)NSString *payDatetime;  // 支付时间
@property(nonatomic,copy)NSString *checkDatetime;  // 审核时间
@property(nonatomic,copy)NSString *finishDatetime;  // 订单完成时间
@property(nonatomic,copy)NSString *refundDatetime;  // 退款时间
@property(nonatomic,copy)NSString *imgUrl;  //订单图片url
@property(nonatomic,copy)NSString *productDesc;  //订单描述
@property(nonatomic,copy)NSString *creditCode; // 积分代码
@end

NS_ASSUME_NONNULL_END
