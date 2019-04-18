//
//  QDMineHeaderNotLoginView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDLogonWithNoFinancialAccountView.h"

@implementation QDLogonWithNoFinancialAccountView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _settingBtn = [[UIButton alloc] init];
        [_settingBtn setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        [self addSubview:_settingBtn];
        
//        _voiceBtn = [[UIButton alloc] init];
//        [_voiceBtn setImage:[UIImage imageNamed:@"icon_info"] forState:UIControlStateNormal];
//        [self addSubview:_voiceBtn];
//        
        _picView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.06, SCREEN_HEIGHT*0.1, SCREEN_WIDTH*0.12, SCREEN_WIDTH*0.12)];
        _picView.layer.cornerRadius = SCREEN_WIDTH*0.06;
        _picView.layer.masksToBounds = YES;
        _picView.userInteractionEnabled = YES;
        [_picView setImage:[UIImage imageNamed:@"icon_headerPic"]];
        [self addSubview:_picView];
        
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.text = @"加载中";
        _userNameLab.textColor = APP_BLACKCOLOR;
        _userNameLab.font = QDFont(17);
        [self addSubview:_userNameLab];
        
        _userIdLab = [[UILabel alloc] init];
        _userIdLab.text = @"--";
        _userIdLab.textColor = APP_GRAYLINECOLOR;
        _userIdLab.font = QDFont(14);
        [self addSubview:_userIdLab];
        
        _levelPic = [[UIImageView alloc] init];
        [_levelPic setImage:[UIImage imageNamed:@"icon_crown"]];
        [self addSubview:_levelPic];
        
        _levelLab = [[UILabel alloc] init];
        _levelLab.text = @"Lv2";
        _levelLab.textColor = APP_WHITECOLOR;
        _levelLab.font = QDFont(12);
        [_levelPic addSubview:_levelLab];
        
        _vipRightsBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        _vipRightsBtn.frame = CGRectMake(0, 0, 109, 30);
        [_vipRightsBtn setTitle:@"会员权益 >" forState:UIControlStateNormal];
        [_vipRightsBtn setImage:[UIImage imageNamed:@"icon_rights"] forState:UIControlStateNormal];
        [_vipRightsBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        _vipRightsBtn.titleLabel.font = QDFont(12);
        _vipRightsBtn.backgroundColor = APP_GRAYBUTTONCOLOR;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_vipRightsBtn.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(SCREEN_HEIGHT*0.025, SCREEN_HEIGHT*0.025)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _vipRightsBtn.bounds;
        maskLayer.path = maskPath.CGPath;
        _vipRightsBtn.layer.mask = maskLayer;
        [self addSubview:_vipRightsBtn];
        
        _financialPic = [[UIImageView alloc] init];
        [_financialPic setImage:[UIImage imageNamed:@"vipLevel"]];
        [self addSubview:_financialPic];
        
        _info1Lab = [[UILabel alloc] init];
        _info1Lab.text = @"升级还需";
        _info1Lab.textColor = APP_GRAYLINECOLOR;
        _info1Lab.font = QDFont(13);
        [_financialPic addSubview:_info1Lab];

        _info2Lab = [[UILabel alloc] init];
        _info2Lab.textColor = APP_BLUECOLOR;
        _info2Lab.font = QDFont(13);
        [_financialPic addSubview:_info2Lab];

        _info3Lab = [[UILabel alloc] init];
        _info3Lab.text = @"成长值";
        _info3Lab.textColor = APP_GRAYLINECOLOR;
        _info3Lab.font = QDFont(13);
        [_financialPic addSubview:_info3Lab];
        
        _progressView = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, 238, 4)];
        [self addSubview:_progressView];

        _info4Lab = [[UILabel alloc] init];
        _info4Lab.textColor = APP_BLACKCOLOR;
        _info4Lab.font = QDFont(12);
        [_financialPic addSubview:_info4Lab];
        
        _info5Lab = [[UILabel alloc] init];
        _info5Lab.textColor = APP_GRAYTEXTCOLOR;
        _info5Lab.font = QDFont(11);
        [_financialPic addSubview:_info5Lab];
        
        _info6Lab = [[UILabel alloc] init];
        _info6Lab.textColor = APP_BLACKCOLOR;
        _info6Lab.font = QDFont(12);
        [_financialPic addSubview:_info6Lab];
        
        _info7Lab = [[UILabel alloc] init];
        _info7Lab.textColor = APP_GRAYTEXTCOLOR;
        _info7Lab.font = QDFont(11);
        [_financialPic addSubview:_info7Lab];
        
        _info8Lab = [[UILabel alloc] init];
        _info8Lab.text = @"我的玩贝(个)";
        _info8Lab.textColor = APP_GRAYTEXTCOLOR;
        _info8Lab.font = QDFont(13);
        [_financialPic addSubview:_info8Lab];

        
        _info9Lab = [[UILabel alloc] init];
        _info9Lab.textColor = APP_BLACKCOLOR;
        _info9Lab.font = QDBoldFont(18);
        [_financialPic addSubview:_info9Lab];
        
        _accountInfo = [[UIButton alloc] init];
        [_accountInfo setTitle:@"查看账户" forState:UIControlStateNormal];
        _accountInfo.titleLabel.font = QDFont(14);
        [_accountInfo setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        [self addSubview:_accountInfo];
        
        _balanceLab = [[UILabel alloc] init];
        _balanceLab.text = @"我的余额(元)";
        _balanceLab.textColor = APP_GRAYLINECOLOR;
        _balanceLab.font = QDFont(13);
        [self addSubview:_balanceLab];
        
        _balance = [[UILabel alloc] init];
        _balance.text = @"--";
        _balance.textColor = APP_BLACKCOLOR;
        _balance.font = QDFont(17);
        [self addSubview:_balance];

        _openFinancialBtn = [[UIButton alloc] init];
        [_openFinancialBtn setTitle:@"开通资金账户" forState:UIControlStateNormal];
        [_openFinancialBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 140, 36);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        gradientLayer.cornerRadius = 5;
        gradientLayer.masksToBounds = YES;
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
        [_openFinancialBtn.layer addSublayer:gradientLayer];
        _openFinancialBtn.titleLabel.font = QDFont(15);
        [self addSubview:_openFinancialBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SafeAreaTopHeight-33);
        make.right.equalTo(self.mas_right).offset(-63);
        make.width.and.height.mas_equalTo(24);
    }];
