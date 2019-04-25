//
//  QDShareView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/6.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDShareView.h"

@implementation QDShareView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = APP_BLACKCOLOR;
        [self addSubview:_leftLine];
        
        _shareText = [[UILabel alloc] init];
        _shareText.text = @"分享到";
        _shareText.textColor = APP_BLACKCOLOR;
        _shareText.font = QDFont(14);
        [self addSubview:_shareText];
        
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = APP_BLACKCOLOR;
        [self addSubview:_rightLine];
        
        _weiboBtn = [[UIButton alloc] init];
        [_weiboBtn setImage:[UIImage imageNamed:@"icon_weibo"] forState:UIControlStateNormal];
        _weiboBtn.tag = 1001;
        [self addSubview:_weiboBtn];
        
        _weiboLab = [[UILabel alloc] init];

        _weiboLab.textColor = APP_BLACKCOLOR;
        _weiboLab.font = QDFont(12);
        _weiboLab.text = @"新浪微博";
        [self addSubview:_weiboLab];
        
        _weixinBtn = [[UIButton alloc] init];
        [_weixinBtn setImage:[UIImage imageNamed:@"icon_weixin"] forState:UIControlStateNormal];
        _weixinBtn.tag = 1003;
        [self addSubview:_weixinBtn];
        
        _weixinLab = [[UILabel alloc] init];
        _weixinLab.font = QDFont(12);
        _weixinLab.text = @"微信";
        [self addSubview:_weixinLab];
        
        _pyqBtn = [[UIButton alloc] init];
        [_pyqBtn setImage:[UIImage imageNamed:@"icon_weixinzone"] forState:UIControlStateNormal];
        _pyqBtn.tag = 1002;
        [self addSubview:_pyqBtn];
        
        _pyqLab = [[UILabel alloc] init];
        _pyqLab.text = @"朋友圈";
        _pyqLab.font = QDFont(12);
        [self addSubview:_pyqLab];
        
        _qqBtn = [[UIButton alloc] init];
        [_qqBtn setImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
        _qqQBtn.tag = 1005;
        [self addSubview:_qqBtn];
        
        _qqLab = [[UILabel alloc] init];
        _qqLab.text = @"QQ";
        _qqLab.font = QDFont(12);
        [self addSubview:_qqLab];
        
        _qqQBtn = [[UIButton alloc] init];
        [_qqQBtn setImage:[UIImage imageNamed:@"icon_qqzone"] forState:UIControlStateNormal];
        _qqQBtn.tag = 1004;
        [self addSubview:_qqQBtn];
        
        _qqQLab = [[UILabel alloc] init];
        _qqQLab.text = @"QQ空间";
        _qqQLab.font = QDFont(12);
        [self addSubview:_qqQLab];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = APP_LIGHTGRAYCOLOR;
        [self addSubview:_bottomLine];
        
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = QDFont(14);
        [self addSubview:_cancelBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_shareText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.02);
    }];
    
    [_leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shareText);
        make.right.equalTo(_shareText.mas_left).offset(-8);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(1);
    }];
    
    [_rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shareText);
        make.width.and.height.equalTo(_leftLine);
        make.left.equalTo(_shareText.mas_right).offset(8);
    }];
    
    [_pyqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_shareText);
        make.top.equalTo(_shareText.mas_bottom).offset(SCREEN_HEIGHT*0.01);
    }];

    [_pyqLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_pyqBtn);
        make.top.equalTo(_pyqBtn.mas_bottom).offset(5);
    }];
    
    [_weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pyqBtn);
        make.right.equalTo(_pyqBtn.mas_left).offset(-(SCREEN_WIDTH*0.2));
    }];
    
    [_weiboLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_weiboBtn);
        make.centerY.equalTo(_pyqLab);
    }];
    
    [_weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pyqBtn);
        make.left.equalTo(_pyqBtn.mas_right).offset(SCREEN_WIDTH*0.2);
    }];
    
    [_weixinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_weixinBtn);
        make.centerY.equalTo(_pyqLab);
    }];
    
    [_weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_pyqBtn);
        make.left.equalTo(_pyqBtn.mas_right).offset(SCREEN_WIDTH*0.2);
    }];
    
    [_qqQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_weiboBtn);
        make.top.equalTo(_weiboBtn.mas_bottom).offset(SCREEN_HEIGHT*0.07);
    }];
    
    [_qqQLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_qqQBtn);
        make.top.equalTo(_qqQBtn.mas_bottom).offset(5);
    }];
    
    [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_pyqBtn);
        make.centerY.equalTo(_qqQBtn);
    }];

    [_qqLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_qqBtn);
        make.centerY.equalTo(_qqQLab);
    }];

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_qqLab);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.top.equalTo(_qqLab.mas_bottom).offset(SCREEN_HEIGHT*0.02);
        make.height.mas_equalTo(1);
    }];

    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomLine);
        make.top.equalTo(_bottomLine.mas_bottom).offset(SCREEN_WIDTH*0.02);
        make.width.mas_equalTo(SCREEN_WIDTH*0.5);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.07);
    }];
}
@end
