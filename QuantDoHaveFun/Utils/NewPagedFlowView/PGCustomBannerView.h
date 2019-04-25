//
//  PGCustomBannerView.h
//  NewPagedFlowViewDemo
//
//  Created by Guo on 2017/8/24.
//  Copyright © 2017年 robertcell.net. All rights reserved.
//

#import "PGIndexBannerSubiew.h"
#import "VipCardDTO.h"
@interface PGCustomBannerView : PGIndexBannerSubiew

@property (nonatomic, strong) UILabel *indexLabel;

@property (nonatomic, strong) UILabel *cardNameLab;

@property (nonatomic, strong) UILabel *cardMoneyLab;

@property (nonatomic, strong) UILabel *cardMoney;


- (void)loadDataWithModel:(VipCardDTO *)cardModel;

@end
