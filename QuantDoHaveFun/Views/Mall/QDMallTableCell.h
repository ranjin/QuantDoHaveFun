//
//  QDMallTableCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDMallModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDMallTableCell : UITableViewCell
@property (nonatomic, strong) UIImageView *hotelImg;
@property (nonatomic, strong) UILabel *hotelName;
@property (nonatomic, strong) UILabel *wanbeiLab;
@property (nonatomic, strong) UILabel *wanbei;
@property (nonatomic, strong) UILabel *yueLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *salesLab;
@property (nonatomic, strong) UILabel *totalSales;
@property (nonatomic, strong) UILabel *isShipping;

- (void)fillContentWithModel:(QDMallModel *)mallModel;


@end

NS_ASSUME_NONNULL_END
