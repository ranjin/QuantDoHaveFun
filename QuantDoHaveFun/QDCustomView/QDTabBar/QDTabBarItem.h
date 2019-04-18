//
//  QDTabBarItem.h
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QDTabBarItemType) {
    QDTabBarItemNormal = 0,
    QDTabBarItemRise
};
NS_ASSUME_NONNULL_BEGIN

extern NSString *const QDTabBarItemAttributeTitle;
extern NSString *const QDTabBarItemAttributeNormalImageName;
extern NSString *const QDTabBarItemAttributeSelectedImageName;
extern NSString *const QDTabBarItemAttributeType;


@interface QDTabBarItem : UIButton

@property (nonatomic, assign) QDTabBarItemType tabBarItemType;

@end

NS_ASSUME_NONNULL_END
