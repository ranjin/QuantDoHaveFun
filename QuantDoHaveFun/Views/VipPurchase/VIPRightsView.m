//
//  VIPRightsView.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/25.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "VIPRightsView.h"

@implementation VIPRightsView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.58)];
        _whiteBackView.backgroundColor = APP_WHITECOLOR;
        [self addSubview:_whiteBackView];
        
        _topBlueView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.14)];
        _topBlueView.image = [UIImage imageNamed:@"vipRights_top"];
        [self addSubview:_topBlueView];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"VIP权益";
        _titleLab.font = QDBoldFont(18);
        _titleLab.textColor = APP_BLUETEXTCOLOR;
        [self addSubview:_titleLab];
        
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 119)];
        _centerView.backgroundColor = APP_BLUECOLOR;
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 360, 119);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#B5FBDD"] CGColor],(id)[[UIColor colorWithHexString:@"#5EE8BC"] CGColor]]];//渐变数组
        [_centerView.layer addSublayer:gradientLayer];
        _centerView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:158/255.0 blue:115/255.0 alpha:0.3].CGColor;
        _centerView.layer.shadowOffset = CGSizeMake(0,0);
        _centerView.layer.shadowOpacity = 1;
        _centerView.layer.shadowRadius = 10;
        _centerView.layer.cornerRadius = 5;
        _centerView.layer.masksToBounds = YES;
        [self addSubview:_centerView];
        
        _bottomWhiteView = [[UIView alloc] init];
        _bottomWhiteView.backgroundColor = APP_WHITECOLOR;
        _bottomWhiteView.layer.cornerRadius = 5;
        _bottomWhiteView.layer.masksToBounds = YES;
        [self addSubview:_bottomWhiteView];
        
        _balancePic = [[UIImageView alloc] init];
        _balancePic.image = [UIImage imageNamed:@"balance"];
        [_bottomWhiteView addSubview:_balancePic];
        
        _priceTextLab = [[UILabel alloc] init];
        _priceTextLab.text = @"金额";
        _priceTextLab.textColor = APP_GRAYCOLOR;
        _priceTextLab.font = QDFont(14);
        [_bottomWhiteView addSubview:_priceTextLab];
        
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"¥";
        _priceLab.textColor = APP_BLACKCOLOR;
        _priceLab.font = QDBoldFont(30);
        [_bottomWhiteView addSubview:_priceLab];
        
        _price = [[UILabel alloc] init];
        _price.textColor = APP_BLACKCOLOR;
        _price.font = QDBoldFont(24);
        [_bottomWhiteView addSubview:_price];
        
        _priceTF = [[UITextField alloc] init];
        _priceTF.placeholder = @"请输入金额";
        [_priceTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _priceTF.clearButtonMode = UITextFieldViewModeAlways;
        _priceTF.keyboardType = UIKeyboardTypeDecimalPad;
        _priceTF.hidden = YES;
        _priceTF.font = QDBoldFont(30);
        [_priceTF setValue:APP_GRAYLINECOLOR forKeyPath:@"placeholderLabel.textColor"];
        [_priceTF setValue:QDFont(24) forKeyPath:@"_placeholderLabel.font"];
        [_bottomWhiteView addSubview:_priceTF];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [_bottomWhiteView addSubview:_lineView];
        
        _bottomLab1 = [[UILabel alloc] init];
        _bottomLab1.text = @"奖励玩贝";
        _bottomLab1.font = QDFont(14);
        _bottomLab1.textColor = APP_GRAYTEXTCOLOR;
        [_bottomWhiteView addSubview:_bottomLab1];
        
        _bottomLab2 = [[UILabel alloc] init];
        _bottomLab2.text = @"";
        _bottomLab2.font = QDFont(14);
        _bottomLab2.textColor = APP_GRAYTEXTCOLOR;
        [_bottomWhiteView addSubview:_bottomLab2];
        
        _payButton = [[UIButton alloc] init];
        [_payButton setBackgroundImage:[UIImage imageNamed:@"vip_pay"] forState:UIControlStateNormal];
        [_payButton setTitle:@"确认并支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _payButton.titleLabel.font = QDFont(16);
        [_bottomWhiteView addSubview:_payButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(40+SafeAreaTopHeight-64);
    }];
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topBlueView);
        make.top.equalTo(_titleLab.mas_bottom).offset(18);
        make.width.mas_equalTo(360);
        make.height.mas_equalTo(119);
    }];
    
    [_bottomWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(354);
        make.height.mas_equalTo(211);
        make.top.equalTo(_whiteBackView.mas_bottom).offset(15);
    }];
    
    [_balancePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomWhiteView.mas_left).offset(17);
        make.top.equalTo(_bottomWhiteView.mas_top).offset(35);
    }];
    
    [_priceTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_balancePic.mas_right).offset(7);
        make.centerY.equalTo(_balancePic);
    }];

    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_balancePic.mas_bottom).offset(23);
        make.left.equalTo(_balancePic);
    }];

    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLab);
        make.left.equalTo(_priceLab.mas_right).offset(6);
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_priceLab.mas_bottom).offset(10);
        make.width.mas_equalTo(330);
        make.height.mas_equalTo(1);
    }];

    [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLab);
        make.left.equalTo(self.mas_left).offset(35);
        make.width.mas_equalTo(320);
    }];

    [_bottomLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceTextLab);
        make.left.equalTo(_bottomWhiteView.mas_left).offset(253);
    }];

    [_bottomLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomLab1);
        make.left.equalTo(_bottomLab1.mas_right).offset(5);
    }];

    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomWhiteView);
        make.bottom.equalTo(_bottomWhiteView.mas_bottom).offset(-28);
        make.width.mas_equalTo(316);
        make.height.mas_equalTo(50);
    }];
}
@end
