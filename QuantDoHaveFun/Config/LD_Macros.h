
/**
颜色
 */
#define LD_colorRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0  blue:((float)((rgbValue & 0xFF)))/255.0  alpha:1.0]
#define LD_colorRGBValueAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0  blue:((float)((rgbValue & 0xFF)))/255.0  alpha:alp]
#define LD_colorRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define LD_RanDomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0f]


/**
 系统对象
 */
#define LD_Application [UIApplication sharedApplication]
#define LD_KeyWindow [UIApplication sharedApplication].keyWindow
#define LD_UserDefaults [NSUserDefaults standardUserDefaults]
#define LD_NotificationCenter [NSNotificationCenter defaultCenter]
#define LD_appVersion [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//  各类常用尺寸
#define LD_SCREENWIDTH [[UIScreen mainScreen]bounds].size.width      //屏宽
#define LD_SCREENHEIGHT [[UIScreen mainScreen]bounds].size.height   //  屏高
#define LD_SCR_Width_Fit [[UIScreen mainScreen]bounds].size.width/375  //以iphone6s为标准设计时可用
#define LD_SCR_Height_Fit [[UIScreen mainScreen]bounds].size.height/667
#define LD_NavigationBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height + 44)  // 导航栏高度

/*
    设备型号判断及尺寸适配
*/
//判断是否是ipad
#define isPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX或Xs（分辨率尺寸完全相同）
#define IS_IPHONE_X_OR_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size)) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)

//留海屏系列 navBar和tabBar的判断
#define IS_NotchScreen (IS_IPHONE_X_OR_Xs==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES)
#define ConstHeight_StatusBar ((IS_IPHONE_X_OR_Xs==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
#define Height_NavAndStatusBar ((IS_IPHONE_X_OR_Xs==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define Height_TabBar ((IS_IPHONE_X_OR_Xs==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)
// 当StatusBar隐藏时，返回0
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;


#define LD_LOCK_semaphore(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#define LD_UNLOCK_semaphore(lock) dispatch_semaphore_signal(lock);


/**
 字体
 */
#define LDFont(x) [UIFont systemFontOfSize:x]
#define LDBoldFont(x) [UIFont boldSystemFontOfSize:x]
#define LDNameFont(name,size) [UIFont fontWithName:name size:size]


/**
 判断空值
 */
#define LD_iSNullString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define LD_iSNullArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0 ||[array isEqual:[NSNull null]])
#define LD_iSNullDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0 || [dic isEqual:[NSNull null]])
#define LD_iSNullObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
#define LD_GetNullDefaultObj(_value,_default) ([_value isKindOfClass:[NSNull class]] || !_value || _value == nil || [_value isEqualToString:@"(null)"] || [_value isEqualToString:@"<null>"] || [_value isEqualToString:@""] || [_value length] == 0)?_default:_value
