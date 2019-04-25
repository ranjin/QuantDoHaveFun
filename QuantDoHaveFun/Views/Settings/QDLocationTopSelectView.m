//
//  QDLocationTopSelectView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDLocationTopSelectView.h"

@implementation QDLocationTopSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = [UIColor colorWithHexString:@"#EEF3F6"];
        _topBackView.layer.masksToBounds = YES;
        _topBackView.layer.cornerRadius = SCREEN_WIDTH*0.04;
        [self addSubview:_topBackView];
        
        _imgView = [[UIImageView alloc] init];
        [_imgView setImage:[UIImage imageNamed:@"icon_search"]];
        [_topBackView addSubview:_imgView];
        
        
        _inputTF = [[UITextField alloc] init];
        _inputTF.placeholder = @"城市/区域/位置";
        [_inputTF setValue:APP_LIGHTGRAYCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        [_inputTF setValue:QDFont(14) forKeyPath:@"_placeholderLabel.font"];
        _inputTF.font = QDFont(14);
        _inputTF.textColor = APP_BLACKCOLOR;
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_topBackView addSubview:_inputTF];

        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = QDFont(16);
        [self addSubview:_cancelBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.04);
        make.width.mas_equalTo(SCREEN_WIDTH*0.8);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.05);
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
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.02));
        make.centerY.equalTo(self);
    }];
}
@end
