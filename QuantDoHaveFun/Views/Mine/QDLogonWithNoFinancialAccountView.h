//
//  QDLogonWithNoFinancialAccountView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/22.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
#import "MQGradientProgressView.h"
#import "QDMemberDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDLogonWithNoFinancialAccountView : UIView

@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) UIButton *voiceBtn;

@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UILabel *userNameLab;
@property (nonatomic, strong) UILabel *userIdLab;
@property (nonatomic, strong) UIImageView *levelPic;
@property (nonatomic, strong) UILabel *levelLab;
@property (nonatomic, strong) UIButton *vipRightsBtn;

@property (nonatomic, strong) UIImageView *financialPic;
@property (nonatomic, strong) UILabel *info1Lab;
@property (nonatomic, strong) UILabel *info2Lab;
@property (nonatomic, strong) UILabel *info3Lab;
@property (nonatomic, strong) MQGradientProgressView *progressView;

@property (nonatomic, strong) UILabel *info4Lab;
@property (nonatomic, strong) UILabel *info5Lab;

@property (nonatomic, strong) UILabel *info6Lab;
@property (nonatomic, strong) UILabel *info7Lab;

@property (nonatomic, strong) UILabel *info8Lab;
@property (nonatomic, strong) UILabel *info9Lab;
@property (nonatomic, strong) UIButton *accountInfo;



@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, strong) UILabel *balance;

@property (nonatomic, strong) UIButton *openFinancialBtn;


- (void)loadViewWithModel:(QDMemberDTO *)member;

@end
NS_ASSUME_NONNULL_END
