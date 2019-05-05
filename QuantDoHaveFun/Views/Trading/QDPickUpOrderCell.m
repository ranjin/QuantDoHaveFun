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
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = APP_WHITECOLOR;
        _topBackView.layer.cornerRadius = 2;
        _topBackView.layer.masksToBounds = YES;
        [self.contentView addSubview:_topBackView];
        
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [_topBackView addSubview:_shadowView];
        
        _operationImg = [[UIImageView alloc] init];
        _operationImg.image = [UIImage imageNamed:@"operateType"];
        [_topBackView addSubview:_operationImg];
        
        _operationTypeLab = [[UILabel alloc] init];
        _operationTypeLab.text = @"卖出";
        _operationTypeLab.font = QDFont(15);
        [_topBackView addSubview:_operationTypeLab];
        
        _totalPriceTextLab = [[UILabel alloc] init];
        _totalPriceTextLab.text = @"单价";
        _totalPriceTextLab.textColor = APP_GRAYTEXTCOLOR;
        _totalPriceTextLab.font = QDFont(14);
        [_topBackView addSubview:_totalPriceTextLab];
        
        _totalPriceLab = [[UILabel alloc] init];
        _totalPriceLab.text = @"¥";
        _totalPriceLab.font = QDBoldFont(17);
        _totalPriceLab.textColor = APP_ORANGETEXTCOLOR;
        [_topBackView addSubview:_totalPriceLab];
        
        _totalPrice = [[UILabel alloc] init];
        _totalPrice.text = @"34.00";
        _totalPrice.font = QDBoldFont(23);
        _totalPrice.textColor = APP_ORANGETEXTCOLOR;
        [_topBackView addSubview:_totalPrice];
        
        _amountLab = [[UILabel alloc] init];
        _amountLab.text = @"数量";
        _amountLab.textColor = APP_GRAYLINECOLOR;
        _amountLab.font = QDFont(14);
        [_topBackView addSubview:_amountLab];
        
        _amount = [[UILabel alloc] init];
        _amount.text = @"2000";
        _amount.font = QDFont(14);
        _amount.textColor = APP_GRAYTEXTCOLOR;
        [_topBackView addSubview:_amount];
        
        
        _balanceLab = [[UILabel alloc] init];
        _balanceLab.text = @"金额";
        _balanceLab.textColor = APP_GRAYLINECOLOR;
        _balanceLab.font = QDFont(14);
        [_topBackView addSubview:_balanceLab];
        
        _balance = [[UILabel alloc] init];
        _balance.text = @"¥60000.00";
        _balance.font = QDFont(14);
        _balance.textColor = APP_GRAYTEXTCOLOR;
        [_topBackView addSubview:_balance];
        
        
        _transferLab = [[UILabel alloc] init];
        _transferLab.text = @"手续费";
        _transferLab.textColor = APP_GRAYLINECOLOR;
        _transferLab.font = QDFont(14);
        [_topBackView addSubview:_transferLab];
        
        _transfer = [[UILabel alloc] init];
        _transfer.text = @"¥30.00";
        _transfer.textColor = APP_GRAYTEXTCOLOR;
        _transfer.font = QDFont(14);
        [_topBackView addSubview:_transfer];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = APP_GRAYLINECOLOR;
        _centerLine.alpha = 0.2;
        [_topBackView addSubview:_centerLine];
        
        _statusLab = [[UILabel alloc] init];
        _statusLab.text = @"--";
        _statusLab.textColor = APP_GRAYLINECOLOR;
        _statusLab.font = QDFont(14);
        [_topBackView addSubview:_statusLab];
        
        _withdrawBtn = [[UIButton alloc] init];
        [_withdrawBtn setTitle:@"我不买了" forState:UIControlStateNormal];
        [_withdrawBtn setBackgroundImage:[UIImage imageNamed:@"withdraw_btn"] forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = QDFont(14);
        [_topBackView addSubview:_withdrawBtn];
        
        _payBtn = [[UIButton alloc] init];
        [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"pay_btn"] forState:UIControlStateNormal];
        [_payBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _payBtn.titleLabel.font = QDFont(14);
        [_topBackView addSubview:_payBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.05);
        make.right.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(_topBackView);
        make.top.equalTo(_topBackView.mas_top).offset(42);
        make.height.mas_equalTo(7);
    }];
    
    [_operationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBackView.mas_top).offset(13);
        make.left.equalTo(_topBackView.mas_left).offset(18);
    }];

    [_operationTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationImg);
        make.left.equalTo(_operationImg.mas_right).offset(8);
    }];

    [_totalPriceTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadowView.mas_bottom).offset(6);
        make.left.equalTo(_topBackView.mas_left).offset(18);
    }];
    
    [_totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalPriceTextLab.mas_bottom).offset(12);
        make.left.equalTo(_topBackView.mas_left).offset(18);
    }];
    
    [_totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalPriceLab.mas_right).offset(2);
        make.bottom.equalTo(_totalPriceLab);
    }];
    
    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_totalPriceTextLab);
        make.left.equalTo(_topBackView.mas_left).offset(SCREEN_WIDTH*0.53);
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

    [_centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(_topBackView);
        make.bottom.equalTo(_topBackView.mas_bottom).offset(-42);
        make.height.mas_equalTo(1);
    }];

    [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerLine.mas_bottom).offset(7);
        make.left.equalTo(_topBackView.mas_left).offset(170);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(28);
    }];

    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.height.equalTo(_withdrawBtn);
        make.left.equalTo(_withdrawBtn.mas_right).offset(21);
        make.width.mas_equalTo(62);
    }];

    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_withdrawBtn);
        make.left.equalTo(_totalPriceTextLab);
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
