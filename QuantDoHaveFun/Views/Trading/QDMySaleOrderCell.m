//
//  QDMySaleOrderCell.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/25.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMySaleOrderCell.h"
#import "QDOrderField.h"
@implementation QDMySaleOrderCell

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
        _backView.backgroundColor = APP_WHITECOLOR;
        _backView.layer.cornerRadius = 2;
        _backView.layer.masksToBounds = YES;
        [self.contentView addSubview:_backView];
        
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [_backView addSubview:_shadowView];
        
        _operationImg = [[UIImageView alloc] init];
        _operationImg.image = [UIImage imageNamed:@"operateType"];
        [_backView addSubview:_operationImg];
        
        _operationTypeLab = [[UILabel alloc] init];
        _operationTypeLab.text = @"卖掉";
        _operationTypeLab.font = QDFont(15);
        [_backView addSubview:_operationTypeLab];
        
        _dealLab = [[UILabel alloc] init];
        _dealLab.text = @"已成交";
        _dealLab.textColor = APP_GRAYCOLOR;
        _dealLab.font = QDFont(14);
        [_backView addSubview:_dealLab];
        
        _deal = [[UILabel alloc] init];
        _deal.text = @"2700";
        _deal.textColor = APP_BLUECOLOR;
        _deal.font = QDBoldFont(14);
        [_backView addSubview:_deal];
        
        _dealTextLab = [[UILabel alloc] init];
        _dealTextLab.text = @"个";
        _dealTextLab.font = QDFont(14);
        _dealTextLab.textColor = APP_GRAYCOLOR;
        [_backView addSubview:_dealTextLab];
        
        _frozenLab = [[UILabel alloc] init];
        _frozenLab.text = @"冻结";
        _frozenLab.textColor = APP_GRAYCOLOR;
        _frozenLab.font = QDFont(14);
        [_backView addSubview:_frozenLab];
        
        _frozen = [[UILabel alloc] init];
        _frozen.text = @"300";
        _frozen.textColor = APP_BLUECOLOR;
        _frozen.font = QDBoldFont(14);
        [_backView addSubview:_frozen];
        
        _frozenTextLab = [[UILabel alloc] init];
        _frozenTextLab.text = @"个";
        _frozenTextLab.font = QDFont(14);
        _frozenTextLab.textColor = APP_GRAYCOLOR;
        [_backView addSubview:_frozenTextLab];
        
        _priceTextLab = [[UILabel alloc] init];
        _priceTextLab.text = @"单价";
        _priceTextLab.font = QDFont(14);
        _priceTextLab.textColor = APP_GRAYLINECOLOR;
        [_backView addSubview:_priceTextLab];
        
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"¥";
        _priceLab.font = QDBoldFont(20);
        _priceLab.textColor = APP_ORANGETEXTCOLOR;
        [_backView addSubview:_priceLab];
        
        _price = [[UILabel alloc] init];
        _price.text = @"30.00";
        _price.font = QDBoldFont(24);
        _price.textColor = APP_ORANGETEXTCOLOR;
        [_backView addSubview:_price];
        
        _statusImg = [[UIImageView alloc] init];
        _statusImg.image = [UIImage imageNamed:@"status_img"];
        [_backView addSubview:_statusImg];
        
        _status = [[UILabel alloc] init];
        _status.text = @"可零售";
        _status.font = QDFont(14);
        _status.textColor = APP_BLUECOLOR;
        [_backView addSubview:_status];
        
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
        _lineView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        _lineView.alpha = 0.2;
        [_backView addSubview:_lineView];
        
        
        _orderStatusLab = [[UILabel alloc] init];
        _orderStatusLab.text = @"已部分成交";
        _orderStatusLab.font = QDFont(14);
        _orderStatusLab.textColor = APP_GRAYLINECOLOR;
        [_backView addSubview:_orderStatusLab];
        
        _withdrawBtn = [[UIButton alloc] init];
        _withdrawBtn.backgroundColor = APP_WHITECOLOR;
        _withdrawBtn.layer.borderColor = [UIColor colorWithHexString:@"#EEEEEE"].CGColor;
        _withdrawBtn.layer.borderWidth = 0.6;
        _withdrawBtn.layer.cornerRadius = 13;
        _withdrawBtn.layer.masksToBounds = YES;
        [_withdrawBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        [_withdrawBtn setTitle:@"我不卖了" forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = QDFont(14);
        [_backView addSubview:_withdrawBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.05);
        make.right.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
    
    [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(_backView);
        make.top.equalTo(_backView.mas_top).offset(42);
        make.height.mas_equalTo(7);
    }];
    
    [_operationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(18);
        make.top.equalTo(_backView.mas_top).offset(12);
    }];
    
    [_operationTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationImg);
        make.left.equalTo(_operationImg.mas_right).offset(8);
    }];
    
    [_frozenTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.left.equalTo(_backView.mas_right).offset(-20);
    }];
    
    [_frozen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.right.equalTo(_frozenTextLab.mas_left).offset(-1);
    }];
    
    [_frozenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.right.equalTo(_frozen.mas_left).offset(-1);
    }];
    
    [_dealTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.right.equalTo(_frozenLab.mas_left).offset(-5);
    }];
    
    [_deal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.right.equalTo(_dealTextLab.mas_left).offset(-1);
    }];
    
    [_dealLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.right.equalTo(_deal.mas_left).offset(-1);
    }];

    [_priceTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadowView.mas_bottom).offset(6);
        make.left.equalTo(_backView.mas_left).offset(18);
    }];

    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceTextLab.mas_bottom).offset(12);
        make.left.equalTo(_backView.mas_left).offset(18);
    }];

    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLab.mas_right).offset(2);
        make.bottom.equalTo(_priceLab);
    }];


    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceTextLab);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.5);
    }];

    [_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_amountLab);
        make.left.equalTo(_amountLab.mas_right).offset(12);
    }];

    [_balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_price);
        make.left.equalTo(_amountLab);
    }];

    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_balanceLab);
        make.left.equalTo(_amount);
    }];
    
    [_transferLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_balanceLab.mas_bottom).offset(14);
        make.left.equalTo(_balanceLab);
    }];

    [_transfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_transferLab);
        make.left.equalTo(_transferLab.mas_right).offset(4);
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(18);
        make.top.equalTo(_priceLab.mas_bottom).offset(15);
    }];
    
    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_statusImg);
        make.left.equalTo(_statusImg.mas_right).offset(4);
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(_backView);
        make.bottom.equalTo(_backView.mas_bottom).offset(-(41));
        make.height.mas_equalTo(0.5);
    }];

    [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.mas_right).offset(-16);
        make.top.equalTo(_lineView.mas_bottom).offset(6);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(26);
    }];

    [_orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(18);
        make.bottom.equalTo(_backView.mas_bottom).offset(-14);
    }];
}

