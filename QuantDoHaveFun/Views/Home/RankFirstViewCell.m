//
//  QDCustomTourCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "RankFirstViewCell.h"
#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UIView+Animated.h"

@implementation RankFirstViewCell

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
        _backView.backgroundColor = APP_WHITECOLOR;
        [self.contentView addSubview:_backView];
        
        _thePic = [[UIImageView alloc] init];
        _thePic.layer.cornerRadius = 5;
        _thePic.layer.masksToBounds = YES;
        _thePic.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [_backView addSubview:_thePic];
        
//        _thePic.layer.shadowColor = APP_GRAYCOLOR.CGColor;
//        // 阴影偏移，默认(0, -3)
//        _thePic.layer.shadowOffset = CGSizeMake(13,13);
//        // 阴影透明度，默认0
//        _thePic.layer.shadowOpacity = 13;
//        // 阴影半径，默认3
//        _thePic.layer.shadowRadius = 6;
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = QDBoldFont(16);
        _titleLab.numberOfLines = 0;
        _titleLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [_backView addSubview:_titleLab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(361);
        make.height.mas_equalTo(266);
    }];
    
    [_thePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.equalTo(_backView);
        make.height.mas_equalTo(203);
    }];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(15);
        make.top.equalTo(self.thePic.mas_bottom).offset(19);
        make.width.mas_equalTo(238);
    }];
}

- (void)loadVideoDataWithArr:(RankFirstVideoModel *)model{
    self.titleLab.text = model.videoTitle;
    [self.thePic sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
}
@end
