//
//  LD_Extension.m
//  pukka-ios
//
//  Created by lidi on 16/5/3.
//  Copyright © 2016年 Pukka Inc. All rights reserved.
//

#import "LD_Extension.h"
//  获取设备型号需要
#import <sys/utsname.h>
// 获取ip地址需要
#import <ifaddrs.h>
#import <arpa/inet.h>
// 获取wifi ssid需要
#import <SystemConfiguration/CaptiveNetwork.h>

#include <sys/socket.h>
#include <net/if.h>
// 解析域名需要
#include <netdb.h>

#import <objc/runtime.h>
#import "NSObject+coding.h"
//#import <MMAlertView.h>

#define KC_UUID_Key @"KCUUIDKeyHCTX"

@implementation LD_Extension
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString*)deviceModel
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"]||[deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone7";
    if ([deviceString isEqualToString:@"iPhone9,2"]||[deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([deviceString isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([deviceString isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([deviceString isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";

    //iPod
    
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([deviceString isEqualToString:@"iPod7,1"]) return @"iPod Touch 6G";
    
    //iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad2 (32nm)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad4 (CDMA)";
    
    // iPad air
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad6,11"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad6,12"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    
    // iPad pro
    if ([deviceString isEqualToString:@"iPad7,1"])      return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad7,2"])      return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad7,3"])      return @"iPad Pro (10.5 inch)";
    if ([deviceString isEqualToString:@"iPad7,4"])      return @"iPad Pro (10.5 inch)";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9 inch)";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7 inch)";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7 inch)";
    // iPad mini
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad mini 4";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad mini 4";
    // Simulator
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]||[deviceString isEqualToString:@"iPad4,5"]||[deviceString isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
     if ([deviceString isEqualToString:@"iPad4,7"]||[deviceString isEqualToString:@"iPad4,8"]||[deviceString isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    return deviceString;
}
+ (NSString *)getIOSVersion
{
    return [[UIDevice currentDevice] systemVersion];
}
+(NSString *)getAppName{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}
+(NSString *)getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
+(NSString *)getBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[LD_Extension keyChainLoad:KC_UUID_Key];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [LD_Extension save:KC_UUID_Key data:strUUID];
        
    }
    return strUUID;
}

+(NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+(void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+(id)keyChainLoad:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+(NSString *)documentPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
+(NSString *)cachePath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}
+(NSString *)supportPath{
    return NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory,   NSUserDomainMask, YES).firstObject;
}
+(NSString *)tmpPath{
    return NSTemporaryDirectory();
}
+(NSString *)homeDirectoryPath{
    return NSHomeDirectory();
}
+ (BOOL)validateNumberByRegExp:(NSString *)string {
    BOOL isValid = YES;
    NSUInteger len = string.length;
    if (len > 0) {
        NSString *numberRegex = @"^[0-9]*$";
        NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
        isValid = [numberPredicate evaluateWithObject:string];
    }
    return isValid;
}

+(NSString *)randomString32MixNumber{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 65;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    return responseJSON;
}
+(NSString *)removeUnescapedControlCharacter:(NSString *)inputStr
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];//获取那些特殊字符
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];//寻找字符串中有没有这些特殊字符
    if (range.location != NSNotFound)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound)
        {
            [mutable deleteCharactersInRange:range];//去掉这些特殊字符
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
}
//单个文件的大小
+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
+ (NSString *)mimeWithString:(NSString *)string
{
    // 先从参入的路径的出URL
    NSURL *url = [NSURL fileURLWithPath:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 只有响应头中才有其真实属性 也就是MIME
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    return response.MIMEType;
}


+ (void)scheduleAlarmForDate:(NSDate*)theDate alert:(NSString *)alertBody
{
    UIApplication* app = [UIApplication sharedApplication];
    NSArray*    oldNotifications = [app scheduledLocalNotifications];
    
    // Clear out the old notification before scheduling a new one.
    if ([oldNotifications count] > 0)
        [app cancelAllLocalNotifications];
    
    // Create a new notification.
    UILocalNotification* alarm = [[UILocalNotification alloc] init];
    if (alarm)
    {
        alarm.fireDate = theDate;
        alarm.timeZone = [NSTimeZone defaultTimeZone];
        alarm.repeatInterval = 0;
//        alarm.soundName = @"unbelievable.caf";
        alarm.alertBody = alertBody;
        
        [app scheduleLocalNotification:alarm];
    }
}

+ (long long)getWiFiDataCountersReceived
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
//    long long WiFiSent = 0;
    long long WiFiReceived = 0;
//    long long WWANSent = 0;
//    long long WWANReceived = 0;
    
    NSString *name=[[NSString alloc]init];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
//            NSLog(@"ifa_name %s == %@n", cursor->ifa_name,name);
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
//                    WiFiSent+=networkStatisc->ifi_obytes;
                    WiFiReceived+=networkStatisc->ifi_ibytes;
                    // NSLog(@"WiFiSent %d ==%d",WiFiSent,networkStatisc->ifi_obytes);
                    //NSLog(@"WiFiReceived %d ==%d",WiFiReceived,networkStatisc->ifi_ibytes);
                }
