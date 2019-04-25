//
//  RankFirstHeadView.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/18.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "RankFirstHeadView.h"

@implementation RankFirstHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _thePic = [[UIImageView alloc] init];
        _thePic.image = [UIImage imageNamed:@"home_star"];
        [self addSubview:_thePic];
        
        _title = [[UILabel alloc] init];
        _title.text = @"当红精选";
        _title.textColor = APP_BLACKCOLOR;
        _title.font = QDBoldFont(20);
        [self addSubview:_title];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_thePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(9);
        make.width.and.height.mas_equalTo(20);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_thePic);
        make.left.equalTo(_thePic.mas_right).offset(9);
    }];
}

@end
