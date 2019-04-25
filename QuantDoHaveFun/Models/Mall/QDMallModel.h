//
//  QDMallModel.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDMallModel : NSObject

@property (nonatomic, assign) NSInteger id;                 //代码
@property (nonatomic, copy) NSString *bonusTypeId;
@property (nonatomic, copy) NSString *brandId;              //品牌ID
@property (nonatomic, copy) NSString *buyCount;             //本次购买数量
@property (nonatomic, copy) NSString *catId;                //商品分类ID
@property (nonatomic, copy) NSString *catName;              //商品分类名称
@property (nonatomic, copy) NSString *city;                 //市
@property (nonatomic, copy) NSString *clickCount;           //点击数
@property (nonatomic, copy) NSString *createTime;           //创建时间
@property (nonatomic, copy) NSString *creditCode;           //积分代码
@property (nonatomic, copy) NSString *district;             //区
@property (nonatomic, copy) NSString *extensionCode;        //
@property (nonatomic, copy) NSString *fisrtShippingCost;    //首件邮费
@property (nonatomic, copy) NSString *fixedShippingCost;    //固定邮费
@property (nonatomic, copy) NSString *giveIntegral;         //赠送消费积分
@property (nonatomic, copy) NSString *goodsBrief;           //商品简单描述
@property (nonatomic, copy) NSString *goodsDesc;            //商品详细描述
@property (nonatomic, copy) NSString *goodsImg;             //商品图片地址
@property (nonatomic, copy) NSString *goodsName;            //商品名称
@property (nonatomic, copy) NSString *goodsNameStyle;       //商品名称格式-不需要使用
@property (nonatomic, copy) NSString *goodsNumber;          //商品库存
@property (nonatomic, copy) NSString *goodsSn;              //商品SKU编号
@property (nonatomic, copy) NSString *goodsThumb;           //商品缩略图地址
@property (nonatomic, copy) NSString *goodsTypeId;          //商品类型ID
@property (nonatomic, copy) NSString *goodsWeight;          //商品重量
@property (nonatomic, strong) NSArray *imageList;           //图片列表
@property (nonatomic, copy) NSString *integral;             //使用积分可抵扣金额，填写金额，根据金额积分比前台换算成需要多少积分来抵扣
@property (nonatomic, copy) NSString *isAloneSale;          //是否单独销售，0-否，只能作为配件销售，1-是，可单独销售
@property (nonatomic, copy) NSString *isBest;               //是否精品
@property (nonatomic, copy) NSString *isCheck;              //
@property (nonatomic, copy) NSString *isDelete;             //是否已删除
@property (nonatomic, copy) NSString *isHot;                //是否热销
@property (nonatomic, copy) NSString *isNew;                //是否新品
@property (nonatomic, copy) NSString *isOnSale;             //是否上架销售
@property (nonatomic, copy) NSString *isPromote;            //
@property (nonatomic, copy) NSString *isReal;               //
@property (nonatomic, copy) NSString *isReturn;             //是否支持退货
@property (nonatomic, copy) NSString *isShipping;           //是否免邮,0-否，1-是
@property (nonatomic, copy) NSString *keywords;             //商品关键字
@property (nonatomic, copy) NSString *limitSell;            //单笔订单数量上限,0-表示无上限
@property (nonatomic, copy) NSString *marketCredit;         //对应积分市场价
@property (nonatomic, copy) NSString *marketPrice;          //市场价
@property (nonatomic, copy) NSString *memberLimit;          //
@property (nonatomic, copy) NSString *onemoreShippingCost;  //每增加一件邮费
@property (nonatomic, copy) NSString *originalImg;          //商品原始图片地址
@property (nonatomic, copy) NSString *pageNum;          //商品重量
@property (nonatomic, copy) NSString *pageSize;          //商品重量
@property (nonatomic, copy) NSString *promoteCredit;          //商品重量
@property (nonatomic, copy) NSString *promoteEndDate;          //商品重量
@property (nonatomic, copy) NSString *promotePrice;          //商品重量
@property (nonatomic, copy) NSString *promoteStartDate;          //商品重量
@property (nonatomic, copy) NSString *providerName;          //商品重量
@property (nonatomic, copy) NSString *province;          //商品重量
@property (nonatomic, copy) NSString *rankIntegral;          //商品重量
@property (nonatomic, copy) NSString *returnDays;          //商品重量
@property (nonatomic, copy) NSString *sessionId;          //商品重量
@property (nonatomic, copy) NSString *shopCredit;          //商品重量
@property (nonatomic, copy) NSString *shopId;          //商品重量
@property (nonatomic, copy) NSString *shopPrice;          //商品重量
@property (nonatomic, copy) NSString *sortColumn;          //商品重量
@property (nonatomic, copy) NSString *sortOrder;          //商品重量
@property (nonatomic, copy) NSString *sortType;          //商品重量
@property (nonatomic, copy) NSString *suppliersId;          //商品重量
@property (nonatomic, copy) NSString *updateTime;          //商品重量
@property (nonatomic, copy) NSString *userId;          //商品重量
@property (nonatomic, copy) NSString *virtualSales;          //商品重量
@property (nonatomic, copy) NSString *warnNumber;          //商品重量



@end

NS_ASSUME_NONNULL_END
