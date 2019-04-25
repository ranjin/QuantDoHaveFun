//
//  QDHomePageTopView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/17.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHomePageTopView.h"

@implementation QDHomePageTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _addressBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        _addressBtn.imageTitleSpace = SCREEN_WIDTH*0.02;
        [_addressBtn setTitle:@"定位中" forState:UIControlStateNormal];
        [_addressBtn setImage:[UIImage imageNamed:@"icon_selectAddress"] forState:UIControlStateNormal];
        [_addressBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _addressBtn.titleLabel.font = QDBoldFont(20);
        [self addSubview:_addressBtn];
        
        _iconBtn = [[UIButton alloc] init];
        [_iconBtn setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
//        _iconBtn setim image = [UIImage imageNamed:@"icon_map"];
        [self addSubview:_iconBtn];
        
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = [UIColor colorWithHexString:@"#EEF3F6"];
        _topBackView.layer.masksToBounds = YES;
        _topBackView.layer.cornerRadius = 8;
        [self addSubview:_topBackView];
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"icon_search"]];
        [_topBackView addSubview:_imgView];
        
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setTitle:@"搜索关键字" forState:UIControlStateNormal];
        _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_searchBtn setTitleColor:APP_GRAYTEXTCOLOR forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = QDFont(15);
        [_topBackView addSubview:_searchBtn];
        
        _hysgBtn = [[UIButton alloc] init];
        _hysgBtn.tag = 1001;
        [_hysgBtn setImage:[UIImage imageNamed:@"icon_vip"] forState:UIControlStateNormal];
        [self addSubview:_hysgBtn];
        
//
//        _glBtn = [[UIButton alloc] init];
//        _glBtn.tag = 1002;
//        [_glBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_glBtn setImage:[UIImage imageNamed:@"icon_strategy"] forState:UIControlStateNormal];
//        [self addSubview:_glBtn];
        
        _dzyBtn = [[UIButton alloc] init];
        _dzyBtn.tag = 1003;
        [_dzyBtn setImage:[UIImage imageNamed:@"icon_customTour"] forState:UIControlStateNormal];
        [self addSubview:_dzyBtn];
        
        _scBtn = [[UIButton alloc] init];
        _scBtn.tag = 1004;
        [_scBtn setImage:[UIImage imageNamed:@"icon_market"] forState:UIControlStateNormal];
        [self addSubview:_scBtn];
        
        _hysgLab = [[UILabel alloc] init];
        _hysgLab.text = @"会员申购";
        _hysgLab.textColor = APP_BLACKCOLOR;
        _hysgLab.font = QDFont(13);
        [self addSubview:_hysgLab];
//
//        _glLab = [[UILabel alloc] init];
//        _glLab.text = @"目的地攻略";
//        _glLab.textColor = APP_BLACKCOLOR;
//        _glLab.font = QDFont(13);
//        [self addSubview:_glLab];
        
        _dzyLab = [[UILabel alloc] init];
        _dzyLab.text = @"定制游";
        _dzyLab.textColor = APP_BLACKCOLOR;
        _dzyLab.font = QDFont(13);
        [self addSubview:_dzyLab];
        
        _scLab = [[UILabel alloc] init];
        _scLab.text = @"商城";
        _scLab.textColor = APP_BLACKCOLOR;
        _scLab.font = QDFont(13);
        [self addSubview:_scLab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.05);
    }];
    
    [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addressBtn);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.82);
    }];
    
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.12);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackView);
        make.left.equalTo(self.topBackView.mas_left).offset(SCREEN_WIDTH*0.04);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackView);
        make.left.equalTo(self.imgView.mas_right).offset(SCREEN_WIDTH*0.02);
        make.width.mas_equalTo(SCREEN_WIDTH*0.75);
    }];
    
//    [_glBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.width.and.height.equalTo(_hysgBtn);
//        make.left.equalTo(_hysgBtn.mas_right).offset(SCREEN_WIDTH*0.1);
//    }];
//
//    [_glLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_glBtn);
//        make.top.equalTo(_glBtn.mas_bottom);
//    }];
    [_dzyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topBackView);
        make.top.equalTo(self.topBackView.mas_bottom).offset(SCREEN_HEIGHT*0.02);
        make.width.and.height.mas_equalTo(55);

    }];
    
    [_dzyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_dzyBtn);
        make.top.equalTo(_dzyBtn.mas_bottom);
    }];
    
    [_hysgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.and.height.equalTo(_dzyBtn);
        make.right.equalTo(_dzyBtn.mas_left).offset(-60);
    }];

    [_hysgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_hysgBtn);
        make.top.equalTo(_hysgBtn.mas_bottom);
    }];
    
    [_scBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.and.height.equalTo(_dzyBtn);
        make.left.equalTo(_dzyBtn.mas_right).offset(60);
    }];

    [_scLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scBtn);
        make.top.equalTo(_scBtn.mas_bottom);
    }];
    
}
@end
