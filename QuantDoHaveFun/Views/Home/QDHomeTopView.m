//
//  QDHomeTopView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/18.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHomeTopView.h"

@implementation QDHomeTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_returnBtn];
        
        _goWhereLab = [[UILabel alloc] init];
        _goWhereLab.text = @"您想去哪里?";
        _goWhereLab.textColor = [UIColor whiteColor];
        _goWhereLab.font = QDFont(25);
        [self addSubview:_goWhereLab];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"想呼吸着每座城市的空气，想感受着每座城市的人儿,\n想看着每座城市的风景。";
        _infoLab.numberOfLines = 0;
        _infoLab.textColor = [UIColor whiteColor];
        _infoLab.font = QDFont(13);
        [self addSubview:_infoLab];
        
        _searchBar = [[UISearchBar alloc] init];
        [_searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.placeholder = @"我的目的地";
        [[[[_searchBar.subviews objectAtIndex:0]subviews]objectAtIndex:0] removeFromSuperview];
//        _searchBar.showsCancelButton = YES;
//        [[[_searchBar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:[UIColor greenColor]];
        [self addSubview:_searchBar];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.07);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
    }];

    [_goWhereLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.returnBtn);
        make.left.equalTo(self.returnBtn.mas_right).offset(SCREEN_WIDTH*0.037);
    }];

    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.goWhereLab.mas_bottom).offset(SCREEN_HEIGHT*0.01);
    }];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.infoLab.mas_bottom).offset(SCREEN_HEIGHT*0.04);
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.073);
    }];
}


@end
