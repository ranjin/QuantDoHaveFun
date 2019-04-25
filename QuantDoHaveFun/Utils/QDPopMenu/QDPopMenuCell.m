//
//  QDPopMenuCell.m
//  TravelPoints
//
//  Created by Charles Ran on 2019/02/20.
//  Copyright © 2019年 quantdo. All rights reserved.
//

#import "QDPopMenuCell.h"

@implementation QDPopMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _menuTitleLabel = [[UILabel alloc] init];
        _menuTitleLabel.font = QDFont(16);
        _menuTitleLabel.textColor = APP_BLACKCOLOR;
        _menuTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_menuTitleLabel];
        
        [_menuTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).offset(20);
        }];
        
        _selectImg = [[UIImageView alloc] init];
        _selectImg.image = [UIImage imageNamed:@"icon_checkSelected"];
        [self addSubview:_selectImg];
        
        [_selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).offset(-31);
        }];
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

