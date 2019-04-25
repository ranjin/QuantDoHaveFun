//
//  QDMallTopView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMallTopView.h"

@implementation QDMallTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.borderColor = APP_GRAYCOLOR.CGColor;
        _backView.layer.borderWidth = 1.0f;
        [self addSubview:_backView];
        
        _searchTF = [[UITextField alloc] init];
        _searchTF.placeholder = @"商品/关键字搜索";
        [_searchTF setValue:APP_LIGHTGRAYCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_searchTF setValue:QDFont(16) forKeyPath:@"_placeholderLabel.font"];
        [_backView addSubview:_searchTF];
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [_backView addSubview:_searchBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.04);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.054);
        make.width.mas_equalTo(SCREEN_WIDTH*0.76);
    }];
    
    [_searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(self.backView);
        make.left.equalTo(self.backView.mas_left).offset(SCREEN_WIDTH*0.22);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).offset(-(SCREEN_WIDTH*0.045));
    }];
}

@end
