//
//  TopRightsNotLoginHeadView.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/28.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "TopRightsNotLoginHeadView.h"

@implementation TopRightsNotLoginHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _topBlueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 119)];
        _topBlueView.backgroundColor = APP_BLUECOLOR;
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 360, 119);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#B5FBDD"] CGColor],(id)[[UIColor colorWithHexString:@"#5EE8BC"] CGColor]]];//渐变数组
        [_topBlueView.layer addSublayer:gradientLayer];
        _topBlueView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:158/255.0 blue:115/255.0 alpha:0.3].CGColor;
        _topBlueView.layer.shadowOffset = CGSizeMake(0,0);
        _topBlueView.layer.shadowOpacity = 1;
        _topBlueView.layer.shadowRadius = 10;
        _topBlueView.layer.cornerRadius = 5;
        _topBlueView.layer.masksToBounds = YES;
        [self addSubview:_topBlueView];
        
        _headPic = [[UIImageView alloc] init];
        _headPic.image = [UIImage imageNamed:@"icon_headerPic"];
        [_topBlueView addSubview:_headPic];
        [_headPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(33);
            make.top.equalTo(self.mas_top).offset(18);
        }];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"登录获取更多信息";
        _infoLab.textColor = APP_BLUETEXTCOLOR;
        _infoLab.font = QDFont(16);
        [_topBlueView addSubview:_infoLab];
        [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headPic.mas_right).offset(12);
            make.centerY.equalTo(_headPic);
        }];
        
        _loginBtn = [[UIButton alloc] init];
//        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"notLogin_login"] forState:UIControlStateNormal];
        [_loginBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        CAGradientLayer *btnLayer =  [CAGradientLayer layer];
        btnLayer.frame = CGRectMake(0, 0, 63, 28);
        btnLayer.startPoint = CGPointMake(0, 0);
        btnLayer.endPoint = CGPointMake(1, 0);
        btnLayer.locations = @[@(0.0),@(1.0)];//渐变点
        btnLayer.masksToBounds = YES;
        btnLayer.cornerRadius = 14;
        
        [btnLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
        [_loginBtn.layer addSublayer:btnLayer];
        _loginBtn.titleLabel.font = QDFont(14);
        [_topBlueView addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headPic);
            make.right.equalTo(self.mas_right).offset(-33);
            make.width.mas_equalTo(63);
            make.height.mas_equalTo(28);
        }];
    }
    return self;
}
@end
