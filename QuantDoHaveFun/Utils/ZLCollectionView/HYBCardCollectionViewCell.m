//
//  HYBCardCollectionViewCell.m
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBCardCollectionViewCell.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

@interface HYBCardCollectionViewCell ()

@property (nonatomic, strong) UIView *imageView;

@end

@implementation HYBCardCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
      self.contentView.backgroundColor = APP_WHITECOLOR;
      _backView = [[UIView alloc] init];
      _backView.backgroundColor = APP_WHITECOLOR;
      
      _backView.layer.borderColor = APP_LIGHTGRAYCOLOR.CGColor;
      _backView.layer.borderWidth = 1;
      _backView.layer.cornerRadius = 8;
      _backView.layer.masksToBounds = YES;
//      [self addShadowToView:self.contentView withColor:APP_LIGHTGRAYCOLOR];
      [self.contentView addSubview:_backView];
      
      
      _pic = [[UIImageView alloc] init];
      _pic.layer.cornerRadius = 12;
      [_backView addSubview:_pic];
      
      //默认这好住图片
      _typePic = [[UIImageView alloc] init];
      _typePic.image = [UIImage imageNamed:@"hotel_zhz"];
      [_backView addSubview:_typePic];
      
      _descLab = [[UILabel alloc] init];
      _descLab.text = @"揭秘中国设计NO.1究竟是怎样一个宝藏酒店?";
      _descLab.textColor = APP_WHITECOLOR;
      _descLab.font = QDBoldFont(17);
      _descLab.numberOfLines = 0;
      [_backView addSubview:_descLab];
      
      //默认这好住图片
      _typePic = [[UIImageView alloc] init];
      _typePic.image = [UIImage imageNamed:@"hotel_zhz"];
      [_backView addSubview:_typePic];
      
      _typeLab = [[UILabel alloc] init];
      _typeLab.textColor = APP_WHITECOLOR;
      _typeLab.font = QDFont(16);
      [_backView addSubview:_typeLab];
      
      _titleLab = [[UILabel alloc] init];
      _titleLab.text = @"中国大神设计酒店云南TOP10排行榜";
      _titleLab.textColor = APP_BLACKCOLOR;
      _titleLab.font = QDFont(17);
      [_backView addSubview:_titleLab];
      
      _lineView = [[UIView alloc] init];
      _lineView.backgroundColor = APP_LIGHTGRAYCOLOR;
      [_backView addSubview:_lineView];
      
      _warnLab1 = [[UILabel alloc] init];
      _warnLab1.text = @"过滤无效评价";
      _warnLab1.textColor = APP_GRAYTEXTCOLOR;
      _warnLab1.font = QDFont(12);
      [_backView addSubview:_warnLab1];
      
      _hates = [[UILabel alloc] init];
      _hates.text = @"2080";
      _hates.textColor = APP_BLUECOLOR;
      _hates.font = QDFont(13);
      [_backView addSubview:_hates];
      
      _grayBackView = [[UIView alloc] init];
      _grayBackView.backgroundColor = [UIColor colorWithHexString:@"#757682"];
      _grayBackView.layer.cornerRadius = 15;
      _grayBackView.layer.masksToBounds = YES;
      [_backView addSubview:_grayBackView];
      
      _textOnView = [[UILabel alloc] init];
      _textOnView.textColor = APP_WHITECOLOR;
      _textOnView.font = QDFont(12);
      [_backView addSubview:_textOnView];
      
      _robbotPic = [[UIImageView alloc] init];
      _robbotPic.image = [UIImage imageNamed:@"robbot"];
      [_backView addSubview:_robbotPic];
      
      _warnLab2 = [[UILabel alloc] init];
      _warnLab2.text = @"筛选优质评价";
      _warnLab2.textColor = APP_GRAYTEXTCOLOR;
      _warnLab2.font = QDFont(12);
      [_backView addSubview:_warnLab2];
      
      _likes = [[UILabel alloc] init];
      _likes.text = @"2080";
      _likes.textColor = APP_BLUECOLOR;
      _likes.font = QDFont(13);
      [_backView addSubview:_likes];
  }
  
  return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-(5));
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-(5));
    }];
    
    [_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(_backView);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.43);
    }];

    [_descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pic.mas_top).offset(SCREEN_HEIGHT*0.03);
        make.left.equalTo(_pic.mas_left).offset(SCREEN_WIDTH*0.24);
        make.right.equalTo(_pic.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];

    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_pic.mas_bottom).offset(SCREEN_HEIGHT*0.02);
    }];
    
    [_typePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView);
        make.left.equalTo(self.contentView.mas_left).offset(SCREEN_WIDTH*0.05);
    }];
    
    [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_typePic);
    }];
    
    [_grayBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backView);
        make.top.equalTo(_titleLab.mas_bottom).offset(SCREEN_HEIGHT*0.03);
        make.width.mas_equalTo(SCREEN_WIDTH*0.72);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.034);
    }];
    
    [_robbotPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_grayBackView);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.03);
    }];
    
    [_textOnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_grayBackView);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(SCREEN_HEIGHT*0.07);
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.44);
        make.width.mas_equalTo(SCREEN_WIDTH*0.003);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.03);
    }];
    
    [_warnLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(SCREEN_WIDTH*0.12);
        make.top.equalTo(_titleLab.mas_bottom).offset(SCREEN_HEIGHT*0.07);
    }];
    
    [_hates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_warnLab1);
        make.left.equalTo(_warnLab1.mas_right).offset(SCREEN_WIDTH*0.01);
    }];
    

    [_warnLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_warnLab1);
        make.left.equalTo(_lineView.mas_right).offset(SCREEN_WIDTH*0.02);
        make.top.equalTo(_pic.mas_bottom).offset(SCREEN_HEIGHT*0.02);
    }];

    [_likes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_warnLab2);
        make.left.equalTo(_warnLab2.mas_right).offset(SCREEN_WIDTH*0.01);
    }];
}

- (void)loadCellDataWithModel:(RanklistDTO *)model{
    self.typeLab.text = model.labelsContent;
    self.descLab.text = model.topicName;
    self.titleLab.text = model.topicDescribe;
    self.textOnView.text = [NSString stringWithFormat:@"本榜单已由Aigo为您运算了%@家酒店", model.totalquantity];
    self.hates.text = model.invalidCommentCount;
    self.likes.text = model.validCommentCount;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.imageFullUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"] options:SDWebImageLowPriority];
}

/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(4,5);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 12;
}
@end
