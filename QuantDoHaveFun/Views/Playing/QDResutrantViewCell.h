//
//  QDResutrantViewCell.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/4/3.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResturantModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDResutrantViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thePic;
@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *wanbei;
@property (nonatomic, strong) UILabel *wanbeiLab;

@property (nonatomic, strong) UILabel *costLab;
@property (nonatomic, strong) UILabel *typeLab;

@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *quanLab;

@property (nonatomic, strong) UILabel *infoLab;

-(void)fillRestaurant:(ResturantModel *)infoModel andImgURL:(NSString *)imgURL;
@end

NS_ASSUME_NONNULL_END
