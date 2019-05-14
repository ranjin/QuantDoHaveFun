//
//  QDRoutePlanHeaderView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/1.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDRoutePlanHeaderView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *distanceLab;
@property (nonatomic, strong) UILabel *info1;
@property (nonatomic, strong) UILabel *info2;
@property (nonatomic, strong) UILabel *info3;
@property (nonatomic, strong) UILabel *info4;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *addressPic;
@property (nonatomic, strong) UILabel *addressStr;

@end

NS_ASSUME_NONNULL_END
