//
//  QDCreditOrderTableViewCell.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/7.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDCreditOrderTableViewCell.h"
#import "QDDateUtils.h"

@interface QDCreditOrderTableViewCell ()
@property(nonatomic,strong)UIImageView *orderIcon;
@property(nonatomic,strong)UILabel *orderTypeLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *amountLabel;
@property(nonatomic,strong)UILabel *currencyNameLabel;
@end

@implementation QDCreditOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.orderIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"creditOrder"]];
        [self.contentView addSubview: self.orderIcon];
        [self.orderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(43);
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];
        
        self.orderTypeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.orderTypeLabel];
        [self.orderTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.orderIcon.mas_right).offset(18);
            make.top.equalTo(self.contentView.mas_top).offset(18);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(20);
        }];
        self.orderTypeLabel.font = [UIFont systemFontOfSize:16];
        self.orderTypeLabel.textColor = [UIColor blackColor];
        
        self.timeLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.orderIcon.mas_right).offset(18);
            make.top.equalTo(self.orderTypeLabel.mas_bottom).offset(2);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
        self.timeLabel.font = [UIFont systemFontOfSize:12];
        self.timeLabel.textColor = LD_colorRGBValue(0x999999);
        
        self.currencyNameLabel = [[UILabel alloc]init];
        [self.contentView addSubview:_currencyNameLabel];
        [_currencyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-12);
            make.top.equalTo(self.contentView.mas_top).offset(24);
            make.width.mas_equalTo(26);
            make.height.mas_equalTo(15);
        }];
        _currencyNameLabel.font = QDFont(12);
        _currencyNameLabel.textColor = LD_colorRGBValue(0x999999);
        
        self.amountLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.amountLabel];
        [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_currencyNameLabel.mas_left).offset(-6);
            make.centerY.mas_equalTo(_currencyNameLabel.mas_centerY);
            make.width.mas_equalTo(130);
            make.height.mas_equalTo(18);
        }];
        self.amountLabel.font = [UIFont systemFontOfSize:16];
        self.amountLabel.textColor = [UIColor blackColor];
        self.amountLabel.textAlignment = NSTextAlignmentRight;
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        line.backgroundColor = LD_colorRGBValue(0xF3F7F9);
        
        self.amountLabel.text = @"+5000";
        _currencyNameLabel.text = @"玩贝";
        self.orderTypeLabel.text = @"积分兑换";
        self.timeLabel.text = @"2018.12.08 12:09:38";
    }
    return self;
}

- (void)setCreditOrder:(QDCreditOrder *)creditOrder {
    _creditOrder = creditOrder;
    NSString *amountString;
    if (_creditOrder.tradingDirection == 0) {
        amountString = [NSString stringWithFormat:@"+%ld",(long)_creditOrder.tradingCount];
    } else {
        amountString = [NSString stringWithFormat:@"-%ld",(long)_creditOrder.tradingCount];
    }
    self.amountLabel.text = amountString;
    
    self.timeLabel.text = [QDDateUtils timeStampConversionNSString:_creditOrder.tradingDate];
    NSInteger index = (_creditOrder.tradingtype+1)>=CreditOrderTypeNames.count?0:_creditOrder.tradingtype+1;
    self.orderTypeLabel.text = CreditOrderTypeNames[index];
    self.currencyNameLabel.text = @"玩贝";
//    self.orderTypeLabel.text = _creditOrder.tradingTypeDesc;
}
- (void)setTradingOrder:(QDTradingOrder *)tradingOrder {
    _tradingOrder = tradingOrder;
    NSString *amountString;
    if (_creditOrder.tradingDirection == 0) {
        amountString = [NSString stringWithFormat:@"+%ld",(long)_tradingOrder.tradingCount];
    } else {
        amountString = [NSString stringWithFormat:@"-%ld",(long)_tradingOrder.tradingCount];
    }
    self.amountLabel.text = amountString;
    
    self.timeLabel.text = [QDDateUtils timeStampConversionNSString:_tradingOrder.tradingDate];
    NSInteger index = (_creditOrder.tradingtype+1)>=TradingOrderTypeNames.count?0:_creditOrder.tradingtype+1;
    self.orderTypeLabel.text = TradingOrderTypeNames[index];
//    self.orderTypeLabel.text = _tradingOrder.tradingTypeDesc;
    self.currencyNameLabel.text = @"元";
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
