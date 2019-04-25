//
//  QDKeyWordsSearchHeaderView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/27.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDKeyWordsSearchHeaderView : UIView

@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) SPButton *selectDateBtn;
@property (nonatomic, strong) UIImageView *searchImg;

@property (nonatomic, strong) UIButton *toSearchVCBtn;

@end

NS_ASSUME_NONNULL_END
