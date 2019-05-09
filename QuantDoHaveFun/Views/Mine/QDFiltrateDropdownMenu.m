//
//  QDFiltrateDropdownMenu.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/7.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDFiltrateDropdownMenu.h"
#import "FSCalendar.h"
#import "QDDropDownItem.h"
@interface QDFiltrateDropdownMenu ()<FSCalendarDelegate,FSCalendarDataSource,QDDropDownItemDelegate,UIGestureRecognizerDelegate>

@property (strong , nonatomic) FSCalendar *calendar;
@property(nonatomic,assign)BOOL showedCalendar;
@property(nonatomic,assign)BOOL showedDropDownView;
@property(nonatomic,assign)BOOL canSelectDate;
@property(nonatomic,strong)NSArray *seedTitleArray;
@property(nonatomic,assign)BOOL selectedTiTleIndex;

@end

@implementation QDFiltrateDropdownMenu

+ (instancetype)menuWithLeftTitles:(NSArray *)leftTitles seedTitles:(NSArray *)seedTitles canSelectDate:(BOOL)canSelectDate {
    return [[self alloc] initWithLeftTitles:leftTitles seedTitles:seedTitles canSelectDate:canSelectDate];
}
- (instancetype)initWithLeftTitles:(NSArray *)leftTitles seedTitles:(NSArray *)seedTitles canSelectDate:(BOOL)canSelectDate {
    if (self = [super initWithFrame:CGRectMake(0, 0, LD_SCREENWIDTH, 35)]) {
        self.backgroundColor = [UIColor whiteColor];
        
//        UIView *middelView = [[UIView alloc]initWithFrame:self.bounds];
//        middelView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:middelView];
        
        for (int i = 0; i<leftTitles.count; i++) {
            UIView *item = [[UIView alloc]initWithFrame:CGRectMake(i*55, 0, 55, 35)];
            [self addSubview:item];
            item.backgroundColor = [UIColor whiteColor];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapItem:)];
            [item addGestureRecognizer:tap];
            item.tag = 1000+i;
            
            UILabel *label = [[UILabel alloc]init];
            [item addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(item.mas_centerX).offset(-5);
                make.centerY.mas_equalTo(item.mas_centerY);
                make.width.mas_equalTo(26);
                make.height.mas_equalTo(12);
            }];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = LD_colorRGBValue(0x999999);
            label.text = leftTitles[i];
            
            UIImageView *imv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dropDownArrow"]];
            [item addSubview:imv];
            [imv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(label.mas_right).offset(3);
                make.centerY.mas_equalTo(item.mas_centerY);
                make.width.mas_equalTo(9);
                make.height.mas_equalTo(5);
            }];
        }
        
        if (canSelectDate) {
            self.canSelectDate = canSelectDate;
            self.calendarButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_calendarButton];
            [_calendarButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-5);
                make.centerY.mas_equalTo(self.mas_centerY);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(35);
            }];
            [self.calendarButton.titleLabel setFont:QDFont(12)];
            [self.calendarButton setTitleColor:LD_colorRGBValue(0x999999) forState:0];
            [self.calendarButton setTitle:@"选择日期" forState:0];
            self.calendarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
            UIImageView *dateImv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"selectDate"]];
            [self.calendarButton addSubview:dateImv];
            [dateImv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.calendarButton.mas_right).offset(-12);
                make.centerY.mas_equalTo(self.calendarButton.mas_centerY);
                make.width.height.mas_equalTo(13);
            }];
            [self.calendarButton addTarget:self action:@selector(calendarButtonAction) forControlEvents:UIControlEventTouchUpInside];
        }
        self.seedTitleArray = seedTitles;
        [self initDropDownView];
    }
    return self;
}
- (void)calendarButtonAction {
    [self showOrHideCalendar:nil];
}
- (void)didTapItem:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag-1000;
    [self showOrHideDropDownItem:index];
    
}
- (void)initDropDownView {
    if (!_dropDownView) {
        _dropDownView = [[UIView alloc]initWithFrame:CGRectMake(0, Height_NavAndStatusBar+45, LD_SCREENWIDTH, LD_SCREENHEIGHT)];
        _dropDownView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        _dropDownView.hidden = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_dropDownView];
        if (self.canSelectDate) {
            [_dropDownView addSubview:self.calendar];
        }
        _dropDownView.clipsToBounds = YES;

        // 点击h黑色背景收回当前弹出的菜单
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDropDownView)];
        [_dropDownView addGestureRecognizer:tap];
        tap.delegate = self;
        
        for (int i = 0; i<self.seedTitleArray.count ; i++) {
            NSArray *titles = self.seedTitleArray[i];
            CGFloat dropDownitemHeight = [QDDropDownItem dropDownViewHeightWithItemCount:titles.count];
            QDDropDownItem *dropDownItem = [[QDDropDownItem alloc]initWithFrame:CGRectMake(0, -dropDownitemHeight, LD_SCREENWIDTH, dropDownitemHeight)];
            dropDownItem.itemTitles = titles;
            dropDownItem.itemIndex = i;
            dropDownItem.delegate = self;
            [_dropDownView addSubview:dropDownItem];
        }
        
    }
}
// 收回当前弹出的菜单
- (void)tapDropDownView {
    NSLog(@"tapDropDownView");
    [self showOrHideDropDownItem:self.selectedTiTleIndex];
}
// 子视图不响应父视图的tap手势事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch{
    if (touch.view == self.dropDownView) {
        return YES;
    }
    return NO;
}

- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, -300, LD_SCREENWIDTH, 300)];
        _calendar.backgroundColor = [UIColor whiteColor];
        _calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _calendar.appearance.headerDateFormat = @"yyyy年MM月";
        _calendar.appearance.headerTitleColor = LD_colorRGBValue(0x333333);
        _calendar.appearance.selectionColor = LD_colorRGBValue(0x00C1B1);
        _calendar.appearance.todayColor = LD_colorRGBValue(0x5B9DD6);
        _calendar.weekdayHeight = 0;

        _calendar.dataSource = self;
        _calendar.delegate = self;
    }
    return _calendar;
}
- (void)showOrHideCalendar:(void(^)(void))animationCompletion {
    if (self.showedCalendar) { // 收回
        [UIView animateWithDuration:0.2 animations:^{
            self.calendar.frame = CGRectMake(0, -300, LD_SCREENWIDTH, 300);
        } completion:^(BOOL finished) {
            self.dropDownView.hidden =YES;
            self.showedCalendar = NO;
            if (animationCompletion) {
                animationCompletion();
            }
        }];
    }else{ // 弹出
        if (self.showedDropDownView) {
            // 如果已经弹出了其他菜单，先收回
            for (UIView *view in self.dropDownView.subviews) {
                if ([view isKindOfClass:[QDDropDownItem class]]) {
                    if([(QDDropDownItem*)view itemIndex] == self.selectedTiTleIndex){
                        CGFloat lastItemHeight = [QDDropDownItem dropDownViewHeightWithItemCount:[self.seedTitleArray[self.selectedTiTleIndex] count]];
                        [self dropDownArrowAnimation:self.selectedTiTleIndex isShow:NO];
                        [UIView animateWithDuration:0.2 animations:^{
                            view.frame = CGRectMake(0, -lastItemHeight, LD_SCREENWIDTH, lastItemHeight);
                        } completion:^(BOOL finished) {
                            self.dropDownView.hidden = YES;
                            self.showedDropDownView = NO;
                            [self showOrHideCalendar:nil];
                        }];
                        break;
                    }
                }
            }
        } else {
            self.dropDownView.hidden = NO;
            [UIView animateWithDuration:0.2 animations:^{
                self.calendar.frame = CGRectMake(0, 0, LD_SCREENWIDTH, 300);
            } completion:^(BOOL finished) {
                self.showedCalendar = YES;
                if (animationCompletion) {
                    animationCompletion();
                }
            }];
        }
    }
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSLog(@"%@",date);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showOrHideCalendar:nil];
    });
    if ([self.delegate respondsToSelector:@selector(didSelectedCalendarDate:)]) {
        [self.delegate didSelectedCalendarDate:date];
    }
}
- (void)qdDropDownItem:(QDDropDownItem *)item didSelectedIMenuOfIndex:(NSInteger)index {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showOrHideDropDownItem:item.itemIndex];
    });
    if ([self.delegate respondsToSelector:@selector(didSelectedItemIndex:menuIndex:)]) {
        [self.delegate didSelectedItemIndex:item.itemIndex menuIndex:index];
    }
}
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate date];
}


