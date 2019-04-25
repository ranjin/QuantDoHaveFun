//
//  QDPickOrderView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/14.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDMyPickOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDPickOrderView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UILabel *remainLab;
@property (nonatomic, strong) UILabel *remain;



@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UILabel *operationType;
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UILabel *lab5;
@property (nonatomic, strong) UILabel *lab6;
@property (nonatomic, strong) UILabel *lab7;
@property (nonatomic, strong) UILabel *lab8;
@property (nonatomic, strong) UILabel *lab9;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UILabel *bdNumLab;
@property (nonatomic, strong) UILabel *bdNum;
@property (nonatomic, strong) UILabel *zdNumLab;
@property (nonatomic, strong) UILabel *zdNum;
@property (nonatomic, strong) UILabel *bdTimeLab;
@property (nonatomic, strong) UILabel *bdTime;
@property (nonatomic, strong) UIButton *payBtn;

@property (nonatomic, strong) UIButton *withdrawBtn;


- (void)loadViewWithModel:(QDMyPickOrderModel *)model;
@end

NS_ASSUME_NONNULL_END
