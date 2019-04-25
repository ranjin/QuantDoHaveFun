//
//  QDHomePageViewCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/17.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RanklistDTO.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDHomePageViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIImageView *typePic; //酒店类型+图片
@property (nonatomic, strong) UILabel *typeLab;     //酒店类型文字

@property (nonatomic, strong) UIImageView *pic;

@property (nonatomic, strong) UIImageView *hoteTypeImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *warnLab1;
@property (nonatomic, strong) UILabel *hates;

@property (nonatomic, strong) UIImageView *robbotPic;

@property (nonatomic, strong) UIView *grayBackView;

@property (nonatomic, strong) UILabel *textOnView;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *warnLab2;
@property (nonatomic, strong) UILabel *likes;

- (void)loadTableViewCellDataWithModel:(RanklistDTO *)model;
@end

NS_ASSUME_NONNULL_END
