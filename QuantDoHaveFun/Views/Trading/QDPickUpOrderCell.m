//
//  QDPickUpOrderCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDPickUpOrderCell.h"
#import "QDOrderField.h"
@implementation QDPickUpOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.shadowColor = APP_GRAYLINECOLOR.CGColor;
        // 阴影偏移，默认(0, -3)
        _backView.layer.shadowOffset = CGSizeMake(1,1);
        // 阴影透明度，默认0
        _backView.layer.shadowOpacity = 1;
        // 阴影半径，默认3
        _backView.layer.shadowRadius = 2;
        [self.contentView addSubview:_backView];
        
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:_shadowView];
        
        _operationTypeLab = [[UILabel alloc] init];
        _operationTypeLab.text = @"卖出";
        _operationTypeLab.font = QDFont(13);
        [_shadowView addSubview:_operationTypeLab];
        
        _totalPriceTextLab = [[UILabel alloc] init];
        _totalPriceTextLab.text = @"单价";
        _totalPriceTextLab.textColor = APP_GRAYTEXTCOLOR;
        _totalPriceTextLab.font = QDFont(13);
        [_backView addSubview:_totalPriceTextLab];
        
        _totalPriceLab = [[UILabel alloc] init];
        _totalPriceLab.text = @"¥";
        _totalPriceLab.font = QDBoldFont(17);
        _totalPriceLab.textColor = APP_ORANGETEXTCOLOR;
        [_backView addSubview:_totalPriceLab];
        
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.text = @"34.00";
        _totalPrice.font = QDBoldFont(23);
        _totalPrice.textColor = APP_ORANGETEXTCOLOR;
        [_backView addSubview:_totalPrice];
        
        _amountLab = [[UILabel alloc] init];
        _amountLab.text = @"数量";
        _amountLab.textColor = APP_GRAYLINECOLOR;
        _amountLab.font = QDFont(14);
        [_backView addSubview:_amountLab];
        
        _amount = [[UILabel alloc] init];
        _amount.text = @"2000";
        _amount.font = QDFont(14);
        _amount.textColor = APP_GRAYTEXTCOLOR;
        [_backView addSubview:_amount];
        
        
        _balanceLab = [[UILabel alloc] init];
        _balanceLab.text = @"金额";
        _balanceLab.textColor = APP_GRAYLINECOLOR;
        _balanceLab.font = QDFont(14);
        [_backView addSubview:_balanceLab];
        
        _balance = [[UILabel alloc] init];
        _balance.text = @"¥60000.00";
        _balance.font = QDFont(14);
        _balance.textColor = APP_GRAYTEXTCOLOR;
        [_backView addSubview:_balance];
        
        
        _transferLab = [[UILabel alloc] init];
        _transferLab.text = @"手续费";
        _transferLab.textColor = APP_GRAYLINECOLOR;
        _transferLab.font = QDFont(14);
        [_backView addSubview:_transferLab];
        
        _transfer = [[UILabel alloc] init];
        _transfer.text = @"¥30.00";
        _transfer.textColor = APP_GRAYTEXTCOLOR;
        _transfer.font = QDFont(14);
        [_backView addSubview:_transfer];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_GRAYLINECOLOR;
        _lineView.alpha = 0.2;
        [_backView addSubview:_lineView];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = APP_GRAYLINECOLOR;
        _centerLine.alpha = 0.2;
        [_backView addSubview:_centerLine];
        
        _statusLab = [[UILabel alloc] init];
        _statusLab.text = @"--";
        _statusLab.textColor = APP_GRAYLINECOLOR;
        _statusLab.font = QDFont(14);
        [_backView addSubview:_statusLab];
        
        _withdrawBtn = [[UIButton alloc] init];
        _withdrawBtn.backgroundColor = APP_GRAYBUTTONCOLOR;
        [_withdrawBtn setTitle:@"撤单" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        _withdrawBtn.layer.cornerRadius = 15;
        _withdrawBtn.layer.masksToBounds = YES;
        _withdrawBtn.titleLabel.font = QDFont(16);
        [_backView addSubview:_withdrawBtn];
        
        _payBtn = [[UIButton alloc] init];
        _payBtn.backgroundColor = APP_BLUECOLOR;
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _payBtn.layer.cornerRadius = 15;
        _payBtn.layer.masksToBounds = YES;
        _payBtn.titleLabel.font = QDFont(16);
        [_backView addSubview:_payBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(SCREEN_HEIGHT*0.02);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-(SCREEN_HEIGHT*0.02));
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.05);
        make.right.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(_backView);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.04);
    }];
    
    [_operationTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_shadowView.mas_left).offset(SCREEN_WIDTH*0.04);
    }];
    
    [_totalPriceTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadowView.mas_bottom).offset(SCREEN_HEIGHT*0.03);
        make.left.equalTo(_operationTypeLab);
    }];
    
    [_totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalPriceTextLab.mas_bottom).offset(SCREEN_HEIGHT*0.015);
        make.left.equalTo(_totalPriceTextLab);
    }];
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalPriceLab.mas_right).offset(1);
        make.centerY.equalTo(_totalPriceLab);
    }];
    
    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_totalPriceTextLab);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.53);
    }];
    
    [_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_amountLab);
        make.left.equalTo(_amountLab.mas_right).offset(12);
    }];
    
    [_balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_amount.mas_bottom).offset(4);
        make.left.equalTo(_amountLab);
    }];
    
    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_balanceLab);
        make.left.equalTo(_amount);
    }];
    
    [_transferLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_balanceLab.mas_bottom).offset(4);
        make.left.equalTo(_balanceLab);
    }];
    
    [_transfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_transferLab);
        make.left.equalTo(_transferLab.mas_right).offset(4);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_transfer.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SCREEN_WIDTH*0.81);
    }];
    
    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_shadowView.mas_bottom).offset(SCREEN_HEIGHT*0.02);
        make.bottom.equalTo(_lineView.mas_top).offset(-(SCREEN_HEIGHT*0.02));
        make.width.mas_equalTo(1);
    }];
    
    [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).offset(6);
        make.left.equalTo(_centerLine);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
    
    
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_withdrawBtn);
        make.left.equalTo(_totalPriceTextLab);
    }];
    
   
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_statusLab);
        make.left.equalTo(_withdrawBtn.mas_right).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
}

