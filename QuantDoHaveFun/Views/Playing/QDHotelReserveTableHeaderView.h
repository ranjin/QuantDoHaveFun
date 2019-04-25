//
//  QDHotelReserveTableHeaderView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/18.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelReserveTableHeaderView : UIView

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *locationLab;
@property (nonatomic, strong) SPButton *locateBtn;
@property (nonatomic, strong) UILabel *inLab;
@property (nonatomic, strong) UILabel *outLab;
@property (nonatomic, strong) UIButton *dateIn;
@property (nonatomic, strong) UIButton *dateOut;

//中间蓝色
@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UILabel *totalDayLab;
@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UITextField *locationTF;

@property (nonatomic, strong) UIButton *searchBtn;

@property (nonatomic, strong) NSString *dateInStr;
@property (nonatomic, strong) NSString *dateOutStr;

@property (nonatomic, strong) NSString *dateInPassVal;
@property (nonatomic, strong) NSString *dateOutPassVal;
@end

NS_ASSUME_NONNULL_END
