//
//  VIPRightsView.h
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/25.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopRightsNotLoginHeadView.h"
#import "TopRightsLoginHeadView.h"
NS_ASSUME_NONNULL_BEGIN

@interface VIPRightsView : UIView

@property (nonatomic, strong) UIView *whiteBackView;
@property (nonatomic, strong) UIImageView *topBlueView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) TopRightsLoginHeadView *loginHeadView;
@property (nonatomic, strong) TopRightsNotLoginHeadView *noLoginHeadView;

@property (nonatomic, strong) UIView *bottomWhiteView;
@property (nonatomic, strong) UIImageView *balancePic;
@property (nonatomic, strong) UILabel *priceTextLab;
@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UITextField *priceTF;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *bottomLab1;
@property (nonatomic, strong) UILabel *bottomLab2;
@property (nonatomic, strong) UIButton *payButton;

@end

NS_ASSUME_NONNULL_END
