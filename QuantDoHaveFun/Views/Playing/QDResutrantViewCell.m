//
//  QDCustomTourCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDResutrantViewCell.h"
#import "AppDelegate.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UIView+Animated.h"

@implementation QDResutrantViewCell

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
        _thePic.layer.cornerRadius = 4;
        _thePic.layer.masksToBounds = YES;
        _thePic.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_thePic];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = QDFont(16);
        _titleLab.numberOfLines = 0;
        _titleLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_titleLab];
        
        _wanbei = [[UILabel alloc] init];
        _wanbei.font = QDBoldFont(18);
        _wanbei.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbei];
        
        _wanbeiLab = [[UILabel alloc] init];
        _wanbeiLab.font = QDBoldFont(13);
        _wanbeiLab.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbeiLab];
        
        _costLab = [[UILabel alloc] init];
        _costLab.font = QDFont(13);
        _costLab.textColor = APP_GRAYLINECOLOR;
        _costLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_costLab];
        
        _typeLab = [[UILabel alloc] init];
        _typeLab.font = QDFont(14);
        _typeLab.text = @"西餐";
        _typeLab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_typeLab];
        
        _addressLab = [[UILabel alloc] init];
        _addressLab.font = QDFont(14);
        _addressLab.numberOfLines = 0;
        _addressLab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_addressLab];
        
        _quanLab = [[UILabel alloc] init];
        _quanLab.font = QDFont(12);
        _quanLab.text = @"券";
        _quanLab.textAlignment = NSTextAlignmentCenter;
        _quanLab.textColor = APP_BLUECOLOR;
        _quanLab.layer.borderWidth = 1;
        _quanLab.layer.borderColor = APP_BLUECOLOR.CGColor;
        _quanLab.layer.backgroundColor = [UIColor colorWithRed:232/255.0 green:247/255.0 blue:248/255.0 alpha:1.0].CGColor;
        _quanLab.layer.cornerRadius = 4;
        _quanLab.layer.masksToBounds = YES;
        [self.contentView addSubview:_quanLab];
        
        _infoLab = [[UILabel alloc] init];
        _infoLab.font = QDFont(13);
        _infoLab.text = @"领券买单有优惠";
        _infoLab.textColor = APP_BLUECOLOR;
        [self.contentView addSubview:_infoLab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_thePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(100);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_thePic.mas_right).offset(15);
        make.top.equalTo(_thePic);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
    
    [_wanbei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(12);
    }];
    
    [_wanbeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wanbei.mas_right);
        make.bottom.equalTo(_wanbei);
    }];
    
    [_costLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wanbeiLab.mas_right).offset(2);
        make.centerY.equalTo(self.wanbeiLab);
    }];
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wanbei);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(_wanbei.mas_bottom).offset(3);
    }];
    
//    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_wa);
//        make.left.equalTo(_typeLab.mas_right).offset(5);
//    }];
    
//    [_quanLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_typeLab);
//        make.top.equalTo(_typeLab.mas_bottom).offset(5);
//        make.width.and.height.mas_equalTo(18);
//    }];
//    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_quanLab.mas_right).offset(5);
//        make.centerY.equalTo(_quanLab);
//    }];
}

-(void)fillRestaurant:(ResturantModel *)infoModel andImgURL:(NSString *)imgURL{
    self.costLab.text = @"人均消费";
    self.wanbeiLab.text = @"玩贝";
    self.titleLab.text = infoModel.restaurantName;
    self.wanbei.text = infoModel.perCapita;
    self.addressLab.text = infoModel.address;
    [self.thePic sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
}

@end
