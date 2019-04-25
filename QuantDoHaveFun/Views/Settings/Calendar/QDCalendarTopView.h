//
//  QDCalendarTopView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/21.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDCalendarTopView : UIView
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *cleanBtn;
@property (nonatomic, strong) UILabel *roomInLab;
@property (nonatomic, strong) UILabel *roomOutLab;
@property (nonatomic, strong) UIButton *roomInBtn;
@property (nonatomic, strong) UIButton *roomOutBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *totalDaysLab;

@property (nonatomic, strong) UILabel *sundayLab;
@property (nonatomic, strong) UILabel *mondayLab;
@property (nonatomic, strong) UILabel *tuesdayLab;
@property (nonatomic, strong) UILabel *wednesdayLab;
@property (nonatomic, strong) UILabel *thursdayLab;
@property (nonatomic, strong) UILabel *fridayLab;
@property (nonatomic, strong) UILabel *saturdayLab;

@property (nonatomic, strong) NSString *dateInStr;
@property (nonatomic, strong) NSString *dateOutStr;

@end

NS_ASSUME_NONNULL_END
