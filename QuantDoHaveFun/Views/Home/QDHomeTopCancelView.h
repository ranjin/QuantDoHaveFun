//
//  QDHomeTopCancelView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/23.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDHomeTopCancelView : UIView

@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UIView *topBackView;
@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UITextField *inputTF;
@property(nonatomic, strong) UIButton *searchBtn;

@property(nonatomic, strong) UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END
