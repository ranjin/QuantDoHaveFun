//
//  QDTradeShellsSectionHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMallTableSectionHeaderView.h"
#import "UIButton+ImageTitleStyle.h"
static char *const btnKey = "btnKey";

@interface QDMallTableSectionHeaderView()
{
    BOOL show;
    BOOL baoyou;
}

@end

@implementation QDMallTableSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _allBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        [_allBtn setImage:[UIImage imageNamed:@"icon_arrowDown"] forState:UIControlStateNormal];
        [_allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [_allBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _allBtn.titleLabel.font = QDFont(14);
        [self addSubview:_allBtn];
        
        _amountBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
        [_amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
        [_amountBtn setTitle:@"销量" forState:UIControlStateNormal];
        [_amountBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _amountBtn.titleLabel.font = QDFont(14);
        _amountBtn.tag = 101;
        [_amountBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_amountBtn];
        objc_setAssociatedObject(_amountBtn, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
        
//        _priceBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
//        [_priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
//        [_priceBtn setTitle:@"价格" forState:UIControlStateNormal];
//        [_priceBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
//        _priceBtn.titleLabel.font = QDFont(14);
//        _priceBtn.tag = 102;
//        [_priceBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_priceBtn];
//        objc_setAssociatedObject(_priceBtn, btnKey, @"2", OBJC_ASSOCIATION_ASSIGN);
        
        _baoyouBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionLeft];
        [_baoyouBtn setImage:[UIImage imageNamed:@"icon_baoyouNormal"] forState:UIControlStateNormal];
        [_baoyouBtn setTitle:@"包邮" forState:UIControlStateNormal];
        [_baoyouBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _baoyouBtn.titleLabel.font = QDFont(14);
        [self addSubview:_baoyouBtn];
    }
    return self;
}

- (void)selectClick:(UIButton *)btn{
    NSString *str;
    MallBtnClickType type = MallBtnClickTypeNormal;
    if (btn.tag == 101) {
        [_amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
        NSString *flag = objc_getAssociatedObject(btn, btnKey);
        if ([flag isEqualToString:@"1"]) {  //是数量按钮
            [btn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
            objc_setAssociatedObject(btn, btnKey, @"2", OBJC_ASSOCIATION_ASSIGN);
            type = MallBtnClickTypeUp;
            QDLog(@"amountUp");
            str = @"amountUp";
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AmountUp object:nil];
        }else if ([flag isEqualToString:@"2"]){
            [btn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
            objc_setAssociatedObject(btn, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
            type = MallBtnClickTypeDown;
            QDLog(@"amountDown");
            str = @"amountDown";
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_AmountDown object:nil];
            
        }
    }else if (btn.tag == 102){
        [_amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
        NSString *flag = objc_getAssociatedObject(btn, btnKey);
        if ([flag isEqualToString:@"1"]) {
            [btn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
            objc_setAssociatedObject(btn, btnKey, @"2", OBJC_ASSOCIATION_ASSIGN);
            type = MallBtnClickTypeUp;
            QDLog(@"priceUp");
            str = @"priceUp";
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PriceUp object:nil];
        }else if ([flag isEqualToString:@"2"]){
            [btn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
            objc_setAssociatedObject(btn, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
            type = MallBtnClickTypeDown;
            QDLog(@"priceDown");
            str = @"priceDown";
            [[NSNotificationCenter defaultCenter] postNotificationName:Notification_PriceDown object:nil];
        }
    }else{
//        //点击全部不复位价格
//        if (btn.tag != 103) {
//            UIButton *button = [self viewWithTag:102];
//            [button setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
//            objc_setAssociatedObject(button, btnKey, @"1", OBJC_ASSOCIATION_ASSIGN);
//            type = MallBtnClickTypeNormal;
//        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_amountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(140);
        make.width.and.height.equalTo(_allBtn);
    }];
    
//    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self.mas_left).offset(180);
//        make.width.and.height.equalTo(_allBtn);
//    }];
    
    [_baoyouBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-50);
        make.width.and.height.equalTo(_allBtn);
    }];
}

@end
