//
//  QDHomePageTopView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/17.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHomePageTopView : UIView

@property(nonatomic, strong) SPButton *addressBtn;
@property(nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *searchBtn;

//会员申购 攻略 定制游 商城
@property(nonatomic, strong) UIButton *hysgBtn;
//@property(nonatomic, strong) UIButton *glBtn;
@property(nonatomic, strong) UIButton *dzyBtn;
@property(nonatomic, strong) UIButton *scBtn;

@property(nonatomic, strong) UILabel *hysgLab;
//@property(nonatomic, strong) UILabel *glLab;
@property(nonatomic, strong) UILabel *dzyLab;
@property(nonatomic, strong) UILabel *scLab;



@end

NS_ASSUME_NONNULL_END
