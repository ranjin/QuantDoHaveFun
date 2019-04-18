//
//  QDMineView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMineView.h"

@implementation QDMineView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _ordersView = [[UIView alloc] init];
        _ordersView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_ordersView];
        
        _myOrdersLab = [[UILabel alloc] init];
        _myOrdersLab.text = @"我的消费订单";
        _myOrdersLab.font = [UIFont systemFontOfSize:15];
        [_ordersView addSubview:_myOrdersLab];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [_ordersView addSubview:_lineView];
        
        _btn1 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn1.imageTitleSpace = 10;
        [_btn1 setTitle:@"全部订单" forState:UIControlStateNormal];
        _btn1.titleLabel.font = QDFont(12);
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_ordersView addSubview:_btn1];
        
        
        _btn2 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn2.imageTitleSpace = 10;
        [_btn2 setTitle:@"待出行" forState:UIControlStateNormal];
        _btn2.titleLabel.font = QDFont(12);
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_ordersView addSubview:_btn2];
        
        _btn3 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn3.imageTitleSpace = 10;
        [_btn3 setTitle:@"待支付" forState:UIControlStateNormal];
        _btn3.titleLabel.font = QDFont(12);
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_ordersView addSubview:_btn3];
        
        _btn4 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn4.imageTitleSpace = 10;
        [_btn4 setTitle:@"退款单" forState:UIControlStateNormal];
        _btn4.titleLabel.font = QDFont(12);
        [_btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_ordersView addSubview:_btn4];
        
        _functionsView = [[UIView alloc] init];
        _functionsView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_functionsView];
        
        _functionsLab = [[UILabel alloc] init];
        _functionsLab.text = @"常用功能";
        _functionsLab.font = QDBoldFont(15);
        [_functionsView addSubview:_functionsLab];
        
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        [_functionsView addSubview:_lineView2];
        
        
        _btn5 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn5.imageTitleSpace = 10;
        [_btn5 setTitle:@"积分账户" forState:UIControlStateNormal];
        _btn5.titleLabel.font = QDFont(12);
        [_btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn5 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_functionsView addSubview:_btn5];
        
        _btn6 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn6.imageTitleSpace = 10;
        [_btn6 setTitle:@"邀请好友" forState:UIControlStateNormal];
        _btn6.titleLabel.font = QDFont(12);
        [_btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn6 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_functionsView addSubview:_btn6];
        
        _btn7 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn7.imageTitleSpace = 10;
        [_btn7 setTitle:@"攻略" forState:UIControlStateNormal];
        _btn7.titleLabel.font = QDFont(12);
        [_btn7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn7 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_functionsView addSubview:_btn7];
        
        _btn8 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn8.imageTitleSpace = 10;
        [_btn8 setTitle:@"收藏" forState:UIControlStateNormal];
        _btn8.titleLabel.font = QDFont(12);
        [_btn8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn8 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_functionsView addSubview:_btn8];
        
        _btn9 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn9.imageTitleSpace = 10;
        [_btn9 setTitle:@"地址" forState:UIControlStateNormal];
        _btn9.titleLabel.font = QDFont(12);
        [_btn9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn9 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_functionsView addSubview:_btn9];
        
        _btn10 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn10.imageTitleSpace = 10;
        [_btn10 setTitle:@"安全中心" forState:UIControlStateNormal];
        _btn10.titleLabel.font = QDFont(12);
        [_btn10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn10 setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [_functionsView addSubview:_btn10];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_ordersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.216);
    }];
    [_myOrdersLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.05);
        make.top.equalTo(self.ordersView.mas_top).offset(SCREEN_HEIGHT*0.022);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.ordersView);
        make.top.equalTo(self.ordersView.mas_top).offset(SCREEN_HEIGHT*0.078);
        make.width.mas_equalTo(SCREEN_WIDTH*0.893);
        make.height.equalTo(@1);
    }];
    
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ordersView);
        make.right.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.25);
        make.centerY.equalTo(self.ordersView.mas_top).offset(SCREEN_HEIGHT*0.15);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.25);
        make.right.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.5);
        make.centerY.equalTo(self.btn1);
    }];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.5);
        make.right.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.75);
        make.centerY.equalTo(self.btn1);
    }];
    [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.ordersView);
        make.left.equalTo(self.ordersView.mas_left).offset(SCREEN_WIDTH*0.75);
        make.centerY.equalTo(self.btn1);
    }];
    
    [_functionsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(self.ordersView.mas_bottom).offset(SCREEN_HEIGHT*0.015);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.32);
    }];
    [_functionsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionsView.mas_left).offset(SCREEN_WIDTH*0.05);
        make.top.equalTo(self.functionsView.mas_top).offset(SCREEN_HEIGHT*0.022);
    }];
    
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.functionsView);
        make.top.equalTo(self.functionsView.mas_top).offset(SCREEN_HEIGHT*0.078);
        make.width.mas_equalTo(SCREEN_WIDTH*0.893);
        make.height.equalTo(@1);
    }];
    
    [_btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionsView);
        make.right.equalTo(self.functionsView.mas_left).offset(SCREEN_WIDTH*0.33);
        make.centerY.equalTo(self.lineView2.mas_bottom).offset(SCREEN_HEIGHT*0.26/4);
    }];
    
    [_btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionsView).offset(SCREEN_WIDTH/3);
        make.centerY.and.width.equalTo(self.btn5);
    }];

    [_btn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.functionsView);
        make.left.equalTo(self.functionsView.mas_left).offset(SCREEN_WIDTH*0.67);
        make.centerY.equalTo(self.btn5);
    }];
    
    [_btn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionsView);
        make.right.equalTo(self.functionsView.mas_left).offset(SCREEN_WIDTH*0.33);
        make.centerY.equalTo(self.functionsView.mas_bottom).offset(-(SCREEN_HEIGHT*0.26/4));
    }];
    
    [_btn9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionsView.mas_left).offset(SCREEN_WIDTH/3);
        make.centerY.and.width.equalTo(self.btn8);
    }];
    
    [_btn10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.functionsView);
        make.left.equalTo(self.functionsView.mas_left).offset(SCREEN_WIDTH/3*2);
        make.centerY.equalTo(self.btn8);
    }];
}


@end
