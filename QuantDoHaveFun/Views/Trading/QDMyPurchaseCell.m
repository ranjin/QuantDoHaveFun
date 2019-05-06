//
//  QDMyPurchaseCell.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/25.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMyPurchaseCell.h"
#import "QDORDERField.h"
@implementation QDMyPurchaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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
        _operationTypeLab.text = @"买入";
        _operationTypeLab.textColor = APP_BLACKCOLOR;
        _operationTypeLab.font = QDFont(15);
        [_backView addSubview:_operationTypeLab];
        
        _dealLab = [[UILabel alloc] init];
        _dealLab.text = @"已成交";
        _dealLab.font = QDFont(14);
        _dealLab.textColor = APP_GRAYCOLOR;
        [_backView addSubview:_dealLab];
        
        _deal = [[UILabel alloc] init];
        _deal.text = @"0";
        _deal.font = QDFont(14);
        _deal.textColor = APP_BLUECOLOR;
        [_backView addSubview:_deal];
        
        _dealTextLab = [[UILabel alloc] init];
        _dealTextLab.text = @"个";
        _dealTextLab.font = QDFont(14);
        _dealTextLab.textColor = APP_GRAYCOLOR;
        [_backView addSubview:_dealTextLab];
        
        _frozenLab = [[UILabel alloc] init];
        _frozenLab.text = @"冻结";
        _frozenLab.font = QDFont(14);
        _frozenLab.textColor = APP_GRAYCOLOR;
        [_backView addSubview:_frozenLab];
        
        _frozen = [[UILabel alloc] init];
        _frozen.text = @"0";
        _frozen.font = QDFont(14);
        _frozen.textColor = APP_BLUECOLOR;
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
        _balance.text = @"¥10.00";
        _balance.font = QDFont(14);
        _balance.textColor = APP_GRAYTEXTCOLOR;
        [_backView addSubview:_balance];
        
        _status = [[UILabel alloc] init];
        _status.text = @"已不可部分成交";
        _status.font = QDFont(14);
        _status.textColor = APP_GRAYLINECOLOR;
        [_backView addSubview:_status];
        
        _statusImg = [[UIImageView alloc] init];
        _statusImg.image = [UIImage imageNamed:@"status_img"];
        [_backView addSubview:_statusImg];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [_backView addSubview:_lineView];
        
        _orderStatusLab = [[UILabel alloc] init];
        _orderStatusLab.text = @"已部分成交";
        _orderStatusLab.font = QDFont(14);
        _orderStatusLab.textColor = APP_GRAYLINECOLOR;
        [_backView addSubview:_orderStatusLab];
        
        _withdrawBtn = [[UIButton alloc] init];
        [_withdrawBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        [_withdrawBtn setBackgroundImage:[UIImage imageNamed:@"cancelOrder"] forState:UIControlStateNormal];
        [_withdrawBtn setTitle:@"我不买了" forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = QDFont(14);
        _withdrawBtn.hidden = YES;
        [_backView addSubview:_withdrawBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.and.height.equalTo(self.contentView);
        make.width.mas_equalTo(351);
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

    [_dealLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationTypeLab);
        make.left.equalTo(_backView.mas_left).offset(159);
    }];

    [_deal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationImg);
        make.left.equalTo(_dealLab.mas_right).offset(4);
    }];

    [_dealTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_deal);
        make.left.equalTo(_deal.mas_right).offset(6);
    }];

    [_frozenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationImg);
        make.left.equalTo(_dealTextLab.mas_right).offset(10);
    }];

    [_frozen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealTextLab);
        make.left.equalTo(_frozenLab.mas_right).offset(4);
    }];

    [_frozenTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_frozenLab);
        make.left.equalTo(_frozen.mas_right).offset(6);
    }];
    
    [_priceTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(18);
        make.top.equalTo(_shadowView.mas_bottom).offset(6);
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
        make.left.equalTo(_balanceLab);
        make.top.equalTo(_lineView.mas_bottom).offset(8);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];

    [_orderStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceTextLab);
        make.centerY.equalTo(_withdrawBtn);
    }];
}

- (void)loadPurchaseDataWithModel:(BiddingPostersDTO *)DTO withTag:(NSInteger)btnTag{
    //单价
    if (DTO.price == nil) {
        self.price.text = @"--";
    }else{
        self.price.text= DTO.price;
    }
    _deal.text =  [NSString stringWithFormat:@"%@",DTO.tradedVolume];
    _frozen.text = [NSString stringWithFormat:@"%@",DTO.frozenVolume];
    //剩余数量
    if (DTO.volume == nil) {
        self.amount.text = @"--";
    }else{
        self.amount.text= [NSString stringWithFormat:@"%@个",DTO.volume];
    }
    if (DTO.price == nil || [DTO.price isEqualToString:@""] || DTO.volume == nil || [DTO.volume isEqualToString:@""]) {
        self.balance.text = @"--";
    }else{
        self.balance.text = [NSString stringWithFormat:@"¥%.2lf", [DTO.price doubleValue] * [DTO.surplusVolume doubleValue]];
    }
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
    QDLog(@"btnTag = %ld", (long)btnTag);
    //未成交与部分成交的时候 并且
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
        case QD_ORDERSTATUS_INTENTION:
            self.orderStatusLab.text = @"意向单";
            self.withdrawBtn.hidden = YES;
            break;
        case QD_ORDERSTATUS_WAITPAY:
            self.orderStatusLab.text = @"待付款";
            self.withdrawBtn.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)loadMyPickPurchaseDataWithModel:(QDMyPickOrderModel *)model{
    if (model.amount == nil) {
        self.price.text = @"--";
    }else{
        self.price.text = [NSString stringWithFormat:@"¥%@",model.price];
    }
    if (model.number == nil) {
        self.amount.text = @"--";
    }else{
        self.amount.text= [NSString stringWithFormat:@"%@个",model.number];
    }
    self.balance.text = model.amount;
    self.transfer.text = [NSString stringWithFormat:@"¥%.2lf", [model.poundage doubleValue]];
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
@end
