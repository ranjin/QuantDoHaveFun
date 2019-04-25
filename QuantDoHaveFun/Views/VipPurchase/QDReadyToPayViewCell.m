//
//  QDReadyToPayViewCell.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDReadyToPayViewCell.h"

@implementation QDReadyToPayViewCell

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
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = QDFont(16);
        _titleLab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_titleLab];
        
        _detailLab = [[UILabel alloc] init];
        _detailLab.font = QDFont(16);
        [self.contentView addSubview:_detailLab];
        
        _cxsBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        [_cxsBtn setImage:[UIImage imageNamed:@"icon_selectAddress"] forState:UIControlStateNormal];
        _cxsBtn.titleLabel.font = QDFont(16);
        [_cxsBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        [self.contentView addSubview:_cxsBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.05);
    }];
    
    [_detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLab);
        make.right.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
    
    [_cxsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLab);
        make.right.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
}
@end
