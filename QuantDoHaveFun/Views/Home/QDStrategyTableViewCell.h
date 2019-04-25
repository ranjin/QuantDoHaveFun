//
//  QDStrategyTableViewCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/27.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDStrategyDTO.h"
#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDStrategyTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *desc;
@property (nonatomic, strong) UILabel *person;
@property (nonatomic, strong) UILabel *watched;

-(void)fillContentWithModel:(QDStrategyDTO *)infoModel andImgData:(NSData *)imgData;
@end

NS_ASSUME_NONNULL_END
