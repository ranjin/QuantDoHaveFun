//
//  QDPickUpOrderCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDMyPickOrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDPickUpOrderCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *operationTypeLab;
@property (nonatomic, strong) UILabel *totalPriceTextLab;
@property (nonatomic, strong) UILabel *totalPriceLab;
@property (nonatomic, strong) UILabel *totalPrice;

@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *amount;

@property (nonatomic, strong) UILabel *balanceLab;
@property (nonatomic, strong) UILabel *balance;

@property (nonatomic, strong) UILabel *transferLab;
@property (nonatomic, strong) UILabel *transfer;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *centerLine;
@property (nonatomic, strong) UILabel *statusLab;

@property (nonatomic, strong) UIButton *withdrawBtn;
@property (nonatomic, strong) UIButton *payBtn;


- (void)loadPickOrderWithModel:(QDMyPickOrderModel *)model;

@end

NS_ASSUME_NONNULL_END
