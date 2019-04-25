//
//  QDCustomTourCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDCustomTourCell.h"
#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UIView+Animated.h"

@implementation QDCustomTourCell

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
        _thePic = [[UIImageView alloc] init];
        _thePic.image = [UIImage imageNamed:@"placeHolder"];
        _thePic.layer.cornerRadius = 5;
        _thePic.layer.masksToBounds = YES;
        _thePic.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_thePic];
        
        _thePic.layer.shadowColor = APP_GRAYCOLOR.CGColor;
        // 阴影偏移，默认(0, -3)
        _thePic.layer.shadowOffset = CGSizeMake(13,13);
        // 阴影透明度，默认0
        _thePic.layer.shadowOpacity = 13;
        // 阴影半径，默认3
        _thePic.layer.shadowRadius = 6;
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = QDBoldFont(16);
        _titleLab.numberOfLines = 0;
        _titleLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_titleLab];
        
        _wanbei = [[UILabel alloc] init];
        _wanbei.font = QDBoldFont(20);
        _wanbei.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbei];
        
        _wanbeiLab = [[UILabel alloc] init];
        _wanbeiLab.font = QDBoldFont(16);
        _wanbeiLab.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbeiLab];
        
        _yueLab = [[UILabel alloc] init];
        _yueLab.font = QDFont(14);
        _yueLab.textColor = APP_GRAYLINECOLOR;
        _yueLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_yueLab];
        
        _rmbLab = [[UILabel alloc] init];
        _rmbLab.font = QDFont(15);
        _rmbLab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_rmbLab];
        
        _info1Lab = [[UILabel alloc] init];
        _info1Lab.font = QDFont(13);
        _info1Lab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_info1Lab];
        
        _info2Lab = [[UILabel alloc] init];
        _info2Lab.font = QDFont(13);
        _info2Lab.textColor = APP_BLUECOLOR;
        [self.contentView addSubview:_info2Lab];
        
        _info3Lab = [[UILabel alloc] init];
        _info3Lab.font = QDFont(13);
        _info3Lab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_info3Lab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_thePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(SCREEN_HEIGHT*0.03);
        make.width.mas_equalTo(335);
        make.height.mas_equalTo(250);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_thePic);
        make.top.equalTo(self.thePic.mas_bottom).offset(SCREEN_WIDTH*0.02);
        make.width.mas_equalTo(315);
    }];
    
    [_wanbei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(SCREEN_HEIGHT*0.015);
    }];
    
    [_wanbeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wanbei.mas_right);
        make.centerY.equalTo(_wanbei);
    }];
    
    [_yueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wanbei);
        make.top.equalTo(_wanbei.mas_bottom).offset(3);
    }];

    [_rmbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.left.equalTo(_yueLab.mas_right);
    }];
    [_info1Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thePic.mas_left).offset(SCREEN_WIDTH*0.65);
        make.top.equalTo(_wanbeiLab.mas_bottom);
    }];
    [_info2Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info1Lab.mas_right);
        make.centerY.equalTo(_info1Lab);
    }];
    
    [_info3Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_info2Lab.mas_right);
        make.centerY.equalTo(_info1Lab);
    }];
}

-(void)fillCustomTour:(CustomTravelDTO *)infoModel andImgURL:(NSString *)imgURL{
    self.wanbeiLab.text = @"玩贝";
    self.yueLab.text = @"约";
    self.info1Lab.text = @"提前";
    self.info3Lab.text = @"天预定";
    self.titleLab.text = infoModel.travelName;
    self.wanbei.text = [NSString stringWithFormat:@"%@", infoModel.creditPirce];
    self.rmbLab.text = [NSString stringWithFormat:@"¥%@",infoModel.singleCost];
    self.info2Lab.text = [NSString stringWithFormat:@"%ld", (long)infoModel.preBuyDays];
    [self.thePic sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
}

@end
