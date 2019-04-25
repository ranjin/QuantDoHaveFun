//
//  QDLoginView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDLoginView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *hiLab;
@property (nonatomic, strong) UILabel *infoLab;

@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) UIButton *areaBtn;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UIView *userNameLine;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UIButton *forgetPWD;
@property (nonatomic, strong) UIButton *gotologinBtn;

@end

NS_ASSUME_NONNULL_END
