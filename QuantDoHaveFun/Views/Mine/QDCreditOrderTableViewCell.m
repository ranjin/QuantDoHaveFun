//
//  QDCreditOrderTableViewCell.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/7.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDCreditOrderTableViewCell.h"

@interface QDCreditOrderTableViewCell ()
@property(nonatomic,strong)UIImageView *orderIcon;
@property(nonatomic,strong)UILabel *orderTypeLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *amountLabel;
@end

@implementation QDCreditOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
            make.top.equalTo(self.contentView.mas_top).offset(20);
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
        
//        UILabel *currencyNameLabel = [[UILabel alloc]init];
//        [self.contentView addSubview:currencyNameLabel];
//        [currencyNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).offset(12);
//            make.top.equalTo(self.contentView.mas_top).offset(24);
//            make.width.mas_equalTo();
//        }];
    }
    return self;
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
