//
//  QDPopMenu.h
//  TravelPoints
//
//  Created by Charles Ran on 2019/02/20.
//  Copyright © 2019年 quantdo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QDPopMenu;

@protocol QDPopMenuDelegate <NSObject>

- (void)popMenu:(QDPopMenu *)popMenu didSelectedMenu:(id)menu atIndex:(NSInteger)index;

- (void)dismissPopMenu:(QDPopMenu *)popMenu;

@end

@interface QDPopMenu : UIViewController

@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, assign) id <QDPopMenuDelegate> delegate;
@property (nonatomic) CGSize menuContentSize;           //菜单大小
@property (nonatomic, strong)UIView *sourceView;        //归属视图
@property (nonatomic) CGRect sourceRect;                //归属大小
@property (nonatomic, assign) CGFloat menuCellHeight;   //每一行menu的高度
@property (nonatomic, assign) NSInteger defaultIndex;   //选中的一栏
@property (nonatomic, assign) UIPopoverArrowDirection permittedArrowDirections;//箭头方向
@property (nonatomic, strong) NSString *showPropName;   //显示字段名
@property (nonatomic, strong) NSString *identityName;   //这个下了菜单的名字，为了标识同一个页面多处调用

- (void)showMenuFrom:(UIViewController *)viewController animated:(BOOL)animated;

- (void)showMenuFromSourceView:(UIView *)sourceView sourceReact:(CGRect)sourceRect viewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

