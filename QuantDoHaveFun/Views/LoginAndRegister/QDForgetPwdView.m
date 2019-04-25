//
//  QDForgetPwdView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDForgetPwdView.h"

@implementation QDForgetPwdView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _loginLab = [[UILabel alloc] init];
        _loginLab.text = @"找回密码";
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
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneTF addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_phoneTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_phoneTF];
        
        _nextStepBtn = [[QDButton alloc] init];
        [_nextStepBtn setBackgroundColor:[UIColor colorWithHexString:@"#DDDDDD"] forState:UIControlStateNormal];
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepBtn.titleLabel.font = QDFont(21);
//        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.89, SCREEN_HEIGHT*0.08);
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
//        [_nextStepBtn.layer addSublayer:gradientLayer];
        [self addSubview:_nextStepBtn];
        
    }
    return self;
}

- (void)textValueChanged{
    if (_phoneTF.text.length != 0 && _phoneTF.text.length != 0) {
        [_nextStepBtn setBackgroundColor:APP_BLUECOLOR forState:UIControlStateNormal];
    }else{
        [_nextStepBtn setBackgroundColor:[UIColor colorWithHexString:@"#DDDDDD"] forState:UIControlStateNormal];
    }
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
        make.centerY.and.height.equalTo(self.areaBtn);
        make.width.mas_equalTo(SCREEN_WIDTH*0.6);
    }];

    [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self.phoneLine);
        make.top.equalTo(self.phoneLine.mas_bottom).offset(SCREEN_HEIGHT*0.068);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.075);
    }];
}
@end
