//
//  QDKeyWordsSearchHeaderView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/27.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDKeyWordsSearchHeaderView.h"

@implementation QDKeyWordsSearchHeaderView

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
        
        _selectDateBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _selectDateBtn.titleLabel.lineBreakMode = 0;
        [_selectDateBtn setTitle:@"住12-11\n离12-12" forState:UIControlStateNormal];
        [_selectDateBtn setImage:[UIImage imageNamed:@"icon_dropMenu"] forState:UIControlStateNormal];
        [_selectDateBtn setTitleColor:APP_GRAYTEXTCOLOR forState:UIControlStateNormal];
        _selectDateBtn.titleLabel.font = QDFont(13);
        [self addSubview:_selectDateBtn];
        
        _searchImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
        [self addSubview:_searchImg];
        
        _toSearchVCBtn = [[UIButton alloc] init];
        _toSearchVCBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_toSearchVCBtn setTitle:@"住12-11 离店12-12" forState:UIControlStateNormal];
        [_toSearchVCBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _toSearchVCBtn.titleLabel.font = QDFont(14);
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
    
    [_selectDateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(_backView);
        make.width.mas_equalTo(SCREEN_WIDTH*0.24);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.03);
    }];
    
    [_searchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView);
        make.left.equalTo(_selectDateBtn.mas_right).offset(6);
    }];
    
    [_toSearchVCBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_backView);
        make.left.equalTo(_searchImg.mas_right).offset(2);
        make.right.equalTo(_backView.mas_right).offset(-(5));
    }];
}

@end
