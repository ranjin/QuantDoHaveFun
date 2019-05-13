//
//  ZLCollectionView.h
//  ZLCollectionViewFlowLayout
//
//  Created by YYKit on 2017/8/17.
//  Copyright © 2017年 zl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RanklistDTO.h"
typedef void(^DidSelectedItems)(NSIndexPath *indexPath);
@interface ZLCollectionView : UIView

@property (nonatomic,copy) DidSelectedItems selectedItems;

@property (nonatomic, strong) RanklistDTO *rankModel;
@property (nonatomic, strong) NSMutableArray *rankFirstArr;

@property (nonatomic,strong) UICollectionView *mainCollectionView;
@property (nonatomic,assign) NSInteger itemCount;
@property (nonatomic,assign) CGRect collectionViewFrame;

- (void)didSelectedItemsWithBlock:(DidSelectedItems)selectedItems;

- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount;

+ (instancetype)collectionViewWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount;
@end
