//
//  QDCustomTourCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankFirstVideoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RankFirstViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *thePic;
@property (nonatomic, strong) UILabel *titleLab;

- (void)loadVideoDataWithArr:(RankFirstVideoModel *)model;
@end

NS_ASSUME_NONNULL_END
