//
//  QDCalendarCustomerTourVC.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/2.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDCalendarCustomerTourVC.h"
#import <EventKit/EventKit.h>
#import <FSCalendar.h>
#import "QDCalendarCustomerTourTopView.h"
#import "QDDateUtils.h"
@interface QDCalendarCustomerTourVC ()<FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSCache *cache;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;

@property (strong, nonatomic) NSArray<EKEvent *> *events;
@property (strong, nonatomic) QDCalendarCustomerTourTopView *customerTourTopView;

- (void)loadCalendarEvents;
- (nullable NSArray<EKEvent *> *)eventsForDate:(NSDate *)date;

@end

@implementation QDCalendarCustomerTourVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.3, SCREEN_WIDTH, SCREEN_HEIGHT*0.586)];
    view.backgroundColor = APP_WHITECOLOR;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    self.view = view;
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.2, SCREEN_WIDTH, SCREEN_HEIGHT*0.86)];
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO; // important
    calendar.allowsMultipleSelection = YES;
    calendar.firstWeekday = 2;
    calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    calendar.calendarHeaderView.backgroundColor = [UIColor redColor];
    calendar.appearance.titleDefaultColor = [UIColor blackColor];
    
    calendar.appearance.headerTitleColor = APP_BLACKCOLOR;
    calendar.appearance.titlePlaceholderColor = APP_GRAYTEXTCOLOR;
    calendar.appearance.todayColor = APP_ORANGETEXTCOLOR;
    calendar.appearance.todaySelectionColor = APP_BLUECOLOR;
    calendar.appearance.todayColor = APP_BLUECOLOR;
    calendar.appearance.titleTodayColor = APP_WHITECOLOR;
    calendar.appearance.subtitleDefaultColor = APP_BLUECOLOR;
    calendar.appearance.selectionColor = APP_BLUECOLOR;
    calendar.weekdayHeight = 0;
    calendar.firstWeekday = 1;
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.appearance.headerDateFormat = @"yyyy-MM";
    //最大 最小日期
    
//    NSString *currentDateStr = [QDDateUtils dateFormate:@"yyyy-MM-dd" WithDate:[NSDate date]];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    // 设置日期格式 为了转换成功
    format.dateFormat = @"yyyy-MM-dd";
    self.minimumDate = [format dateFromString:_allowStartDate];
//    self.minimumDate = _allowStartDate;
//    self.maximumDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.minimumDate options:0];
    self.maximumDate = [QDDateUtils getPriousorLaterDateFromDate:self.minimumDate withMonth:12];
    QDLog(@"self.maximumDate = %@", self.maximumDate);

    //    calendar.today = nil; // Hide the today circle
    [self.view addSubview:calendar];
    self.calendar = calendar;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _customerTourTopView = [[QDCalendarCustomerTourTopView alloc] initWithFrame:CGRectMake(0, 0
                                                                           , SCREEN_WIDTH, SCREEN_HEIGHT*0.13)];
    _customerTourTopView.backgroundColor = APP_WHITECOLOR;
    [_customerTourTopView.cancelBtn addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";

    
    self.calendar.accessibilityIdentifier = @"calendar";
    
    [self.view addSubview:_customerTourTopView];
    [self loadCalendarEvents];
}

- (void)dismissVC:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)returnSingleDate:(ReturnSingleDateBlock)block{
    self.returnSingleDateBlock = block;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.cache removeAllObjects];
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - Target actions

- (void)todayItemClicked:(id)sender
{
    [self.calendar setCurrentPage:[NSDate date] animated:YES];
}

//- (void)lunarItemClicked:(UIBarButtonItem *)item
//{
//    self.showsLunar = !self.showsLunar;
//    [self.calendar reloadData];
//}
//
//- (void)eventItemClicked:(id)sender
//{
//    self.showsEvents = !self.showsEvents;
//    [self.calendar reloadData];
//}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
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

#pragma mark - FSCalendarDelegate

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    NSLog(@"dateStr = %@", dateStr);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.returnSingleDateBlock != nil) {
            self.returnSingleDateBlock(dateStr);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    if (!self.events) return 0;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    return events.count;
}

- (NSArray<UIColor *> *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance eventDefaultColorsForDate:(NSDate *)date
{
    if (!self.events) return nil;
    NSArray<EKEvent *> *events = [self eventsForDate:date];
    NSMutableArray<UIColor *> *colors = [NSMutableArray arrayWithCapacity:events.count];
    [events enumerateObjectsUsingBlock:^(EKEvent * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [colors addObject:[UIColor colorWithCGColor:obj.calendar.CGColor]];
    }];
    return colors.copy;
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

- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date
{
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
    return filteredEvents;
}

@end
