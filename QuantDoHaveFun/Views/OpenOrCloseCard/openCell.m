/*
 **
 * @file: openCell
 * @brief:展开的视图cell
 * Copyright: Copyright © 2018
 * Company:岚家小红担
 * @author: 岚家小红担
 * @version: V1.0
 * @date: 2018-10-17
 **/

#import "openCell.h"
#import "UIView+ML_Extension.h"

@implementation openCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        _backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 335, 176)];
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        _backView.layer.cornerRadius = 2;
        _backView.clipsToBounds = YES;
        _backView.layer.masksToBounds = YES;
        [self.contentView addSubview:_backView];
        
        _pic = [[UIImageView alloc] init];
        _pic.image = [UIImage imageNamed:@"houseCoupon"];
        [_backView addSubview:_pic];
        
        _lab = [[UILabel alloc] init];
        _lab.textColor = [UIColor colorWithHexString:@"#553906"];
        _lab.font = QDBoldFont(26);
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
        [_ruleBtn setTitleColor:APP_GRAYTEXTCOLOR forState:UIControlStateNormal];
        [_ruleBtn setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateNormal];
        [_ruleBtn addTarget:self action:@selector(closeMemberView:) forControlEvents:UIControlEventTouchUpInside];
        _ruleBtn.imagePosition = SPButtonImagePositionRight;
        [_backView addSubview:_ruleBtn];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_backView);
        make.height.mas_equalTo(96);
    }];
    
    [_lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_pic);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(23);
        make.left.equalTo(_backView.mas_left).offset(130);
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
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(60);
    }];
}

- (void)loadCouponViewWithModel:(HotelCouponDetailDTO *)model{
    self.titleLab.text = model.hotelName;
    self.lab.text = model.roomTypeName;
    NSString *ss = [self timeStampConversionNSString:model.overdueDate];
    self.deadLineLab.text = [NSString stringWithFormat:@"有效期至:%@", ss];
    self.info3Lab.text = [NSString stringWithFormat:@"需要提前%@天预定", model.advanceDays];
    self.info2Lab.text = [NSString stringWithFormat:@"不可使用日期:%@", model.notUseDate];
}

- (NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (void)closeMemberView:(UIButton *)btn{
    
    [self.indexArr removeObject:[NSString stringWithFormat:@"%d",self.index]];
    
    if ([self.delegate respondsToSelector:@selector(baseCell:btnType:WithIndex:withArr:)])
    {
        [self.delegate baseCell:self btnType:CLOSE WithIndex:self.index withArr:self.indexArr];
    }
}


@end
