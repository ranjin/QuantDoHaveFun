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
        _identifyLab.text = @"请设置登录密码";
        _identifyLab.font = QDFont(22);
        [self addSubview:_identifyLab];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_lineView];
        
        _lineViewTop = [[UIView alloc] init];
        _lineViewTop.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_lineViewTop];
        
        _lineViewCenter = [[UIView alloc] init];
        _lineViewCenter.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_lineViewCenter];
        
        _lineViewBottom = [[UIView alloc] init];
        _lineViewBottom.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
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
        _inviteTF.placeholder = @"请填写邀请码(必填)";
        _inviteTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_inviteTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_inviteTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_inviteTF];
        
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_registerBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_identifyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.156);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.identifyLab);
        make.top.equalTo(self.identifyLab.mas_bottom).offset(SCREEN_HEIGHT*0.012);
        make.width.mas_equalTo(SCREEN_WIDTH*0.097);
        make.height.mas_equalTo(SCREEN_WIDTH*0.01);
    }];
    
    [_lineViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.354);
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
        make.height.equalTo(@1);
    }];
    
    [_pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.lineViewTop.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(self.lineViewTop);
    }];
    
    [_lineViewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineViewTop.mas_top).offset(SCREEN_HEIGHT*0.088);
        make.width.and.height.equalTo(self.lineViewTop);
        make.height.equalTo(@1);
    }];

    [_confirmPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.lineViewCenter.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(self.lineViewTop);
    }];

    [_lineViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.and.height.equalTo(self.lineViewCenter);
        make.top.equalTo(self.lineViewCenter.mas_top).offset(SCREEN_HEIGHT*0.088);
    }];

    [_inviteTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.confirmPwdTF);
        make.bottom.equalTo(self.lineViewBottom.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(self.lineViewTop);
    }];
    
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self.lineViewBottom);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(SCREEN_HEIGHT*0.068);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.075);
    }];
}

@end
