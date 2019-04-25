//
//  QDHotelTypeCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelTypeCell.h"

@implementation QDHotelTypeCell

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
        _selectedImg = [[UIImageView alloc] init];
        _selectedImg.image = [UIImage imageNamed:@"ad_collection_red"];
        [self.contentView addSubview:_selectedImg];
        
        _hotelType = [[UILabel alloc] init];
        _hotelType.text = @"不限";
        _hotelType.textColor = [UIColor grayColor];
        _hotelType.font = QDBoldFont(16);
        [self.contentView addSubview:_hotelType];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_selectedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-(SCREEN_WIDTH*0.06));
    }];
    
    [_hotelType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.06);
    }];
}

@end
