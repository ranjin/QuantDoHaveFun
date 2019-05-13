//
//  ZLCollectionView.m
//  ZLCollectionViewFlowLayout
//
//  Created by YYKit on 2017/8/17.
//  Copyright © 2017年 zl. All rights reserved.
//

#import "ZLCollectionView.h"
#import "ZLFlowLayout.h"
#import "QDVipPurchaseFlowLayout.h"
#import "HYBCardCollectionViewCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
static NSString * identifier = @"collecitonView_cell";
@interface ZLCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource, UIScrollViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    BOOL isScroll;
}

@end

@implementation ZLCollectionView


+ (instancetype)collectionViewWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount
{
    return [[self alloc]initWithFrame:frame itemCount:itemCount];
}

- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.itemCount = itemCount;
        self.collectionViewFrame = frame;
        [self createCollectionViewStyle];
    }
    return self;
}


- (void)createCollectionViewStyle
{
    ZLFlowLayout *layout = [[ZLFlowLayout alloc]init];
    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:self.collectionViewFrame collectionViewLayout:layout];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    self.mainCollectionView.emptyDataSetDelegate = self;
    self.mainCollectionView.emptyDataSetSource = self;
    self.mainCollectionView.backgroundColor = APP_WHITECOLOR;
    self.mainCollectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.mainCollectionView];
    NSLog(@"%f -- %f",layout.itemSize.width,layout.itemSize.height); //375.404
    if (_rankFirstArr.count == 0) {
//        [self.mainCollectionView reloadEmptyDataSet];
    }
    //注册cell
    [self.mainCollectionView registerClass:[HYBCardCollectionViewCell class]
                forCellWithReuseIdentifier:identifier];
}


- (NSInteger )numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}
- (__kindof HYBCardCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QDLog(@"%ld", (long)indexPath.row);
    HYBCardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = APP_BLUECOLOR;
    if (_rankFirstArr.count) {
        [cell loadCellDataWithModel:_rankFirstArr[indexPath.row]];
    }
    /*这段代码的作用就是：
     *当直接往细胞上面添加视图内容时，随着滑动，可能会出现内容重叠的问题。
     *但是在自定义细胞时使用这段代码，就会移除细胞的所有子视图，
     *使用Masonry给电池子视图上的内容进行约束就会崩溃，或者直接给细胞上的内容进行约束时就会出现细胞显示而上面内容不显示的问题。
    //这一步，防止cell上面的内容发生重叠
    for (UIView * view in cell.subviews)
    {
        [view removeFromSuperview];
    }
     */
    
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 5.0f;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedItems) {
        self.selectedItems(indexPath);
    }
}

- (void)didSelectedItemsWithBlock:(DidSelectedItems)selectedItems
{
    if (self.selectedItems) {
        self.selectedItems = selectedItems;
    }
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    isScroll = YES;
    QDLog(@"scrollViewWillBeginDecelerating");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSString *ss;
    QDLog(@"scrollViewDidEndDecelerating");
    QDLog(@"%ld", (long)scrollView.contentOffset.x);
    QDLog(@"%f", SCREEN_WIDTH*0.83);
    isScroll = NO;
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = SCREEN_WIDTH * 0.83;
    //x为0的情况
    if (x >= 0 && x < width) {
        //第一个
        QDLog(@"第一个");
        ss = @"1";
    }else if (x > width && x < width * 2){
        QDLog(@"第二个");
        //                [UIView performWithoutAnimation:^{
        //                    [_mainCollectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:[_rankTypeArr indexOfObject:typeStr] inSection:0]]];
        //                }];
        ss = @"2";
    }else if (x > width * 2 && x < width * 3){
        QDLog(@"第三个");
        ss = @"3";
    }else if (x > width * 3 && x < width * 4){
        QDLog(@"第四个");
        ss = @"4";
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"horizontalSilde" object:ss];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    QDLog(@"============");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"emptySource"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end

