//
//  UIView+LDCategory.h
//  carDV
//
//  Created by lidi on 2018/12/22.
//  Copyright © 2018 rc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (LDCategory)

/**
 添加阴影效果
 */
- (void)LD_addDefalutShadow;
- (void)LD_addShadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;


/**
 添加边框
 */
- (void)LD_addBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

@end

