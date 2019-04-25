//
//  QDHotelTableViewCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/17.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelTableViewCell.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UITableViewCell+TABLayoutSubviews.h"
#import "UIView+Animated.h"
@implementation QDHotelTableViewCell

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
        _hotelImg = [[UIImageView alloc] init];
        _hotelImg.image = [UIImage imageNamed:@"hotel"];
        _hotelImg.layer.cornerRadius = 5;
        _hotelImg.layer.masksToBounds = YES;
        _hotelImg.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_hotelImg];
        
        _hotelName = [[UILabel alloc] init];
        _hotelName.text = @"";
//        _hotelName.numberOfLines = 0;
        _hotelName.font = QDBoldFont(16);
        _hotelName.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_hotelName];
        
        _wanbei = [[UILabel alloc] init];
        _wanbei.text = @"";
        _wanbei.font = QDBoldFont(18);
        _wanbei.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbei];
        
        _wanbeiLab = [[UILabel alloc] init];
        _wanbeiLab.font = QDBoldFont(13);
        _wanbeiLab.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbeiLab];
        
        _yueLab = [[UILabel alloc] init];
        _yueLab.font = QDFont(13);
        _yueLab.textColor = APP_GRAYCOLOR;
        [self.contentView addSubview:_yueLab];
        
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"";
        _priceLab.font = QDBoldFont(14);
        _priceLab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_priceLab];
        
        _starLab = [[UILabel alloc] init];
        _starLab.font = QDFont(12);
        _starLab.textColor = APP_GRAYCOLOR;
        [self.contentView addSubview:_starLab];
        
        _totalStars = [[UILabel alloc] init];
        _totalStars.text = @"";
        _totalStars.font = QDFont(12);
        _totalStars.textColor = APP_BLUECOLOR;
        [self.contentView addSubview:_totalStars];
        
        _locationLab = [[UILabel alloc] init];
        _locationLab.text = @"";
//        _locationLab.numberOfLines = 0;
        _locationLab.font = QDBoldFont(12);
        _locationLab.textColor = APP_GRAYCOLOR;
        _locationLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_locationLab];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_hotelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.054);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(98);
    }];
    
    [_hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelImg);
        make.left.equalTo(self.hotelImg.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-(5));
    }];
    
    [_wanbei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelName.mas_bottom).offset(10);
        make.left.equalTo(_hotelImg.mas_right).offset(15);
    }];
    
    [_wanbeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_wanbei);
        make.left.equalTo(_wanbei.mas_right).offset(2);
    }];
    
    [_yueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_wanbei.mas_bottom).offset(2);
        make.left.equalTo(_wanbei);
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.left.equalTo(_yueLab.mas_right).offset(SCREEN_WIDTH*0.006);
    }];
    
    [_starLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];

    [_totalStars mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.right.equalTo(_starLab.mas_left).offset(-(SCREEN_WIDTH*0.003));
    }];

    [_locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yueLab);
        make.bottom.equalTo(self.hotelImg);
        make.right.equalTo(self.mas_right).offset(-(5));
    }];
}

-(void)fillContentWithModel:(QDHotelListInfoModel *)infoModel andImgURLStr:(NSString *)imgURL{
    self.wanbeiLab.text = @"玩贝";
    self.yueLab.text = @"约";
    self.starLab.text = @"收藏";
    self.hotelName.text = infoModel.hotelName;
    self.totalStars.text = [NSString stringWithFormat:@"%@",infoModel.collectCount];
    self.priceLab.text = [NSString stringWithFormat:@"%.2lf", [infoModel.rmbprice doubleValue]];;
    self.wanbei.text = infoModel.price;
    self.locationLab.text = infoModel.address;
//    SDWebImageManager *manager = [SDWebImageManager sharedManager];
//    BOOL isCached = [manager cachedImageExistsForURL:[NSURL URLWithString:imgURL] completion:nil];
    [self.hotelImg sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
}

@end