//                
//                if ([name hasPrefix:@"pdp_ip"])
//                {
//                    networkStatisc = (const struct if_data *) cursor->ifa_data;
//                    WWANSent+=networkStatisc->ifi_obytes;
//                    WWANReceived+=networkStatisc->ifi_ibytes;
//                    // NSLog(@"WWANSent %d ==%d",WWANSent,networkStatisc->ifi_obytes);
//                    //NSLog(@"WWANReceived %d ==%d",WWANReceived,networkStatisc->ifi_ibytes);
//                    
//                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
//    NSLog(@"\nwifiSend:%.2f MB\nwifiReceived:%.2f MB\n wwansend:%.2f MB\n wwanreceived:%.2f MB\n",WiFiSent/1024.0/1024.0,WiFiReceived/1024.0/1024.0,WWANSent/1024.0/1024.0,WWANReceived/1024.0/1024.0);
//    return [NSArray arrayWithObjects:[NSNumber numberWithInt:WiFiSent], [NSNumber numberWithInt:WiFiReceived],[NSNumber numberWithInt:WWANSent],[NSNumber numberWithInt:WWANReceived], nil];
    return llabs(WiFiReceived);
}
+ (long long)getWiFiDataCountersSend
{
    BOOL   success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    const struct if_data *networkStatisc;
    
    long long WiFiSent = 0;
    
    NSString *name=[[NSString alloc]init];
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            
            name=[NSString stringWithFormat:@"%s",cursor->ifa_name];
            // names of interfaces: en0 is WiFi ,pdp_ip0 is WWAN
            
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                if ([name hasPrefix:@"en"])
                {
                    networkStatisc = (const struct if_data *) cursor->ifa_data;
                    WiFiSent+=networkStatisc->ifi_obytes;
                }
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return llabs(WiFiSent);
}

+(CGSize)getDevicePx{
    //1 Available in iOS 4.0 and later
    UIScreen *MainScreen = [UIScreen mainScreen];
    CGSize Size = [MainScreen bounds].size;
    CGFloat scale = [MainScreen scale];
    CGFloat screenWidth = Size.width * scale;
    CGFloat screenHeight = Size.height * scale;
    NSLog(@"wid = %f   height = %f",screenWidth,screenHeight);
    return CGSizeMake(screenWidth, screenHeight);
}

