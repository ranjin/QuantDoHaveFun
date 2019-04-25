//
//  QDHotelSearchView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/17.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelSearchView : UIView

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verticalLine;

@property (nonatomic, strong) UILabel *locationLab;
@property (nonatomic, strong) SPButton *locateBtn;
@property (nonatomic, strong) UILabel *inLab;
@property (nonatomic, strong) UILabel *outLab;
@property (nonatomic, strong) UIButton *dateIn;
@property (nonatomic, strong) UIButton *dateOut;
@property (nonatomic, strong) UIView *centerLine;

//中间绿色
@property (nonatomic, strong) UIView *greenLine;
@property (nonatomic, strong) UILabel *totalDayLab;



@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UITextField *locationTF;
@property (nonatomic, strong) UIButton *searchBtn;



@end

NS_ASSUME_NONNULL_END
