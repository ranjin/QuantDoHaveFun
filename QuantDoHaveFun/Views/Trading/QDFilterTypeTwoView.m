//
//  QDFilterTypeTwoView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDFilterTypeTwoView.h"

@implementation QDFilterTypeTwoView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _buyBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        _buyBtn.imageTitleSpace = 11;
        [_buyBtn setTitle:@"买入" forState:UIControlStateNormal];
        [_buyBtn setImage:[UIImage imageNamed:@"direction_normal"] forState:UIControlStateNormal];
        [_buyBtn setImage:[UIImage imageNamed:@"direction_selected"] forState:UIControlStateSelected];
        [_buyBtn addTarget:self action:@selector(directionAction:) forControlEvents:UIControlEventTouchUpInside];
        _buyBtn.tag = 206;
        _buyBtn.titleLabel.font = QDFont(14);
        [_buyBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        [self addSubview:_buyBtn];
        
        
        _sellBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        _sellBtn.imageTitleSpace = 11;
        [_sellBtn setImage:[UIImage imageNamed:@"direction_normal"] forState:UIControlStateNormal];
        [_sellBtn setImage:[UIImage imageNamed:@"direction_selected"] forState:UIControlStateSelected];
        [_sellBtn setTitle:@"卖掉" forState:UIControlStateNormal];
        [_sellBtn addTarget:self action:@selector(directionAction:) forControlEvents:UIControlEventTouchUpInside];
        _sellBtn.tag = 207;
        _sellBtn.titleLabel.font = QDFont(14);
        [_sellBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        [self addSubview:_sellBtn];
        
        _wcjBtn = [[UIButton alloc] init];
        _wcjBtn.backgroundColor = [UIColor whiteColor];
        [_wcjBtn setTitle:@"未成交" forState:UIControlStateNormal];
        _wcjBtn.tag = 201;
        [_wcjBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _wcjBtn.titleLabel.font = QDFont(13);
        [_wcjBtn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
        _wcjBtn.layer.borderWidth = 1;
        _wcjBtn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
        _wcjBtn.layer.cornerRadius = 2;
        _wcjBtn.layer.masksToBounds = YES;
        [self addSubview:_wcjBtn];
        
        _bfcjBtn = [[UIButton alloc] init];
        _bfcjBtn.backgroundColor = [UIColor whiteColor];
        [_bfcjBtn setTitle:@"部分成交" forState:UIControlStateNormal];
        _bfcjBtn.tag = 202;
        [_bfcjBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _bfcjBtn.titleLabel.font = QDFont(13);
        [_bfcjBtn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
        _bfcjBtn.layer.borderWidth = 1;
        _bfcjBtn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
        _bfcjBtn.layer.cornerRadius = 2;
        _bfcjBtn.layer.masksToBounds = YES;
        [self addSubview:_bfcjBtn];
        
        _qbcjBtn = [[UIButton alloc] init];
        _qbcjBtn.backgroundColor = [UIColor whiteColor];
        [_qbcjBtn setTitle:@"全部成交" forState:UIControlStateNormal];
        _qbcjBtn.titleLabel.font = QDFont(13);
        [_qbcjBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _qbcjBtn.tag = 203;
        [_qbcjBtn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
        _qbcjBtn.layer.borderWidth = 1;
        _qbcjBtn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
        _qbcjBtn.layer.cornerRadius = 2;
        _qbcjBtn.layer.masksToBounds = YES;

        [self addSubview:_qbcjBtn];
        
        _qbcxBtn = [[UIButton alloc] init];
        _qbcxBtn.backgroundColor = [UIColor whiteColor];
        [_qbcxBtn setTitle:@"全部撤单" forState:UIControlStateNormal];
        _qbcxBtn.tag = 204;
        [_qbcxBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _qbcxBtn.titleLabel.font = QDFont(13);
        [_qbcxBtn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
        _qbcxBtn.layer.borderWidth = 1;
        _qbcxBtn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
        _qbcxBtn.layer.cornerRadius = 2;
        _qbcxBtn.layer.masksToBounds = YES;
        [self addSubview:_qbcxBtn];
        
        _bcbcBtn = [[UIButton alloc] init];
        _bcbcBtn.backgroundColor = [UIColor whiteColor];
        [_bcbcBtn setTitle:@"部分成交部分撤单" forState:UIControlStateNormal];
        _bcbcBtn.tag = 205;
        [_bcbcBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _bcbcBtn.titleLabel.font = QDFont(13);
        [_bcbcBtn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
        _bcbcBtn.layer.borderWidth = 1;
        _bcbcBtn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
        _bcbcBtn.layer.cornerRadius = 2;
        _bcbcBtn.layer.masksToBounds = YES;
        [self addSubview:_bcbcBtn];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = APP_LIGHTGRAYCOLOR;
        _bottomLine.alpha = 0.5;
        [self addSubview:_bottomLine];
        
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_verticalLine];

        
        _resetbtn = [[UIButton alloc] init];
        _resetbtn.backgroundColor = APP_WHITECOLOR;
        [_resetbtn addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [_resetbtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetbtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _resetbtn.titleLabel.font = QDFont(16);
        [self addSubview:_resetbtn];

        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font= QDFont(16);
        [self addSubview:_confirmBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(37);
        make.top.equalTo(self.mas_top).offset(47);
    }];

    [_sellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_buyBtn);
        make.left.equalTo(_buyBtn.mas_right).offset(19);
    }];

    [_wcjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buyBtn.mas_bottom).offset(44);
        make.width.mas_equalTo(96);
        make.left.equalTo(_buyBtn);
    }];

    [_bfcjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.and.height.equalTo(_wcjBtn);
        make.left.equalTo(_wcjBtn.mas_right).offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(32);
    }];

    [_qbcjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.and.height.equalTo(_bfcjBtn);
        make.left.equalTo(_bfcjBtn.mas_right).offset(10);
    }];

    [_qbcxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wcjBtn.mas_bottom).offset(SCREEN_HEIGHT*0.02);
        make.left.width.and.height.equalTo(_wcjBtn);
    }];

    [_bcbcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(_qbcxBtn);
        make.left.equalTo(_bfcjBtn);
        make.right.equalTo(_qbcjBtn);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-46);
        make.height.mas_equalTo(@1);
    }];
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.bottom.equalTo(self);
        make.top.equalTo(_bottomLine.mas_bottom);
        make.width.mas_equalTo(1);
    }];
    
    [_resetbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLine.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(_verticalLine.mas_left);
        make.bottom.equalTo(self);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.bottom.equalTo(_resetbtn);
        make.right.equalTo(self);
        make.left.equalTo(_verticalLine.mas_right);
    }];
}

