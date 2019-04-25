//
//  QDLoginView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDLoginView.h"
#import "QDGlobalFunc.h"
@implementation QDLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _hiLab = [[UILabel alloc] init];
        _hiLab.text = @"Hi,";
        _hiLab.font = QDBoldFont(25);
        [self addSubview:_hiLab];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"欢迎来到这好玩";
        _infoLab.font = QDBoldFont(25);
        [self addSubview:_infoLab];
        
        _phoneLine = [[UIView alloc] init];
        _phoneLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_phoneLine];
        
        _areaBtn = [[UIButton alloc] init];
        [_areaBtn setTitle:@"+86" forState:UIControlStateNormal];
        _areaBtn.titleLabel.font = QDFont(14);
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
        _userNameLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
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
        [_forgetPWD setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _forgetPWD.titleLabel.font = QDFont(14);
        [self addSubview:_forgetPWD];
        
        
//        _gotologinBtn = [[QDButton alloc] init];
//        [_gotologinBtn setBackgroundColor:[UIColor colorWithHexString:@"#6186C9"] forState:UIControlStateNormal];
//        [_gotologinBtn setBackgroundColor:[UIColor colorWithHexString:@"#48689C"] forState:UIControlStateSelected];
//        [_gotologinBtn setBackgroundColor:[UIColor colorWithHexString:@"#75849D"] forState:UIControlStateDisabled];
//        [_gotologinBtn setTitle:@"登录" forState:UIControlStateNormal];
//        _gotologinBtn.titleLabel.font = QDFont(12);
//        _gotologinBtn.layer.cornerRadius = 4;
//        _gotologinBtn.layer.masksToBounds = YES;
//        [self addSubview:_gotologinBtn];
        
//        _gotologinBtn = [[UIButton alloc] init];
//        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//        gradientLayer.frame = CGRectMake(0, 0, 316, 50);
//        gradientLayer.startPoint = CGPointMake(0, 0);
//        gradientLayer.endPoint = CGPointMake(1, 0);
//        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
//        [_gotologinBtn.layer addSublayer:gradientLayer];
//        [_gotologinBtn setTitle:@"登录" forState:UIControlStateNormal];
//        [_gotologinBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
//        _gotologinBtn.layer.cornerRadius = 4;
//        _gotologinBtn.layer.masksToBounds = YES;
//        _gotologinBtn.titleLabel.font = QDFont(17);
//        [self addSubview:_gotologinBtn];
//        UIImage *colorImg = [QDGlobalFunc imageWithColor:[UIColor colorWithHexString:@"#BDE5E5"]];
//        [_gotologinBtn setBackgroundImage:colorImg forState:UIControlStateDisabled];
//        [_gotologinBtn setBackgroundImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateSelected];
//        [_gotologinBtn setBackgroundImage:[UIImage imageNamed:@"login_selected"] forState:UIControlStateHighlighted];
//        [_gotologinBtn setBackgroundImage:[UIImage imageNamed:@"login_disabled"] forState:UIControlStateDisabled];
//        _gotologinBtn.titleLabel.font = QDFont(21);
//        [self addSubview:_gotologinBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_hiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self.mas_left).offset(23);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.15+SafeAreaTopHeight-64);
    }];
    
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hiLab);
        make.top.equalTo(_hiLab.mas_bottom).offset(10);
    }];
    
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_infoLab.mas_bottom).offset(63);
        make.height.equalTo(@1);
        make.width.mas_equalTo(339);
    }];
    
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneLine);
        make.bottom.equalTo(self.phoneLine.mas_top).offset(-(6));
    }];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaBtn.mas_right).offset(19);
        make.centerY.equalTo(self.areaBtn);
        make.right.equalTo(self.phoneLine);
    }];
    
    [_userNameLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.and.left.equalTo(self.phoneLine);
        make.top.equalTo(self.phoneLine.mas_bottom).offset(47);
    }];
    
    [_forgetPWD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userNameLine.mas_top).offset(-(6));
        make.right.equalTo(self.userNameLine);
    }];
    
    
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaBtn);
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
