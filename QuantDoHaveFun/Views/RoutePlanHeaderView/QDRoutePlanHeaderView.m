//
//  QDRoutePlanHeaderView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/1.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDRoutePlanHeaderView.h"

@implementation QDRoutePlanHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"上海东方滨江大酒店";
        _titleLab.font = QDBoldFont(17);
        _titleLab.textColor = APP_BLACKCOLOR;
        [self addSubview:_titleLab];
        
        _distanceLab = [[UILabel alloc] init];
        _distanceLab.text = @"距离1.6km";
        _distanceLab.font = QDFont(13);
        _distanceLab.textColor = APP_GRAYCOLOR;
        [self addSubview:_distanceLab];
        
        _info1 = [[UILabel alloc] init];
        _info1.text = @"320";
        _info1.font = QDBoldFont(17);
        _info1.textColor = APP_ORANGETEXTCOLOR;
        [self addSubview:_info1];
        
        _info2 = [[UILabel alloc] init];
        _info2.text = @"玩贝";
        _info2.font = QDFont(12);
        _info2.textColor = APP_ORANGETEXTCOLOR;
        [self addSubview:_info2];
        
        _info3 = [[UILabel alloc] init];
        _info3.text = @"约";
        _info3.font = QDFont(12);
        _info3.textColor = APP_GRAYLINECOLOR;
        [self addSubview:_info3];
        
        _info4 = [[UILabel alloc] init];
        _info4.text = @"¥310.02";
        _info4.font = QDFont(12);
        _info4.textColor = APP_BLACKCOLOR;
        [self addSubview:_info4];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#DDDDDD"];
        _lineView.alpha = 0.3;
        [self addSubview:_lineView];
        
        _addressPic = [[UIImageView alloc] init];
        [self addSubview:_addressPic];
        
        _distanceLab = [[UILabel alloc] init];
        _distanceLab.text = @"距离1.6km";
        _distanceLab.font = QDFont(13);
        _distanceLab.textColor = APP_GRAYCOLOR;
        [self addSubview:_distanceLab];
        
        _addressPic = [[UIImageView alloc] init];
        _addressPic.image = [UIImage imageNamed:@"icon_hotelAddress"];
        [self addSubview:_addressPic];
        
        _addressStr = [[UILabel alloc] init];
        _addressStr.textColor = APP_GRAYLINECOLOR;
        _addressStr.numberOfLines = 0;
        _addressStr.text = @"上海市浦东新区滨江大道2727号";
        _addressStr.font = QDFont(12);
        [self addSubview:_addressStr];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_WIDTH*0.05);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
    }];

    [_distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(SCREEN_HEIGHT*0.015);
        make.left.equalTo(_titleLab);
    }];
    
    [_info1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.13);
        make.left.equalTo(_titleLab);
    }];
    
    [_info2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info1);
        make.left.equalTo(_info1.mas_right);
    }];
    
    [_info3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info1);
        make.left.equalTo(_info2.mas_right).offset(SCREEN_WIDTH*0.03);
    }];
    
    [_info4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_info1);
        make.left.equalTo(_info3.mas_right);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.18);
        make.width.mas_equalTo(SCREEN_WIDTH*0.84);
        make.height.mas_equalTo(1);
    }];
    
    [_addressPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info1);
        make.top.equalTo(_lineView.mas_bottom).offset(SCREEN_HEIGHT*0.02);
    }];
    
    [_addressStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addressPic);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.1);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.02));
    }];
}


@end
