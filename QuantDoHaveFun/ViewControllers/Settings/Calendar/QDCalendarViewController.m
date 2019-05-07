//
//  RangePickerViewController.m
//  FSCalendar
//
//  Created by dingwenchao on 5/8/16.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "QDCalendarViewController.h"
#import "FSCalendar.h"
#import "RangePickerCell.h"
#import "FSCalendarExtensions.h"
#import "QDCalendarTopView.h"
#import "QDDateUtils.h"
#import <EventKit/EventKit.h>
@interface QDCalendarViewController () <FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;
@property (nonatomic, strong) NSCache *cache;
@property (nonatomic, strong) QDCalendarTopView *calendarTopView;
@property (weak, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;

@property (strong, nonatomic) NSArray<EKEvent *> *events;

- (void)loadCalendarEvents;
- (nullable NSArray<EKEvent *> *)eventsForDate:(NSDate *)date;

// The start date of the range
@property (strong, nonatomic) NSDate *date1;
// The end date of the range
@property (strong, nonatomic) NSDate *date2;
// The start date of the range
@property (strong, nonatomic) NSString *date1Str;
// The end date of the range
@property (strong, nonatomic) NSString *date2Str;


- (void)eventItemClicked:(id)sender;

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position;

@end

@implementation QDCalendarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)loadView
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.294, SCREEN_WIDTH, SCREEN_HEIGHT*0.586)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.294, SCREEN_WIDTH, SCREEN_HEIGHT*0.586)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO;
    calendar.allowsMultipleSelection = YES;
