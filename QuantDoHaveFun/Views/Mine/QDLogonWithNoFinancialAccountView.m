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
        _picView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 39, 39)];
        _picView.layer.cornerRadius = 19.5;
        _picView.layer.masksToBounds = YES;
        _picView.userInteractionEnabled = YES;
        [_picView setImage:[UIImage imageNamed:@"icon_headerPic"] forState:UIControlStateNormal];
        [self addSubview:_picView];
        
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.text = @"加载中";
        _userNameLab.textColor = APP_BLACKCOLOR;
        _userNameLab.font = QDFont(17);
        [self addSubview:_userNameLab];
        
        _levelPic = [[UIImageView alloc] init];
        [_levelPic setImage:[UIImage imageNamed:@"icon_crown"]];
        [self addSubview:_levelPic];
        
        _levelLab = [[UILabel alloc] init];
        _levelLab.text = @"Lv2";
        _levelLab.textColor = APP_WHITECOLOR;
        _levelLab.font = QDFont(12);
        [_levelPic addSubview:_levelLab];
        
        _userIdLab = [[UILabel alloc] init];
        _userIdLab.text = @"--";
        _userIdLab.textColor = APP_GRAYLINECOLOR;
        _userIdLab.font = QDFont(14);
        [self addSubview:_userIdLab];
        
        _vipRightsBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _vipRightsBtn.imageTitleSpace = 7;
        [_vipRightsBtn setTitle:@"会员权益" forState:UIControlStateNormal];
        [_vipRightsBtn setImage:[UIImage imageNamed:@"rights_arrow"] forState:UIControlStateNormal];
        [_vipRightsBtn setTitleColor:APP_GRAYCOLOR forState:UIControlStateNormal];
        _vipRightsBtn.titleLabel.font = QDFont(14);
        _vipRightsBtn.backgroundColor = APP_WHITECOLOR;
        [self addSubview:_vipRightsBtn];
        
        _financialPic = [[UIImageView alloc] init];
        [_financialPic setImage:[UIImage imageNamed:@"vipLevel"]];
        [self addSubview:_financialPic];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"升级还需75成长值";
        _infoLab.textColor = APP_BLUETEXTCOLOR;
        _infoLab.font = QDFont(14);
        [_financialPic addSubview:_infoLab];
        
        _groupUPDesc = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _groupUPDesc.imageTitleSpace = 9;
        [_groupUPDesc setTitle:@"成长值说明" forState:UIControlStateNormal];
        [_groupUPDesc setImage:[UIImage imageNamed:@"rights_blueArrow"] forState:UIControlStateNormal];
        [_groupUPDesc setTitleColor:APP_BLUETEXTCOLOR forState:UIControlStateNormal];
        _groupUPDesc.titleLabel.font = QDFont(12);
        [_financialPic addSubview:_groupUPDesc];
        
        _progressView = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, 315, 4)];
        [self addSubview:_progressView];
        
        _info4Lab = [[UILabel alloc] init];
        _info4Lab.textColor = APP_BLUETEXTCOLOR;
        _info4Lab.font = QDFont(16);
        [_financialPic addSubview:_info4Lab];
        
        _info5Lab = [[UILabel alloc] init];
        _info5Lab.textColor = APP_BLUETEXTCOLOR;
        _info5Lab.font = QDFont(12);
        [_financialPic addSubview:_info5Lab];
        
        _info6Lab = [[UILabel alloc] init];
        _info6Lab.textColor = APP_BLUETEXTCOLOR;
        _info6Lab.font = QDFont(16);
        [_financialPic addSubview:_info6Lab];
        
        _info7Lab = [[UILabel alloc] init];
        _info7Lab.textColor = APP_BLUETEXTCOLOR;
        _info7Lab.font = QDFont(12);
        [_financialPic addSubview:_info7Lab];
        
        _info8Lab = [[UILabel alloc] init];
        _info8Lab.text = @"我的玩贝(个)";
        _info8Lab.textColor = [UIColor colorWithHexString:@"#2BC1A3"];
        _info8Lab.font = QDFont(13);
        [_financialPic addSubview:_info8Lab];
        
        
        _info9Lab = [[UILabel alloc] init];
        _info9Lab.textColor = APP_BLUETEXTCOLOR;
        _info9Lab.font = QDBoldFont(25);
        [_financialPic addSubview:_info9Lab];
        
        _accountInfo = [[UIButton alloc] init];
        [_accountInfo setTitle:@"查看账户" forState:UIControlStateNormal];
        _accountInfo.titleLabel.font = QDFont(14);
        [_accountInfo setTitleColor:APP_BLUETEXTCOLOR forState:UIControlStateNormal];
        [self addSubview:_accountInfo];
        
        _balanceLab = [[UILabel alloc] init];
        _balanceLab.text = @"我的余额(元)";
        _balanceLab.textColor = APP_GRAYLINECOLOR;
        _balanceLab.font = QDFont(13);
        [self addSubview:_balanceLab];
        
        _balance = [[UILabel alloc] init];
        _balance.text = @"0.00";
        _balance.textColor = APP_BLACKCOLOR;
        _balance.font = QDBoldFont(18);
        [self addSubview:_balance];
        
        
        _openFinancialBtn = [[UIButton alloc] init];
        [_openFinancialBtn setTitle:@"开通资金账户" forState:UIControlStateNormal];
        [_openFinancialBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 115, 28);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        gradientLayer.cornerRadius = 14;
        gradientLayer.masksToBounds = YES;
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
        [_openFinancialBtn.layer addSublayer:gradientLayer];
        _openFinancialBtn.titleLabel.font = QDFont(14);
        [self addSubview:_openFinancialBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(12);
        make.top.equalTo(self.mas_top).offset(SafeAreaTopHeight-64+40);
        make.width.and.height.mas_equalTo(39);
    }];
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SafeAreaTopHeight-33);
        make.right.equalTo(self.mas_right).offset(-49);
    }];
    
