//
//  QDCurrentLocationView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDCurrentLocationView : UIView
@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *myLocationLab;

@property (nonatomic, strong) UILabel *detailLocationLab;
@property (nonatomic, strong) UILabel *cityLab;
@end

NS_ASSUME_NONNULL_END
