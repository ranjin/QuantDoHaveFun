//
//  QDMineSectionHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/18.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMineSectionHeaderView.h"

@implementation QDMineSectionHeaderView

- (void)layoutSubviews{
    [super layoutSubviews];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.25);
        make.centerY.equalTo(self);
    }];
    
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.25);
        make.right.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.5);
        make.centerY.equalTo(self.btn1);
    }];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.5);
        make.right.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.75);
        make.centerY.equalTo(self.btn1);
    }];
    [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.75);
        make.centerY.equalTo(self.btn1);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _btn1 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn1.imageTitleSpace = 10;
        _btn1.tag = 0;
        [_btn1 setTitle:@"全部订单" forState:UIControlStateNormal];
        _btn1.titleLabel.font = QDFont(12);
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn1 setImage:[UIImage imageNamed:@"icon_orders"] forState:UIControlStateNormal];
        [self addSubview:_btn1];
        
        
        _btn2 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn2.imageTitleSpace = 10;
        _btn2.tag = 1;
        [_btn2 setTitle:@"待出行" forState:UIControlStateNormal];
        _btn2.titleLabel.font = QDFont(12);
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn2 setImage:[UIImage imageNamed:@"icon_dcx"] forState:UIControlStateNormal];
        [self addSubview:_btn2];
        
        _btn3 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn3.imageTitleSpace = 10;
        _btn3.tag = 2;
        [_btn3 setTitle:@"待支付" forState:UIControlStateNormal];
        _btn3.titleLabel.font = QDFont(12);
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn3 setImage:[UIImage imageNamed:@"icon_dzf"] forState:UIControlStateNormal];
        
        [self addSubview:_btn3];
        
        _btn4 = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionTop];
        _btn4.imageTitleSpace = 10;
        _btn4.tag = 3;
        [_btn4 setTitle:@"退款单" forState:UIControlStateNormal];
        _btn4.titleLabel.font = QDFont(12);
        [_btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btn4 setImage:[UIImage imageNamed:@"icon_tkd"] forState:UIControlStateNormal];
        [self addSubview:_btn4];
    }
    return self;
}

@end