//    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.settingBtn);
//        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
//    }];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_settingBtn.mas_bottom).offset(9);
        make.left.equalTo(self.mas_left).offset(78);
    }];
    
    [_userIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userNameLab.mas_bottom);
        make.left.equalTo(_userNameLab);
    }];
    
   
    [_levelPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_userIdLab);
        make.top.equalTo(_userIdLab.mas_bottom);
    }];
    
    [_levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_levelPic.mas_right).offset(-10);
        make.centerY.equalTo(_levelPic);
    }];
    
    [_vipRightsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_settingBtn.mas_bottom).offset(22);
        make.right.equalTo(self);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(30);
    }];
    
    [_financialPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.18);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(359);
        make.height.mas_equalTo(202);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info1Lab);
        make.top.equalTo(_info1Lab.mas_bottom).offset(7);
    }];
    
    [_info1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_financialPic.mas_left).offset(SCREEN_WIDTH*0.06);
        make.top.equalTo(_financialPic.mas_top).offset(SCREEN_HEIGHT*0.06);

    }];

    [_info2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info1Lab);
        make.left.equalTo(_info1Lab.mas_right);
    }];

    [_info3Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info2Lab);
        make.left.equalTo(_info2Lab.mas_right);
    }];

    
    [_info4Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_financialPic.mas_top).offset(SCREEN_HEIGHT*0.12);
        make.left.equalTo(_info1Lab);
    }];

    [_info5Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info4Lab);
        make.left.equalTo(_info4Lab.mas_right);
    }];

    [_info6Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info4Lab);
        make.left.equalTo(_financialPic.mas_left).offset(SCREEN_WIDTH*0.54);
    }];

    [_info7Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info6Lab);
        make.left.equalTo(_info6Lab.mas_right);
    }];

    [_info8Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info1Lab);
        make.top.equalTo(self.info4Lab.mas_bottom).offset(21);
    }];
    
    [_info9Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_info8Lab);
        make.top.equalTo(_info8Lab.mas_bottom).offset(8);
    }];

    [_accountInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info9Lab);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.34);
    }];
    
    [_balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.08);
        make.top.equalTo(_info8Lab.mas_bottom).offset(76);
    }];
    
    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_balanceLab);
        make.top.equalTo(_balanceLab.mas_bottom).offset(SCREEN_HEIGHT*0.007);
    }];
    
    [_openFinancialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.balanceLab.mas_top).offset(8);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(36);
        make.width.mas_equalTo(140);
    }];
}

- (void)loadViewWithModel:(QDMemberDTO *)member{
    UserMoneyDTO *moneyDTO = member.userMoneyDTO;
    UserCreditDTO *creditDTO = member.userCreditDTO;
    NSString *userLevel = [NSString stringWithFormat:@"Lv%@", member.userLevel];
    //当前经验值 两个等级
    NSString *currentLevel = [NSString stringWithFormat:@"Lv%@", member.userLevel];
    NSString *currentLevelValue = member.userLevelValue;
    NSString *nextLevel = [NSString stringWithFormat:@"Lv%d", [member.userLevel intValue] + 1];
    NSString *minLevelValue = [NSString stringWithFormat:@"(%@)",  member.minLevelValue];
    NSString *maxLevelValue = [NSString stringWithFormat:@"(%@)", member.maxLevelValue];
    self.info9Lab.text = [creditDTO.available stringValue];
    self.balance.text = [NSString stringWithFormat:@"%.2f", [moneyDTO.available doubleValue]];
    self.info2Lab.text = [NSString stringWithFormat:@"%d", [member.maxLevelValue intValue] - [member.userLevelValue intValue]];
    self.levelLab.text = userLevel;
    self.info4Lab.text = currentLevel;
    self.info5Lab.text = minLevelValue;
    self.info6Lab.text = nextLevel;
    self.info7Lab.text = maxLevelValue;
    self.balance.text = [NSString stringWithFormat:@"%.2f", [moneyDTO.available doubleValue]];
    QDLog(@"用户等级 = %@, 用户当前经验值 = %@, 用户当前等级的最小值 = %@, 用户当前等级的最大值 = %@", userLevel, currentLevelValue, minLevelValue, maxLevelValue);
    //进度值
    CGFloat ss = [member.userLevelValue floatValue] / [member.maxLevelValue floatValue];
    _progressView.progress = ss;
    QDLog(@"ss = %.2f", ss);
}

@end
