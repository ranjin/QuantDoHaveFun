//
//  WXProgressHUD.h
//  WXIOS
//
//  Created by 🐟猛 on 2018/7/25.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
typedef NS_ENUM(NSInteger, WXHUDPositionStyle) {
    WXHUDPositionTopStyle,
    WXHUDPositionCenterStyle,
    WXHUDPositionBottomStyle
};

@interface WXProgressHUD : NSObject

+ (MBProgressHUD *)createHUD:(UIView *)view;

+ (MBProgressHUD *)shoWHUD:(UIView *)view
                     title:(NSString *)title
               autoDismiss:(BOOL)autoDismiss
                completion:(MBProgressHUDCompletionBlock)completion;

+ (MBProgressHUD *)wx_show:(NSString *)text
                      icon:(NSString *)icon
                      view:(UIView *)view
                completion:(MBProgressHUDCompletionBlock)completion;

+ (void)hideHUDForView:(UIView *)view;

+ (void)showHUD;

+ (void)hideHUD;

+(void)showWithTittle:(NSString*)tittle;

+(MBProgressHUD *)showErrorWithTittle:(NSString*)tittle;

+(MBProgressHUD *)showSuccessWithTittle:(NSString*)tittle;
+(MBProgressHUD *)showInfoWithTittle:(NSString*)tittle;

+(void)toast:(NSString*)tittle;

+(void)toastTop:(NSString*)tittle;

+(void)toastBootom:(NSString*)tittle;

+ (void)showMessage:(NSString *)message
        detailTitle:(NSString *)detailTitle
             toView:(UIView *)view
           position:(WXHUDPositionStyle)position
         completion:(MBProgressHUDCompletionBlock)completion;


@end
