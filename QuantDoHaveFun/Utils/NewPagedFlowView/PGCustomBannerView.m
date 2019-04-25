//
//  PGCustomBannerView.m
//  NewPagedFlowViewDemo
//
//  Created by Guo on 2017/8/24.
//  Copyright © 2017年 robertcell.net. All rights reserved.
//

#import "PGCustomBannerView.h"

@interface PGCustomBannerView ()

@end

@implementation PGCustomBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.cardNameLab];
        [self addSubview:self.cardMoneyLab];
        [self addSubview:self.cardMoney];

    }
    
    return self;
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {

    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = superViewBounds;
    [self.cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.16);
    }];
    
    [self.cardMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-(SCREEN_HEIGHT*0.1));
    }];
    
    [self.cardMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cardMoney);
        make.right.equalTo(self.cardMoney.mas_left).offset(-2);
    }];
}

- (UILabel *)indexLabel {
    if (_indexLabel == nil) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _indexLabel.font = [UIFont systemFontOfSize:16.0];
        _indexLabel.textColor = [UIColor whiteColor];
    }
    return _indexLabel;
}

- (UILabel *)cardNameLab {
    if (!_cardNameLab) {
        _cardNameLab = [[UILabel alloc] init];
        _cardNameLab.text = @"钻石玩卡";
        _cardNameLab.font = QDFont(23);
        _cardNameLab.textColor = APP_BLACKCOLOR;
    }
    return _cardNameLab;
}

- (UILabel *)cardMoney {
    if (_cardMoney == nil) {
        _cardMoney = [[UILabel alloc] init];
        _cardMoney.text = @"";
        _cardMoney.font = QDBoldFont(24);
        _cardMoney.textColor = APP_BLACKCOLOR;
    }
    return _cardMoney;
}

- (UILabel *)cardMoneyLab {
    if (_cardMoneyLab == nil) {
        _cardMoneyLab = [[UILabel alloc] init];
        _cardMoneyLab.text = @"¥";
        _cardMoneyLab.font = QDBoldFont(18);
        _cardMoneyLab.textColor = APP_BLACKCOLOR;
    }
    return _cardMoneyLab;
}

- (void)loadDataWithModel:(VipCardDTO *)cardModel{
    if ([cardModel.vipMoney doubleValue] == 0) {
        _cardMoneyLab.hidden = YES;
        _cardMoney.text = @"设置金额";
        _cardMoney.font = QDFont(24);
    }else{
        _cardMoneyLab.hidden = NO;
        _cardMoney.text = cardModel.vipMoney;
        _cardMoney.font = QDBoldFont(24);
    }
    _cardNameLab.text = cardModel.vipTypeName;
}
@end
