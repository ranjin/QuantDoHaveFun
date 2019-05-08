//
//  QDDropDownItem.h
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/8.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QDDropDownItem;
@protocol QDDropDownItemDelegate <NSObject>

- (void)qdDropDownItem:(QDDropDownItem *)item didSelectedIMenuOfIndex:(NSInteger)index;

@end


@interface QDDropDownItem : UIView
@property(nonatomic,strong)NSArray *itemTitles;
@property(nonatomic,assign)NSInteger itemIndex;
@property(nonatomic,weak)id<QDDropDownItemDelegate> delegate;
+ (CGFloat)dropDownViewHeightWithItemCount:(NSInteger)count;
- (void)setDefaultCellState;
@end

NS_ASSUME_NONNULL_END
