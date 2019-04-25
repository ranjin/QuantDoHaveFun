//
//  IdentifyView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "IdentifyView.h"

@implementation IdentifyView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _identifyLab = [[UILabel alloc] init];
        _identifyLab.text = @"验证身份，请输入图中验证码";
        _identifyLab.font = QDFont(22);
        [self addSubview:_identifyLab];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_lineView];
        
        NSArray *randomArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        _pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.234, SCREEN_HEIGHT*0.3, SCREEN_WIDTH*0.53, SCREEN_HEIGHT*0.067) andChangeArray:randomArr];
        [self addSubview:_pooCodeView];
        
        _refreshBtn = [[UIButton alloc] init];
        [_refreshBtn setTitle:@"看不清? 点击刷新" forState:UIControlStateNormal];
        [_refreshBtn addTarget:self action:@selector(refreshVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
        [_refreshBtn setTitleColor:[UIColor colorWithHexString:@"CCCCCC"] forState:UIControlStateNormal];
        _refreshBtn.titleLabel.font = QDFont(13);
        [self addSubview:_refreshBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_identifyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.156);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.identifyLab);
        make.top.equalTo(self.identifyLab.mas_bottom).offset(SCREEN_HEIGHT*0.012);
        make.width.mas_equalTo(SCREEN_WIDTH*0.097);
        make.height.mas_equalTo(SCREEN_WIDTH*0.01);
    }];

    [_pooCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineView.mas_bottom).offset(SCREEN_HEIGHT*0.06);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.067);
        make.width.mas_equalTo(SCREEN_WIDTH*0.53);
    }];

    [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.pooCodeView);
        make.top.equalTo(self.pooCodeView.mas_bottom).offset(SCREEN_HEIGHT*0.022);
    }];
}

- (void)refreshVerifyCode:(UIButton *)sender{
    [_pooCodeView changeCode];
}
@end
