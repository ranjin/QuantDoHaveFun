//
//  QDHotelsInAreaViewTableViewCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/27.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHotelListInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDHotelsInAreaViewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *picView;
@property (nonatomic, strong) UIImageView *rangePic;
@property (nonatomic, strong) UILabel *hotelName;
@property (nonatomic, strong) UILabel *startLab;
@property (nonatomic, strong) UILabel *ftLab;
@property (nonatomic, strong) UILabel *rmbLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *recommendLab;
@property (nonatomic, strong) UILabel *descLab;
@property (nonatomic, strong) UILabel *peopleRecommendLab;
@property (nonatomic, strong) UIButton *detailBtn;

-(void)fillContentWithModel:(QDHotelListInfoModel *)infoModel andImgData:(NSData *)imgData;
@end

NS_ASSUME_NONNULL_END