//我的摘单 卖出订单
- (void)loadMyPickSaleDataWithModel:(QDMyPickOrderModel *)model{
    if (model.amount == nil) {
        self.price.text = @"--";
    }else{
        self.price.text= model.amount;
    }
    if (model.number == nil) {
        self.amount.text = @"--";
    }else{
        self.amount.text= model.number;
    }
    
    self.balance.text = model.price;
    
    switch ([model.state integerValue]) {
        case QD_WaitForPurchase:
            self.orderStatusLab.text = @"待付款";
            self.withdrawBtn.hidden = NO;
            break;
        case QD_HavePurchased:
            self.orderStatusLab.text = @"已成交";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_HaveFinished:
            self.orderStatusLab.text = @"已完成";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_OverTimeCanceled:
            self.orderStatusLab.text = @"已取消";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_ManualCanceled:
            self.orderStatusLab.text = @"已取消";
            self.withdrawBtn.hidden = YES;
            break;
        default:
            break;
    }
}

//我的报单 卖出
- (void)loadSaleOrderDataWithModel:(BiddingPostersDTO *)DTO withTag:(NSInteger)btnTag{
    if (DTO.price == nil) {
        self.price.text = @"--";
    }else{
        self.price.text= [NSString stringWithFormat:@"%.2lf", [DTO.price doubleValue]];
    }
    self.deal.text = [NSString stringWithFormat:@"%@", DTO.tradedVolume];
    self.frozen.text = [NSString stringWithFormat:@"%@", DTO.frozenVolume];
    if (DTO.surplusVolume == nil) {
        self.amount.text = @"--";
    }else{
        self.amount.text= [NSString stringWithFormat:@"%@个",DTO.volume];
    }
    if (DTO.price == nil || [DTO.price isEqualToString:@""] || DTO.volume == nil || [DTO.volume isEqualToString:@""]) {
        self.balance.text = @"--";
    }else{
        self.balance.text = [NSString stringWithFormat:@"¥%.2lf", [DTO.price doubleValue] * [DTO.volume doubleValue]];
    }
    self.transfer.text = [NSString stringWithFormat:@"¥%.2lf", [DTO.askFee doubleValue]];
    if ([DTO.isPartialDeal isEqualToString:@"0"]) {
        self.statusImg.hidden = YES;
        self.status.hidden = YES;
    }else{
        self.statusImg.hidden = NO;
        self.status.hidden = NO;
        self.status.text = @"可零售";
        self.status.textColor = APP_BLUECOLOR;
    }
    self.withdrawBtn.tag = btnTag;
    //未成交
    switch ([DTO.postersStatus integerValue]) {
        case QD_ORDERSTATUS_NOTTRADED:
            self.orderStatusLab.text = @"未成交";
            if ([DTO.frozenVolume isEqualToString:@"0"] || DTO.frozenVolume == nil) {
                self.withdrawBtn.hidden = NO;
            }else{
                self.withdrawBtn.hidden = YES;
            }
            break;
        case QD_ORDERSTATUS_PARTTRADED:
            self.orderStatusLab.text = @"部分成交";
            if ([DTO.frozenVolume isEqualToString:@"0"] || DTO.frozenVolume == nil) {
                self.withdrawBtn.hidden = NO;
            }else{
                self.withdrawBtn.hidden = YES;
            }
            break;
        case QD_ORDERSTATUS_ALLTRADED:
            self.orderStatusLab.text = @"全部成交";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_ORDERSTATUS_ALLCANCELED:
            self.orderStatusLab.text = @"全部撤单";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_ORDERSTATUS_PARTCANCELED:
            self.orderStatusLab.text = @"部分成交部分撤单";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_ORDERSTATUS_ISCANCELED:
            self.orderStatusLab.text = @"已取消";
            self.withdrawBtn.hidden = YES;
            break;
        default:
            break;
    }
}
@end
