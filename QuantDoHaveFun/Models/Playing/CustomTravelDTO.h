//
//  CustomTravelDTO.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/24.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTravelDTO : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *travelName;         //定制游名称
@property (nonatomic, strong) NSString *travelDesc;         //定制游描述
@property (nonatomic, strong) NSString *topicUrl;           //标题推片地址
@property (nonatomic, strong) NSString *unitCode;           //所属机构代码
@property (nonatomic, assign) NSString *singleCost;         //单人人民币价格
@property (nonatomic, assign) NSDecimalNumber *roomDiff;    //房差(人民币）
@property (nonatomic, assign) NSInteger buyLimit;           //购买上限,0-表示无上限
@property (nonatomic, assign) NSInteger preBuyDays;         //提前预定天数
@property (nonatomic, assign) NSInteger isAllowRefund;      //是否允许退款1是0否
@property (nonatomic, assign) NSInteger refundDays;         //提前退款申请天数
@property (nonatomic, strong) NSString *keyword;            //标签
@property (nonatomic, assign) NSInteger collectCount;       //收藏数
@property (nonatomic, assign) NSInteger isRecommend;        //是否推荐,0-否，1-是，默认为0
@property (nonatomic, assign) NSInteger isSaleable;         //是否上架，0-否，1-是，默认为0
@property (nonatomic, assign) NSInteger creater;            //创建人
@property (nonatomic, strong) NSString *createTime;         //创建时间
@property (nonatomic, strong) NSString *updateTime;         //修改时间
@property (nonatomic, strong) NSString *updater;            //修改人
@property (nonatomic, assign) NSInteger pageNum;            //创建人
@property (nonatomic, assign) NSInteger pageSize;           //创建人
@property (nonatomic, strong) NSMutableArray *imageList;    //图片集合
@property (nonatomic, strong) NSString *creditPirce;        //玩贝价格

@end

NS_ASSUME_NONNULL_END
