//
//  QDServiceClient.h
//  QDINFI
//
//  Created by 冉金 on 2017/10/21.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class QDResponseObject;

/**
 网络请求类型

 - kHTTPRequestTypeGET: GET
 - kHTTPRequestTypePOST: POST
 - kHTTPRequestTypePUT: PUT
 - kHTTPRequestTypeDELETE: DELETE
 - kHTTPRequestTypeHEAD: HEAD
 */
typedef NS_ENUM(NSUInteger, HTTPRequestType) {
    kHTTPRequestTypeGET = 0,
    kHTTPRequestTypePOST,
    kHTTPRequestTypePUT,
    kHTTPRequestTypeDELETE,
    kHTTPRequestTypeHEAD
};

//缓存的block
typedef void(^RequestCache)(id jsonCache);
//请求成功的block
typedef void(^RequestSuccess)(QDResponseObject *responseObject);

typedef void(^RequestH5Success)(id responseObject);

//请求失败的block
typedef void(^RequestFailure)(NSError *error);
//上传进度block
typedef void(^UploadProgress)(NSProgress *progress);
//下载进度block
typedef void(^DownloadProgress)(NSProgress *progress);

@interface QDServiceClient : NSObject

/**
 网络请求管理类
 */
@property (nonatomic, strong)AFURLSessionManager *manager;

+ (instancetype)shareClient;

+ (void)startMonitoringNetworking;

/**
 根据url获取完整的urlString

 @param urlString url
 @return urlString
 */
- (NSString *)getFullUrlByUrl:(NSString *)urlString;

- (NSString *)getRequestURLStr:(NSString *)urlStr;
/**
 网络请求
 @param successBlock 成功block
 @param type 网络请求类型
 @param failureBlock 失败block
 */
- (void)requestWithType:(HTTPRequestType)type urlString:(NSString *)urlString params:(id)params successBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock;

/**
 用户登录

 @param userName 用户名
 @param password 密码
 @param userType 用户类型
 @param successBlock 成功block
 @param failureBlock 失败block
 */
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password userType:(NSString *)userType successBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock;

- (NSString *)getVerifyCodeImgUrlString;

/**
 取消所有网络请求
 */
- (void)cancelAllRequest;


/**
 取消指定URL请求
 
 @param requestType 该请求的请求类型
 @param string 该请求的URL
 */
- (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string;

- (void)requestWithServiceName:(NSString *)serviceName functionName:(NSString *)funcName paraments:(NSArray *)paraments successBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock progress:(DownloadProgress)progressBlock;

- (void)requestWithHTMLType:(HTTPRequestType)type urlString:(NSString *)urlString params:(id)params successBlock:(RequestH5Success)successBlock failureBlock:(RequestFailure)failureBlock;
/*
 退出登录
 */
- (void)logoutWitStr:(NSString *)urlStr SuccessBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock;
@end
