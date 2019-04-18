//
//  QDRefreshFooter.m
//  QDINFI
//
//  Created by ZengTark on 2017/11/13.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDRefreshFooter.h"

@implementation QDRefreshFooter

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
        [self setTitle:@"上拉可以加载更多" forState:MJRefreshStateIdle];
        [self setTitle:@"释放即可加载更多" forState:MJRefreshStatePulling];
        [self setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        [self setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
        
        //设置字体
        self.stateLabel.font = QDFont(12);
        
        //设置颜色
        self.stateLabel.textColor = [UIColor colorWithHexString:@"#9B9B9B"];
        
        self.automaticallyHidden = YES;
    }
    return self;
}

@end
