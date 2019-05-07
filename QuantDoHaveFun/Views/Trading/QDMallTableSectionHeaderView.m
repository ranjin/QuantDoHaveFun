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
        _allBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
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
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    [_amountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.and.height.equalTo(_allBtn);
    }];
}

@end
