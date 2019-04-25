//
//  QDCalendarViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/21.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnDateBlock)(NSString *startDate, NSString *endDate, NSString *dateInPassedVal, NSString *dateOutPassedVal, int totayDays);
@protocol SendDateStrDelegate <NSObject>

- (void)sendDateStr:(NSString *)dateInStr andDateOutStr:(NSString *)dateOutStr andPassedInVal:(NSString *)dateInPassedVal andPassedOutVal:(NSString *)dateOutPassedVal andTotalDays:(int)totalDays;

@end
@interface QDCalendarViewController : UIViewController

@property (nonatomic, copy) ReturnDateBlock returnDateBlock;    //声明一个block属性
@property (nonatomic, assign) id<SendDateStrDelegate> delegate;
@property (nonatomic, strong) NSString *dateInStr;
@property (nonatomic, strong) NSString *dateOutStr;

//传递的年月日
@property (nonatomic, strong) NSString *dateInPassedVal;
@property (nonatomic, strong) NSString *dateOutPassedVal;

@property (nonatomic, assign) int totalDays;

- (void)returnDate:(ReturnDateBlock)block;

@end

NS_ASSUME_NONNULL_END
