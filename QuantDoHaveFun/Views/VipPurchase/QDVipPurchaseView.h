//
//  QDVipPurchaseView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/17.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLCollectionView.h"
#import "MQGradientProgressView.h"
#import "QDMemberDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDVipPurchaseView : UIView
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *returnBtn;

@property (nonatomic, strong) UIButton *protocolBtn;
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UILabel *info1Lab;
@property (nonatomic, strong) UILabel *info2Lab;
@property (nonatomic, strong) UILabel *info3Lab;
@property (nonatomic, strong) UILabel *info4Lab;
@property (nonatomic, strong) UILabel *info5Lab;

@property (nonatomic, strong) UIImageView *leftCircleImg;
@property (nonatomic, strong) MQGradientProgressView *progressView;
@property (nonatomic, strong) UIImageView *rightCircleImg;
@property (nonatomic, strong) UILabel *leftLevelLab;
@property (nonatomic, strong) UILabel *leftLevel;
@property (nonatomic, strong) UILabel *rightLevelLab;
@property (nonatomic, strong) UILabel *rightLevel;

@property (nonatomic, strong) UILabel *priceTextLab;
@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UITextField *priceTF;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *bottomLab1;
@property (nonatomic, strong) UILabel *bottomLab2;
@property (nonatomic, strong) UILabel *bottomLab3;
@property (nonatomic, strong) UILabel *bottomLab4;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, assign) double basePrice;

- (void)loadVipViewWithModel:(QDMemberDTO *)member;
@end

NS_ASSUME_NONNULL_END
