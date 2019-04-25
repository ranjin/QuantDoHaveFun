//
//  navigationView.m
//  DelskApp
//
//  Created by Tiger on 2017/7/25.
//  Copyright © 2017年 Delsk. All rights reserved.
//

#import "NavigationView.h"

static const CGFloat width = 23; //宽度
static const CGFloat space = 15; //间距

@interface NavigationView ()

@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIView *parting;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *titleArr;


@property (nonatomic, assign) BOOL animatFinsh;

@end

@implementation NavigationView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleArr = @[@"图片",@"概况",@"信息",@"设施",@"租含",@"安保",@"出行",@"宠物",@"位置",@"退订",@"评价",@"养学",@"周边"];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _addressBtn = [[SPButton alloc] initWithImagePosition:SPButtonImagePositionRight];
    _addressBtn.imageTitleSpace = SCREEN_WIDTH*0.02;
    [_addressBtn setTitle:@"云南大理" forState:UIControlStateNormal];
    [_addressBtn setImage:[UIImage imageNamed:@"icon_selectAddress"] forState:UIControlStateNormal];
    [_addressBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
    _addressBtn.titleLabel.font = QDBoldFont(20);
    [self addSubview:_addressBtn];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.04);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.06);
    }];
    
    _iconBtn = [[UIButton alloc] init];
    [_iconBtn setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
    [self addSubview:_iconBtn];
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.06);
    }];
    
    [_iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_addressBtn);
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.82);
    }];
//    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.backBtn setImage:[UIImage imageNamed:@"ad_back_black"] forState:UIControlStateNormal];
//    [self.backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.backBtn];
//
//    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws).offset(10);
//        make.top.mas_equalTo(@35);
//        make.size.mas_equalTo(CGSizeMake(22, 22));
//    }];
//
//    self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.shareBtn setImage:[UIImage imageNamed:@"ad_share_black"] forState:UIControlStateNormal];
//    self.shareBtn.userInteractionEnabled = NO;
//    [self.shareBtn addTarget:self action:@selector(shareHouse) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.shareBtn];
//
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(ws.backBtn);
//        make.right.equalTo(ws).offset(-73);
//        make.size.mas_offset(CGSizeMake(22, 22));
//    }];
//
//    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.collectBtn setImage:[UIImage imageNamed:@"ad_collection_black"] forState:UIControlStateNormal];
//    [self.collectBtn setImage:[UIImage imageNamed:@"ad_collection_red"] forState:UIControlStateSelected];
//    [self.collectBtn addTarget:self action:@selector(collecHouse) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.collectBtn];
//
//    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(ws.backBtn);
//        make.right.equalTo(ws).offset(-30);
//        make.size.mas_equalTo(CGSizeMake(22, 22));
//    }];
//
//    self.parting = [[UIView alloc]init];
//    self.parting.backgroundColor = APP_BLUECOLOR;
//    [self addSubview:self.parting];
//
//    [self.parting mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws.mas_right);
//        make.centerY.equalTo(ws.backBtn);
//        make.width.mas_equalTo(0.5);
//        make.height.mas_equalTo(14);
//    }];
//
//    UIView *line = [[UIView alloc]init];
//    line.backgroundColor = APP_LINECOLOR;
//    [self addSubview:line];
//
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws);
//        make.right.equalTo(ws);
//        make.bottom.equalTo(ws);
//        make.height.mas_equalTo(@0.5);
//    }];
//
//    self.scrollView = [[UIScrollView alloc]init];
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    [self addSubview:self.scrollView];
//
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws.mas_right);
//        make.bottom.equalTo(ws);
//        make.size.mas_equalTo(CGSizeMake(100, 44));
//    }];
//
//    for (int i = 0; i < self.titleArr.count; i++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
//        [btn setTitleColor:APP_BLUECOLOR forState:UIControlStateSelected];
//        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag = 10000+i;
//        btn.titleLabel.font = F11;
//        [self.scrollView addSubview:btn];
//
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(ws.scrollView).offset(space + (width + space) * i);
//            make.centerY.equalTo(ws.scrollView).offset(4);
//            make.height.mas_equalTo(10);
//            make.width.mas_equalTo(width);
//        }];
//    }
//    self.scrollView.contentSize = CGSizeMake(space + (width + space) * self.titleArr.count, 44);
}

