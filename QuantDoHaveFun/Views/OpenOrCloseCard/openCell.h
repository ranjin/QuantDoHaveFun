/*
 **
 * @file: openCell
 * @brief:展开的视图cell
 * Copyright: Copyright © 2018
 * Company:岚家小红担
 * @author: 岚家小红担
 * @version: V1.0
 * @date: 2018-10-17
 **/

#import "BaseCell.h"
#import "SPButton.h"
#import "HotelCouponDetailDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface openCell : BaseCell

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

- (void)loadCouponViewWithModel:(HotelCouponDetailDTO *)model;


@end

NS_ASSUME_NONNULL_END
