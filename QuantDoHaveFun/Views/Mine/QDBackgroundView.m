//
//  QDBackgroundView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDBackgroundView.h"

@implementation QDBackgroundView

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor redColor];
    [color set];    //设置线条颜色
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0.3;
    path.lineCapStyle = kCGLineCapButt;
    path.lineJoinStyle = kCGLineJoinBevel;
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT*0.252)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT*0.294)];
    [path addLineToPoint:CGPointMake(0, SCREEN_HEIGHT*0.252)];
    [path closePath];
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];//设置线条颜色
    UIColor *fillColor = [UIColor blueColor];
    [fillColor set];
    [path fill];//填充
}


@end
