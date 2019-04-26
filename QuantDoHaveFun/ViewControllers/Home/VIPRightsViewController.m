//
//  VIPRightsViewController.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/25.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "VIPRightsViewController.h"
#import "VIPRightsView.h"
#import "NewPagedFlowView.h"
#import "PGCustomBannerView.h"
#import "QDLoginAndRegisterVC.h"
@interface VIPRightsViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>{
    VIPRightsView *_rightsView;
}

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *cardArr;

/**
 轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@end

@implementation VIPRightsViewController

- (void)test:(UIButton *)sender{
    QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    _imageArray = [[NSMutableArray alloc] init];
    _rightsView = [[VIPRightsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _rightsView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [_rightsView.payButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightsView];
    [self setupCardUI];
}

- (void)setupCardUI{
    for (int index = 1; index < 6; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img_card%d", index]];
        [_imageArray addObject:image];
    }
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 206+SafeAreaTopHeight-64, SCREEN_WIDTH, 300)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.01;
    pageFlowView.isCarousel = NO;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = NO;
    [pageFlowView reloadData];
    [_rightsView addSubview:pageFlowView];
    self.pageFlowView = pageFlowView;
}

#pragma mark - NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeMake(236, 300);
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    if (_cardArr.count) {
//        _currentModel = _cardArr[pageNumber];
//        if ([_currentModel.vipMoney doubleValue] == 0) {
//            _vipPurchaseView.price.hidden = YES;
//            _vipPurchaseView.priceTF.hidden = NO;
//            _vipPurchaseView.bottomLab2.text = @"--";
//            _vipPurchaseView.priceTF.text = @"";
//        }else{
//            _vipPurchaseView.price.hidden = NO;
//            _vipPurchaseView.price.text = _currentModel.vipMoney;
//            //折合玩贝
//            double ss = floor([[_currentModel.vipMoney stringByDividingBy:_currentModel.basePrice] doubleValue]);
//            NSString *sss = [NSString stringWithFormat:@"%.lf", ss];
//            _vipPurchaseView.bottomLab2.text = sss;
//            _vipPurchaseView.priceTF.hidden = YES;
//        }
    }
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView{
    return self.imageArray.count;
}


- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGCustomBannerView *bannerView = (PGCustomBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGCustomBannerView alloc] init];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //这里需要加入容错
    bannerView.mainImageView.image = self.imageArray[index];
//    if (_cardArr.count) {
//        [bannerView loadDataWithModel:_cardArr[index]];
//    }
    return bannerView;
}


@end
