//
//  QDHotelTableViewCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/17.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHotelListInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *hotelImg;
@property (nonatomic, strong) UILabel *hotelName;
@property (nonatomic, strong) UILabel *wanbeiLab;
@property (nonatomic, strong) UILabel *wanbei;
@property (nonatomic, strong) UILabel *yueLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *totalStars;
@property (nonatomic, strong) UILabel *starLab;

@property (nonatomic, strong) UILabel *locationLab;

-(void)fillContentWithModel:(QDHotelListInfoModel *)infoModel andImgURLStr:(NSString *)imgURL;

@end

NS_ASSUME_NONNULL_END
