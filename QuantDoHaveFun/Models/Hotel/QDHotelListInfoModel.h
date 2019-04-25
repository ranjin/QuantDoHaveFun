//
//  QDHotelListInfoModel.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/23.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QDBankaccountDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelListInfoModel : NSObject

@property (nonatomic, assign) NSInteger id;              //酒店代码
@property (nonatomic, strong) NSString *hotelCode;              //酒店代码
@property (nonatomic, strong) NSString *hotelName;              //酒店名称
@property (nonatomic, assign) NSInteger unitId;                 //机构ID
@property (nonatomic, assign) NSInteger hotelLevel;             //酒店星级
@property (nonatomic, assign) NSInteger hotelTypeId;            //酒店类别
@property (nonatomic, assign) NSInteger openYear;               //开业年份
@property (nonatomic, assign) NSInteger totalFloor;             //总楼层
@property (nonatomic, assign) NSInteger totalRoom;              //总房间数

@property (nonatomic, strong) NSString *collectCount;           //收藏数
//

@property (nonatomic, strong) NSString *province;               //省
@property (nonatomic, strong) NSString *city;                   //市
@property (nonatomic, strong) NSString *district;               //区
@property (nonatomic, strong) NSString *address;                //详细地址
@property (nonatomic, strong) NSString *telphone;               //联系电话
@property (nonatomic, strong) NSString *manager;                //酒店账号
@property (nonatomic, strong) NSString *label;                  //标签
@property (nonatomic, strong) NSString *hotelDesc;              //酒店描述
@property (nonatomic, assign) NSInteger isSelfOperate;          //是否自营酒店, 0-否，1-是，默认为0

@property (nonatomic, assign) NSInteger isRecommend;            //是否推荐酒店, 0-否，1-是，默认为0
@property (nonatomic, assign) NSInteger isSaleable;             //是否上架，0-下架，1-营业中，默认为0
@property (nonatomic, strong) NSString *creater;                //创建人
@property (nonatomic, strong) NSDate *createTime;               //创建时间

@property (nonatomic, strong) NSDate *updateTime;               //修改时间

@property (nonatomic, strong) NSString *updater;                //修改人
@property (nonatomic, strong) QDBankaccountDTO *bankaccount;    //银行信息
@property (nonatomic, strong) NSArray *hotelFacilityList;       //酒店设施
@property (nonatomic, strong) NSArray *roomTypeList;            //房型列表
@property (nonatomic, assign) NSInteger isReBack;               //是否满返

@property (nonatomic, strong) NSArray *imageList;               //图片集合

@property (nonatomic, assign) NSDecimalNumber *maxPrice;        //最大价格
@property (nonatomic, assign) NSDecimalNumber *minPrice;        //最大价格
@property (nonatomic, strong) NSString *price;                  //酒店积分
@property (nonatomic, strong) NSString *rmbprice;               //酒店展示价格

@property (nonatomic, assign) NSDecimalNumber *registeredCapital;   //注册资本


//分页
@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, assign) NSInteger pageSize;

@end

NS_ASSUME_NONNULL_END
