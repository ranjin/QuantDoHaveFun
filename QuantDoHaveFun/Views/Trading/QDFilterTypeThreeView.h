//
//  QDFilterTypeThreeView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDFilterTypeThreeView : UIView
@property (nonatomic, strong) SPButton *buyBtn;
@property (nonatomic, strong) SPButton *sellBtn;

@property (nonatomic, strong) UILabel *orderStatusLab;
@property (nonatomic, strong) UIButton *dfkBtn;
@property (nonatomic, strong) UIButton *ycjBtn;
@property (nonatomic, strong) UIButton *yqxBtn;

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *resetbtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, copy) void (^sdDirectionBlock) (NSString *directionID);

@property (nonatomic, copy) void (^sdStatusStatusBlock) (NSString *statusID);

@end

NS_ASSUME_NONNULL_END
