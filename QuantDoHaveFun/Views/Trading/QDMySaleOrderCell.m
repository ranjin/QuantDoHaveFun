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
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.shadowColor = APP_GRAYLINECOLOR.CGColor;
        // 阴影偏移，默认(0, -3)
        _backView.layer.shadowOffset = CGSizeMake(2,3);
        // 阴影透明度，默认0
        _backView.layer.shadowOpacity = 3;
        // 阴影半径，默认3
        _backView.layer.shadowRadius = 2;
        [self.contentView addSubview:_backView];
        
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self.contentView addSubview:_shadowView];
        
        _operationTypeLab = [[UILabel alloc] init];
        _operationTypeLab.text = @"卖掉";
        _operationTypeLab.font = QDFont(15);
        [_shadowView addSubview:_operationTypeLab];
        
        _dealLab = [[UILabel alloc] init];
        _dealLab.text = @"已成交";
        _dealLab.textColor = APP_BLUECOLOR;
        _dealLab.font = QDFont(14);
        [_shadowView addSubview:_dealLab];
        
        _deal = [[UILabel alloc] init];
        _deal.text = @"2700";
        _deal.textColor = APP_BLUECOLOR;
        _deal.font = QDBoldFont(14);
        [_shadowView addSubview:_deal];
        
        _frozenLab = [[UILabel alloc] init];
        _frozenLab.text = @"冻结";
        _frozenLab.textColor = APP_BLUECOLOR;
        _frozenLab.font = QDFont(14);
        [_shadowView addSubview:_frozenLab];
        
        _frozen = [[UILabel alloc] init];
        _frozen.text = @"300";
        _frozen.textColor = APP_BLUECOLOR;
        _frozen.font = QDBoldFont(14);
        [_shadowView addSubview:_frozen];
        
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = APP_GRAYLINECOLOR;
        _centerLine.alpha = 0.2;
        [_backView addSubview:_centerLine];
        
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
        [_statusImg setImage:[UIImage imageNamed:@"icon_bfcj"]];
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
        _lineView.backgroundColor = APP_GRAYLINECOLOR;
        _lineView.alpha = 0.2;
        [_backView addSubview:_lineView];
        
        
        _orderStatusLab = [[UILabel alloc] init];
        _orderStatusLab.text = @"已部分成交";
        _orderStatusLab.font = QDFont(14);
        _orderStatusLab.textColor = APP_GRAYLINECOLOR;
        [_backView addSubview:_orderStatusLab];
        
        _withdrawBtn = [[UIButton alloc] init];
        _withdrawBtn.backgroundColor = APP_GRAYBUTTONCOLOR;
        [_withdrawBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
        [_withdrawBtn setTitle:@"撤单" forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = QDFont(16);
        _withdrawBtn.layer.cornerRadius = 14;
        _withdrawBtn.layer.masksToBounds = YES;
        [_backView addSubview:_withdrawBtn];
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
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
    
    [_operationTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_shadowView.mas_left).offset(SCREEN_WIDTH*0.04);
    }];
    
    [_dealLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.5);
    }];
    
    [_deal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_dealLab.mas_right).offset(4);
    }];
    
    [_frozenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_deal.mas_right).offset(10);
    }];
    
    [_frozen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shadowView);
        make.left.equalTo(_frozenLab.mas_right).offset(4);
    }];
    
    [_priceTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shadowView.mas_bottom).offset(15);
        make.left.equalTo(_operationTypeLab);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceTextLab.mas_bottom).offset(2);
        make.left.equalTo(_shadowView.mas_left).offset(30);
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_price);
        make.right.equalTo(_price.mas_left).offset(-2);
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceTextLab);
        make.top.equalTo(_price.mas_bottom).offset(6);
    }];

    [_status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_statusImg);
        make.left.equalTo(_statusImg.mas_right).offset(6);
    }];

    //数量 金额 手续费
    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceTextLab);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.53);
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
        make.centerY.equalTo(_status);
        make.left.equalTo(_balanceLab);
    }];

    [_transfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_transferLab);
        make.left.equalTo(_transferLab.mas_right).offset(4);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_status.mas_bottom).offset(8);
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
        make.left.equalTo(_transferLab);
        make.top.equalTo(_lineView.mas_bottom).offset(6);
        make.width.mas_equalTo(SCREEN_WIDTH*0.17);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.05);
    }];
    
    [_orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_withdrawBtn);
        make.left.equalTo(_statusImg);
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
            self.orderStatusLab.text = @"已付款";
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
        self.price.text= DTO.price;
    }
    self.deal.text = [NSString stringWithFormat:@"%@个", DTO.tradedVolume];
    self.frozen.text = [NSString stringWithFormat:@"%@个", DTO.frozenVolume];
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
        self.status.text = @"不可零售";
        self.status.textColor = APP_GRAYLINECOLOR;
    }else{
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