- (void)resetBtns
{
    for (UIView *btn in self.scrollView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)btn;
            [button setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        }
    }
}

- (void)navigationAnimation{
    
    WS(ws);
    
//    if (_animatFinsh == NO) {
//
//        for (int i = 0; i<4; i++) {
//            switch (i) {
//                case 0:{
//                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [ws.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.centerY.equalTo(ws.backBtn);
//                            make.left.equalTo(ws).offset(39);
//                            make.size.mas_offset(CGSizeMake(22, 22));
//                        }];
//                        [self layoutIfNeeded];
//                    } completion:nil];
//                    break;
//                }
//                case 1:{
//                    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [ws.collectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.centerY.equalTo(ws.backBtn);
//                            make.left.equalTo(self.shareBtn.mas_right).offset(25);
//                            make.size.mas_equalTo(CGSizeMake(22, 22));
//                        }];
//                        [self layoutIfNeeded];
//                    } completion:nil];
//                    break;
//                }
//                case 2:{
//                    [UIView animateWithDuration:0.5 delay:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [ws.parting mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.collectBtn.mas_right).offset(25);
//                            make.centerY.equalTo(ws.backBtn);
//                            make.width.mas_equalTo(0.5);
//                            make.height.mas_equalTo(14);
//                        }];
//                        [self layoutIfNeeded];
//                    } completion:nil];
//                    break;
//                }
//                case 3:{
//                    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [ws.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.parting.mas_right);
//                            make.bottom.equalTo(ws);
//                            make.right.equalTo(ws);
//                            make.height.mas_equalTo(44);
//                        }];
//                        [ws layoutIfNeeded];
//                    } completion:^(BOOL finished) {
//                        _animatFinsh = YES;
//                    }];
//                    break;
//                }
//                default:
//                    break;
//            }
//        }
//    }
}

- (void)resetFrame{
    
    WS(ws);
//    if (_animatFinsh == YES) {
//        for (int i = 0; i<4; i++) {
//            switch (i) {
//                case 0:{
//                    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [ws.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.mas_right);
//                            make.bottom.equalTo(ws);
//                            make.size.mas_equalTo(CGSizeMake(100, 44));
//                        }];
//                        [ws layoutIfNeeded];
//                    } completion:nil];
//
//                    break;
//                }
//                case 1:{
//                    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [ws.parting mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.mas_right);
//                            make.centerY.equalTo(ws.backBtn);
//                            make.width.mas_equalTo(0.5);
//                            make.height.mas_equalTo(14);
//                        }];
//                        [self layoutIfNeeded];
//                    } completion:^(BOOL finished) {
//
//                    }];
//
//                    break;
//                }
//                case 2:{
//                    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [self.collectBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.centerY.equalTo(ws.backBtn);
//                            make.right.equalTo(ws).offset(-30);
//                            make.size.mas_equalTo(CGSizeMake(22, 22));
//                        }];
//                        [self layoutIfNeeded];
//                    } completion:nil];
//                    break;
//                }
//                case 3:{
//                    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionTransitionNone animations:^{
//                        [self.shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//                            make.centerY.equalTo(ws.backBtn);
//                            make.right.equalTo(ws).offset(-73);
//                            make.size.mas_offset(CGSizeMake(22, 22));
//                        }];
//                        [self layoutIfNeeded];
//                    } completion:^(BOOL finished) {
//                        _animatFinsh = NO;
//                    }];
//                    break;
//                }
//                default:
//                    break;
//            }
//        }
//    }
}

- (void)touchBtn:(UIButton *)btn{
    DebugLog(@"yyyyyyyyyyyyyyyyyyyyyyyy");
    if ([_naviDelegate respondsToSelector:@selector(NavigationViewWithScrollerButton:)]) {
        [_naviDelegate NavigationViewWithScrollerButton:btn];
    }
}

- (void)backViewController{
    if ([self.naviDelegate respondsToSelector:@selector(NavigationViewGoBack)]) {
        [self.naviDelegate NavigationViewGoBack];
    }
}

- (void)shareHouse{
    if ([self.naviDelegate respondsToSelector:@selector(NavigationViewGoShare)]) {
        [self.naviDelegate NavigationViewGoShare];
    }
}

- (void)collecHouse{
    if ([self.naviDelegate respondsToSelector:@selector(NavigationViewGoCollect)]) {
        [self.naviDelegate NavigationViewGoCollect];
    }
}

@end
