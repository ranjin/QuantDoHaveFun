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
@class QDMallTableSectionHeaderView;

typedef NS_ENUM(NSInteger,MallBtnClickType){
    MallBtnClickTypeNormal = 0,
    MallBtnClickTypeUp = 1,
    MallBtnClickTypeDown = 2
};

@interface QDMallTableSectionHeaderView : UIView

@property (nonatomic, strong) SPButton *allBtn;
@property (nonatomic, strong) SPButton *amountBtn;
//@property (nonatomic, strong) SPButton *priceBtn;
@property (nonatomic, strong) SPButton *baoyouBtn;  //是否包邮
//默认选中，默认是第一个
@property (nonatomic, assign) int defaultSelectIndex;

//默认选中项，默认是第一个
@property (nonatomic, assign) int defaultSelectItmeIndex;
//设置可选项数组
@property (nonatomic, copy) NSArray *selectItmeArr;

@end

NS_ASSUME_NONNULL_END
