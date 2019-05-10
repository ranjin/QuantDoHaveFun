/*
 **
 * @file: BaseCell
 * @brief:父cell
 * Copyright: Copyright © 2018
 * Company:岚家小红担
 * @author: 岚家小红担
 * @version: V1.0
 * @date: 2018-10-17
 **/

#import <UIKit/UIKit.h>
#import "openOrCloseModel.h"
#import "HotelCouponDetailDTO.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger) {
    CLOSE  = 0, //关闭
    OPEN  = 1, //打开
}BtnType;

@class BaseCell;

@protocol BaseCellDelegate <NSObject>

/** 选中按钮点击 */
- (void)baseCell:(BaseCell *)baseCell btnType:(BtnType)btnType WithIndex:(int)index withArr:(NSMutableArray *)array;


@end


@interface BaseCell : UITableViewCell

@property (nonatomic, weak) id <BaseCellDelegate> delegate;

@property (nonatomic, assign) BtnType btnType;

/**
 点击的是哪一个cell上的按钮
 */
@property(assign,nonatomic)int index;

/**
 记录每个cell上的按钮状态
 */
@property(strong,nonatomic)NSMutableArray *indexArr;


- (void)setView:(openOrCloseModel *)model;
- (void)loadCouponViewWithModel:(HotelCouponDetailDTO *)model;

@end

NS_ASSUME_NONNULL_END
