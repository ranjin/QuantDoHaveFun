//
//  QDFiltrateDropdownMenu.h
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/7.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol QDFiltrateDropdownMenuDelegate <NSObject>

- (void)didSelectedItemIndex:(NSInteger)itemIndex menuIndex:(NSInteger)menuIndex;
@optional
- (void)didSelectedCalendarDate:(NSDate *)date;
@end

@interface QDFiltrateDropdownMenu : UIView
@property(nonatomic,strong)UIView *dropDownView;
@property(nonatomic,strong)UIButton *calendarButton;
@property(nonatomic,weak)id<QDFiltrateDropdownMenuDelegate> delegate;
+ (instancetype)menuWithLeftTitles:(NSArray *)leftTitles seedTitles:(NSArray *)seedTitles canSelectDate:(BOOL)canSelectDate;
@end

NS_ASSUME_NONNULL_END
