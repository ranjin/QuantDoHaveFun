//
//  QDBaseViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelReserveVC : QDBaseViewController

@property (nonatomic, strong) NSString *dateInStr;
@property (nonatomic, strong) NSString *dateOutStr;

@property (nonatomic, strong) NSString *dateInPassedVal;
@property (nonatomic, strong) NSString *dateOutPassedVal;
@end

NS_ASSUME_NONNULL_END
