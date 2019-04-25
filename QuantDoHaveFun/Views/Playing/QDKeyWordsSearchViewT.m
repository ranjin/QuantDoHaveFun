//
//  QDKeyWordsSearchViewT.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/28.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDKeyWordsSearchViewT.h"

@implementation QDKeyWordsSearchViewT

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_returnBtn];
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
        _backView.layer.cornerRadius = 18;
        _backView.layer.masksToBounds = YES;
        [self addSubview:_backView];
        
        _searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
        [_backView addSubview:_searchImg];
        
        _toSearchVCBtn = [[UIButton alloc] init];
        _toSearchVCBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_toSearchVCBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _toSearchVCBtn.titleLabel.font = QDFont(16);
        _toSearchVCBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_toSearchVCBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_returnBtn);
        make.left.equalTo(_returnBtn.mas_right).offset(12);
        make.width.mas_equalTo(SCREEN_WIDTH*0.84);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
    
    [_searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView);
        make.left.equalTo(_backView.mas_left).offset(18);
    }];
    
    [_toSearchVCBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView);
        make.left.equalTo(_searchImg.mas_right).offset(2);
        make.right.equalTo(_backView.mas_right).offset(-(5));
    }];
}
@end
