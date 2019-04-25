//
//  QDFilterTypeOneView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDFilterTypeOneView : UIView

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UITextField *lowPrice;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITextField *hightPrice;

@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UITextField *lowAmount;
@property (nonatomic, strong) UIView *lineViewT;
@property (nonatomic, strong) UITextField *hightAmount;

@property (nonatomic, strong) UILabel *infoLab;
@property (nonatomic, strong) UIButton *yesBtn;
@property (nonatomic, strong) UIButton *noBtn;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIButton *resetbtn;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, copy) void (^sdIsPartialBlock) (NSString *directionID);

@end

NS_ASSUME_NONNULL_END
