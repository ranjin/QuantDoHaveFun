//
//  QDCalendarCustomerTourTopView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/2.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDCalendarCustomerTourTopView.h"
#import "QDDateUtils.h"
@implementation QDCalendarCustomerTourTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.text = @"选择日期";
        _titleLab.font = QDFont(18);
        _titleLab.textColor = APP_BLACKCOLOR;
        [self addSubview:_titleLab];
        
        _sundayLab = [[UILabel alloc] init];
        _sundayLab.text = @"日";
        _sundayLab.font = QDFont(14);
        _sundayLab.textColor = APP_GRAYCOLOR;
        [self addSubview:_sundayLab];
        
        NSArray *title = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        for (int i =0 ; i < 7 ; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/7*i, SCREEN_HEIGHT*0.13, SCREEN_WIDTH/7, SCREEN_HEIGHT*0.05)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title[i];
            label.font = QDFont(14);
            label.textColor = APP_GRAYTEXTCOLOR;
            [self addSubview:label];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.054);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.056);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(_cancelBtn);
    }];
    
}

- (NSString *)getCurrentDate{
    NSString *currentDateStr = [QDDateUtils dateFormate:@"MM-dd" WithDate:[NSDate date]];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy-MM-dd";
    //    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    return currentDateStr;
}

@end
