//
//  QDHotelTableFooterView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/24.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelTableFooterView.h"

@implementation QDHotelTableFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _resetBtn = [[UIButton alloc] init];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _resetBtn.backgroundColor = [UIColor whiteColor];
        _resetBtn.titleLabel.font = QDFont(19);
        [self addSubview:_resetBtn];
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = APP_BLUECOLOR;
        _confirmBtn.titleLabel.font = QDFont(19);
        [self addSubview:_confirmBtn];
    }
    return self;
}


- (void)layoutSubview{
    [super layoutSubviews];
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.and.left.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH*0.5);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.and.right.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH*0.5);
    }];
}
@end
