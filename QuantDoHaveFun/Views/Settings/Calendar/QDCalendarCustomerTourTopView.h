//
//  QDCalendarCustomerTourTopView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/2.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDCalendarCustomerTourTopView : UIView
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLab;
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
