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
        _whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 421+SafeAreaTopHeight-64)];
        _whiteBackView.backgroundColor = APP_WHITECOLOR;
        [self addSubview:_whiteBackView];
        
        _topBlueView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120+SafeAreaTopHeight-64)];
        _topBlueView.image = [UIImage imageNamed:@"vipRights_top"];
        [self addSubview:_topBlueView];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"VIP权益";
        _titleLab.font = QDBoldFont(18);
        _titleLab.textColor = APP_BLUETEXTCOLOR;
        [self addSubview:_titleLab];
        
        //默认显示未登录状态
        _noLoginHeadView = [[TopRightsNotLoginHeadView alloc] initWithFrame:CGRectMake(0, 0, 360, 119)];
        [self addSubview:_noLoginHeadView];
        _noLoginHeadView.hidden = NO;

        _loginHeadView = [[TopRightsLoginHeadView alloc] initWithFrame:CGRectMake(0, 0, 360, 119)];
        _loginHeadView.hidden = YES;
        [self addSubview:_loginHeadView];
        
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
        _bottomLab2.textColor = APP_BLACKCOLOR;
        [_bottomWhiteView addSubview:_bottomLab2];
        
        _payButton = [[UIButton alloc] init];
//        [_payButton setBackgroundImage:[UIImage imageNamed:@"vip_pay"] forState:UIControlStateNormal];
//        [_payButton setTitle:@"确认并支付" forState:UIControlStateNormal];
//        [_payButton setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
//        _payButton.titleLabel.font = QDFont(16);
//        [_bottomWhiteView addSubview:_payButton];
        
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 316, 50);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor],(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor]]];//渐变数组
        [_payButton.layer addSublayer:gradientLayer];
        [_payButton setTitle:@"确认并支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _payButton.titleLabel.font = QDFont(16);
        _payButton.layer.cornerRadius = 25;
        _payButton.layer.masksToBounds = YES;
        [_bottomWhiteView addSubview:_payButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(20+SafeAreaTopHeight-64);
    }];
    
    [_noLoginHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topBlueView);
        make.top.equalTo(_titleLab.mas_bottom).offset(18);
        make.width.mas_equalTo(360);
        make.height.mas_equalTo(119);
    }];
    
    [_loginHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.left.equalTo(_priceLab.mas_right).offset(5);
//        make.width.mas_equalTo(310);
        make.right.equalTo(_lineView);
    }];

    [_bottomLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceTextLab);
        make.right.equalTo(_bottomWhiteView.mas_right).offset(-19);
    }];
    
    [_bottomLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomLab2);
        make.right.equalTo(_bottomLab2.mas_left);
    }];

    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomWhiteView);
        make.bottom.equalTo(_bottomWhiteView.mas_bottom).offset(-28);
        make.width.mas_equalTo(316);
        make.height.mas_equalTo(50);
    }];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    //判断第一位是否为数字
    if ([textField.text isEqualToString: @"."]) {
        textField.text = @"";
    }
    //判断是否有两个小数点
    if (textField.text.length >= 2) {
        NSString *str = [textField.text substringToIndex:textField.text.length-1];
        NSString *strTwo = [textField.text substringFromIndex:textField.text.length-1];
        NSRange range = [str rangeOfString:@"."];
        if (range.location != NSNotFound && [strTwo isEqualToString:@"."]) {
            textField.text = [textField.text substringToIndex:textField.text.length-1];
        }
    }
    //小数点后面数字位数控制  （此时为小数点后一位，3改4就是两位    思路：取倒数第X个字符是否为小数点，是小数点的话，就不再允许输入）
    if (textField.text.length > 4) {
        NSString *myStr = [textField.text substringWithRange:NSMakeRange(textField.text.length-4 , 1)];
        if ([myStr isEqualToString:@"."]) {
            textField.text = [textField.text substringToIndex:textField.text.length-1];
        }
    }
    //最大值控制
    double doubleNum = [textField.text doubleValue];
    NSUInteger myNub = doubleNum;
    NSUInteger sum = 1000000;
    if (myNub > sum) {
        textField.text = [textField.text substringToIndex:textField.text.length-1];
    }
    double ss = floor([_priceTF.text doubleValue] / _basePrice);
    _bottomLab2.text = [NSString stringWithFormat:@"%.lf个", ss];
}

@end
