//
//  QDFilterTypeOneView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDFilterTypeOneView.h"

@implementation QDFilterTypeOneView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"价格区间(元)";
        _priceLab.font = QDFont(14);
        [self addSubview:_priceLab];
        
        _lowPrice = [[UITextField alloc] init];
        [self setUpTextFieldWithHolderStr:_lowPrice andHolderStr:@"最低价"];
        [self addSubview:_lowPrice];
        
        _lineView = [[UILabel alloc] init];
        _lineView.text = @"到";
        _lineView.textColor = APP_BLACKCOLOR;
        _lineView.font = QDFont(14);
        [self addSubview:_lineView];
        
        _hightPrice = [[UITextField alloc] init];
        [self setUpTextFieldWithHolderStr:_hightPrice andHolderStr:@"最高价"];
        [self addSubview:_hightPrice];
        
        _amountLab = [[UILabel alloc] init];
        _amountLab.text = @"数量区间(个)";
        _amountLab.font = QDFont(14);
        [self addSubview:_amountLab];
        
        _lowAmount = [[UITextField alloc] init];
        [self setUpTextFieldWithHolderStr:_lowAmount andHolderStr:@"最小量"];
        [self addSubview:_lowAmount];
        
        _lineViewT = [[UILabel alloc] init];
        _lineViewT.text = @"到";
        _lineViewT.textColor = APP_BLACKCOLOR;
        _lineViewT.font = QDFont(14);
        [self addSubview:_lineViewT];

        _hightAmount = [[UITextField alloc] init];
        [self setUpTextFieldWithHolderStr:_hightAmount andHolderStr:@"最大量"];
        [self addSubview:_hightAmount];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"可零售";
        _infoLab.font = QDFont(14);
        [self addSubview:_infoLab];
        
        _yesBtn = [[UIButton alloc] init];
        _yesBtn.backgroundColor = [UIColor whiteColor];
        [_yesBtn setTitle:@"是" forState:UIControlStateNormal];
        [_yesBtn addTarget:self action:@selector(isAllDealed:) forControlEvents:UIControlEventTouchUpInside];
        _yesBtn.tag = 201;
        _yesBtn.titleLabel.font = QDFont(13);
        [_yesBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _yesBtn.layer.borderWidth = 1;
        _yesBtn.layer.borderColor = APP_GRAYCOLOR.CGColor;
        _yesBtn.layer.cornerRadius = 2;
        _yesBtn.layer.masksToBounds = YES;
        [self addSubview:_yesBtn];
        
        _noBtn = [[UIButton alloc] init];
        _noBtn.backgroundColor = [UIColor whiteColor];
        [_noBtn setTitle:@"否" forState:UIControlStateNormal];
        _noBtn.titleLabel.font = QDFont(13);
        [_noBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _noBtn.layer.borderWidth = 1;
        _noBtn.layer.borderColor = APP_GRAYCOLOR.CGColor;
        _noBtn.layer.cornerRadius = 2;
        _noBtn.layer.masksToBounds = YES;
        [_noBtn addTarget:self action:@selector(isAllDealed:) forControlEvents:UIControlEventTouchUpInside];
        _noBtn.tag = 202;
        [self addSubview:_noBtn];
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_bottomLine];
        
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [self addSubview:_verticalLine];
        
        _resetbtn = [[UIButton alloc] init];
        _resetbtn.backgroundColor = APP_WHITECOLOR;
        [_resetbtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetbtn addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
        [_resetbtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _resetbtn.titleLabel.font = QDFont(16);
        [self addSubview:_resetbtn];
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = APP_WHITECOLOR;
        _confirmBtn.titleLabel.font= QDFont(16);
        [self addSubview:_confirmBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(17);
        make.top.equalTo(self.mas_top).offset(58);
    }];
    
    [_lowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLab);
        make.left.equalTo(self.mas_left).offset(133);
        make.width.mas_equalTo(84);
        make.height.mas_equalTo(31);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lowPrice);
        make.left.equalTo(_lowPrice.mas_right).offset(18);
    }];
    
    [_hightPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.and.height.equalTo(_lowPrice);
        make.right.equalTo(self.mas_right).offset(-25);
    }];
    
    [_lowAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.and.height.equalTo(_lowPrice);
        make.top.equalTo(_lowPrice.mas_bottom).offset(28);
    }];
    
    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lowAmount);
        make.left.equalTo(_priceLab);
    }];
    
    [_lineViewT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lowAmount);
        make.left.equalTo(_lineView);
    }];
    
    [_hightAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.and.height.equalTo(_lowAmount);
        make.right.equalTo(_hightPrice);
    }];
    
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_amountLab);
        make.top.equalTo(_amountLab.mas_bottom).offset(45);
    }];
    
    [_yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lowPrice);
        make.centerY.equalTo(_infoLab);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(20);
    }];

    [_noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yesBtn.mas_right).offset(15);
        make.centerY.width.and.height.equalTo(_yesBtn);
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
    textField.layer.cornerRadius = 2;
    textField.layer.masksToBounds = YES;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.font = QDFont(14);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:holderStr attributes:@{NSForegroundColorAttributeName:APP_GRAYCOLOR,NSFontAttributeName:QDFont(14), NSParagraphStyleAttributeName:style}];
    textField.attributedPlaceholder = attri;
    [textField setValue:[NSNumber numberWithInt:20] forKey:@"paddingLeft"];

    textField.layer.borderColor = [UIColor colorWithHexString:@"#EEEEEE"].CGColor;
    textField.layer.borderWidth = 1;
    [textField setValue:QDFont(14) forKeyPath:@"_placeholderLabel.font"];
    textField.backgroundColor = APP_WHITECOLOR;
}
#pragma mark - 选择方向
- (void)isAllDealed:(UIButton *)sender{
    for (int i = 201; i <= 202; i++) {
        UIButton *btn = [self viewWithTag:i];
        if (btn.tag != sender.tag) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
            [btn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
            btn.selected=NO;
        }else{
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = APP_BLUECOLOR.CGColor;
            [btn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
            btn.selected = YES;
        }
    }
    if (self.sdIsPartialBlock) {
        NSString *directionStr;
        QDLog(@"text = %@", sender.titleLabel.text);
        if (sender.tag == 201) {
            directionStr = @"1";
        }else if (sender.tag == 202){
            directionStr = @"0";
        }
        self.sdIsPartialBlock(directionStr);
    }
}

#pragma mark - 重置
- (void)resetAction:(UIButton *)sender{
    for (int i = 201; i <= 202; i++) {
        UIButton *btn = [self viewWithTag:i];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = APP_GRAYLAYERCOLOR.CGColor;
        [btn setTitleColor:APP_GRAYBUTTONTEXTCOLOR forState:UIControlStateNormal];
        btn.selected = NO;
    }
    self.lowPrice.text = @"";
    self.hightPrice.text = @"";
    self.lowAmount.text = @"";
    self.hightAmount.text = @"";
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
