//
//  HouseCouponModel.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/28.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HouseCouponModel : NSObject

@property (nonatomic, strong) NSString *houseCouponTitle;
@property (nonatomic, strong) NSString *houseCouponNo;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, assign) BOOL isShowMoreText;

@end

NS_ASSUME_NONNULL_END
