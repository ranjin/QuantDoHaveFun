//
//  QDMallTableCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMallTableCell.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "UIView+Animated.h"

@implementation QDMallTableCell

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
        _hotelImg.layer.cornerRadius = 5;
        _hotelImg.layer.masksToBounds = YES;
        _hotelImg.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_hotelImg];
        
        _hotelName = [[UILabel alloc] init];
        _hotelName.font = QDBoldFont(15);
        _hotelName.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_hotelName];
        
        _wanbei = [[UILabel alloc] init];
        _wanbei.font = QDFont(17);
        _wanbei.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbei];
        
        _wanbeiLab = [[UILabel alloc] init];
        _wanbeiLab.font = QDFont(12);
        _wanbeiLab.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_wanbeiLab];
        
        _yueLab = [[UILabel alloc] init];
        _yueLab.font = QDFont(12);
        _yueLab.textColor = APP_GRAYCOLOR;
        _yueLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_yueLab];
        
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = QDBoldFont(13);
        _priceLab.textColor = APP_GRAYTEXTCOLOR;
        [self.contentView addSubview:_priceLab];
        
        _salesLab = [[UILabel alloc] init];
        _salesLab.font = QDFont(12);
        _salesLab.textColor = APP_GRAYCOLOR;
        _salesLab.loadStyle = TABViewLoadAnimationWithOnlySkeleton;
        [self.contentView addSubview:_salesLab];
        
        _totalSales = [[UILabel alloc] init];
        _totalSales.font = QDFont(13);
        _totalSales.textColor = APP_BLUECOLOR;
        [self.contentView addSubview:_totalSales];
        
//        _isShipping = [[UILabel alloc] init];
//        _isShipping.textColor = APP_BLUECOLOR;
//        _isShipping.textAlignment = NSTextAlignmentCenter;
//        _isShipping.font = QDFont(11);
//
//        _isShipping.layer.backgroundColor = [UIColor colorWithRed:2/255.0 green:170/255.0 blue:176/255.0 alpha:0.09].CGColor;
//        _isShipping.layer.cornerRadius = 2;
//        _isShipping.layer.masksToBounds = YES;
//        [self.contentView addSubview:_isShipping];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_hotelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.054);
        make.width.and.height.mas_equalTo(74);
    }];
    
    [_hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_hotelImg);
        make.left.equalTo(self.hotelImg.mas_right).offset(19);
        make.right.equalTo(self.mas_right).offset(-(3));
    }];
    
    [_yueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_hotelImg);
        make.left.equalTo(_wanbei);
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.left.equalTo(_yueLab.mas_right).offset(SCREEN_WIDTH*0.006);
    }];
    
    [_wanbei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_yueLab.mas_top).offset(-8);
        make.left.equalTo(_hotelName);
    }];
    
    [_wanbeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_wanbei);
        make.left.equalTo(_wanbei.mas_right);
    }];
    
    [_salesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.right.equalTo(self.mas_left).offset(326);
    }];
    
    [_totalSales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_yueLab);
        make.right.equalTo(_salesLab.mas_left).offset(-(SCREEN_WIDTH*0.003));
    }];
//
//    [_isShipping mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_yueLab);
//        make.left.equalTo(_priceLab.mas_right).offset(SCREEN_WIDTH*0.03);
//        make.width.mas_equalTo(34);
//        make.height.mas_equalTo(18);
//    }];
}

- (void)fillContentWithModel:(QDMallModel *)mallModel{
    self.wanbeiLab.text = @"玩贝";
    self.yueLab.text = @"约";
    self.salesLab.text = @"已售";
    self.isShipping.text = @"包邮";
    self.hotelName.text = mallModel.goodsName;
    self.totalSales.text = [NSString stringWithFormat:@"%@",mallModel.virtualSales];
    self.wanbei.text = [NSString stringWithFormat:@"%@", mallModel.shopCredit];
    NSString *ss = [NSString stringWithFormat:@"¥%.2lf", [mallModel.shopPrice doubleValue]];
    self.priceLab.text = ss;
    if ([mallModel.isShipping isEqualToString:@"0"]) {
        [self.isShipping setHidden:YES];
    }else{
        [self.isShipping setHidden:NO];
    }
    NSString *imgStr = mallModel.goodsImg;
    //    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //    BOOL isCached = [manager cachedImageExistsForURL:[NSURL URLWithString:imgURL] completion:nil];
    if (imgStr == nil) {
        self.hotelImg.image = [UIImage imageNamed:@"placeHolder"];
    }else{
        [self.hotelImg sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
    }
}
@end
