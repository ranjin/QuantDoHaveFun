//
//  QDMineHeaderNotLoginView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMineHeaderNotLoginView.h"

@implementation QDMineHeaderNotLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.2)];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.18);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#DFE4EA"] CGColor],(id)[APP_WHITECOLOR CGColor]]];//渐变数组
        [_whiteBackView.layer addSublayer:gradientLayer];
        [self addSubview:_whiteBackView];
        
        _settingBtn = [[UIButton alloc] init];
        [_settingBtn setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        [_whiteBackView addSubview:_settingBtn];
        
//        _voiceBtn = [[UIButton alloc] init];
//        [_voiceBtn setImage:[UIImage imageNamed:@"icon_info"] forState:UIControlStateNormal];
//        [_whiteBackView addSubview:_voiceBtn];
        
        _picBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.06, SCREEN_HEIGHT*0.1, SCREEN_WIDTH*0.12, SCREEN_WIDTH*0.12)];
        [_picBtn setImage:[UIImage imageNamed:@"icon_headerPic"] forState:UIControlStateNormal];
//        CALayer *layer = [CALayer layer];
//        layer.frame = _picBtn.frame;
//        layer.backgroundColor = [UIColor blackColor].CGColor;
//        layer.shadowOffset = CGSizeMake(10, 10);
//        layer.shadowOpacity = 1;
//        layer.cornerRadius = SCREEN_WIDTH*0.06;
//        [_picBtn.layer addSublayer:layer];
        _picBtn.layer.masksToBounds =YES;
        _picBtn.layer.cornerRadius =SCREEN_WIDTH*0.06;
        [_whiteBackView addSubview:_picBtn];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"登录获取更多信息";
        _infoLab.textColor = APP_BLACKCOLOR;
        _infoLab.font = QDBoldFont(17);
        [self addSubview:_infoLab];
        
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = APP_BLUECOLOR;
        _loginBtn.titleLabel.font = QDFont(16);
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        [self addSubview:_loginBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_whiteBackView.mas_top).offset(SCREEN_HEIGHT*0.05);
        make.left.equalTo(_whiteBackView.mas_left).offset(SCREEN_WIDTH*0.76);
    }];
//    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.settingBtn);
//        make.right.equalTo(_whiteBackView.mas_right).offset(-(SCREEN_WIDTH*0.05));
//    }];

    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_picBtn);
        make.left.equalTo(_whiteBackView.mas_left).offset(SCREEN_WIDTH*0.2);
    }];

    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_infoLab);
        make.left.equalTo(_whiteBackView.mas_left).offset(SCREEN_WIDTH*0.72);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.05);
        make.width.mas_equalTo(SCREEN_WIDTH*0.21);
    }];
}

@end
