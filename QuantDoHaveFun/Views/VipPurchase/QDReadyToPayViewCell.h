//
//  QDReadyToPayViewCell.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
#import "VipCardDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDReadyToPayViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) SPButton *cxsBtn;

@end

NS_ASSUME_NONNULL_END
