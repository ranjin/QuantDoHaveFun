//
//  QDStrategyTableViewCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/27.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDStrategyTableViewCell.h"

@implementation QDStrategyTableViewCell

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
        _pic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"strategy"]];
        [self.contentView addSubview:_pic];
        
        _desc = [[UILabel alloc] init];
        _desc.text = @"忘掉高楼大厦，扎进上海弄堂里寻找接地气的";
        _desc.font = QDBoldFont(13);
        _desc.numberOfLines = 0;
        [self.contentView addSubview:_desc];
        
        _person = [[UILabel alloc] init];
        _person.text = @"by_小小木头人";
        _person.textColor = APP_GRAYCOLOR;
        _person.font = QDFont(12);
        [self.contentView addSubview:_person];
        
        _watched = [[UILabel alloc] init];
        _watched.text = @"8888浏览";
        _watched.font = QDFont(10);
        [self.contentView addSubview:_watched];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.053);
        make.width.mas_equalTo(SCREEN_WIDTH*0.4);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.18);
    }];
    
    [_desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.48);
        make.top.equalTo(self.contentView.mas_top).offset(SCREEN_HEIGHT*0.04);
        make.right.equalTo(self.contentView.mas_right).offset(SCREEN_WIDTH*0.053);
    }];
    
    [_person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.desc);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-(SCREEN_HEIGHT*0.065));
    }];
    
    [_watched mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_desc);
        make.centerY.equalTo(_person);
    }];
}

-(void)fillContentWithModel:(QDStrategyDTO *)infoModel andImgData:(NSData *)imgData{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.pic.image = [UIImage imageWithData:imgData];
    self.desc.text = infoModel.title;
    self.person.text = infoModel.creater;
    self.watched.text = infoModel.lookNum;
}

@end
