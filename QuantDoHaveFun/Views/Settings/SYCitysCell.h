//
//  SYCitysCell.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYCollectionCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYCitysCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, copy) NSArray *citys;
@property (nonatomic, copy) void(^selectCity)(NSString *cityName);

@property (nonatomic, strong) UICollectionView *collectionView;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (CGFloat)heightForCitys:(NSArray *)citys;
@end

NS_ASSUME_NONNULL_END
