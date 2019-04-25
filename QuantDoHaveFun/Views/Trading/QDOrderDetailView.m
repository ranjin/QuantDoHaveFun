//
//  QDOrderDetailView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDOrderDetailView.h"

@implementation QDOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_shadowView];
        
        _operationTypeLab = [[UILabel alloc] init];
        _operationTypeLab.text = @"卖出";
        _operationTypeLab.font = QDFont(13);
        [_shadowView addSubview:_operationTypeLab];
        
        _statusLab = [[UILabel alloc] init];
        _statusLab.text = @"部分成交";
        _statusLab.textColor = APP_BLUECOLOR;
        _statusLab.font = QDFont(13);
        [_shadowView addSubview:_statusLab];
        
        _totalPriceLab = [[UILabel alloc] init];
        _totalPriceLab.text = @"金额(元)";
        _totalPriceLab.textColor = APP_GRAYTEXTCOLOR;
        _totalPriceLab.font = QDFont(12);
        [self addSubview:_totalPriceLab];
        
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.text = @"¥15,000.00";
        _totalPrice.textColor = APP_BLUECOLOR;
        _totalPrice.font = QDBoldFont(15);
        [self addSubview:_totalPrice];
        
        _amountLab = [[UILabel alloc] init];
        _amountLab.text = @"数量1000";
        _amountLab.font = QDFont(12);
        _amountLab.textColor = APP_GRAYTEXTCOLOR;
        [self addSubview:_amountLab];
        
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"价格¥15.00";
        _priceLab.font = QDFont(12);
        _priceLab.textColor = APP_GRAYTEXTCOLOR;
        [self addSubview:_priceLab];
        
        _dealAmountLab = [[UILabel alloc] init];
        _dealAmountLab.text = @"成交(个)";
        _dealAmountLab.textColor = APP_GRAYTEXTCOLOR;
        _dealAmountLab.font = QDFont(12);
        [self addSubview:_dealAmountLab];
        
        _dealAmount = [[UILabel alloc] init];
        _dealAmount.text = @"200";
        _dealAmount.font = QDBoldFont(15);
        _dealAmount.textColor = APP_BLUECOLOR;
        [self addSubview:_dealAmount];
        
        _transferLab = [[UILabel alloc] init];
        _transferLab.text = @"手续费¥100.00";
        _transferLab.font = QDFont(12);
        _transferLab.textColor = APP_GRAYTEXTCOLOR;
        [self addSubview:_transferLab];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = APP_GRAYLINECOLOR;
        _centerLine.alpha = 0.2;
        [self addSubview:_centerLine];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.04);
    }];
    
    [_operationTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_shadowView.mas_left).offset(SCREEN_WIDTH*0.04);
    }];

    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.right.equalTo(_shadowView.mas_right).offset(-(SCREEN_WIDTH*0.04));
    }];

    [_totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadowView.mas_bottom).offset(SCREEN_HEIGHT*0.03);
        make.left.equalTo(_operationTypeLab);
    }];

    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalPriceLab.mas_bottom).offset(SCREEN_HEIGHT*0.015);
        make.left.equalTo(_operationTypeLab);
    }];

    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalPrice.mas_bottom).offset(SCREEN_HEIGHT*0.015);
        make.left.equalTo(_operationTypeLab);
    }];

    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_amountLab);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.19);
    }];

    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_shadowView.mas_bottom).offset(SCREEN_HEIGHT*0.03);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.07);
    }];

    [_dealAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_totalPriceLab);
        make.left.equalTo(_centerLine.mas_left).offset(SCREEN_WIDTH*0.04);
    }];

    [_dealAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_totalPrice);
        make.left.equalTo(_dealAmountLab);
    }];

    [_transferLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_amountLab);
        make.left.equalTo(_dealAmount.mas_left);
    }];
}

@end
