//
//  QDResetLoginPwdView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDResetLoginPwdView.h"

@implementation QDResetLoginPwdView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _identifyLab = [[UILabel alloc] init];
        _identifyLab.text = @"请重置登录密码";
        _identifyLab.font = QDFont(22);
        [self addSubview:_identifyLab];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_lineView];
        
        _lineViewTop = [[UIView alloc] init];
        _lineViewTop.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_lineViewTop];
        
        _lineViewBottom = [[UIView alloc] init];
        _lineViewBottom.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [self addSubview:_lineViewBottom];
        
        _theNewPwdTF = [[UITextField alloc] init];
        _theNewPwdTF.placeholder = @"请输入新登录密码";
        _theNewPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _theNewPwdTF.secureTextEntry = YES;
        [_theNewPwdTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_theNewPwdTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_theNewPwdTF];
        
        _confirmPwdTF = [[UITextField alloc] init];
        _confirmPwdTF.placeholder = @"请确认登录密码";
        _confirmPwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _confirmPwdTF.secureTextEntry = YES;
        [_confirmPwdTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_confirmPwdTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_confirmPwdTF];

        _confirmBtn = [[UIButton alloc] init];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 335, 50);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
        [_confirmBtn.layer addSublayer:gradientLayer];
        _confirmBtn.layer.masksToBounds =YES;
        _confirmBtn.layer.cornerRadius =4;
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:_confirmBtn];
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
    
    [_theNewPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.lineViewTop.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(_lineViewTop.mas_right).offset(-10);
    }];
    
    [_lineViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineViewTop.mas_top).offset(SCREEN_HEIGHT*0.088);
        make.width.and.height.equalTo(self.lineViewTop);
        make.height.equalTo(@1);
    }];
    
    [_confirmPwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
        make.bottom.equalTo(self.lineViewBottom.mas_top).offset(-(SCREEN_HEIGHT*0.015));
        make.right.equalTo(_lineViewBottom.mas_right).offset(-10);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self.lineViewBottom);
        make.top.equalTo(self.lineViewBottom.mas_bottom).offset(SCREEN_HEIGHT*0.068);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(335);
    }];
}
@end
