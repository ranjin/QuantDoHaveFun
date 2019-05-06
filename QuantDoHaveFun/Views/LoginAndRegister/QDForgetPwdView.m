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
        _loginLab.textColor = APP_BLACKCOLOR;
        _loginLab.font = QDFont(24);
        [self addSubview:_loginLab];
        
        _phoneLine = [[UIView alloc] init];
        _phoneLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_phoneLine];
        
        _areaBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _areaBtn.imageTitleSpace = 6;
        [_areaBtn setImage:[UIImage imageNamed:@"select_down"] forState:UIControlStateNormal];
        [_areaBtn setTitle:@"+86" forState:UIControlStateNormal];
        [_areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _areaBtn.titleLabel.font = QDFont(14);
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
        [_nextStepBtn setBackgroundImage:[UIImage imageNamed:@"login_nor"] forState:UIControlStateNormal];
        [_nextStepBtn setBackgroundImage:[UIImage imageNamed:@"login_dis"] forState:UIControlStateDisabled];
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextStepBtn.titleLabel.font = QDFont(16);
        [_nextStepBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _nextStepBtn.enabled = NO;
        [self addSubview:_nextStepBtn];
        
    }
    return self;
}

- (void)textValueChanged{
    if (_phoneTF.text.length != 0 && _phoneTF.text.length != 0) {
        _nextStepBtn.enabled = YES;
    }else{
        _nextStepBtn.enabled = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(21);
        make.top.equalTo(self.mas_top).offset(97+SafeAreaTopHeight-64);
    }];
    
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(194+SafeAreaTopHeight-64);
        make.height.equalTo(@1);
        make.width.mas_equalTo(339);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginLab);
        make.top.equalTo(self.loginLab.mas_bottom).offset(37);
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(76);
        make.centerY.and.height.equalTo(self.areaBtn);
        make.width.mas_equalTo(SCREEN_WIDTH*0.75);
    }];

    [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.phoneLine);
        make.top.equalTo(self.phoneLine.mas_bottom).offset(42);
        make.width.mas_equalTo(339);
        make.height.mas_equalTo(50);
    }];
}
@end
