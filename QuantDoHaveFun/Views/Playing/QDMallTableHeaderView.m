//
//  QDMallTableHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMallTableHeaderView.h"

@implementation QDMallTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = APP_GRAYBUTTONCOLOR;
        _topBackView.layer.masksToBounds = YES;
        _topBackView.layer.cornerRadius = 18;
        [self addSubview:_topBackView];
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"icon_search"]];
        [_topBackView addSubview:_imgView];
        
        _inputTF = [[UITextField alloc] init];
        _inputTF.placeholder = @"搜索关键字";
        [_inputTF setValue:APP_GRAYTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_inputTF setValue:QDFont(15) forKeyPath:@"_placeholderLabel.font"];
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_topBackView addSubview:_inputTF];
        
        _carBtn = [[UIButton alloc] init];
        [_carBtn setImage:[UIImage imageNamed:@"icon_shopCar"] forState:UIControlStateNormal];
        _carBtn.backgroundColor = [UIColor colorWithHexString:@"#EFEFF4"];
        _carBtn.layer.cornerRadius = 18;
        _carBtn.layer.masksToBounds = YES;
        [self addSubview:_carBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
        make.width.mas_equalTo(275);
        make.height.mas_equalTo(36);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackView);
        make.left.equalTo(self.topBackView.mas_left).offset(SCREEN_WIDTH*0.04);
    }];
    
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackView);
        make.left.equalTo(self.imgView.mas_right).offset(SCREEN_WIDTH*0.02);
        make.right.equalTo(self.topBackView);
    }];
    
    [_carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(36);
    }];
}

@end
