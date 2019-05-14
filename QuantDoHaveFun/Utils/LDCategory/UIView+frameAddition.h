//
//  UIView+frameAddition.h
//  carDV
//
//  Created by lidi on 2018/8/15.
//  Copyright © 2018年 rc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAddition)
@property (nonatomic, assign) CGFloat ld_x;
@property (nonatomic, assign) CGFloat ld_y;
@property (nonatomic, assign) CGFloat ld_centerX;
@property (nonatomic, assign) CGFloat ld_centerY;
@property (nonatomic, assign) CGFloat ld_width;
@property (nonatomic, assign) CGFloat ld_height;
@property (nonatomic, assign) CGSize  ld_size;
@property (nonatomic, assign) CGPoint ld_origin;
/**
 view上边的y坐标
 */
@property (nonatomic, assign) CGFloat ld_top;
/**
 view左边的x坐标
 */
@property (nonatomic, assign) CGFloat ld_left;
/**
 view右边的x坐标
 */
@property (nonatomic, assign) CGFloat ld_right;
/**
 view下边的y坐标
 */
@property (nonatomic, assign) CGFloat ld_bottom;



@end