+ (NSString* )hostResolutionWithAddress:(NSString* )ipaddress{
    Boolean     resolved;
    NSArray *   addresses;
    NSString* IPAddress;
    // Find the first appropriate address.
    
    addresses = (__bridge NSArray *) CFHostGetAddressing((__bridge CFHostRef _Nonnull)(ipaddress), &resolved);
    NSLog(@"%@",addresses);
    if ( resolved && (addresses != nil) ) {
        resolved = false;
        for (NSData * address in addresses) {
            const struct sockaddr * addrPtr;
            
            addrPtr = (const struct sockaddr *) address.bytes;
            if ( address.length >= sizeof(struct sockaddr) ) {
                char *s = NULL;
                switch (addrPtr->sa_family) {
                    case AF_INET: {
                        struct sockaddr_in *addr_in = (struct sockaddr_in *)addrPtr;
                        s = malloc(INET_ADDRSTRLEN);
                        inet_ntop(AF_INET, &(addr_in->sin_addr), s, INET_ADDRSTRLEN);
                        IPAddress = [NSString stringWithFormat:@"%s", s];
                        NSLog(@"%@",IPAddress);
                    } break;
                    case AF_INET6: {
                        struct sockaddr_in6 *addr_in6 = (struct sockaddr_in6 *)addrPtr;
                        s = malloc(INET6_ADDRSTRLEN);
                        inet_ntop(AF_INET6, &(addr_in6->sin6_addr), s, INET6_ADDRSTRLEN);
                        IPAddress = [NSString stringWithFormat:@"%s", s];
                        NSLog(@"%@",IPAddress);
                        
                    } break;
                }
            }
            if (resolved) {
                break;
            }
        }
    }
    return IPAddress;
}
/* 获取当前连接wifi的SSID
 在iOS12以后m，需要在Xcode开启 capability-> Access WiFi Information 
 */
+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            //            bssid = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
}



/**
 *截图功能
 */
+(UIImage *)screenShot:(UIView *)view{
    UIView *ssView;
    CGFloat reduceHeight = 0.0f;
    if (view) {
        ssView = view;
    }else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        ssView = window;
        reduceHeight = 20.0f;
    }

    CGRect rect = CGRectMake(ssView.bounds.origin.x, ssView.bounds.origin.y-reduceHeight, ssView.bounds.size.width, ssView.bounds.size.height-reduceHeight);
    UIGraphicsBeginImageContextWithOptions(ssView.bounds.size, NO, 0.0);
//    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    [ssView drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
    
//    //以下为图片保存代码
//    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
//    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pictureName= @"screenShow.png";
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
//    CGImageRelease(imageRefRect);
//    //从手机本地加载图片
//    UIImage *bgImage2 = [[UIImage alloc]initWithContentsOfFile:savedImagePath];
//    return sendImage;
}
/**
 *UIScrollView截屏（一屏无法显示完整）
 */
+ (UIImage *)longScreenShot:(UIScrollView *)scrollView{
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        NSLog(@"截图成功!");
        return image;
    }
    return nil;
}

+ (NSString*)JsonToString:(id)json{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    do {
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    } while ([jsonString containsString:@" "]);
    return jsonString;
}


+(void)callServicePhone:(UIViewController *)showedVC phoneNum:(NSString *)phoneNum{
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]] options:@{} completionHandler:^(BOOL success) {
            NSLog(@"callPhone: %d",success); // 能弹出提示框就是YES，如果没有程序能处理URL，才会返回NO。
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:phoneNum message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 这种方法在低版本不会弹出提示框，在高版本会弹出，导致出现两次弹窗。
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]]];
            });
        }]];
        [showedVC presentViewController:alert animated:YES completion:nil];
    }
}

//+(void)showMMAlertWithTitle:(NSString *)title message:(NSString *)message{
//    NSArray *items =
//    @[MMItemMake(@"确定", MMItemTypeNormal, nil)
//      ];
//    MMAlertView *alert = [[MMAlertView alloc] initWithTitle:title
//                                           detail:message
//                                            items:items];
//    [alert show];
//}


+(void)archiveObject:(id)object withFileName:(NSString *)fileName{
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
    BOOL sucess = [NSKeyedArchiver archiveRootObject:object toFile:filePath];
    if (sucess) {
        NSLog(@"保存%@成功",fileName);
    }
}
+(id)unArchiveObjectWithFileName:(NSString *)fileName{
    NSString *filePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"unArchiveObject：%@",object);
    return object;
}

+ (void)findResponderChain:(UIResponder *)responder {
    static NSString *log = @"\n--------------------------- ResponderChain ----------------------------\n\n";
    if (responder.nextResponder) {
        log = [log stringByAppendingString:[NSString stringWithFormat:@"%@\n↓\n",responder]];
        [self findResponderChain:responder.nextResponder];
    }else{
        log = [log stringByAppendingString:[NSString stringWithFormat:@"%@\n\n--------------------------- ResponderChain ----------------------------",responder]];
        NSLog(@"%@",log);
        log = @"\n--------------------------- ResponderChain ----------------------------\n\n";
    }
}
@end

