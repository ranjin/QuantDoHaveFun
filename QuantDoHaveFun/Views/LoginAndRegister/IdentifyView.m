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
        _identifyLab.text = @"请输入图中验证码";
        _identifyLab.font = QDFont(25);
        [self addSubview:_identifyLab];
        
        NSArray *randomArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        _pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.234, SCREEN_HEIGHT*0.3, SCREEN_WIDTH*0.53, SCREEN_HEIGHT*0.067) andChangeArray:randomArr];
        [self addSubview:_pooCodeView];
        
        _refreshBtn = [[UIButton alloc] init];
        [_refreshBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
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
        make.left.equalTo(self.mas_left).offset(19);
        make.top.equalTo(self.mas_top).offset(106+SafeAreaTopHeight-64);
    }];
    

    [_pooCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_identifyLab);
        make.top.equalTo(self.identifyLab.mas_bottom).offset(34);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.067);
        make.width.mas_equalTo(SCREEN_WIDTH*0.53);
    }];

    [_refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pooCodeView);
        make.left.equalTo(self.pooCodeView.mas_right).offset(21);
    }];
}

- (void)refreshVerifyCode:(UIButton *)sender{
    [_pooCodeView changeCode];
}
@end
