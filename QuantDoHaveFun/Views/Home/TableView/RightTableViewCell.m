//
//  RightTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "RightTableViewCell.h"
#import "CategoryModel.h"

@implementation RightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = APP_WHITECOLOR;
        [self.contentView addSubview:self.backView];
        
        self.imageV = [[UIImageView alloc] init];
        self.imageV.image = [UIImage imageNamed:@"test2"];
        [_backView addSubview:self.imageV];

        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.textColor = APP_BLACKCOLOR;
        self.nameLabel.font = QDFont(14);
        [_backView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setModel:(FoodModel *)model
{
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.picture]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",@(model.min_price)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(249);
        make.height.mas_equalTo(100);
    }];
    
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.height.equalTo(_backView);
        make.width.mas_equalTo(100);
    }];

    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageV.mas_right).offset(17);
        make.top.equalTo(_backView.mas_top).offset(17);
        make.width.mas_equalTo(126);
    }];
}

- (void)loadDataWithRankModel:(RanklistDTO *)rankModel{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:rankModel.imageFullUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
    self.nameLabel.text = rankModel.topicDescribe;
}
@end