- (void)loadPickOrderWithModel:(QDMyPickOrderModel *)model{
    //单价
    if ([model.businessType isEqualToString:@"0"]) {
        self.operationTypeLab.text = @"买入";
    }else{
        self.operationTypeLab.text = @"卖掉";
    }
    if (model.price == nil) {
        self.totalPrice.text = @"--";
    }else{
        self.totalPrice.text= model.price;
    }
    if (model.number == nil) {
        self.amount.text = @"--";
    }else{
        self.amount.text= [NSString stringWithFormat:@"%@个",model.number];
    }
    self.balance.text = [NSString stringWithFormat:@"¥%@",model.amount];
    //手续费
    self.transfer.text = [NSString stringWithFormat:@"¥%@", model.poundage];
    if ([model.state isEqualToString:@"0"]) {
        self.statusLab.text = @"待付款";
        _withdrawBtn.hidden = NO;
        _payBtn.hidden = NO;
    }else{
        _withdrawBtn.hidden = YES;
        _payBtn.hidden = YES;
        switch ([model.state integerValue]) {
            case QD_HavePurchased:
                self.statusLab.text = @"已付款";
                break;
            case QD_HaveFinished:
                self.statusLab.text = @"已完成";
                break;
            case QD_OverTimeCanceled:
                self.statusLab.text = @"已取消";
                break;
            case QD_ManualCanceled:
                self.statusLab.text = @"已取消";
                break;
            default:
                break;
        }
    }
}

@end
