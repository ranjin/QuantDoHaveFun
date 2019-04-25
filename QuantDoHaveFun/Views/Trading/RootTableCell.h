//
//  RootCell.h
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BiddingPostersDTO.h"
typedef void(^OperateBlock) (NSUInteger btnTag);

@class RootTableCell;
@protocol RootCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(RootTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(BiddingPostersDTO *)urlStr;
@end

@interface RootTableCell : UITableViewCell
@property (nonatomic, copy) OperateBlock operateBlock;

@property (nonatomic, weak) id<RootCellDelegate> delegate;

@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat heightED;

@end
