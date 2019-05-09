//
//  WXApi.h
//  QDINFI
//  API定义文件
//  Created by ZengTark on 2017/10/20.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#ifndef WXApi_h
#define WXApi_h
// 高德地图
//const static NSString *APIKey = @"4d9a3eeccc55429b57663893c21a7813";    //生产环境
//const static NSString *APIKey = @"1572e2947f38693cadbb912c8afc5891";    //UAT环境
const static NSString *APIKey = @"403cc9f385a5fa52382a5772a2249d6f";      //UI改版



//const static NSString *APIKey = @"10ee55741af6f6665e283a8785473ceb";    //videoVersion
const static NSString *APP_ID = @"1456067852";

//const static NSString *APIKey = @"0b39f0a341315a7f3574e309d8d24082";

static NSString * const QD_Domain = @"https://appuat.wedotting.com";    //UAT环境

//static NSString * const QD_Domain = @"https://app.wedotting.com";

//测试环境
//static NSString * const QD_Domain = @"http://203.110.179.27:60409";
//static NSString * const QD_Domain = @"http://112.64.226.138:60409";
//
//static NSString * const QD_Domain = @"http://47.101.222.172:8080";

static NSString * const QD_ProjectName = @"/lyjfapp/sso/";
static NSString * const QD_MarkProjectName = @"/qdMarketJniServer/";

static NSString * const QD_Service = @"service/";
static NSString * const QD_JniService = @"qdMarketJniServer/";

static NSString * const QD_RestfulService = @"restfulservice/";
static NSString * const QD_WS_Service = @"wsPublicMessage";
static NSTimeInterval const QD_Timeout = 30;

/***************** WS Topic **************************/
static NSString * const WS_TOPIC_Quotation = @"public_instrument_"; //行情订阅（后加交易所id_合约id：public_instrument_exchangeID_instrumentID）
static NSString * const WS_TOPIC_Trade = @"public_trade_return_";    //成交回报（接brokerID + investorID）
static NSString * const WS_TOPIC_Order = @"public_order_return_";    //委托回报（接brokerID + investorID）

static NSString * const WS_TOPIC_Order_Action = @"public_order_action_return_";    //撤单响应（接brokerID + investorID）

static NSString * const WS_TOPIC_Order_Insert = @"public_order_insert_return_";    //下单响应（接brokerID + investorID）

static NSString * const WS_TOPIC_Account = @"public_part_account_"; //资金订阅（接userID）

static NSString * const Notification_LoginSucceeded = @"loginSucceeded"; //行情订阅（后加交易所id_合约id：public_instrument_exchangeID_instrumentID）

static NSString * const Notification_PriceUp = @"priceUp";
static NSString * const Notification_PriceDown = @"priceDown";
static NSString * const Notification_AmountUp = @"amountUp";
static NSString * const Notification_AmountDown = @"amountDown";


/***************** API **************************/
static NSString * const api_Login = @"login";            //登录
static NSString * const api_GetVerifyCode = @"captcha?d=";      //获取验证码
static NSString * const api_ListMarketData = @"listMarketDataByInstrumentIdList";//合约列表行情
static NSString * const api_GetMarketDataById = @"getMarketDataByInstrumentId";  //根据合约id获取行情
static NSString * const api_ListInstrument = @"listInstrument"; //查询合约列表
static NSString * const api_FindInstrumentList = @"findInstrumentList";

static NSString * const api_QueryOperTradingAccount = @"queryOperTradingAccount";   //查询个人资金数据
static NSString * const api_QueryBaseInfo = @"queryBaseInfo";   //查询基础枚举数据

/**************** ServiceName *******************/
static NSString *const QD_Service_Trade = @"qdFrontTradeService";
static NSString *const QD_Service_BaseData = @"baseDataService";
//static NSString *const QD_Service_Market = @"qdFrontMarketDataService";
static NSString *const QD_Service_Market = @"marketDataService";
static NSString *const QD_Service_AppGeneral = @"appGeneralService";
static NSString *const QD_Service_AnonymousAppGeneral = @"anonymousAppGeneralService";  //app匿名服务
static NSString *const QD_Service_FileUpload = @"memberFileUploadService";  //文件上传服务
static NSString *const QD_Service_clientApply = @"clientApplyService";  //身份验证
static NSString *const QD_Service_kLineService = @"kLineService";

/**************** NotificationName about WS *******************/
static NSString *const QD_Notification_Quotation = @"QD_Notification_Quotation";
static NSString *const QD_Notification_Trade = @"QD_Notification_Trade";
static NSString *const QD_Notification_Order = @"QD_Notification_Order";
static NSString *const QD_Notification_OrderInsert = @"QD_Notification_OrderInsert";
static NSString *const QD_Notification_OrderAction = @"QD_Notification_OrderAction";


static NSString * const api_UserLogout = @"/lyjfapp/sso/logout";          //登出

