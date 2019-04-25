/*
 **
 * @file: UIView (ML_Extension)
 * @brief:ML_Extension
 * Copyright: Copyright © 2018
 * Company:岚家小红担
 * @author: 岚家小红担
 * @version: V1.0
 * @date: 2018-10-17
 **/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ML_Extension)

@property CGPoint origin;

/**x*/
@property (nonatomic, assign) CGFloat x;

/**y*/
@property (nonatomic, assign) CGFloat y;

/**centerX*/
@property (nonatomic, assign) CGFloat centerX;

/**centerY*/
@property (nonatomic, assign) CGFloat centerY;

/**width*/
@property (nonatomic, assign) CGFloat width;

/**height*/
@property (nonatomic, assign) CGFloat height;

/**size*/
@property (nonatomic, assign) CGSize size;

/**视图顶部*/
@property(nonatomic, assign) CGFloat top;

/**视图左部*/
@property(nonatomic, assign)CGFloat left;

/**视图底部*/
@property(nonatomic, assign)CGFloat bottom;

/**视图右部*/
@property(nonatomic, assign)CGFloat right;

/**视图左下的点坐标*/
@property (readonly) CGPoint bottomLeft;

/**视图的右下坐标*/
@property (readonly) CGPoint bottomRight;

/**视图的上右坐标*/
@property (readonly) CGPoint topRight;

@end

NS_ASSUME_NONNULL_END
