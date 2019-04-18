//
//  QDMemberDTO.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/23.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserMoneyDTO.h"
#import "UserCreditDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDMemberDTO : NSObject

@property (nonatomic, strong) NSString *userId;         //用户ID
@property (nonatomic, strong) NSString *userTypeId;     //用户类型代码

@property (nonatomic, strong) NSString *saleCode;       //承销商代码

@property (nonatomic, strong) NSString *userName;       //注册用户名
@property (nonatomic, strong) NSString *nickname;       //用户昵称
@property (nonatomic, strong) NSString *userPwd;        //登录密码
@property (nonatomic, strong) NSString *confirmUserPwd; //登录密码
@property (nonatomic, strong) NSString *accountId;      //资金账号
@property (nonatomic, assign) NSInteger userState;      //客户状态
@property (nonatomic, assign) NSInteger checkState;     //审核状态

@property (nonatomic, strong) NSString *invitedCode;    //邀请码
@property (nonatomic, strong) NSString *beInvitedCode;  //推荐人邀请码
@property (nonatomic, assign) NSDecimalNumber *registeredCapital;   //注册资本
@property (nonatomic, strong) NSString *faxNum;         //传真号码
@property (nonatomic, strong) NSString *socialNum;      //社会信用代码
@property (nonatomic, strong) NSString *province;       //省市
@property (nonatomic, strong) NSString *district;       //市区
@property (nonatomic, strong) NSString *address;        //详细地址
@property (nonatomic, strong) NSString *legalName;      //法人姓名
@property (nonatomic, strong) NSString *documentId;     //证件类型ID
@property (nonatomic, strong) NSString *legalCertNum;   //法人证件号
@property (nonatomic, strong) NSDate *vaildtyDate;      //法人证件到期日
@property (nonatomic, strong) NSString *legalPhone;     //法人电话号码
@property (nonatomic, strong) NSString *legalEmail;     //法人电子邮箱
@property (nonatomic, strong) NSString *contactName;    //联系人
@property (nonatomic, strong) NSString *contactMobile;  //手机号
@property (nonatomic, strong) NSString *contactEmail;   //邮箱
@property (nonatomic, strong) NSString *creater;        //创建人
@property (nonatomic, strong) NSDate *createTime;       //创建时间
@property (nonatomic, strong) NSDate *updateTime;       //修改时间
@property (nonatomic, strong) NSString *updater;        //修改人
@property (nonatomic, strong) NSString *verificationType;        //校验 0校验手机号用户名 1注册发送短信
@property (nonatomic, assign) NSInteger isFirst;        //是否第一次交易 0否1是
@property (nonatomic, strong) NSString *verificationCode;        //验证码
@property (nonatomic, strong) NSString *isYepay;        //是否开通资金账户
@property (nonatomic, strong) UserMoneyDTO *userMoneyDTO;        //资金信息
@property (nonatomic, strong) UserCreditDTO *userCreditDTO;      //修改人

@property (nonatomic, strong) NSString *userLevel;           //用户等级
@property (nonatomic, strong) NSString *userLevelValue;      //用户等级
@property (nonatomic, strong) NSString *minLevelValue;       //用户等级
@property (nonatomic, strong) NSString *maxLevelValue;       //用户等级
@property (nonatomic, strong) NSString *tradingStatus;       //用户等级

@property (nonatomic, strong) NSString *iconUrl;    //用户头像
@end

NS_ASSUME_NONNULL_END
