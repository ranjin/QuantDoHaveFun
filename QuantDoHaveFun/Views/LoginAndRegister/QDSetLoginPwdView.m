//
//  QDSetLoginPwdView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDSetLoginPwdView.h"

@implementation QDSetLoginPwdView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _identifyLab = [[UILabel alloc] init];
        _identifyLab.text = @"设置登录密码";
        _identifyLab.font = QDFont(25);
        [self addSubview:_identifyLab];
        
        _lineViewTop = [[UIView alloc] init];
        _lineViewTop.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_lineViewTop];
        
        _lineViewCenter = [[UIView alloc] init];
        _lineViewCenter.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_lineViewCenter];
        
        _lineViewBottom = [[UIView alloc] init];
        _lineViewBottom.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_lineViewBottom];
        
        _pwdTF = [[UITextField alloc] init];
        _pwdTF.placeholder = @"登录密码(6~16位字母与数字组合)";
        _pwdTF.secureTextEntry = YES;
        _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_pwdTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_pwdTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_pwdTF];
        
        _confirmPwdTF = [[UITextField alloc] init];
        _confirmPwdTF.placeholder = @"确认登录密码(6~16位字母与数字组合)";
        _confirmPwdTF.secureTextEntry = YES;
        _confirmPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_confirmPwdTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_confirmPwdTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_confirmPwdTF];
        
        _inviteTF = [[UITextField alloc] init];
        _inviteTF.placeholder = @"请正确填写邀请码(必填)";
        _inviteTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_inviteTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_inviteTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_inviteTF];
        
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 316, 50);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor],(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor]]];//渐变数组
        [_registerBtn.layer addSublayer:gradientLayer];
        _registerBtn.titleLabel.font = QDFont(16);
        _registerBtn.layer.cornerRadius = 25;
        _registerBtn.layer.masksToBounds = YES;
        [self addSubview:_registerBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_identifyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(18);
        make.top.equalTo(self.mas_top).offset(107+SafeAreaTopHeight-64);
    }];
    
    [_lineViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(199+SafeAreaTopHeight-64);
        make.width.mas_equalTo(339);
        make.height.equalTo(@1);
    }];
    
    [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.lineViewTop.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(self.lineViewTop);
    }];
    
    [_lineViewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineViewTop.mas_bottom).offset(52);
        make.width.and.height.equalTo(self.lineViewTop);
    }];

    [_confirmPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.lineViewCenter.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(self.lineViewTop);
    }];

    [_lineViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.and.height.equalTo(self.lineViewCenter);
        make.top.equalTo(self.lineViewCenter.mas_bottom).offset(52);
    }];

    [_inviteTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.confirmPwdTF);
        make.bottom.equalTo(self.lineViewBottom.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(self.lineViewTop);
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.lineViewBottom);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(45);
        make.width.mas_equalTo(316);
        make.height.mas_equalTo(50);
    }];
}

@end
