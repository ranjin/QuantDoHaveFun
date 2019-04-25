//
//  QDRegisterView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/14.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDRegisterView.h"
@implementation QDRegisterView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
//        _cancelBtn = [[UIButton alloc] init];
//        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self addSubview:_cancelBtn];
//
//        _loginBtn = [[UIButton alloc] init];
//        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self addSubview:_loginBtn];
        
        _registerLab = [[UILabel alloc] init];
        _registerLab.text = @"注册这好玩";
        _registerLab.font = QDFont(32);
        [self addSubview:_registerLab];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_lineView];

        _phoneLine = [[UIView alloc] init];
        _phoneLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_phoneLine];

        _areaBtn = [[UIButton alloc] init];
        [_areaBtn setTitle:@"+86" forState:UIControlStateNormal];
        [_areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_areaBtn];

        _phoneTF = [[UITextField alloc] init];
        _phoneTF.placeholder = @"请输入手机号";
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_phoneTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_phoneTF];

        _userNameLine = [[UIView alloc] init];
        _userNameLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_userNameLine];

        _userNameTF = [[UITextField alloc] init];
        _userNameTF.placeholder = @"请输入用户名";
//        _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_userNameTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_userNameTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_userNameTF];

        _infoLab = [[UILabel alloc] init];
        _infoLab.textColor = [UIColor colorWithHexString:@"CCCCCC"];
        _infoLab.text = @"支持6-20个字符";
        _infoLab.font = QDFont(13);
        [self addSubview:_infoLab];
        
        _nextBtn = [[UIButton alloc] init];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 335, 50);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
        [_nextBtn.layer addSublayer:gradientLayer];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.layer.cornerRadius = 4;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.titleLabel.font = QDFont(20);
        [self addSubview:_nextBtn];
        
        
//        _nextBtn = [[QDButton alloc] init];
//        [_nextBtn setBackgroundColor:APP_LIGHTGRAYCOLOR forState:UIControlStateNormal];
//        [_nextBtn setBackgroundColor:APP_BLUECOLOR forState:UIControlStateSelected];
//        [_nextBtn setBackgroundColor:APP_BLUECOLOR forState:UIControlStateHighlighted];
//        [_nextBtn setBackgroundColor:APP_LIGHTGRAYCOLOR forState:UIControlStateDisabled];
//        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
//        _nextBtn.titleLabel.font = QDFont(21);
//        [self addSubview:_nextBtn];
        
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor redColor];
        _imgView.image = [UIImage imageNamed:@"icon_tabbar_homepage"];
        _imgView.hidden = YES;
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.054);
//        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.056);
//    }];
//    
//    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.cancelBtn);
//        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.056));
//    }];
//    
    [_registerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.156);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.registerLab);
        make.top.equalTo(self.registerLab.mas_bottom).offset(SCREEN_HEIGHT*0.012);
        make.width.mas_equalTo(SCREEN_WIDTH*0.097);
        make.height.mas_equalTo(SCREEN_WIDTH*0.01);
    }];
    
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.35);
        make.height.equalTo(@1);
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
    }];

    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.phoneLine.mas_top).offset(-(SCREEN_HEIGHT*0.01));
    }];

    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH*0.22);
        make.centerY.equalTo(self.areaBtn);
        make.right.equalTo(self.phoneLine);
    }];

    [_userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.and.left.equalTo(self.phoneLine);
        make.top.equalTo(self.phoneLine.mas_bottom).offset(SCREEN_HEIGHT*0.1);
    }];

    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTF);
        make.bottom.equalTo(self.userNameLine.mas_top).offset(-(SCREEN_HEIGHT*0.01));
        make.right.equalTo(self.userNameLine);
    }];
    
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userNameTF);
        make.right.equalTo(self.userNameLine);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(335);
        make.centerX.equalTo(self);
        make.top.equalTo(self.userNameLine.mas_bottom).offset(SCREEN_HEIGHT*0.12);
    }];
}

@end
