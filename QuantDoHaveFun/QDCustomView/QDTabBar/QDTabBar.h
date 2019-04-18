//
//  QDTabBar.h
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDTabBarItem.h"
NS_ASSUME_NONNULL_BEGIN

@protocol QDTabBarDelegate <NSObject>

- (void)tabBarDidSelectedRiseButton;

@end
@interface QDTabBar : UIView

@property (nonatomic, copy) NSArray<NSDictionary *> *tabBarItemAttributes;
@property (nonatomic, weak) id <QDTabBarDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
