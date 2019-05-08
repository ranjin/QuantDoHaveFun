//
//  QDCreditOrderTableViewCell.h
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/7.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDCreditOrder.h"
#import "QDTradingOrder.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDCreditOrderTableViewCell : UITableViewCell
@property(nonatomic,strong)QDCreditOrder *creditOrder;
@property(nonatomic,strong)QDTradingOrder *tradingOrder;
@end

NS_ASSUME_NONNULL_END
