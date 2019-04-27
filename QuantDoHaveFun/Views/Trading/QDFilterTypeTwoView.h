//
//  QDFilterTypeTwoView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDFilterTypeTwoView : UIView

@property (nonatomic, strong) SPButton *buyBtn;
@property (nonatomic, strong) SPButton *sellBtn;

@property (nonatomic, strong) UIButton *wcjBtn;
@property (nonatomic, strong) UIButton *bfcjBtn;
@property (nonatomic, strong) UIButton *qbcjBtn;
@property (nonatomic, strong) UIButton *qbcxBtn;
@property (nonatomic, strong) UIButton *bcbcBtn;

@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *resetbtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, copy) void (^sdDirectionBlock) (NSString *directionID);

@property (nonatomic, copy) void (^sdStatusStatusBlock) (NSString *statusID);

@end

NS_ASSUME_NONNULL_END
