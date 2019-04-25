//
//  QYBaseView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QYBaseView.h"

@implementation QYBaseView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    return self;
}

@end
