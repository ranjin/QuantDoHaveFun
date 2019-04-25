//
//  QDTradeShellsSectionHeaderView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPButton.h"
NS_ASSUME_NONNULL_BEGIN
@class QDTradeShellsSectionHeaderView;

typedef NS_ENUM(NSInteger,ButtonClickType){
    ButtonClickTypeNormal = 0,
    ButtonClickTypeUp = 1,
    ButtonClickTypeDown = 2,
};
@protocol NY_SelectViewDelegate <NSObject>
@optional

@end

@interface QDTradeShellsSectionHeaderView : UIView

@property (nonatomic, strong) SPButton *amountBtn;
@property (nonatomic, strong) SPButton *priceBtn;
@property (nonatomic, strong) SPButton *filterBtn;
@property (nonatomic, weak) id<NY_SelectViewDelegate>delegate;
//默认选中，默认是第一个
@property (nonatomic, assign) int defaultSelectIndex;

//默认选中项，默认是第一个
@property (nonatomic, assign) int defaultSelectItmeIndex;
//设置可选项数组
@property (nonatomic, copy) NSArray *selectItmeArr;

@end

NS_ASSUME_NONNULL_END
