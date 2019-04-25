//
//  TestCollectionCell.h
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingPostersDTO.h"
@interface RootFirstCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *headPic;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *singlePriceLab;

@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) UILabel *amountLab;
@property (nonatomic, strong) UILabel *amount;

@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UIButton *sell;

- (void)loadDataWithDataArr:(BiddingPostersDTO *)infoModel andTypeStr:(NSString *)str;
@end
