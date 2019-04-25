//
//  QDHotelsInAreaViewTableViewCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/27.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelsInAreaViewTableViewCell.h"
#import "AppDelegate.h"
@implementation QDHotelsInAreaViewTableViewCell

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
        _backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_backView];
        
        _picView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"range"]];
        [_backView addSubview:_picView];
        
        _hotelName = [[UILabel alloc] init];
        _hotelName.text = @"上海东方滨江大酒店";
        _hotelName.font = QDBoldFont(19);
        [_backView addSubview:_hotelName];
        
        _startLab = [[UILabel alloc] init];
        _startLab.text = @"66人收藏";
        _startLab.textColor = APP_GRAYCOLOR;
        _startLab.font = QDBoldFont(12);
        [_backView addSubview:_startLab];
        
        _ftLab = [[UILabel alloc] init];
        _ftLab.text = @"588FT";
        _ftLab.font = QDBoldFont(15);
        [_backView addSubview:_ftLab];
        
        _rmbLab = [[UILabel alloc] init];
        _rmbLab.text = @"≈ ¥500.00";
        _rmbLab.textColor = APP_GRAYCOLOR;
        _rmbLab.font = QDFont(11);
        [_backView addSubview:_rmbLab];
        
        _addressLab = [[UILabel alloc] init];
        _addressLab.text = @"陆家嘴 | 浦东新区";
        _addressLab.font = QDFont(11);
        [_backView addSubview:_addressLab];
        
        _recommendLab = [[UILabel alloc] init];
        _recommendLab.text = @"推荐理由";
        _recommendLab.font = QDBoldFont(13);
        [_backView addSubview:_recommendLab];
        
        _descLab = [[UILabel alloc] init];
        _descLab.textColor = APP_GRAYCOLOR;
        _descLab.text = @"这处充满艺术气息的民宿位于市中心的老弄堂这处充满艺术气息的民宿位于市中心的老弄堂这处充满艺术气息的民宿位于市中心的老弄堂这处充满艺术气息的民宿位于市中心的老弄堂";
        _descLab.numberOfLines = 0;
        _descLab.font = QDFont(13);
        [_backView addSubview:_descLab];
        
        _peopleRecommendLab = [[UILabel alloc] init];
        _peopleRecommendLab.text = @"达人推荐";
        _peopleRecommendLab.font = QDBoldFont(13);
        [_backView addSubview:_peopleRecommendLab];
        
        
        _detailBtn = [[UIButton alloc] init];
        [_detailBtn setTitle:@"查看详情" forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = QDFont(13);
        _detailBtn.backgroundColor = APP_GRAYCOLOR;
        [_backView addSubview:_detailBtn];
        
//        for (int i = 1; i <= 4; i++) {
//            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.053*i + SCREEN_WIDTH*0.15*(i-1), SCREEN_WIDTH*0.053*i + SCREEN_WIDTH*0.15*i , SCREEN_WIDTH*0.15, SCREEN_WIDTH*0.15)];
//            img.image = [UIImage imageNamed:@"icon_tabbar_mine_selected"];
//
//        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.mas_equalTo(SCREEN_WIDTH*0.89);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.85);
    }];
    
    [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(_backView);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.27);
    }];

    [_hotelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.053);
        make.top.equalTo(_picView.mas_bottom).offset(SCREEN_HEIGHT*0.053);
    }];

    [_startLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_hotelName);
        make.right.equalTo(_backView.mas_right).offset(-(SCREEN_WIDTH*0.053));
    }];

    [_ftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hotelName);
        make.top.equalTo(_hotelName.mas_bottom).offset(SCREEN_HEIGHT*0.015);
    }];

    [_rmbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_ftLab);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.237);
    }];
    
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_ftLab);
        make.right.equalTo(_startLab);
    }];
    
    [_recommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ftLab);
        make.top.equalTo(_ftLab.mas_bottom).offset(SCREEN_HEIGHT*0.022);
    }];
    
    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_recommendLab.mas_bottom).offset(SCREEN_HEIGHT*0.007);
        make.width.mas_equalTo(SCREEN_WIDTH*0.787);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.1);
    }];
    [_peopleRecommendLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_ftLab);
        make.top.equalTo(_descLab.mas_bottom).offset(SCREEN_HEIGHT*0.022);
    }];
    
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_picView.mas_bottom).offset(SCREEN_HEIGHT*0.5);
        make.width.mas_equalTo(SCREEN_WIDTH*0.787);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
}

-(void)fillContentWithModel:(QDHotelListInfoModel *)infoModel andImgData:(NSData *)imgData{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.hotelName.text = infoModel.hotelName;
    self.startLab.text = [NSString stringWithFormat:@"%@人收藏",infoModel.collectCount];
    self.ftLab.text = [NSString stringWithFormat:@"%@FT 起", infoModel.collectCount];
    double ss = [infoModel.price doubleValue] * delegate.basePirceRate;
    self.rmbLab.text = [NSString stringWithFormat:@"折合人民币%.f元", ss];
//    self.recommendLab.text = infoModel.isRecommend
    self.addressLab.text = infoModel.address;
    self.picView.image = [UIImage imageWithData:imgData];
//    self.detailBtn.tag =
}
@end
