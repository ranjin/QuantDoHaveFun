//
//  QDHotelHeaderView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/17.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDHotelSearchView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDHotelHeaderView : UIView

@property (nonatomic, strong) UIView *backImgView;
@property (nonatomic, strong) UILabel *hotelLab;
@property (nonatomic, strong) QDHotelSearchView *searchView;


@end

NS_ASSUME_NONNULL_END
