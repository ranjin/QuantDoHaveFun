//
//  UIView+frameAddition.m
//  carDV
//
//  Created by lidi on 2018/8/15.
//  Copyright © 2018年 rc. All rights reserved.
//

#import "UIView+frameAddition.h"

@implementation UIView (frameAddition)
-(CGFloat)ld_x{
    return self.frame.origin.x;
}
-(void)setLd_x:(CGFloat)ld_x{
    CGRect frame = self.frame;
    frame.origin.x = ld_x;
    self.frame = frame;
}
-(CGFloat)ld_y{
    return self.frame.origin.y;
}
-(void)setLd_y:(CGFloat)ld_y{
    CGRect frame = self.frame;
    frame.origin.y = ld_y;
    self.frame = frame;
}
-(CGFloat)ld_centerX{
    return self.center.x;
}
-(void)setLd_centerX:(CGFloat)ld_centerX{
    CGPoint center = self.center;
    center.x = ld_centerX;
    self.center = center;
}
- (CGFloat)ld_centerY{
    return self.center.y;
}
- (void)setLd_centerY:(CGFloat)ld_centerY{
    CGPoint center = self.center;
    center.y = ld_centerY;
    self.center = center;
}
-(CGFloat)ld_width{
    return self.frame.size.width;
}
- (void)setLd_width:(CGFloat)ld_width{
    CGRect frame = self.frame;
    frame.size.width = ld_width;
    self.frame = frame;
}
- (CGFloat)ld_height{
    return self.frame.size.height;
}
- (void)setLd_height:(CGFloat)ld_height{
    CGRect frame = self.frame;
    frame.size.height = ld_height;
    self.frame = frame;
}
- (CGSize)ld_size{
    return self.frame.size;
}
- (void)setLd_size:(CGSize)ld_size{
    CGRect frame = self.frame;
    frame.size = ld_size;
    self.frame = frame;
}
-(CGPoint)ld_origin{
    return self.frame.origin;
}
-(void)setLd_origin:(CGPoint)ld_origin{
    CGRect frame = self.frame;
    frame.origin = ld_origin;
    self.frame = frame;
}
-(CGFloat)ld_top{
    return self.ld_y;
}
-(void)setLd_top:(CGFloat)ld_top{
    self.ld_y = ld_top;
}
- (CGFloat)ld_left{
    return self.ld_x;
}
-(void)setLd_left:(CGFloat)ld_left{
    self.ld_x = ld_left;
}
- (CGFloat)ld_right{
    return self.ld_x+self.ld_width;
}
- (void)setLd_right:(CGFloat)ld_right{
    CGRect frame = self.frame;
    frame.origin.x = ld_right-frame.size.width;
    self.frame = frame;
}
- (CGFloat)ld_bottom{
    return self.ld_y+self.ld_height;
}
- (void)setLd_bottom:(CGFloat)ld_bottom{
    CGRect frame = self.frame;
    frame.origin.y = ld_bottom-frame.size.height;
    self.frame = frame;
}
@end
