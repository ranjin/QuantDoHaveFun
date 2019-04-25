//
//  QDMyPickOrderModel.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/25.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 amount = 50;
 businessType = 1;
 cancel = "<null>";
 cancelReason = "<null>";
 createTime = 1550562402000;
 creater = U1902150023;
 creditCode = 10001;
 firstTime = 0;
 firstVisit = 1;
 id = 266;
 number = 5;
 orderId = P190219A00007;
 pageNum = "<null>";
 pageSize = "<null>";
 payment = "<null>";
 postersId = O190219B00010;
 poundage = 10;
 price = 10;
 remainMinutes = 0;
 state = 1;
 tradingUserId = U1902150024;
 transactionId = T190219A00007;
 updateTime = "<null>";
 updater = "<null>";
 userId = U1902150023;
 */
NS_ASSUME_NONNULL_BEGIN

@interface QDMyPickOrderModel : NSObject

@property (nonatomic, assign) NSInteger id;                         //酒店代码
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *businessType;
@property (nonatomic, strong) NSString *cancel;
@property (nonatomic, strong) NSString *cancelReason;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *creditCode;
@property (nonatomic, strong) NSString *firstTime;
@property (nonatomic, strong) NSString *firstVisit;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *pageNum;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *payment;
@property (nonatomic, strong) NSString *postersId;
@property (nonatomic, strong) NSString *poundage;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *remainMinutes;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *tradingUserId;
@property (nonatomic, strong) NSString *transactionId;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *updater;
@property (nonatomic, strong) NSString *userId;
@end

NS_ASSUME_NONNULL_END
