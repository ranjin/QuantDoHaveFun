//
//  QDCalendarCustomerTourVC.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/2.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnSingleDateBlock)(NSString *singleDate);

@interface QDCalendarCustomerTourVC : UIViewController

@property (nonatomic, copy) ReturnSingleDateBlock returnSingleDateBlock;    //声明一个block属性

- (void)returnSingleDate:(ReturnSingleDateBlock)block;

@property (nonatomic, strong) NSString *allowStartDate;
@end

NS_ASSUME_NONNULL_END
