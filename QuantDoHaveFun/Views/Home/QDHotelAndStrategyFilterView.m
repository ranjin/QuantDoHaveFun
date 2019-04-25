//
//  QDHotelAndStrategyFilterView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/28.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelAndStrategyFilterView.h"

@implementation QDHotelAndStrategyFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.borderColor = APP_GRAYCOLOR.CGColor;
        _backView.layer.borderWidth = 1.0f;
        _backView.layer.cornerRadius = 15;
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];
        
        _searchTF = [[UITextField alloc] init];
        _searchTF.placeholder = @"请输入城市或景点";
        [_searchTF setValue:APP_LIGHTGRAYCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_searchTF setValue:QDFont(16) forKeyPath:@"_placeholderLabel.font"];
        [_backView addSubview:_searchTF];
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setImage:[UIImage imageNamed:@"seach_01"] forState:UIControlStateNormal];
        [_backView addSubview:_searchBtn];
        
        _switchBtn = [[UIButton alloc] init];
        [_switchBtn setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
        [self addSubview:_switchBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.054);
        make.width.mas_equalTo(SCREEN_WIDTH*0.76);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.048);
    }];
    
    [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(self.backView);
        make.left.equalTo(self.backView.mas_left).offset(SCREEN_WIDTH*0.22);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).offset(-(SCREEN_WIDTH*0.045));
    }];
    
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.053));
    }];
}


@end
