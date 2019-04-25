//
//  QDBuyOrSellViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingPostersDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDBuyOrSellViewController : UIViewController

@property (nonatomic, assign) int cellCount;
@property (nonatomic, strong) BiddingPostersDTO *operateModel;
@property (nonatomic, strong) NSString *postersType;
@end

NS_ASSUME_NONNULL_END