- (void)showOrHideDropDownItem:(NSInteger)index {
    if (self.canSelectDate && self.showedCalendar) {
        // 如果日历菜单还没收回，就点击了另一个菜单弹出按钮。
        // 则先收回日历再弹出新的菜单
        [self showOrHideCalendar:^{
            [self showOrHideDropDownItem:index]; // 收回后弹出菜单
        }];
        return;
    }
    UIView *selectedItem;
    NSArray *subviews = self.dropDownView.subviews;
    for (UIView *item in subviews) {
        if ([item isKindOfClass:[QDDropDownItem class]]) {
            if([(QDDropDownItem*)item itemIndex] == index){
                selectedItem = item;
                break;
            }
        }
    }
    CGFloat itemHeight = [QDDropDownItem dropDownViewHeightWithItemCount:[self.seedTitleArray[index] count]];

    if (self.showedDropDownView) {// 收回菜单
        if (self.selectedTiTleIndex != index) {
            // 如果上一个菜单还没收回，就点击了另一个菜单弹出按钮。
            // 则先收回再弹出新的菜单
            for (UIView *view in self.dropDownView.subviews) {
                if ([view isKindOfClass:[QDDropDownItem class]]) {
                    if([(QDDropDownItem*)view itemIndex] == self.selectedTiTleIndex){
                        selectedItem = view;
                        CGFloat lastItemHeight = [QDDropDownItem dropDownViewHeightWithItemCount:[self.seedTitleArray[self.selectedTiTleIndex] count]];
                        [self dropDownArrowAnimation:self.selectedTiTleIndex isShow:NO];
                        [UIView animateWithDuration:0.2 animations:^{
                            selectedItem.frame = CGRectMake(0, -lastItemHeight, LD_SCREENWIDTH, lastItemHeight);
                        } completion:^(BOOL finished) {
                            self.dropDownView.hidden = YES;
                            self.showedDropDownView = NO;
                            [self dropDownArrowAnimation:index isShow:YES];
                            [self showOrHideDropDownItem:index]; // 收回后弹出菜单
                        }];
                        break;
                    }
                }
            }
        }else {
            [self dropDownArrowAnimation:index isShow:NO];
            [UIView animateWithDuration:0.2 animations:^{
                selectedItem.frame = CGRectMake(0, -itemHeight, LD_SCREENWIDTH, itemHeight);
            } completion:^(BOOL finished) {
                self.dropDownView.hidden = YES;
                self.showedDropDownView = NO;
            }];
        }
    } else { // 弹出菜单
        self.dropDownView.hidden = NO;
        [self dropDownArrowAnimation:index isShow:YES];
        [UIView animateWithDuration:0.2 animations:^{
            selectedItem.frame = CGRectMake(0, 0, LD_SCREENWIDTH, itemHeight);
        } completion:^(BOOL finished) {
            self.showedDropDownView = YES;
            self.selectedTiTleIndex = index;
        }];
    }
}

- (void)dropDownArrowAnimation:(NSInteger)itemIndex isShow:(BOOL)show {
    UIButton *button = [self viewWithTag:1000+itemIndex];
    UIView *arrow;
    for (UIView *view in button.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            arrow = view;
        }
    }
    if (!arrow) {
        return;
    }
    if (show) {
        [UIView animateWithDuration:0.2 animations:^{
            arrow.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            arrow.transform = CGAffineTransformMakeRotation(0.01);
        }];
    }
}
@end