//发送短信验证码
static NSString * const api_SendVerificationCode = @"/lyjfapp/api/v1/message/sendVerificationCode";

//校验短信验证码
static NSString * const api_VerificationCode = @"/lyjfapp/api/v1/message/verificationCode";

static NSString * const api_TryToRegister = @"/lyjfapp/api/v1/user/tryToRegister";

//验证用户是否注册
static NSString * const api_VerificationRegister = @"/lyjfapp/api/v1/user/verificationRegister";

//设置密码时候校验手机号是否注册
static NSString * const api_VerificationIsRegister = @"/lyjfapp/api/v1/user/verificationIsRegister";

static NSString * const api_ChangePwd = @"/lyjfapp/api/v1/user/changePwd";



static NSString * const api_GetBasicPrice = @"/lyjfapp/api/v1/common/getBasicPrice";
static NSString * const api_GetUserDetail = @"/lyjfapp/api/v1/user/detail";
static NSString * const api_GetHotelCondition = @"/lyjfapp/api/v1/hotel/findByCondition";
static NSString * const api_GetDZYList = @"/lyjfapp/api/v1/travel/findByCondition"; //定制游列表
static NSString * const api_GetMallList = @"/lyjfapp/api/v1/goods/findOnStockByCondition"; //商城列表

static NSString * const api_FindHotelById = @"/lyjfapp/api/v1/hotel/findHotelById";
static NSString * const api_FindDifferentStrategyDTO = @"/lyjfapp/api/v1/strategy/findDifferentStrategyDTO";     //不同的攻略列表,最新最热酒店定制游

static NSString * const api_RankedSorting = @"/lyjfapp/api/v1/ranklist/findByCondition";   //榜单列表查询
static NSString * const api_FindCanTrade = @"/lyjfapp/api/v1/ctrade/findCanTrade";   //可交易挂单查询
static NSString * const api_FindMyBiddingPosterse = @"/lyjfapp/api/v1/ctrade/findMyBiddingPosters";   //我的挂单查询
static NSString * const api_FindMyOrder = @"/lyjfapp/api/v1/ctrade/findMyOrder";   //我的摘单查询
static NSString * const api_SaveIntentionPosters = @"/lyjfapp/api/v1/ctrade/saveIntentionPosters";   //生成意向单

static NSString * const api_GetRecommendLists = @"/lyjfapp/api/v1/ctrade/getRecommendList";   //智能推荐
static NSString * const api_FindPurchaseInfos = @"/lyjfapp/api/v1/ctrade/findPurchaseInfos";   //积分充值卡查询

static NSString * const api_ReadyToCreateOrder = @"/lyjfapp/api/v1/ctrade/readyToCreateOrder";   //准备申购

static NSString * const api_SaleByProxyApply = @"/lyjfapp/api/v1/ctrade/saleByProxyApply";   //代销申购
static NSString * const api_FindRankTypeToSort = @"/lyjfapp/api/v1/ranklist/findRankTypeToSort";   //榜单类型排序查询
static NSString * const api_FindAllMapDict = @"/lyjfapp/api/v1/common/findAllMapDict";   //数据字典

static NSString * const api_IsLogin = @"/lyjfapp/api/v1/user/isLogin";           //检查用户是否登录
static NSString * const api_CancelOrderForm = @"/lyjfapp/api/v1/ctrade/cancelOrderForm";           //取消订单(摘单)
static NSString * const api_BuyAndSellBiddingPosters = @"/lyjfapp/api/v1/ctrade/buyAndSellBiddingPosters";           //买卖摘单

static NSString * const api_UserOrderDetail = @"/lyjfapp/api/v1/userorder/detail";           //查看订单详情
static NSString * const api_GetBiddingPosterByPosterId = @"/lyjfapp/api/v1/ctrade/getBiddingPosterByPosterId";         //查看挂单详情
static NSString * const api_CancelBiddingPosters = @"/lyjfapp/api/v1/ctrade/cancelBiddingPosters";                     //撤销挂单
static NSString * const api_saveBiddingPosters = @"/lyjfapp/api/v1/ctrade/saveBiddingPosters";                       //挂单申请
static NSString * const api_findCategory       = @"/lyjfapp/api/v1/goods/findCategory";                  //获取商品分类列表
static NSString * const api_findAllMyHouseCoupon  = @"/lyjfapp/api/v1/hotelCoupon/findAllMyHouseCoupon";                  //查询我的房券
static NSString * const api_checkLoginNum       = @"/lyjfapp/api/v1/user/checkLoginNum";                  //用户重复登录次数控制
static NSString * const api_findNoticeByTypeId      = @"/lyjfapp/api/v1/common/findNoticeByTypeId";       //协议查询
static NSString * const api_imageUpload      = @"/consumer/image/upload";       //图片上传
static NSString * const api_otherProtocols   = @"/lyjfapp/api/v1/common/otherProtocols";       //app_玩呗手册、会员协议
static NSString * const api_resturant = @"/lyjfapp/api/v1/restaurant/listRestaurantByConditionForApp";       //获取餐厅列表

