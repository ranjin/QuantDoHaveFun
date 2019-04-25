//
//  QDHomeTopCancelView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/23.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHomeTopCancelView.h"

@implementation QDHomeTopCancelView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.1)];
        _backView.backgroundColor = APP_WHITECOLOR;
        [self addSubview:_backView];
        
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = [UIColor colorWithHexString:@"#EEF3F6"];
        _topBackView.layer.masksToBounds = YES;
        _topBackView.layer.cornerRadius = SCREEN_WIDTH*0.04;
        [_backView addSubview:_topBackView];
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"icon_search"]];
        [_topBackView addSubview:_imgView];
        
        
        _inputTF = [[UITextField alloc] init];
        _inputTF.placeholder = @"搜索关键字";
        _inputTF.tintColor = APP_BLUECOLOR;
        [_inputTF setValue:QDFont(14) forKeyPath:@"_placeholderLabel.font"];
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_topBackView addSubview:_inputTF];
        
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@"icon_closeSearch"] forState:UIControlStateNormal];
        [_backView addSubview:_cancelBtn];
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setImage:[UIImage imageNamed:@"icon_goSearch"] forState:UIControlStateNormal];
        [_backView addSubview:_searchBtn];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.15);
        make.right.equalTo(_backView.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.top.equalTo(_backView.mas_top).offset(SCREEN_HEIGHT*0.04);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.05);
    }];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackView);
        make.left.equalTo(self.topBackView.mas_left).offset(SCREEN_WIDTH*0.04);
    }];
    
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topBackView);
        make.left.equalTo(self.imgView.mas_right).offset(SCREEN_WIDTH*0.02);
        make.width.mas_equalTo(SCREEN_WIDTH*0.6);
    }];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topBackView);
        make.right.equalTo(_topBackView.mas_left).offset(-(SCREEN_WIDTH*0.04));
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topBackView);
        make.right.equalTo(_topBackView.mas_right).offset(-(SCREEN_WIDTH*0.04));
    }];
    
    
//    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.and.width.equalTo(_backView);
//        make.top.equalTo(_backView.mas_bottom);
//        make.height.mas_equalTo(1);
//    }];
    
    
    
}
@end
