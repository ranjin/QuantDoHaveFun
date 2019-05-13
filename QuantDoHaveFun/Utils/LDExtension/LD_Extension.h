//
//  LD_Extension.h
//  pukka-ios
//
//  Created by lidi on 16/5/3.
//  Copyright © 2016年 Pukka Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LD_Extension : NSObject
+ (NSString*)deviceModel; //获取手机型号
+ (NSString *)getIOSVersion;  //  获取手机系统版本
+(NSString *)getUUID;  // 获取手机UUID，并保存到钥匙串
+(NSString *)getBuildVersion;  // 获取BuildVersion
+(NSString*)getAppVersion;  // 获取app版本号
+(NSString*)getAppName;  // 获取app名字
+(CGSize)getDevicePx; // 获取设备分辨率大小（像素）
+(NSString *)documentPath;
+(NSString *)cachePath;
+(NSString *)supportPath;
+(NSString *)tmpPath;
+(NSString *)homeDirectoryPath;
+ (void)scheduleAlarmForDate:(NSDate*)theDate alert:(NSString*)alertBody;  // 本地推送
+ (long long)getWiFiDataCountersReceived; // 读取网卡信息，获得WiFi下载量
+ (long long)getWiFiDataCountersSend; // 获取WiFi上传量
+ (NSString* )hostResolutionWithAddress:(NSString* )ipaddress; // 域名解析
+ (NSString *)getWifiName;  // 获取当前连接的WiFi名称，需要开启Capabilities -> Access WiFi Infomation
+ (UIImage *)screenShot:(UIView *)view; // 截全屏
+ (UIImage *)longScreenShot:(UIScrollView *)scrollView; // 截长图
+ (NSString*)JsonToString:(id)json; // json转字符串
+(void)callServicePhone:(UIViewController *)showedVC phoneNum:(NSString *)phoneNum; // 调起电话，拨打客服电话
+(void)showMMAlertWithTitle:(NSString *)title message:(NSString *)message;  // 单选项的提示框

/**
归档对象，记得引入NSObject+coding类目，可以归档自定义类型数据。保存到Document目录
 @param object 待归档对象
 @param fileName 保存的文件名，要有唯一性
 */
+(void)archiveObject:(id)object withFileName:(NSString *)fileName;
/**
 反归档取出保存的对象
 @param fileName 保存的文件名
 @return 存的是什么类型，取出时就要转换成什么类型来用
 */
+(id)unArchiveObjectWithFileName:(NSString *)fileName;

/**
 逐级查找打印对象的上一级响应者
 */
+ (void)findResponderChain:(UIResponder *)responder;

@end
