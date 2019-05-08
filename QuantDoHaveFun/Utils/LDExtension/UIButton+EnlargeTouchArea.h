//
//  UIButton+EnlargeTouchArea.h
//  carDV
//
//  Created by lidi on 2018/8/9.
//  Copyright © 2018年 rc. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

/**
 扩大按钮点击范围
参数分别是上下左右要扩大的长度
 */
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

/**
 扩大按钮点击范围

 @param size 四周扩大同样的长度
 */
- (void)setEnlargeEdge:(CGFloat) size;

@end
