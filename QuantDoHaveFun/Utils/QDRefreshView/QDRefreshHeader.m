//
//  QDRefreshHeader.m
//  QDINFI
//
//  Created by ZengTark on 2017/11/13.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDRefreshHeader.h"

@implementation QDRefreshHeader

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
        //自动改变透明度
        self.automaticallyChangeAlpha = YES;
        //设置各种状态下的刷新文字
        [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"释放即可刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        //设置字体
        self.stateLabel.font = QDFont(12);
        self.lastUpdatedTimeLabel.font = QDFont(12);
        
        //设置颜色
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        self.lastUpdatedTimeLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        
        // 设置普通状态的动画图片
        NSMutableArray *idleImages = [NSMutableArray array];
        for (int i = 1; i<=28; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"layer%d", i]];
            [idleImages addObject:image];
        }
        [self setImages:idleImages forState:MJRefreshStateIdle];
        
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        NSMutableArray *refreshingImages = [NSMutableArray array];
        for (int i = 1; i<=6; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"layer%d", i]];
            [refreshingImages addObject:image];
        }
//        [self setImages:refreshingImages forState:MJRefreshStatePulling];
        
        // 设置正在刷新状态的动画图片
        [self setImages:idleImages forState:MJRefreshStateRefreshing];
    }
    [self endRefreshing];
    return self;
}

@end
