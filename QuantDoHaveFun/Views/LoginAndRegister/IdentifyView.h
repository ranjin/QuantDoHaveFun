//
//  IdentifyView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PooCodeView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol refreshCodeDelegate <NSObject>

- (void)callTheRefreshAction;
@end

@interface IdentifyView : UIView

@property (nonatomic, strong) UILabel *identifyLab;
@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) PooCodeView *pooCodeView;
@property (nonatomic, strong) UIButton *refreshBtn;
@property (assign,nonatomic)id <refreshCodeDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
