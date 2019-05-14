//
//  UIView+LDCategory.m
//  carDV
//
//  Created by lidi on 2018/12/22.
//  Copyright © 2018 rc. All rights reserved.
//

#import "UIView+LDCategory.h"

@implementation UIView (LDCategory)

- (void)LD_addDefalutShadow {
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOffset:CGSizeMake(2, 3)];
    [self.layer setShadowOpacity:0.5];
    [self.layer setShadowRadius:3];
}

- (void)LD_addShadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
    [self.layer setShadowColor:shadowColor.CGColor];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowRadius:radius];
}

- (void)LD_addBorderWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    [self.layer setBorderColor:borderColor.CGColor];
    [self.layer setBorderWidth:borderWidth];
}
@end