//    calendar.rowHeight = 100;
    calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;

    
    calendar.calendarHeaderView.backgroundColor = [UIColor redColor];
    calendar.appearance.titleDefaultColor = [UIColor blackColor];
    calendar.appearance.titleSelectionColor = APP_GRAYTEXTCOLOR;
    calendar.appearance.headerTitleColor = APP_BLACKCOLOR;
    calendar.appearance.titlePlaceholderColor = APP_GRAYTEXTCOLOR;
    calendar.appearance.todayColor = APP_ORANGETEXTCOLOR;
    calendar.appearance.todaySelectionColor = APP_ORANGETEXTCOLOR;
    calendar.appearance.titleTodayColor = APP_ORANGETEXTCOLOR;
    
    calendar.appearance.subtitleDefaultColor = APP_BLUECOLOR;
    calendar.weekdayHeight = 0;
    calendar.firstWeekday = 1;
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.appearance.headerDateFormat = @"yyyy-MM";
    //最大 最小日期
    NSString *currentDateStr = [QDDateUtils dateFormate:@"yyyy-MM-dd" WithDate:[NSDate date]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    self.minimumDate = [format dateFromString:currentDateStr];
//    self.maximumDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:10 toDate:[NSDate date] options:0];
    self.maximumDate = [QDDateUtils getPriousorLaterDateFromDate:self.minimumDate withMonth:12];
//    calendar.today = nil; // Hide the today circle
    [calendar registerClass:[RangePickerCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
}

- (void)dismissVC:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cleanAction:(UIButton *)sender{
    [self configureVisibleCells];
    [self.calendar reloadData];
}

- (void)returnDate:(ReturnDateBlock)block{  //block的实现方法
    self.returnDateBlock = block;
}

- (void)chooseDate:(UIButton *)sender{
    QDLog(@"%@, %@", _dateInStr, _dateOutStr);
    if(self.date1 == nil || self.date2 == nil){
        [WXProgressHUD showInfoWithTittle:@"请正确选择您的住离时间"];
    }else{
        if (self.returnDateBlock != nil) {
            self.returnDateBlock(_dateInStr, _dateOutStr, _date1Str, _date2Str, _totalDays);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _calendarTopView = [[QDCalendarTopView alloc] initWithFrame:CGRectMake(0, 0
                                                                           , SCREEN_WIDTH, SCREEN_HEIGHT*0.294)];
    if (_dateInStr == nil || _dateOutStr == nil) {
        [_calendarTopView.roomInBtn setTitle:@"请选择入住时间" forState:UIControlStateNormal];
        [_calendarTopView.roomOutBtn setTitle:@"请选择离店时间" forState:UIControlStateNormal];
    }else{
        [_calendarTopView.roomInBtn setTitle:_dateInStr forState:UIControlStateNormal];
        [_calendarTopView.roomOutBtn setTitle:_dateOutStr forState:UIControlStateNormal];
    }
    //返回 清空 开始搜索
    [_calendarTopView.cleanBtn addTarget:self action:@selector(cleanAction:) forControlEvents:UIControlEventTouchUpInside];
    [_calendarTopView.cancelBtn addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
    _calendarTopView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    [self.view addSubview:_calendarTopView];
    //中国农历
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];

    //公历(常用)
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    // For UITest
    self.calendar.accessibilityIdentifier = @"calendar";
    
    UIButton *confirmBtn = [[UIButton alloc] init];
    confirmBtn.backgroundColor = [UIColor whiteColor];
    [confirmBtn setTitle:@"选择此日期" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.layer.masksToBounds = YES;
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 296, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
    gradientLayer.masksToBounds = YES;
    gradientLayer.cornerRadius = 25;
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
    [confirmBtn.layer addSublayer:gradientLayer];
    [confirmBtn addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventTouchUpInside];
    confirmBtn.titleLabel.font = QDFont(16);
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(SCREEN_HEIGHT*0.03));
        make.width.mas_equalTo(296);
        make.height.mas_equalTo(50);
    }];
    [self loadCalendarEvents];
    
}

#pragma mark - Private methods

- (void)loadCalendarEvents
{
    __weak typeof(self) weakSelf = self;
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
        if(granted) {
            NSDate *startDate = self.minimumDate;
            NSDate *endDate = [self.dateFormatter dateFromString:@"2021-04-10"];

            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!weakSelf) return;
                weakSelf.events = events;
                [weakSelf.calendar reloadData];
            });
            
        } else {
            
            // Alert
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"权限错误" message:@"无法获取日历上的特定节假日." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    // 设置日期格式 为了转换成功
//    NSString *currentDateStr = [QDDateUtils dateFormate:@"yyyy-MM-dd" WithDate:[NSDate date]];
//    format.dateFormat = @"yyyy-MM-dd";
//    return [format dateFromString:currentDateStr];
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
//    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:10 toDate:[NSDate date] options:0];
    return self.maximumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    EKEvent *event = [self eventsForDate:date].firstObject;
    if (event) {
        return event.title;
    }
    return nil;
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    RangePickerCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

#pragma mark - FSCalendarDelegate

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return NO;
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date{
    if (!self.events) return 0;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    return events.count;
}


- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    NSLog(@"dateStr = %@", dateStr);

    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
//    NSString *ss = [self.dateFormatter stringFromDate:date];
//    NSLog(@"ss = %@", ss);
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];// 设置日期格式
//    format.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
//    format.dateFormat = @"yyyy-MM-dd";// NSString * ->
//    NSDate *currentData = [format dateFromString:ss];
    QDLog(@"currentData = %@",localeDate);
    if (calendar.swipeToChooseGesture.state == UIGestureRecognizerStateChanged) {
        // If the selection is caused by swipe gestures
        if (!self.date1) {
            self.date1 = localeDate;
            self.date1Str = dateStr;
        } else {
            if (self.date2) {
                [calendar deselectDate:self.date2];
            }
            self.date2 = localeDate;
            self.date2Str = dateStr;
        }
    } else {
        if (self.date2) {
            [calendar deselectDate:self.date1];
            [calendar deselectDate:self.date2];
            self.date1 = localeDate;
            self.date1Str = dateStr;
            self.date2 = nil;
        } else if (!self.date1) {
            self.date1 = localeDate;
            self.date1Str = dateStr;
        } else {
            self.date2 = localeDate;
            self.date2Str = dateStr;
        }
    }
    if (self.date1 != nil && self.date2 != nil) {
        QDLog(@"self.date1 = %@, self.date2 = %@", self.date1, self.date2);
        NSInteger aa = [QDDateUtils compareDate:[NSString stringWithFormat:@"%@", self.date1] withDate:[NSString stringWithFormat:@"%@", self.date2]];
        
        NSInteger i = [QDDateUtils getDaysFrom:self.date1 To:self.date2];
        NSInteger j = [QDDateUtils calcDaysFromBegin:self.date1 end:self.date2];
        QDLog(@"i = %ld, j = %ld", (long)i, (long)j);
        int totalDays = abs((int)j);
        
        _calendarTopView.totalDaysLab.text = [NSString stringWithFormat:@"%d晚", totalDays];
        if (totalDays > 30) {
            [WXProgressHUD showInfoWithTittle:@"入住离店时间不能超过30晚,请重新选择"];
            return;
        }
        _totalDays = totalDays;
        NSString *str3 = [QDDateUtils weekdayStringFromDate:self.date1];
        NSString *str4 = [QDDateUtils weekdayStringFromDate:self.date2];
        QDLog(@"aa = %ld, str3 = %@, str4 = %@", (long)aa, str3, str4);
        if (aa > 0) {
            NSArray *inArr = [self.date1Str componentsSeparatedByString:@"-"];
//            NSString *strIn = [NSString stringWithFormat:@"%@ %@", self.date1Str, str3];
            _dateInStr = [NSString stringWithFormat:@"%@月%@日", inArr[1], inArr[2]];
//            NSString *strOut = [NSString stringWithFormat:@"%@ %@", self.date2Str, str4];
            NSArray *outArr = [self.date2Str componentsSeparatedByString:@"-"];
            _dateOutStr = [NSString stringWithFormat:@"%@月%@日", outArr[1], outArr[2]];
            [_calendarTopView.roomInBtn setTitle:_dateInStr forState:UIControlStateNormal];
            [_calendarTopView.roomOutBtn setTitle:_dateOutStr forState:UIControlStateNormal];
        }else if(aa < 0){
            NSArray *inArr = [self.date2Str componentsSeparatedByString:@"-"];
            _dateInStr = [NSString stringWithFormat:@"%@月%@日", inArr[1], inArr[2]];
            NSArray *outArr = [self.date1Str componentsSeparatedByString:@"-"];
            _dateOutStr = [NSString stringWithFormat:@"%@月%@日", outArr[1], outArr[2]];
            [_calendarTopView.roomInBtn setTitle:_dateInStr forState:UIControlStateNormal];
            [_calendarTopView.roomOutBtn setTitle:_dateOutStr forState:UIControlStateNormal];
            NSString *tempDateStr;
            QDLog(@"%@  %@", _dateInPassedVal, _dateOutPassedVal);
            tempDateStr = self.date2Str;
            self.date2Str = self.date1Str;
            self.date1Str = tempDateStr;
        }
    }
    [self configureVisibleCells];
}




- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
//    if ([self.gregorian isDateInToday:date]) {
//        return @[[UIColor orangeColor]];
//    }
//    return @[appearance.eventDefaultColor];
    if (!self.events) return nil;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:events.count];
    [events enumerateObjectsUsingBlock:^(EKEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [colors addObject:[UIColor colorWithCGColor:obj.calendar.CGColor]];
    }];
    return colors.copy;
}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
}

- (void)configureCell:(__kindof FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position
{
    NSLog(@"did select %@",[self.dateFormatter stringFromDate:date]);

    RangePickerCell *rangeCell = cell;
    if (position != FSCalendarMonthPositionCurrent) {
        rangeCell.middleLayer.hidden = YES;
        rangeCell.selectionLayer.hidden = YES;
        return;
    }
    if (self.date1 && self.date2) {
        // The date is in the middle of the range
        BOOL isMiddle = [date compare:self.date1] != [date compare:self.date2];
        rangeCell.middleLayer.hidden = !isMiddle;
    } else {
        rangeCell.middleLayer.hidden = YES;
    }
    BOOL isSelected = NO;
    isSelected |= self.date1 && [self.gregorian isDate:date inSameDayAsDate:self.date1];
    isSelected |= self.date2 && [self.gregorian isDate:date inSameDayAsDate:self.date2];
    rangeCell.selectionLayer.hidden = !isSelected;
}

- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date{
    NSArray<EKEvent *> *events = [self.cache objectForKey:date];
    if ([events isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    if (filteredEvents.count) {
        [self.cache setObject:filteredEvents forKey:date];
    } else {
        [self.cache setObject:[NSNull null] forKey:date];
    }
    if (filteredEvents != nil) {
        QDLog(@"filteredEvents = %@", filteredEvents);
    }
    return filteredEvents;
}

@end
