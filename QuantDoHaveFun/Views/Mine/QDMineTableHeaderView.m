//
//  QDMineTableHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMineTableHeaderView.h"

@implementation QDMineTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor colorWithHexString:@"#88D013"];
        [self addSubview:_imgView];
        
        _settingBtn = [[UIButton alloc] init];
        [_settingBtn setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [self addSubview:_settingBtn];
        
        _voiceBtn = [[UIButton alloc] init];
        [_voiceBtn setImage:[UIImage imageNamed:@"icon_tabbar_homepage"] forState:UIControlStateNormal];
        [self addSubview:_voiceBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.and.width.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.26);
    }];
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.06);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.16));
    }];
    
    [_voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.settingBtn);
        make.right.equalTo(self.mas_right).offset(SCREEN_WIDTH*0.06);
    }];
}


@end
