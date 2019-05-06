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
        _hiLab = [[UILabel alloc] init];
        _hiLab.text = @"Hi,";
        _hiLab.font = QDBoldFont(25);
        [self addSubview:_hiLab];
        
        _welcomeLab = [[UILabel alloc] init];
        _welcomeLab.text = @"欢迎注册这好玩";
        _welcomeLab.font = QDBoldFont(25);
        [self addSubview:_welcomeLab];
        
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
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_phoneTF setValue:APP_GRAYLAYERCOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_phoneTF setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_phoneTF];

        _userNameLine = [[UIView alloc] init];
        _userNameLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
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
        
        _nextBtn = [[QDButton alloc] init];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"login_nor"] forState:UIControlStateNormal];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"login_dis"] forState:UIControlStateDisabled];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = QDFont(16);
        [_nextBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _nextBtn.enabled = NO;
        [self addSubview:_nextBtn];
        
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
    [_hiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.equalTo(self.mas_left).offset(23);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.15+SafeAreaTopHeight-64);
    }];
    
    [_welcomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hiLab);
        make.top.equalTo(_hiLab.mas_bottom).offset(10);
    }];
    
    [_phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_welcomeLab.mas_bottom).offset(63);
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
        make.top.equalTo(self.phoneLine.mas_bottom).offset(55);
    }];
    

    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userNameLine.mas_top).offset(-(6));
        make.right.equalTo(self.userNameLine);
    }];

    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_areaBtn);
        make.centerY.equalTo(_infoLab);
        make.right.equalTo(_infoLab.mas_left);
    }];

    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(335);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.userNameLine.mas_bottom).offset(90);
    }];
}

@end
