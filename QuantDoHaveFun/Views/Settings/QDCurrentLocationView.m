//
//  QDCurrentLocationView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDCurrentLocationView.h"

@implementation QDCurrentLocationView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _locationImg = [[UIImageView alloc] init];
        [_locationImg setImage:[UIImage imageNamed:@"icon_grayLocate"]];
        [self addSubview:_locationImg];
        
        _myLocationLab = [[UILabel alloc] init];
        _myLocationLab.text = @"我的位置";
        _myLocationLab.font = QDFont(17);
        [self addSubview:_myLocationLab];
        
        _detailLocationLab = [[UILabel alloc] init];
        _detailLocationLab.text = @"定位中...";
        _detailLocationLab.textColor = [UIColor grayColor];
        _detailLocationLab.font = QDFont(15);
        [self addSubview:_detailLocationLab];
        
        _cityLab = [[UILabel alloc] init];
        _cityLab.backgroundColor = [UIColor colorWithHexString:@"#EAF0F3"];
        _cityLab.layer.cornerRadius = 3;
        _cityLab.layer.masksToBounds = YES;
        _cityLab.text = @"--";
        _cityLab.font = QDFont(14);
        _cityLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cityLab];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.03);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
    }];
    
    [_myLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationImg.mas_right).offset(SCREEN_WIDTH*0.027);
        make.top.equalTo(self);
    }];
    
    [_detailLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myLocationLab.mas_bottom).offset(SCREEN_HEIGHT*0.004);
        make.left.equalTo(self.myLocationLab);
    }];
    
    [_cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.myLocationLab);
        make.top.equalTo(self.detailLocationLab.mas_bottom).offset(SCREEN_HEIGHT*0.02);
        make.width.mas_equalTo(SCREEN_WIDTH*0.15);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.04);
    }];
}

@end
