//
//  SYCitysCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "SYCitysCell.h"
@implementation SYCitysCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(10, 16, 0, 16);
    CGFloat itemW = ([[UIScreen mainScreen] bounds].size.width - 16 * 3 - 10 * 2) / 4;
    layout.itemSize = CGSizeMake(itemW, 30);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[SYCollectionCell class] forCellWithReuseIdentifier:@"SYCollectionCell"];
    [self.contentView addSubview:_collectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _collectionView.frame = self.contentView.bounds;
}

- (void)setCitys:(NSArray *)citys {
    if (_citys == citys) return;
    _citys = citys;
    [_collectionView reloadData];
}

+ (CGFloat)heightForCitys:(NSArray *)citys {
    CGFloat h = 10;
    
    NSInteger row = (citys.count % 4 == 0) ? citys.count / 4 - 1 : citys.count / 4;
    
    h += row * 10 + (row + 1) * 30;
    return h;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.citys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SYCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SYCollectionCell" forIndexPath:indexPath];
    cell.textLabel.text = self.citys[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.selectCity) {
        _selectCity(self.citys[indexPath.row]);
    }
}

@end
