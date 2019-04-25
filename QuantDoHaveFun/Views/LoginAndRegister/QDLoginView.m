//
//  QDLoginView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDLoginView.h"

@implementation QDLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _loginLab = [[UILabel alloc] init];
        _loginLab.text = @"登录这好玩";
        _loginLab.font = QDFont(32);
        [self addSubview:_loginLab];
        
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
        _phoneTF.delegate = self;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_phoneTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [_phoneTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_phoneTF];
        
        _userNameLine = [[UIView alloc] init];
        _userNameLine.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_userNameLine];
        
        _userNameTF = [[UITextField alloc] init];
        _userNameTF.delegate = self;
        _userNameTF.placeholder = @"请输入登录密码";
        _userNameTF.secureTextEntry = YES;
        _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_userNameTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_userNameTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [_userNameTF addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_userNameTF];
        
        _forgetPWD = [[UIButton alloc] init];
        [_forgetPWD setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPWD setTitleColor:[UIColor colorWithHexString:@"CCCCCC"] forState:UIControlStateNormal];
        _forgetPWD.titleLabel.font = QDFont(13);
        [self addSubview:_forgetPWD];
        
        
        _gotologinBtn = [[UIButton alloc] init];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 335, 50);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
        [_gotologinBtn.layer addSublayer:gradientLayer];
        [_gotologinBtn setTitle:@"登录" forState:UIControlStateNormal];
        _gotologinBtn.layer.cornerRadius = 4;
        _gotologinBtn.layer.masksToBounds = YES;
        _gotologinBtn.titleLabel.font = QDFont(17);
        [self addSubview:_gotologinBtn];
//        [_gotologinBtn setBackgroundColor:APP_LIGHTGRAYCOLOR forState:UIControlStateNormal];
//        [_gotologinBtn setBackgroundColor:APP_BLUECOLOR forState:UIControlStateSelected];
//        [_gotologinBtn setBackgroundColor:APP_BLUECOLOR forState:UIControlStateHighlighted];
//        [_gotologinBtn setBackgroundColor:APP_BLUECOLOR forState:UIControlStateDisabled];

        _gotologinBtn.titleLabel.font = QDFont(21);
        [self addSubview:_gotologinBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.156);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginLab);
        make.top.equalTo(self.loginLab.mas_bottom).offset(SCREEN_HEIGHT*0.012);
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
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.24);
        make.centerY.equalTo(self.areaBtn);
        make.right.equalTo(self.phoneLine);
    }];
    
    [_userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.and.left.equalTo(self.phoneLine);
        make.top.equalTo(self.phoneLine.mas_bottom).offset(SCREEN_HEIGHT*0.1);
    }];
    
    [_forgetPWD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userNameLine.mas_top).offset(-(SCREEN_HEIGHT*0.017));
        make.right.equalTo(self.userNameLine);
    }];
    
    
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTF);
        make.centerY.equalTo(_forgetPWD);
        make.right.equalTo(_forgetPWD.mas_left);
    }];
    
    [_gotologinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(335);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.userNameLine.mas_bottom).offset(SCREEN_HEIGHT*0.067);
    }];
}

#pragma mark - 监听键盘输入
- (void)textFieldChanged:(UITextField *)textField{
    if (![_phoneTF.text isEqualToString:@""] && ![_userNameTF.text isEqualToString:@""]) {
        [_gotologinBtn setSelected:YES];
    }
}
@end
