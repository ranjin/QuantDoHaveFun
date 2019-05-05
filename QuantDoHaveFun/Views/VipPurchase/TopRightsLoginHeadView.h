//
//  TopRightsLoginHeadView.h
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/28.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQGradientProgressView.h"
#import "QDMemberDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface TopRightsLoginHeadView : UIView

@property (nonatomic, strong) UIView *topBlueView;
@property (nonatomic, strong) UIButton *headPic;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *vipTypeLab;

@property (nonatomic, strong) UILabel *protocolLab;
@property (nonatomic, strong) UILabel *vipProgressLab;
@property (nonatomic, strong) UIImageView *leftCircleImg;
@property (nonatomic, strong) MQGradientProgressView *progressView;
@property (nonatomic, strong) UIImageView *rightCircleImg;
@property (nonatomic, strong) UILabel *leftLevelLab;
@property (nonatomic, strong) UILabel *leftLevel;
@property (nonatomic, strong) UILabel *rightLevelLab;
@property (nonatomic, strong) UILabel *rightLevel;

- (void)loadVipViewWithModel:(QDMemberDTO *)member;
@end

NS_ASSUME_NONNULL_END
