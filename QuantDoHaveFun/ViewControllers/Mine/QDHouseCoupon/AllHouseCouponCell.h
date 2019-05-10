//
//  AllHouseCouponCell.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/28.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
#import "HotelCouponDetailDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface AllHouseCouponCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *couponNo;
@property (nonatomic, strong) UILabel *deadLineLab;
@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UILabel *info2Lab;
@property (nonatomic, strong) UILabel *info3Lab;

@property (nonatomic, strong) SPButton *ruleBtn;

@property (nonatomic, copy) void (^reLayoutBlock) (BOOL ss);

- (void)loadCouponViewWithModel:(HotelCouponDetailDTO *)model;
@end

NS_ASSUME_NONNULL_END