//    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_settingBtn);
//        make.right.equalTo(self.mas_right).offset(-12);
//    }];
    
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picView);
        make.left.equalTo(_picView.mas_right).offset(18);
    }];
    
    [_levelPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_userNameLab);
        make.top.equalTo(_userNameLab.mas_bottom).offset(4);
    }];
    
    [_levelLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(_levelPic);
        make.centerY.equalTo(_levelPic);
        make.right.equalTo(_levelPic.mas_right).offset(-10);
    }];
    
    [_userIdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_levelPic.mas_bottom).offset(10);
        make.left.equalTo(_userNameLab);
    }];
    
    
    [_vipRightsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_levelPic);
        make.left.equalTo(_levelPic.mas_right).offset(20);
    }];
    
    [_financialPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userIdLab.mas_bottom).offset(16);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(174);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_financialPic);
        make.top.equalTo(_financialPic.mas_top).offset(50);
        make.width.mas_equalTo(315);
        make.height.mas_equalTo(4);
    }];
    
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_financialPic.mas_left).offset(26);
        make.top.equalTo(_financialPic.mas_top).offset(24);
    }];
    
    [_info4Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_financialPic.mas_top).offset(65);
        make.left.equalTo(_infoLab);
    }];

    [_info5Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info4Lab);
        make.left.equalTo(_info4Lab.mas_right);
    }];

    [_info7Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info5Lab);
        make.right.equalTo(self.mas_right).offset(-17);
    }];

    [_info6Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info7Lab);
        make.right.equalTo(_info7Lab.mas_left);
    }];

    [_info8Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_infoLab);
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
        make.left.equalTo(self.mas_left).offset(16);
        make.top.equalTo(_info9Lab.mas_bottom).offset(42);
    }];

    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_balanceLab);
        make.top.equalTo(_balanceLab.mas_bottom).offset(SCREEN_HEIGHT*0.007);
    }];

    [_openFinancialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.balanceLab.mas_top).offset(8);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(115);
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
    self.infoLab.text = [NSString stringWithFormat:@"升级还需%d成长值", [member.maxLevelValue intValue] - [member.userLevelValue intValue]];
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
