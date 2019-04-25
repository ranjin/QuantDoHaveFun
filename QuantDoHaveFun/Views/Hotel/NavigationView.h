//
//  navigationView.h
//  DelskApp
//
//  Created by Tiger on 2017/7/25.
//  Copyright © 2017年 Delsk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
@protocol NavigationViewDelegate <NSObject>

- (void)NavigationViewWithScrollerButton:(UIButton *)btn;
- (void)NavigationViewGoBack;
- (void)NavigationViewGoShare;
- (void)NavigationViewGoCollect;

@end

@interface NavigationView : UIView
@property (nonatomic, strong) SPButton *addressBtn;
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, weak) id<NavigationViewDelegate> naviDelegate;
@property (nonatomic, strong) UIButton *backBtn;

//向左移动
- (void)navigationAnimation;
//恢复原位
- (void)resetFrame;
//选中恢复
- (void)resetBtns;
@end
