//
//  QDHotelHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/17.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelHeaderView.h"

@implementation QDHotelHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _backImgView = [[UIView alloc] init];
        _backImgView.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_backImgView];
        
        _hotelLab = [[UILabel alloc] init];
        _hotelLab.text = @"酒店预定";
        _hotelLab.textColor = [UIColor whiteColor];
        _hotelLab.font = QDFont(31);
        [self addSubview:_hotelLab];
        
        _searchView = [[QDHotelSearchView alloc] init];
        _searchView.backgroundColor = [UIColor whiteColor];
        [self addShadowToView:_searchView withColor:APP_LIGHTGRAYCOLOR];
        [self addSubview:_searchView];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.34);
    }];
    
    [_hotelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.08);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.053);
    }];
    
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.18);
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.382);
    }];
}

- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,5);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.4;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 1;
    
}
@end
