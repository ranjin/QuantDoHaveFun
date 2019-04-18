//
//  QDMineInfoTableViewCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/22.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMineInfoTableViewCell.h"

@implementation QDMineInfoTableViewCell

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
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = APP_BLACKCOLOR;
        _titleLab.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLab];
        
        _indicatorPic = [[UIImageView alloc] init];
        _indicatorPic.image = [UIImage imageNamed:@"home_dropDown"];
        [self.contentView addSubview:_indicatorPic];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.05);
    }];
    [_indicatorPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-(SCREEN_WIDTH*0.09));
    }];
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextFillRect(context, rect);
//
//    //上分割线，
////    CGContextSetStrokeColorWithColor(context, APP_BLUECOLOR.CGColor);
////    CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
//
//    //下分割线
//    CGContextSetStrokeColorWithColor(context, APP_BLUECOLOR.CGColor);
//    CGContextStrokeRect(context, CGRectMake(20, rect.size.height, 335, 0.5));
//}

@end
