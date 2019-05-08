//
//  QDHotelReserveTableHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/18.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHotelReserveTableHeaderView.h"
#import "QDDateUtils.h"
@implementation QDHotelReserveTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = APP_WHITECOLOR;
        _topView.layer.cornerRadius = 7.5;
        _topView.layer.masksToBounds = YES;
        [self addSubview:_topView];
        
        _locationTF = [[UITextField alloc] init];
        _locationTF.placeholder = @"输入关键词/酒店名";
        [_locationTF setValue:APP_GRAYCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        _locationTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_locationTF setValue:QDFont(14) forKeyPath:@"_placeholderLabel.font"];
        [_topView addSubview:_locationTF];
        
        _locateBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        [_locateBtn setImage:[UIImage imageNamed:@"icon_location"] forState:UIControlStateNormal];
        [_locateBtn setTitle:@"我的位置" forState:UIControlStateNormal];
        [_locateBtn setTitleColor:APP_GRAYTEXTCOLOR forState:UIControlStateNormal];
        _locateBtn.titleLabel.font = QDFont(13);
        _locateBtn.imageTitleSpace = SCREEN_WIDTH*0.012;
        [_topView addSubview:_locateBtn];
        
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = APP_WHITECOLOR;
        _centerView.layer.cornerRadius = 5;
        _centerView.layer.masksToBounds = YES;
        [self addSubview:_centerView];
        
        _inLab = [[UILabel alloc] init];
        _inLab.text = @"入住";
        _inLab.textColor = APP_GRAYCOLOR;
        _inLab.font = QDFont(13);
        [_centerView addSubview:_inLab];
        
        _outLab = [[UILabel alloc] init];
        _outLab.text = @"离店";
        _outLab.textColor = APP_GRAYCOLOR;
        _outLab.font = QDFont(12);
        [_centerView addSubview:_outLab];
        
        _dateIn = [[UIButton alloc] init];
        _dateInStr = [self getCurrentDate:[NSDate date]];
        _dateInPassVal = [self getPassedCurrentDate:[NSDate date]];
        QDLog(@"_dateInPassVal = %@", _dateInPassVal);
        [_dateIn setTitle:_dateInStr forState:UIControlStateNormal];
        _dateIn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_dateIn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _dateIn.titleLabel.font = QDBoldFont(15);
        _dateIn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_centerView addSubview:_dateIn];
        
        _dateOut = [[UIButton alloc] init];
        NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];//后一天
        _dateOutStr = [self getCurrentDate:nextDay];
        _dateOutPassVal = [self getPassedCurrentDate:nextDay];
        QDLog(@"_dateOutPassVal = %@", _dateOutPassVal);
        [_dateOut setTitle:_dateOutStr forState:UIControlStateNormal];
        _dateOut.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_dateOut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_dateOut setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _dateOut.titleLabel.font = QDBoldFont(15);
        [_centerView addSubview:_dateOut];
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = APP_BLUECOLOR;
        [_centerView addSubview:_topLine];
        
        _totalDayLab = [[UILabel alloc] init];
        _totalDayLab.textColor = APP_BLUECOLOR;
        _totalDayLab.layer.borderColor = APP_BLUECOLOR.CGColor;
        _totalDayLab.layer.borderWidth = 2;
        _totalDayLab.font = QDBoldFont(13);
        _totalDayLab.text = @"1晚";
        _totalDayLab.textAlignment = NSTextAlignmentCenter;
        [_centerView addSubview:_totalDayLab];
        
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = APP_BLUECOLOR;
        [_centerView addSubview:_bottomLine];
        
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.backgroundColor = [UIColor whiteColor];
        [_searchBtn setTitle:@"开始搜索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        _searchBtn.layer.cornerRadius = 5;
        _searchBtn.layer.masksToBounds = YES;
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 296, 43);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        gradientLayer.masksToBounds = YES;
        gradientLayer.cornerRadius = 21.5;
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
        [_searchBtn.layer addSublayer:gradientLayer];
        _searchBtn.layer.masksToBounds = YES;
        _searchBtn.titleLabel.font = QDFont(16);
        [self addSubview:_searchBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.03);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.075);
    }];
    
    [_locationTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topView);
        make.left.equalTo(_topView.mas_left).offset(20);
        make.right.equalTo(_topView.mas_left).offset(245);
    }];
    
    [_locateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.centerY.equalTo(_topView);
    }];
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.and.height.equalTo(_topView);
        make.top.equalTo(_topView.mas_bottom).offset(SCREEN_HEIGHT*0.02);
    }];
    
    [_inLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerView.mas_left).offset(40);
        make.top.equalTo(_centerView.mas_top).offset(10);
    }];
    
    [_outLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.inLab);
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.2));
    }];
    
    [_dateIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inLab);
        make.bottom.equalTo(self.centerView.mas_bottom).offset(-(SCREEN_HEIGHT*0.004));
    }];
    
    [_dateOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.equalTo(self.dateIn);
        make.centerX.equalTo(_outLab);
        make.right.equalTo(self.centerView.mas_right).offset(-(SCREEN_WIDTH*0.05));
    }];
    
    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_centerView);
        make.top.equalTo(_centerView.mas_top).offset(SCREEN_HEIGHT*0.01);
        make.width.mas_equalTo(SCREEN_WIDTH*0.004);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.015);
    }];
    //线2
    [_totalDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.centerView);
        make.width.mas_equalTo(SCREEN_WIDTH*0.11);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.03);
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.and.height.equalTo(_topLine);
        make.top.equalTo(_totalDayLab.mas_bottom);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView);
        make.top.equalTo(_centerView.mas_bottom).offset(20);
        make.width.mas_equalTo(296);
        make.height.mas_equalTo(43);
    }];
}


- (NSString *)getCurrentDate:(NSDate *)theDate{
    NSString *currentDateStr = [QDDateUtils dateFormate:@"MM月dd日" WithDate:theDate];
    return currentDateStr;
}

- (NSString *)getPassedCurrentDate:(NSDate *)theDate{
    NSString *currentDateStr = [QDDateUtils dateFormate:@"yyyy-MM-dd" WithDate:theDate];
    return currentDateStr;
}


@end
