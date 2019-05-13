//
//  QDServiceClient.m
//  QDINFI
//
//  Created by 冉金 on 2017/10/21.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDServiceClient.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworkActivityIndicatorManager.h"
#import "WXApi.h"
#import "QDResponseObject.h"
#import "QDServiceErrorHandler.h"
#import "QDNetworkCache.h"



//请求成功的block
typedef void(^PrivateRequestSuccess)(NSURLSessionDataTask *task, QDResponseObject *responseObject);
//请求失败的block
typedef void(^PrivateRequestFailure)(NSURLSessionDataTask *task, NSError *error);


@interface QDServiceClient ()


@property (nonatomic, strong)NSMutableArray *tasks;                         //管理请求数组
@end

@implementation QDServiceClient

+ (instancetype)shareClient
{
    static QDServiceClient *serviceClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceClient = [[QDServiceClient alloc] init];
        serviceClient.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        //客户端是否信任非法证书
        serviceClient.manager.securityPolicy.allowInvalidCertificates = NO;
        //是否在证书域字段中验证域名
//        serviceClient.manager.securityPolicy.validatesDomainName = YES;
        
        serviceClient.tasks = [[NSMutableArray alloc] init];
    });
    return serviceClient;
}

+ (void) startMonitoringNetworking
{
    AFNetworkReachabilityManager *statusManager = [AFNetworkReachabilityManager sharedManager];
    [statusManager startMonitoring];
    [statusManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                QDToast(@"网络状态位置错误");
                [QDUserDefaults setObject:@"0" forKey: @"networkStatus"];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                QDToast(@"当前网络不可用"); 
                [QDUserDefaults setObject:@"1" forKey:@"networkStatus"];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
//                QDToast(@"当前网络为3/4G状态");
                //连接上网络 首页开始加载数据
                [QDUserDefaults setObject:@"2" forKey:@"networkStatus"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:nil];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
//                QDToast(@"当前网络环境为WI-FI");
                [QDUserDefaults setObject:@"3" forKey:@"networkStatus"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"123" object:nil];
            }
                break;
            default:
                break;
        }
    }];
}

- (NSString *)getFullUrlByUrl:(NSString *)urlString
{
    return [NSString stringWithFormat:@"%@%@%@", QD_Domain, QD_ProjectName, urlString];
}

- (NSString *)getRequestURLStr:(NSString *)urlStr
{
    return [NSString stringWithFormat:@"%@%@", QD_Domain, urlStr];
}

/**
 用户登录
 
 @param userName 用户名
 @param password 密码
 @param successBlock 成功block
 @param failureBlock 失败block
 */

/**{"password" : "1",
    "userName" : "17321400216",
    "terminal":"ios",
    "userType":"member",
    "os":"383",
    "clientVersion":"1.0.0"
 */
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password userType:(NSString *)userType successBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:userName forKey:@"userName"];
    [params setValue:password forKey:@"password"];
    [params setValue:userType forKey:@"userType"];
    [params setValue:@"ios" forKey:@"terminal"];
    [params setValue:@"383" forKey:@"os"];
    [params setValue:@"1.0.0" forKey:@"clientVersion"];
    
    //移除cookie
    [QDUserDefaults removeCookies];
    
    NSData *dataFromDict = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *logonUrl = [self getFullUrlByUrl:api_Login];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:logonUrl parameters:nil error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:dataFromDict];
    request.timeoutInterval = 30;
    __block NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock ? failureBlock(responseObject):nil;
        }else{
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSString *cookie = response.allHeaderFields[@"Set-Cookie"];
            QDLog(@"登录返回结果Cookie = %@",cookie);
            if (cookie) {
                [QDUserDefaults setCookies:cookie];
            }
            QDResponseObject *responseObj = [QDResponseObject yy_modelWithDictionary:responseObject];
            successBlock ? successBlock(responseObj):nil;
        }
    }];
    [task resume];
}


- (NSString *)getVerifyCodeImgUrlString
{
    NSDate *date = [NSDate date];
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    NSLog(@"url:%@", [self getFullUrlByUrl:[NSString stringWithFormat:@"%@%f", api_GetVerifyCode, timeStamp]]);
    return [self getFullUrlByUrl:[NSString stringWithFormat:@"%@%f", api_GetVerifyCode, timeStamp]];
}

/**
 取消所有网络请求
 */
- (void)cancelAllRequest
{
    [self.manager.operationQueue cancelAllOperations];
}


/**
 取消指定URL请求
 
 @param requestType 该请求的请求类型
 @param string 该请求的URL
 */
