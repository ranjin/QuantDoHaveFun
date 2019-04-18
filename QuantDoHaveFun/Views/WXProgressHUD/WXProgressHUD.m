//
//  WXProgressHUD.m
//  WXIOS
//
//  Created by 🐟猛 on 2018/7/25.
//  Copyright © 2018年 quantdo. All rights reserved.


//hud.mode = MBProgressHUDModeIndeterminate;//菊花，默认值
//hud.mode = MBProgressHUDModeDeterminate; // 圆饼，饼状图
//hud.mode = MBProgressHUDModeDeterminateHorizontalBar; //进度条
// hud.mode = MBProgressHUDModeAnnularDeterminate;  //圆环作为进度条
// hud.mode = MBProgressHUDModeCustomView;      //需要自定义试图时候设置成这个
//hud.mode = MBProgressHUDModeText;    //只显示文本
//
#import "MBProgressHUD.h"
#import "WXProgressHUD.h"

NSTimeInterval const KHideAfterDelayTime = 1.f;
NSTimeInterval const kMinShowTime = 1.f;
static NSString * const loading = @"加载中";




@implementation WXProgressHUD

+ (MBProgressHUD *)createHUD:(UIView *)view {
    if (view == nil){
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    //先 remove 掉以前的
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            [WXProgressHUD hideHUDForView:view];
        }
    }
    
    return [MBProgressHUD showHUDAddedTo:view
                                animated:YES];
}

+(void)loggggg{
    NSLog(@"");
    [self hideHUD];
}

+ (MBProgressHUD *)configHUD:(UIView *)view{
    MBProgressHUD *hud = [self createHUD:view];
    [WXProgressHUD labelConfig:hud.label];
    hud.activityIndicatorColor = [UIColor whiteColor];
    hud.minShowTime = 1.f;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.6f];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideHUD)];
    [hud addGestureRecognizer:tap];
    return hud;
}


+ (MBProgressHUD *)shoWHUD:(UIView *)view
                                  title:(NSString *)title
                            autoDismiss:(BOOL)autoDismiss
                             completion:(MBProgressHUDCompletionBlock)completion {
    MBProgressHUD *hud = [self configHUD:view];
    [WXProgressHUD labelConfig:hud.label];
    hud.label.numberOfLines = 0;
    hud.label.text = title;
    hud.removeFromSuperViewOnHide = YES;
  
    if (autoDismiss) {
        [hud hideAnimated:YES
               afterDelay:KHideAfterDelayTime];
    }
    return hud;
}

+ (MBProgressHUD *)wx_show:(NSString *)text
                      icon:(NSString *)icon
                      view:(UIView *)view
     completion:(MBProgressHUDCompletionBlock)completion {

    
    MBProgressHUD *hud = [WXProgressHUD configHUD:view];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = text;
    hud.contentColor = [UIColor whiteColor];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@",icon]];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.tintColor = [UIColor whiteColor];
    
    [WXProgressHUD labelConfig:hud.label];
    hud.customView = imageView;
    hud.removeFromSuperViewOnHide = YES;
    
    hud.minShowTime = kMinShowTime;
    [hud hideAnimated:YES afterDelay:KHideAfterDelayTime];
    hud.completionBlock = completion;
    return hud;
}

+ (void)hideHUDForView:(UIView *)view {
    if (view == nil){
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    [MBProgressHUD hideHUDForView:view animated:YES];
}


+(void)showHUD{
    [WXProgressHUD showWithTittle:loading];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

+(void)showWithTittle:(NSString*)tittle{
  MBProgressHUD *hud = [WXProgressHUD shoWHUD:nil title:tittle autoDismiss:NO completion:nil];
  hud.mode = MBProgressHUDModeIndeterminate;
}

+(MBProgressHUD *)showErrorWithTittle:(NSString*)tittle{
    return [WXProgressHUD wx_show:tittle icon:@"error" view:nil completion:nil];
};

+(MBProgressHUD *)showSuccessWithTittle:(NSString*)tittle{
    return [WXProgressHUD wx_show:tittle icon:@"success" view:nil completion:nil];
};

+(MBProgressHUD *)showInfoWithTittle:(NSString*)tittle{
    return [WXProgressHUD wx_show:tittle icon:@"info" view:nil completion:nil];
};

+(void)toast:(NSString*)tittle{
    [WXProgressHUD showMessage:tittle detailTitle:@"" toView:nil position:WXHUDPositionCenterStyle completion:nil];
}

+(void)toastTop:(NSString*)tittle{
    [WXProgressHUD showMessage:tittle detailTitle:@"" toView:nil position:WXHUDPositionTopStyle completion:nil];
}

+(void)toastBootom:(NSString*)tittle{
    [WXProgressHUD showMessage:tittle detailTitle:@"" toView:nil position:WXHUDPositionBottomStyle completion:nil];
}



+ (void)showMessage:(NSString *)message
           detailTitle:(NSString *)detailTitle
                toView:(UIView *)view
              position:(WXHUDPositionStyle)position
            completion:(MBProgressHUDCompletionBlock)completion {
    MBProgressHUD *hud = [WXProgressHUD shoWHUD:view title:@"" autoDismiss:YES completion:nil];
    hud.detailsLabel.text = message;
    hud.contentColor = [UIColor whiteColor];
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    
    switch (position) {
        case WXHUDPositionTopStyle:
            hud.offset = CGPointMake(0, 80 - SCREEN_HEIGHT/2 );
            break;
        case WXHUDPositionCenterStyle:
            hud.offset = CGPointZero;
            break;
        case WXHUDPositionBottomStyle:
            hud.offset = CGPointMake(0, MBProgressMaxOffset);
            break;
        default:
            break;
    }
    
    hud.minShowTime = kMinShowTime;
//    [hud hideAnimated:YES afterDelay:KHideAfterDelayTime];
    hud.completionBlock = completion;
}

+ (void)labelConfig:(UILabel *)label{
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.font = QDFont(14);
    label.textAlignment = NSTextAlignmentCenter;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
}

@end
