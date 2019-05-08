
#define LD_colorRGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0  blue:((float)((rgbValue & 0xFF)))/255.0  alpha:1.0]
#define LD_colorRGBValueAlpha(rgbValue,alp) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000)>>16))/255.0 green:((float)((rgbValue & 0xFF00)>>8))/255.0  blue:((float)((rgbValue & 0xFF)))/255.0  alpha:alp]
#define LD_RanDomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0f]

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