- (void)cancelHttpRequestWithRequestType:(NSString *)requestType requestUrlString:(NSString *)string
{
    
}


#pragma mark - private method
- (void)requestWithType:(HTTPRequestType)type urlString:(NSString *)urlString params:(id)params successBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock
{
    NSDictionary *insetParams;
    NSString *requestTypeStr;
    NSData *jsonData;
    NSData *dataFromDict;
    if (params != nil) {
        NSError *error;
        jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            insetParams = @{@"params":@[]};
        }
        else {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            insetParams = @{@"params":jsonString};
        }
        dataFromDict = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    }
    else {
        
//        insetParams = @{@"params":@[]};
    }
    NSString *requestUrl = [self getRequestURLStr:urlString];
    switch (type) {
        case kHTTPRequestTypeGET:
            requestTypeStr = @"GET";
            break;
        case kHTTPRequestTypePOST:
            requestTypeStr = @"POST";
            break;
        default:
            break;
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestTypeStr URLString:requestUrl parameters:insetParams error:nil];
    //把cookie取出来
    NSString *cookie = [NSString stringWithFormat:@"%@", [QDUserDefaults getCookies]];
    if (cookie && ![cookie isEqualToString:@"(null)"] && ![cookie isEqualToString:@""]) {
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (insetParams != nil) {
        [request setHTTPBody:dataFromDict];
    }
    __block NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock ? failureBlock(responseObject):nil;
        }else{
            QDResponseObject *responseObj = [QDResponseObject yy_modelWithDictionary:responseObject];
            successBlock ? successBlock(responseObj):nil;
        }
    }];
    [task resume];
}

#pragma mark - 针对H5的
- (void)requestWithHTMLType:(HTTPRequestType)type urlString:(NSString *)urlString params:(id)params successBlock:(RequestH5Success)successBlock failureBlock:(RequestFailure)failureBlock
{
    NSDictionary *insetParams;
    NSString *requestTypeStr;
    NSData *jsonData;
    NSData *dataFromDict;
    if (params != nil) {
        NSError *error;
        jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            insetParams = @{@"params":@[]};
        }
        else {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            insetParams = @{@"params":jsonString};
        }
        dataFromDict = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    }
    else {
        
            insetParams = @{@"params":@[]};
    }
//    NSString *requestUrl = [self getRequestURLStr:urlString];
    NSString *requestUrl = urlString;

    switch (type) {
        case kHTTPRequestTypeGET:
            requestTypeStr = @"GET";
            break;
        case kHTTPRequestTypePOST:
            requestTypeStr = @"POST";
            break;
        default:
            break;
    }
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:requestTypeStr URLString:requestUrl parameters:insetParams error:nil];
    //把cookie取出来
    NSString *cookie = [NSString stringWithFormat:@"%@", [QDUserDefaults getCookies]];
    if (cookie && ![cookie isEqualToString:@"(null)"] && ![cookie isEqualToString:@""]) {
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (insetParams != nil) {
        [request setHTTPBody:dataFromDict];
    }
    __block NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock ? failureBlock(responseObject):nil;
        }else{
            successBlock ? successBlock(responseObject):nil;
        }
    }];
    [task resume];
}
- (NSString *)getUploadUrlWithServiceName:(NSString *)serviceName functionName:(NSString *)funcName type:(NSString *)type
{
    NSString *urlString;
    if (type && ![type isEqualToString:@""]) {
        urlString = [self getFullUrlByUrl:[NSString stringWithFormat:@"upload/%@/%@?params=[%%22%@%%22,null]", serviceName, funcName, type]];
    }
    else {
        urlString = [self getFullUrlByUrl:[NSString stringWithFormat:@"upload/%@/%@", serviceName, funcName]];
    }
    return urlString;
}

- (NSString *)getMD5String:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (void)logoutWitStr:(NSString *)urlStr SuccessBlock:(RequestSuccess)successBlock failureBlock:(RequestFailure)failureBlock
{
    NSError *error;
    urlStr = [self getRequestURLStr:api_UserLogout];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlStr parameters:nil error:&error];
    //把cookie取出来
    NSString *cookie = [NSString stringWithFormat:@"%@", [QDUserDefaults getCookies]];
    if (cookie && ![cookie isEqualToString:@"(null)"] && ![cookie isEqualToString:@""]) {
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    __block NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failureBlock ? failureBlock(responseObject):nil;
        }else{
            QDResponseObject *responseObj = [QDResponseObject yy_modelWithDictionary:responseObject];
            successBlock ? successBlock(responseObj):nil;
        }
    }];
    [task resume];
}
@end
