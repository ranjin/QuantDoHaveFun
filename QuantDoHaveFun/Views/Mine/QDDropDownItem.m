//
//  QDDropDownItem.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/8.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDDropDownItem.h"
#import "QDDropDownItemCell.h"
#import <UICollectionViewLeftAlignedLayout.h>
#import "LD_Macros.h"
@interface QDDropDownItem ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateLeftAlignedLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation QDDropDownItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.itemSize = CGSizeMake(78, 29);
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        flowLayout.minimumLineSpacing = 22;
//        flowLayout.minimumInteritemSpacing = 14;
//        flowLayout.sectionInset = UIEdgeInsetsMake(20, 12, 17, 12);
        
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];

        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[QDDropDownItemCell class] forCellWithReuseIdentifier:@"QDDropDownItemCell"];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView reloadData];
    
     
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setDefaultCellState) name:@"kNotificationDropDownMenuDidLoaded" object:nil];
    }
    return self;
}
- (void)setDefaultCellState {
    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QDDropDownItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QDDropDownItemCell" forIndexPath:indexPath];
    cell.title = self.itemTitles[indexPath.row];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemTitles.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(qdDropDownItem:didSelectedIMenuOfIndex:)]) {
        [self.delegate qdDropDownItem:self didSelectedIMenuOfIndex:indexPath.row];
    }
}
#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(78, 29);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 22;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 12, 17, 12);
}

+ (CGFloat)dropDownViewHeightWithItemCount:(NSInteger)count {
    return (ceil(count/4.0f)-1)*55+70;
//    return count>4?230:70;
}
@end
