//
//  QDShellRecommendVC.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingPostersDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDShellRecommendVC : UIViewController

@property (nonatomic, assign) int recommendType;
@property (nonatomic, strong) BiddingPostersDTO *recommendModel;
@property (nonatomic, strong) NSString *volume;    //购买数量
@property (nonatomic, strong) NSString *price;     //购买价格
@property (nonatomic, strong) NSString *postersType;     //挂单类型
@property (nonatomic, strong) NSString *isPartialDeal;  //是否允许部分成交
@end

NS_ASSUME_NONNULL_END