static NSString * const api_getIsUpdate  = @"/lyjfapp/api/v1/version/getIsUpdate";       //强制更新
static NSString * const api_changeIcon = @"/lyjfapp/api/v1/user/changeIcon";       //更换头像

static NSString * const api_getVideoList = @"/lyjfapp/api/v1/video/homeImage/list";            //首页这好玩视频封面

static NSString * const api_findAllDestinationList = @"/lyjfapp/api/v1/ranklist/findAllDestinationList";            //榜单目的地列表

static NSString *const api_getCreditOrderList = @"/lyjfapp/api/v1/ctrade/findCreditFlowListByUser";   // 玩贝明细订单
static NSString *const api_findTradingFlowList = @"/lyjfapp/api/v1/ctrade/findTradingFlowListByUser";  // 资金明细
static NSString *const api_getPostersFee = @"/lyjfapp/api/v1/ctrade/getPostersFee";  //获得挂单手续费


/**
 JAVAScriptBridgeWebView
 */

static NSString * const QD_JSURL                = @"https://appuat.wedotting.com/app";    //前端地址
static NSString * const QD_TESTJSURL            = @"https://appuat.wedotting.com/app/#";    //前端地址
////
//static NSString * const QD_JSURL                = @"https://app.wedotting.com/app";    //前端地址
//static NSString * const QD_TESTJSURL            = @"https://app.wedotting.com/app/#";    //前端地址//static NSString * const QD_TESTJSURL            = @"https://192.168.40.10:3000/app/#";    //前端地址

//static NSString * const QD_JSURL                = @"http://203.110.179.27:60409/app";    //前端地址
//static NSString * const QD_TESTJSURL            = @"http://203.110.179.27:60409/app/#";    //前端地址

//static NSString * const QD_JSURL            = @"http://192.168.40.21:3001";    //前端地址
//static NSString * const QD_TESTJSURL            = @"http://192.168.40.21:3001/#";    //前端地址

//static NSString * const QD_JSURL                = @"http://47.101.222.172:8080/app";    //前端地址
//static NSString * const QD_TESTJSURL            = @"http://47.101.222.172:8080/app/#";    //前端地址

static NSString * const JS_HOTELDETAIL          = @"/#/hotel/detail";               //酒店详情
static NSString * const JS_CUSTOMERTRAVEL       = @"/#/coustomSwim/detail";         //定制游详情

static NSString * const JS_ATTRACTIONSDETAIL    = @"/#/attractions/detail";         //景区详情
static NSString * const JS_STRATEGYDETAIL       = @"/#/strategy/detail";            //攻略详情
static NSString * const JS_RESTAURANTDETAIL     = @"/#/restaurant/detail";          //餐厅详情


static NSString * const JS_ORDERS               = @"/#/my/orders/home";                  //全部订单
static NSString * const JS_INTEGRAL             = @"/#/my/integral";                //积分账户
static NSString * const JS_ADDRESS              = @"/#/my/address";                 //地址
static NSString * const JS_SECURITYCENTER       = @"/#/securityCenter/home";        //安全中心
static NSString * const JS_STRATEGY             = @"/#/my/strategy";                //攻略
static NSString * const JS_BANKCARD             = @"/#/my/bankCard";                //我的银行卡
static NSString * const JS_MYHOURSE             = @"/#/my/house";                   //房券
static NSString * const JS_SHOPCART             = @"/#/shopping/shopp-cart";        //购物车
static NSString * const JS_SHOPPING             = @"/#/shopping/details";           //商城
static NSString * const JS_SETTING              = @"/#/my/setting";                 //设置
static NSString * const JS_NOTICE               = @"/#/my/notice";                  //系统消息
static NSString * const JS_COLLECTION           = @"/#/my/collection";              //我的收藏
static NSString * const JS_PAYACTION            = @"/#/pay/orderPay";               //支付
static NSString * const JS_RECHARGE             = @"/pay/recharge";                 //充值
static NSString * const JS_WITHDRAW             = @"/pay/withdraw";                 //提现
static NSString * const JS_OPENACCOUNT          = @"/#/my/openAccount";             //开通资金账户

static NSString * const JS_PREPARETOPAY         = @"/order/pay";                    //预支付
static NSString * const JS_RANKLIST             = @"/list/detail";                  //榜单详情
static NSString * const JS_INVITEFRIENDS        = @"/invitefriends";                  //邀请好友
static NSString * const JS_NOTICETYPE           = @"/common/notice";                  //协议
static NSString * const JS_WBSC                 = @"/wanbei/img";                  //玩贝手册


#endif /* WXApi_h */

