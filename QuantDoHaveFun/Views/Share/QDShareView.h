//
//  QDShareView.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/6.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDShareView : UIView

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UILabel *shareText;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIButton *weiboBtn;
@property (nonatomic, strong) UILabel *weiboLab;

@property (nonatomic, strong) UIButton *weixinBtn;
@property (nonatomic, strong) UILabel *weixinLab;

@property (nonatomic, strong) UIButton *pyqBtn;
@property (nonatomic, strong) UILabel *pyqLab;

@property (nonatomic, strong) UIButton *qqBtn;
@property (nonatomic, strong) UILabel *qqLab;

@property (nonatomic, strong) UIButton *qqQBtn;
@property (nonatomic, strong) UILabel *qqQLab;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

NS_ASSUME_NONNULL_END
