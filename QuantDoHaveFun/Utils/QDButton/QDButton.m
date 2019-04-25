//
//  QDButton.m
//  QDINFI
//
//  Created by ZengTark on 2017/12/8.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDButton.h"

@implementation QDButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    if (self = [super init]) {        
//        self.layer.borderColor = [UIColor colorWithHexString:@"648AC7"].CGColor;
//        self.layer.borderWidth = 0.5f;
        self.layer.cornerRadius = 24.0f;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)bgColor forState:(UIControlState)state
{
    if (bgColor) {
        UIImage *colorImg = [QDGlobalFunc imageWithColor:bgColor];
        [self setBackgroundImage:colorImg forState:state];
    }
}
@end
