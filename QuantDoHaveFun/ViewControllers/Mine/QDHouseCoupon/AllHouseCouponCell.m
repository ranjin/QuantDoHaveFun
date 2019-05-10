//
//  MyTableCell.m
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "AllHouseCouponCell.h"

@implementation AllHouseCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = APP_WHITECOLOR;
        _backView.layer.cornerRadius = 2;
        _backView.layer.masksToBounds = YES;
        [self.contentView addSubview:_backView];
        
        _pic = [[UIImageView alloc] init];
        _pic.image = [UIImage imageNamed:@"houseCoupon"];
        [_backView addSubview:_pic];
        
        _lab = [[UILabel alloc] init];
        _lab.textColor = APP_BLACKCOLOR;
        _lab.font = QDBoldFont(18);
        _lab.numberOfLines = 0;
        [_backView addSubview:_lab];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"重庆华城国际大酒店";
        _titleLab.textColor = APP_BLACKCOLOR;
        _titleLab.font = QDBoldFont(15);
        [_backView addSubview:_titleLab];
        
        _couponNo = [[UILabel alloc] init];
        _couponNo.text = @"券号:121314000000000";
        _couponNo.textColor = APP_GRAYLINECOLOR;
        _couponNo.font = QDFont(11);
        [_backView addSubview:_couponNo];
        
        _deadLineLab = [[UILabel alloc] init];
        _deadLineLab.text = @"有效期至:2019-01-09";
        _deadLineLab.textColor = APP_GRAYTEXTCOLOR;
        _deadLineLab.font = QDFont(12);
        [_backView addSubview:_deadLineLab];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.text = @"此房劵仅适用于该酒店指定房型";
        _infoLab.textColor = APP_GRAYTEXTCOLOR;
        _infoLab.font = QDFont(12);
        [_backView addSubview:_infoLab];
       
        _info2Lab = [[UILabel alloc] init];
        _info2Lab.text = @"不可使用日期：2019-02-14、2019-02-05";
        _info2Lab.textColor = APP_GRAYTEXTCOLOR;
        _info2Lab.font = QDFont(12);
        [_backView addSubview:_info2Lab];
        
        _info3Lab = [[UILabel alloc] init];
        _info3Lab.text = @"需要提前3天预订";
        _info3Lab.textColor = APP_GRAYTEXTCOLOR;
        _info3Lab.font = QDFont(12);
        [_backView addSubview:_info3Lab];
        
        _ruleBtn = [[SPButton alloc] init];
        [_ruleBtn setTitle:@"规则" forState:UIControlStateNormal];
        _ruleBtn.titleLabel.font = QDFont(12);
        _ruleBtn.backgroundColor = APP_BLUECOLOR;
        [_ruleBtn setTitleColor:APP_GRAYTEXTCOLOR forState:UIControlStateNormal];
        [_ruleBtn setImage:[UIImage imageNamed:@"icon_selectAddress"] forState:UIControlStateNormal];
        [_ruleBtn addTarget:self action:@selector(reLayout:) forControlEvents:UIControlEventTouchUpInside];
        _ruleBtn.imagePosition = SPButtonImagePositionRight;
        [_backView addSubview:_ruleBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(335);
        make.height.mas_equalTo(self.contentView.frame.size.height-30);
    }];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_backView);
        make.height.mas_equalTo(96);
    }];
    
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(15);
        make.centerY.equalTo(_backView);
        make.width.mas_equalTo(72);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(23);
        make.left.equalTo(_backView.mas_left).offset(125);
    }];

    [_couponNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(2);
        make.left.equalTo(_titleLab);
    }];

    [_deadLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_couponNo.mas_bottom).offset(6);
        make.left.equalTo(_titleLab);
    }];
    
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.top.equalTo(_backView.mas_top).offset(106);
    }];
    
    [_info2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.top.equalTo(_backView.mas_top).offset(136);
    }];
    
    [_info3Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.top.equalTo(_info2Lab.mas_bottom).offset(1);
    }];
    
    [_ruleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_infoLab);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.width.and.height.mas_equalTo(40);
    }];
}

- (void)reLayout:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.reLayoutBlock) {
        self.reLayoutBlock(sender.selected);
    }
    if (sender.selected) {
        [_ruleBtn setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
//            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(335);
            make.height.mas_equalTo(176);
        }];
    }else{
        [_ruleBtn setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateNormal];
        [_backView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
//            make.top.equalTo(self.contentView);
            make.width.mas_equalTo(335);
            make.height.mas_equalTo(136);
        }];
    }
}
- (void)loadCouponViewWithModel:(HotelCouponDetailDTO *)model{
    self.pic.image = [UIImage imageNamed:@"houseCoupon"];
    self.titleLab.text = model.hotelName;
    self.lab.text = model.roomTypeName;
    NSString *ss = [self timeStampConversionNSString:model.overdueDate];
    self.deadLineLab.text = [NSString stringWithFormat:@"有效期至:%@", ss];
    self.info3Lab.text = [NSString stringWithFormat:@"需要提前%@天预定", model.advanceDays];
}

- (NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
//+ (CGFloat)cellDefaultHeight:(TextEntity *)entity{
//    return 136;
//}
//
//+ (CGFloat)cellMoreHeight:(TextEntity *)entity{
//    return 176;
//}
@end
