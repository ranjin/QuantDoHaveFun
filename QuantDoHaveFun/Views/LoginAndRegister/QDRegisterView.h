//
//  QDRegisterView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/14.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDRegisterView : UIView

//@property (nonatomic, strong) UIButton *cancelBtn;
//@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UILabel *registerLab;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) UIButton *areaBtn;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UIView *userNameLine;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIImageView *imgView; //输入完成

@end

NS_ASSUME_NONNULL_END
