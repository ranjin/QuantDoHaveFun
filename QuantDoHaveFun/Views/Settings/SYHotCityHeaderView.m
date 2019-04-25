//
//  SYHotCityHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "SYHotCityHeaderView.h"

@implementation SYHotCityHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F9FAFC"];
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = APP_BLUECOLOR;
    [self.contentView addSubview:_lineView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.text = @"热门城市";
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.053);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.024);
        make.width.mas_equalTo(SCREEN_WIDTH*0.006);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.lineView.mas_right).offset(SCREEN_WIDTH*0.05);
    }];
}

@end
