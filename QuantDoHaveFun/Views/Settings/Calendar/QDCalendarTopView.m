//
//  QDCalendarTopView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/21.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDCalendarTopView.h"
#import "QDDateUtils.h"
@implementation QDCalendarTopView


- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
//        _cleanBtn = [[UIButton alloc] init];
//        [_cleanBtn setTitle:@"清空" forState:UIControlStateNormal];
//        _cleanBtn.titleLabel.font = QDBoldFont(15);
//        [_cleanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [self addSubview:_cleanBtn];
        
        _roomInLab = [[UILabel alloc] init];
        _roomInLab.text = @"入住";
        _roomInLab.font = QDFont(12);
        _roomInLab.textColor = APP_GRAYTEXTCOLOR;
        [self addSubview:_roomInLab];
        
        _roomOutLab = [[UILabel alloc] init];
        _roomOutLab.text = @"离店";
        _roomOutLab.font = QDFont(12);
        _roomOutLab.textColor = APP_GRAYTEXTCOLOR;
        [self addSubview:_roomOutLab];
        
        _roomInBtn = [[UIButton alloc] init];
        _roomInBtn.titleLabel.font = QDBoldFont(15);
        [_roomInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_roomInBtn];
        
        _roomOutBtn = [[UIButton alloc] init];
        _roomOutBtn.titleLabel.font = QDBoldFont(15);
        [_roomOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_roomOutBtn];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_BLUECOLOR;
        [self addSubview:_lineView];
        
        _totalDaysLab = [[UILabel alloc] init];
        _totalDaysLab.text = @"1晚";
        _totalDaysLab.font = QDFont(15);
        _totalDaysLab.textColor = APP_BLUECOLOR;
        [self addSubview:_totalDaysLab];
        
        _sundayLab = [[UILabel alloc] init];
        _sundayLab.text = @"日";
        _sundayLab.font = QDFont(14);
        _sundayLab.textColor = APP_GRAYCOLOR;
        [self addSubview:_sundayLab];
        
        NSArray *title = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        for (int i =0 ; i < 7 ; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/7*i, SCREEN_HEIGHT*0.25, SCREEN_WIDTH/7, SCREEN_HEIGHT*0.05)];
            label.textAlignment = NSTextAlignmentCenter;
//            label.backgroundColor = [UIColor whiteColor];
            label.text = title[ i];
            label.font = QDFont(15);
            label.textColor = APP_GRAYCOLOR;
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
    
//    [_cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.cancelBtn);
//        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.056));
//    }];
    
    [_roomInLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.15);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.14);
    }];
    
    [_roomOutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.roomInLab);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.15));
    }];
    
    [_roomInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_roomInLab);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.18);
    }];
    [_roomOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.roomInBtn);
        make.centerX.equalTo(_roomOutLab);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-(SCREEN_HEIGHT*0.075));
        make.width.mas_equalTo(SCREEN_WIDTH*0.1);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.003);
    }];
    
    [_totalDaysLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.lineView.mas_top).offset(-(SCREEN_HEIGHT*0.006));
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
