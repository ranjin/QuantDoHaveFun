//
//  HYBCardCollectionViewCell.h
//  CollectionViewDemos
//
//  Created by huangyibiao on 16/3/26.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RanklistDTO.h"
@interface HYBCardCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UIImageView *typePic; //酒店类型+图片
@property (nonatomic, strong) UILabel *typeLab;

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *warnLab1;
@property (nonatomic, strong) UILabel *hates;

@property (nonatomic, strong) UIImageView *robbotPic;

@property (nonatomic, strong) UIView *grayBackView;

@property (nonatomic, strong) UILabel *textOnView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *warnLab2;
@property (nonatomic, strong) UILabel *likes;

- (void)loadCellDataWithModel:(RanklistDTO *)model;

@end
