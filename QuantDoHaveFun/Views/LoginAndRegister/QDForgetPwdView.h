//
//  QDForgetPwdView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDForgetPwdView : UIView

@property (nonatomic, strong) UILabel *loginLab;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) UIButton *areaBtn;
@property (nonatomic, strong) UITextField *phoneTF;

@property (nonatomic, strong) QDButton *nextStepBtn;
@end

NS_ASSUME_NONNULL_END
