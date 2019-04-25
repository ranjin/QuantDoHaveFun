//
//  QDMineHeaderNotLoginView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMineHeaderNotLoginView.h"

@implementation QDMineHeaderNotLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _whiteBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 118+SafeAreaTopHeight-64)];
        _whiteBackView.backgroundColor = [UIColor whiteColor];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 118+SafeAreaTopHeight-64);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.locations = @[@(0.2),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#DFE4EA"] CGColor],(id)[APP_WHITECOLOR CGColor]]];//渐变数组
        [_whiteBackView.layer addSublayer:gradientLayer];
        [self addSubview:_whiteBackView];
        
        _picBtn = [[UIButton alloc] initWithFrame:CGRectMake(11, 51+SafeAreaTopHeight-64, 50, 50)];
        [_picBtn setImage:[UIImage imageNamed:@"icon_headerPic"] forState:UIControlStateNormal];
        _picBtn.layer.masksToBounds =YES;
        _picBtn.backgroundColor = APP_BLUECOLOR;
        _picBtn.layer.cornerRadius =SCREEN_WIDTH*0.06;
        [_whiteBackView addSubview:_picBtn];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"登录获取更多信息";
        _infoLab.textColor = APP_BLACKCOLOR;
        _infoLab.font = QDBoldFont(16);
        [self addSubview:_infoLab];
        [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_picBtn);
            make.left.equalTo(_whiteBackView.mas_left).offset(65);
        }];
        
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = APP_BLUECOLOR;
        [_loginBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        CAGradientLayer *btnLayer =  [CAGradientLayer layer];
        btnLayer.frame = CGRectMake(0, 0, 63, 28);
        btnLayer.startPoint = CGPointMake(0, 0);
        btnLayer.endPoint = CGPointMake(1, 1);
        btnLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [btnLayer setColors:@[(id)[[UIColor colorWithHexString:@"#00C0AC"] CGColor],(id)[[UIColor colorWithHexString:@"#00C9CB"] CGColor]]];//渐变数组
        [_loginBtn.layer addSublayer:btnLayer];
        _loginBtn.layer.cornerRadius = 14;
        _loginBtn.layer .masksToBounds = YES;
        _loginBtn.titleLabel.font = QDFont(14);
        [_whiteBackView addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_infoLab);
            make.right.equalTo(_whiteBackView.mas_right).offset(-22);
            make.width.mas_equalTo(63);
            make.height.mas_equalTo(28);
        }];
        
//        _headerView = [[QDMineSectionHeaderView alloc] init];
//        _headerView.backgroundColor = APP_ORANGECOLOR;
//        [_whiteBackView addSubview:_headerView];
//        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_picBtn.mas_bottom).offset(30);
//            make.width.equalTo(_whiteBackView);
//            make.height.mas_equalTo(90);
//        }];
    }
    return self;
}

@end
