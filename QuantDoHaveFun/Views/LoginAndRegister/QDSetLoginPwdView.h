//
//  QDSetLoginPwdView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDSetLoginPwdView : UIView

@property (nonatomic, strong) UILabel *identifyLab;

@property (nonatomic, strong) UIView *lineViewTop;
@property (nonatomic, strong) UIView *lineViewCenter;
@property (nonatomic, strong) UIView *lineViewBottom;

@property (nonatomic, strong) UITextField *pwdTF;
@property (nonatomic, strong) UITextField *confirmPwdTF;
@property (nonatomic, strong) UITextField *inviteTF;

@property (nonatomic, strong) UIButton *registerBtn;

@end

NS_ASSUME_NONNULL_END
