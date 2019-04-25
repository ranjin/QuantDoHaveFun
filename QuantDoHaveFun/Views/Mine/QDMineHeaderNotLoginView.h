//
//  QDMineHeaderNotLoginView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDMineSectionHeaderView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDMineHeaderNotLoginView : UIView
@property (nonatomic, strong) UIView *whiteBackView;
@property (nonatomic, strong) UIButton *picBtn;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) QDMineSectionHeaderView *headerView;

@end

NS_ASSUME_NONNULL_END
