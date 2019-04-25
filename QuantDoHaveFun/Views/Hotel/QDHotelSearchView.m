//
//  QDHotelSearchView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/17.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelSearchView.h"

@implementation QDHotelSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_LIGHTGRAYCOLOR;
        [self addSubview:_lineView];
        
        _locateBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        [_locateBtn setImage:[UIImage imageNamed:@"ad_collection_black"] forState:UIControlStateNormal];
        [_locateBtn setTitle:@"我的位置" forState:UIControlStateNormal];
        [_locateBtn setTitleColor:APP_GRAYCOLOR forState:UIControlStateNormal];
        _locateBtn.titleLabel.font = QDFont(11);
        _locateBtn.imageTitleSpace = SCREEN_WIDTH*0.012;
        [self addSubview:_locateBtn];
        
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = APP_LIGHTGRAYCOLOR;
        [self addSubview:_verticalLine];
        
        _locationLab = [[UILabel alloc] init];
        _locationLab.text = @"上海";
        _locationLab.font = QDFont(15);
        [self addSubview:_locationLab];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = APP_LIGHTGRAYCOLOR;
        [self addSubview:_centerLine];
        
        _inLab = [[UILabel alloc] init];
        _inLab.text = @"入住";
        _inLab.textColor = APP_GRAYCOLOR;
        _inLab.font = QDFont(12);
        [self addSubview:_inLab];
        
        _outLab = [[UILabel alloc] init];
        _outLab.text = @"离店";
        _outLab.textColor = APP_GRAYCOLOR;
        _outLab.font = QDFont(12);
        [self addSubview:_outLab];
        
        _dateIn = [[UIButton alloc] init];
        [_dateIn setTitle:@"11月29日 周四" forState:UIControlStateNormal];
        [_dateIn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _dateIn.titleLabel.font = QDBoldFont(15);
        [self addSubview:_dateIn];
        
        _dateOut = [[UIButton alloc] init];
        [_dateOut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dateOut setTitle:@"11月30日 周五" forState:UIControlStateNormal];
        [_dateOut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _dateOut.titleLabel.font = QDBoldFont(15);
        [self addSubview:_dateOut];
        
        _greenLine = [[UIView alloc] init];
        _greenLine.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_greenLine];
        
        _totalDayLab = [[UILabel alloc] init];
        _totalDayLab.textColor = APP_BLUECOLOR;
        _totalDayLab.font = QDFont(15);
        _totalDayLab.text = @"1晚";
        [self addSubview:_totalDayLab];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = APP_LIGHTGRAYCOLOR;
        [self addSubview:_centerLine];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = APP_LIGHTGRAYCOLOR;
        [self addSubview:_bottomLine];
        
        _locationTF = [[UITextField alloc] init];
        _locationTF.placeholder = @"关键词／酒店名／地标";
        [_locationTF setValue:APP_LIGHTGRAYCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_locationTF setValue:QDFont(15) forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_locationTF];
        
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.backgroundColor = [UIColor whiteColor];
        [_searchBtn setTitle:@"开始搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        _searchBtn.layer.borderWidth = 1;
        _searchBtn.layer.borderColor = APP_BLUECOLOR.CGColor;
        _searchBtn.layer.cornerRadius = SCREEN_WIDTH*0.06;
        _searchBtn.layer.masksToBounds = YES;
        [self addSubview:_searchBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //线1
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(SCREEN_HEIGHT*0.078);
        make.width.mas_equalTo(SCREEN_WIDTH*0.79);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.003);
    }];
    
    [_locateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.03);
    }];
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(self.locateBtn);
        make.width.mas_equalTo(SCREEN_WIDTH*0.006);
        make.right.equalTo(self.locateBtn.mas_left).offset(-(SCREEN_WIDTH*0.021));
    }];
    
    [_locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.verticalLine);
        make.left.equalTo(self.lineView);
    }];
    
    //线2
    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.and.width.equalTo(self.lineView);
        make.top.equalTo(self.lineView.mas_bottom).offset(SCREEN_HEIGHT*0.11);
    }];
    
    [_inLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView);
        make.top.equalTo(self.lineView.mas_bottom).offset(SCREEN_HEIGHT*0.022);
    }];
    
    [_outLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inLab);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.27));
    }];
    
    [_dateIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineView);
        make.top.equalTo(self.lineView.mas_bottom).offset(SCREEN_HEIGHT*0.06);
    }];

    
    [_dateOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.dateIn);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
    
    [_greenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.16);
        make.width.mas_equalTo(SCREEN_WIDTH*0.1);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.003);
    }];

    [_totalDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.greenLine);
        make.bottom.equalTo(self.greenLine.mas_top).offset(-(SCREEN_HEIGHT*0.006));
    }];

    //线3
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.and.height.equalTo(self.centerLine);
        make.top.equalTo(self.centerLine.mas_bottom).offset(SCREEN_HEIGHT*0.075);
    }];

    [_locationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateIn);
        make.bottom.equalTo(self.bottomLine.mas_top).offset(-(SCREEN_HEIGHT*0.02));
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH*0.79);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.066);
        make.centerX.equalTo(self);
        make.top.equalTo(self.bottomLine.mas_bottom).offset(SCREEN_HEIGHT*0.02);
    }];
}
@end
