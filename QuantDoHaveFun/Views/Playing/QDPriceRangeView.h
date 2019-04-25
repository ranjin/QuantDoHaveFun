//
//  QDPriceRangeView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/1.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFDualWaySlider.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDPriceRangeView : UIView

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *priceDetailLab;

@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) SFDualWaySlider *slider;

@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UILabel *rightLab;

@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UILabel *lab6;

@end

NS_ASSUME_NONNULL_END
