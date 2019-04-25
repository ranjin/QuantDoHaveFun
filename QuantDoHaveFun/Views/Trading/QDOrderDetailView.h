//
//  QDOrderDetailView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDPickUpOrderCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDOrderDetailView : UIView

@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UILabel *operationTypeLab;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UILabel *totalPriceLab;
@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *priceLab;

@property (nonatomic, strong) UILabel *dealAmountLab;
@property (nonatomic, strong) UILabel *dealAmount;
@property (nonatomic, strong) UILabel *transferLab;
@property (nonatomic, strong) UIView *centerLine;
@end

NS_ASSUME_NONNULL_END
