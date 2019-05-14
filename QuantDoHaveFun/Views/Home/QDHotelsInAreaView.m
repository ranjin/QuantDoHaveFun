//
//  QDHotelsInAreaView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/25.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelsInAreaView.h"

@implementation QDHotelsInAreaView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_backBtn];
        
        _cityBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        [_cityBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_cityBtn];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.05);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.042);
    }];
    
    [_cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backBtn);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.042));
    }];
}

@end