- (void)setUpTextFieldWithHolderStr:(UITextField *)textField andHolderStr:(NSString *)holderStr{
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.font = QDFont(14);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:holderStr attributes:@{NSForegroundColorAttributeName:APP_GRAYCOLOR,NSFontAttributeName:QDFont(14), NSParagraphStyleAttributeName:style}];
    textField.attributedPlaceholder = attri;
    textField.layer.borderColor = APP_BLUECOLOR.CGColor;
    [textField setValue:QDFont(13) forKeyPath:@"_placeholderLabel.font"];
    textField.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
}

#pragma mark - 重置
- (void)resetAction:(UIButton *)sender{
    for (int i = 201; i <= 207; i++) {
        UIButton *btn = [self viewWithTag:i];
        if (i == 206 || i == 207) {
            btn.selected = NO;
        }else{
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
            btn.backgroundColor = APP_WHITECOLOR;
            [btn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
            btn.selected = NO;
        }
    }
}

#pragma mark - 按钮点击
- (void)btnClick:(UIButton *)sender{
    for (int i = 201; i <= 205; i++) {
        UIButton *btn = [self viewWithTag:i];
        if (btn.tag != sender.tag) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
            btn.backgroundColor = APP_WHITECOLOR;
            [btn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
            btn.selected=NO;
        }else{
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = APP_BLUECOLOR.CGColor;
            btn.backgroundColor = APP_BLUECOLOR;
            btn.titleLabel.textColor = APP_WHITECOLOR;
            [btn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
            btn.selected = YES;
        }
    }
    if (self.sdStatusStatusBlock) {
        NSString *statusStr;
        QDLog(@"text = %@", sender.titleLabel.text);
        /**
         NO_TRADED(0,"未成交"), // 未成交
         PART_TRADED(1,"部分成交"), // 部分成交
         ALL_TRADED(2,"全部成交"), // 全部成交
         ALL_CANCELED(3,"全部撤单"), // 全部撤单
         PART_CANCELED(4,"部分成交部分撤单"), // 部分成交部分撤单
         IS_CANCELED(5,"已取消"), // 已取消
         INTENTION(6,"意向单") ; // 意向单
         */
        switch (sender.tag) {
            case 201:
                statusStr = @"0";
                break;
            case 202:
                statusStr = @"1";
                break;
            case 203:
                statusStr = @"2";
                break;
            case 204:
                statusStr = @"3";
                break;
            case 205:
                statusStr = @"4";
                break;
            default:
                break;
        }
        self.sdStatusStatusBlock(statusStr);
    }
}

#pragma mark - 选择方向
- (void)directionAction:(UIButton *)sender{
    for (int i = 206; i <= 207; i++) {
        UIButton *btn = [self viewWithTag:i];
        if (btn.tag != sender.tag) {
            btn.selected=NO;
        }else{
            btn.selected = YES;
        }
    }
    if (self.sdDirectionBlock) {
        NSString *directionStr;
        QDLog(@"text = %@", sender.titleLabel.text);
        if ([sender.titleLabel.text isEqualToString:@"买入"]) {
            directionStr = @"0";
        }else if ([sender.titleLabel.text isEqualToString:@"卖掉"]){
            directionStr = @"1";
        }
        self.sdDirectionBlock(directionStr);
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    //判断第一位是否为数字
    if ([textField.text isEqualToString: @"."]) {
        textField.text = @"";
    }
    //判断是否有两个小数点
    if (textField.text.length >= 2) {
        NSString *str = [textField.text substringToIndex:textField.text.length-1];
        NSString *strTwo = [textField.text substringFromIndex:textField.text.length-1];
        NSRange range = [str rangeOfString:@"."];
        if (range.location != NSNotFound && [strTwo isEqualToString:@"."]) {
            textField.text = [textField.text substringToIndex:textField.text.length-1];
        }
    }
    //小数点后面数字位数控制  （此时为小数点后一位，3改4就是两位    思路：取倒数第X个字符是否为小数点，是小数点的话，就不再允许输入）
    if (textField.text.length > 4) {
        NSString *myStr = [textField.text substringWithRange:NSMakeRange(textField.text.length-4 , 1)];
        if ([myStr isEqualToString:@"."]) {
            textField.text = [textField.text substringToIndex:textField.text.length-1];
        }
    }
    //最大值控制
    double doubleNum = [textField.text doubleValue];
    NSUInteger myNub = doubleNum;
    NSUInteger sum = 100000000;
    if (myNub > sum) {
        textField.text = [textField.text substringToIndex:textField.text.length-1];
    }
}
@end
