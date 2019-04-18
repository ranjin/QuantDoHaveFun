//
//  Macro.h
//  DelskApp
//
//  Created by alex on 2017/6/6.
//  Copyright © 2017年 Delsk. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#import <Foundation/Foundation.h>

//#ifdef DEBUG
#define DebugLog( s, ... ) NSLog( @"<%p %@:%d (%@)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,  NSStringFromSelector(_cmd), [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#define RootUri @"http://192.168.1.64:8104"
//#define RootSeviceUri @"http://192.168.1.64:8081"
//#else
//#define DebugLog( s, ... )
#define RootUri @"http://api.hoolihome.com"
#define RootSeviceUri @"http://m.hoolihome.com"
//#endif

#define AppSecret @"123456" 
#define APPvision @"113"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SCREEN_SCALE ([UIScreen mainScreen].bounds.size.width/320)
#define FIT_WIDTH [UIScreen mainScreen].bounds.size.width/375
#define KSelectBorderColor      [UIColor colorWithRed:253/255.0 green:206/255.0 blue:41/255.0 alpha:1]
#define KUnSelectBorderColor    [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define KButtonColor            [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P_7P_X (IS_IPHONE && SCREEN_MAX_LENGTH >= 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define STATUS_BAR_HEIGHT 20
#define NAV_HEIGHT        44
#define TABBAR_HEIGH      49
#define SYSTEM_VERSION   [[[UIDevice currentDevice] systemVersion] floatValue]
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define dispatch_async_on_main(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }

#define dispatch_async_on_global(block)\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block)

/**
 *  版本
 */
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//字体
#define F20 [UIFont systemFontOfSize:20];
#define F18 [UIFont systemFontOfSize:18];
#define F17 [UIFont systemFontOfSize:17];
#define F16 [UIFont systemFontOfSize:16];
#define F15 [UIFont systemFontOfSize:15];
#define F12 [UIFont systemFontOfSize:12];
#define F11 [UIFont systemFontOfSize:11];
#define F10 [UIFont systemFontOfSize:10];

#define BOLDF17 [UIFont boldSystemFontOfSize:17];
#define BOLDF15 [UIFont boldSystemFontOfSize:15];

#define RGB_COLOR_String(string)  [UIColor colorWithHexString:string]
#define APP_BACKGROUND         RGB_COLOR_String(@"f5f5f5")      //背景
#define APP_LIGHTGRAYCOLOR     RGB_COLOR_String(@"#DDDDDD")     //线条灰色
#define APP_GRAYCOLOR          RGB_COLOR_String(@"#999999")     //灰色
#define APP_GRAYCOLOR_BETTER   RGB_COLOR_String(@"#999999")     //浅灰色
#define APP_GRAYCOLOR_SEARCH   RGB_COLOR_String(@"f5f5f5")      //搜索框灰色
#define APP_BLACKCOLOR         RGB_COLOR_String(@"#2B2C42")     //黑色
#define APP_NORMALBARCOLOR          RGB_COLOR_String(@"#72BB37")//主色调 橙色
#define APP_REDCOLOR           RGB_COLOR_String(@"c0965d")      //红色
#define APP_LINECOLOR          RGB_COLOR_String(@"EFEFEF")      //边框色
#define APP_ORANGECOLOR        RGB_COLOR_String(@"FF8244")      //橘红色
#define APP_WHITECOLOR        [UIColor whiteColor]
#define APP_CLEARCOLOR        [UIColor clearColor]
#define APP_LABELCOLOR        RGB_COLOR_String(@"F75D21")
#define APP_LABELBGCOLOR        RGB_COLOR_String(@"FFE1D5")
#define APP_BLUECOLOR        RGB_COLOR_String(@"#02AAB0")


#define APP_GRAYTEXTCOLOR        RGB_COLOR_String(@"#62656E")   //灰色字体
#define APP_GRAYLINECOLOR        RGB_COLOR_String(@"#A6A6B2")   //灰色线条
#define APP_GRAYBUTTONCOLOR      RGB_COLOR_String(@"#EFEFF4") //按钮灰色背景色
#define APP_GRAYLAYERCOLOR       RGB_COLOR_String(@"#CCCCCC")  //灰色layer
#define APP_GRAYBUTTONTEXTCOLOR       RGB_COLOR_String(@"#666666")  //按钮上的灰色字
#define APP_GRAYBACKGROUNDCOLOR       RGB_COLOR_String(@"#F5F5F7")  //灰色背景
#define APP_ORANGETEXTCOLOR       RGB_COLOR_String(@"#FF643B")  //橘红色字体

#define UIBUTTON_BORDER_COLOR        RGB_COLOR_String(@"BFBFBF") //橘红色

#define UmengAnalysticKey @"596c2a2be88bad1f230005a2"
#define MapboxKey @"pk.eyJ1IjoiZGVsc2siLCJhIjoiY2ozdXlhd2JiMDFiYzJ3cjdwMjlzajBmdiJ9.sI485TWBLThAyI2UfCHraQ"
#define JPushKey @"e296f2eb4b57f5498d326af0"
#define NIMAppKey @"1931a28f68e742bbe61f9e484a566d14"//@"45c6af3c98409b18a84451215d0bdd6e"
#define QYAPPKEY @"43614a80f8154a63300f19b0c60f5c18"
#define QYAPPNAME @"Hooli"
#define archivePath @"searchHistory.archive"
#define pay_by_yee @"http://api.hoolihome.com/index/pay-by-yee?token=%@&r_id=%@"
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

extern NSString *const OnDeviceLanguageChanged;
extern NSString *const OnLoginNotification;
extern NSString *const OnLogoutNotification;

//获取屏幕宽度与高度 大小
#define kScreenWidth    (MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height))
#define kScreenHeight   (MAX([UIScreen mainScreen].bounds.size.width, [[UIScreen mainScreen] bounds].size.height))
//适配比例
#define kAutoSizeScaleX kScreenWidth / 375.0
#define kAutoSizeScaleY kScreenHeight / 667.0
#define adaptX(num) num * kAutoSizeScaleX
#define adaptY(num) num * kAutoSizeScaleY
#pragma mark - 字体相关
//字体Font
#define kFontName(name, float) [UIFont fontWithName:name size:float*kAutoSizeScaleX]
#define kFont(float)    [UIFont systemFontOfSize:float * kAutoSizeScaleX]
#define kWeightFont(float, wei) [UIFont systemFontOfSize:float*kAutoSizeScaleX weight:wei*kAutoSizeScaleX]
#define MAIN_FONT(x)    [MBFontAdapter getMainFont:x]
#define IMPACT_FONT(x)  [UIFont fontWithName:@"IMPACT" size:x]
#define kFontWithFontName(fontName,x) [UIFont fontWithName:fontName size:x * kAutoSizeScaleX]
#define BOLD_FONT(x)    [UIFont boldSystemFontOfSize:x * kAutoSizeScaleX]//粗体
#define BOLD_FONT1(x)   [UIFont boldSystemFontOfSize:x]//粗体
//颜色
#define customColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define customColorwithalpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define UIColorFromRGBFM(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


#endif /* Macro_h */
