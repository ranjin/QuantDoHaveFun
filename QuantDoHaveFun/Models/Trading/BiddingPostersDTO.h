//
//  BiddingPostersDTO.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/23.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BiddingPostersDTO : NSObject

@property (nonatomic, assign) NSInteger id;                         //
@property (nonatomic, strong) NSString *userId;                     //用户ID
@property (nonatomic, strong) NSString *creditCode;                 //积分代码
@property (nonatomic, strong) NSString *limitVolume;                //最小交易数量
@property (nonatomic, strong) NSString *bidFee;                     //买入挂单手续费
@property (nonatomic, strong) NSString *askFee;                     //卖出挂单手续费
@property (nonatomic, strong) NSString *deductBidFee;               //已扣买入挂单手续费
@property (nonatomic, strong) NSString *deductAskFee;               //已扣卖出挂单手续费
@property (nonatomic, strong) NSString *price;                      //单价
@property (nonatomic, strong) NSString *volume;                     //挂单数量
@property (nonatomic, strong) NSString *isPartialDeal;              //是否部分成交,0-不允许部分成交，1-允许部分成交
@property (nonatomic, strong) NSString *posterUseMargin;            //挂单占用保证金
@property (nonatomic, strong) NSString *frozenVolume;               //冻结数量
@property (nonatomic, strong) NSString *surplusVolume;              //剩余数量

@property (nonatomic, strong) NSString *postersId;                  //挂单编号
@property (nonatomic, strong) NSString *postersStatus;              //挂单状态：0-交易中，1-已成交，2-已撤单，3-意向单
@property (nonatomic, strong) NSString *postersType;                //挂单类型，0买入挂单，1-卖出挂单
@property (nonatomic, strong) NSString *tradingRange;               //单笔交易区间
@property (nonatomic, strong) NSString *bankAccountShow;            //银行卡是否显示：0不显示，1显示
@property (nonatomic, strong) NSString *alipayAccountShow;          //支付宝是否显示：0不显示，1显示
@property (nonatomic, strong) NSString *wechatAccountShow;          //微信是否显示：0不显示，1显示
@property (nonatomic, strong) NSString *createTime;                 //创建时间
@property (nonatomic, strong) NSString *creater;                    //创建人
@property (nonatomic, strong) NSString *updateTime;                 //修改时间
@property (nonatomic, strong) NSString *updater;                    //修改人
@property (nonatomic, strong) NSString *creditName;                 //积分名称
@property (nonatomic, strong) NSString *balance;                    //总额
@property (nonatomic, strong) NSString *buyVolume;                  //买入数量
@property (nonatomic, strong) NSString *tradeId;
@property (nonatomic, strong) NSString *tradedVolume;
@property (nonatomic, strong) NSString *isPick;


@end

NS_ASSUME_NONNULL_END
