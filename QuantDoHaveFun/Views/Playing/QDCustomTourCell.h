//
//  QDCustomTourCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/19.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTravelDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDCustomTourCell : UITableViewCell
@property (nonatomic, strong) UIImageView *thePic;
@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *wanbei;
@property (nonatomic, strong) UILabel *wanbeiLab;

@property (nonatomic, strong) UILabel *yueLab;
@property (nonatomic, strong) UILabel *rmbLab;

@property (nonatomic, strong) UILabel *info1Lab;
@property (nonatomic, strong) UILabel *info2Lab;
@property (nonatomic, strong) UILabel *info3Lab;

-(void)fillCustomTour:(CustomTravelDTO *)infoModel andImgURL:(NSString *)imgURL;
@end

NS_ASSUME_NONNULL_END
