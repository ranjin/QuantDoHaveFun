//
//  QDHotelReserveVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHotelReserveVC.h"
#import "QDHotelReserveTableHeaderView.h"
#import "QDHotelTableViewCell.h"
#import "TFDropDownMenu.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDGifRefreshHeader.h"
#import "QDBridgeViewController.h"
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "QDOrderField.h"
#import <TYAlertView.h>
#import "AppDelegate.h"
#import "QDPriceRangeView.h"
//预定酒店 定制游 商城
@interface QDHotelReserveVC ()<UITableViewDelegate, UITableViewDataSource, TFDropDownMenuViewDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>{
    UITableView *_tableView;
    TFDropDownMenuView *_menu;
    QDHotelReserveTableHeaderView *_headerView;    
    NSMutableArray *_hotelListInfoArr;
    NSMutableArray *_hotelImgArr;
    QD_LOCATION_STATUS _locationStatus;
    QDEmptyType _emptyType;
    QDPriceRangeView *_priceRangeView;
    int _totalPage;
    int _pageNum;
    int _pageSize;
    NSMutableArray *_array1;
    NSMutableArray *_array2;
    NSMutableArray *_array3;
    NSMutableArray *_hotelLevelArr;
    NSMutableArray *_hotelTypeIdArr;
    NSMutableArray *_levelArr;
}

@end

@implementation QDHotelReserveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _hotelListInfoArr = [[NSMutableArray alloc] init];
    _hotelImgArr = [[NSMutableArray alloc] init];
    _pageNum = 1;
    _pageSize = 10;
    _totalPage = 0; //总页数默认
    
    _hotelTypeId = @"";
    _hotelLevel = @"";
    _minPrice = @"";
    _maxPrice = @"";
    
    _array2 = [[NSMutableArray alloc] init];
    _array3 = [[NSMutableArray alloc] init];
    
    _hotelLevelArr = [[NSMutableArray alloc] init];
    _hotelTypeIdArr = [[NSMutableArray alloc] init];
    _levelArr = [[NSMutableArray alloc] init];

    [self finAllMapDic];
    [self initTableView];
    [self requestHotelData];
}

- (void)finAllMapDic{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindAllMapDict params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            if ([[dic allKeys] containsObject:@"hotelLevel"]) {
                if (_hotelLevelArr.count) {
                    [_hotelLevelArr removeAllObjects];
                }
                if (_hotelTypeIdArr.count) {
                    [_hotelTypeIdArr removeAllObjects];
                }
                if (_levelArr.count) {
                    [_levelArr removeAllObjects];
                }
                NSArray *aaa = [dic objectForKey:@"hotelLevel"];
                for (NSDictionary *dd in aaa) {
                    [_hotelLevelArr addObject:[dd objectForKey:@"dictName"]];
                }
                NSArray *bbb = [dic objectForKey:@"hotelTypeId"];
                for (NSDictionary *dd in bbb) {
                    [_hotelTypeIdArr addObject:[dd objectForKey:@"dictName"]];
                }
                NSArray *ccc = [dic objectForKey:@"Level"];
                for (NSDictionary *dd in ccc) {
                    [_hotelLevelArr addObject:[dd objectForKey:@"dictName"]];
                }
//                [self setHotelDropMenu];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
    }];
}

#pragma mark - 请求酒店信息
- (void)requestHotelData{
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{
                            @"hotelTypeId":_hotelTypeId,    //酒店类型
                            @"hotelLevel":_hotelLevel,      //星级
                            @"minPrice":_minPrice,
                            @"maxPrice":_maxPrice,
                            @"pageNum":@1,                  //
                            @"pageSize":@20
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetHotelCondition params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    QDHotelListInfoModel *infoModel = [QDHotelListInfoModel yy_modelWithDictionary:dic];
                    [_hotelListInfoArr addObject:infoModel];
                    
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    NSString *urlStr = [dic objectForKey:@"imageFullUrl"];
                    QDLog(@"urlStr = %@", urlStr);
                    [_hotelImgArr addObject:urlStr];
                }
                _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
                    QDLog(@"sss");
                    [self endRefreshing];
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }];
                [_tableView reloadData];
            }else{
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_menu setHidden:YES];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
    }];
}

- (TFDropDownMenuView *)setHotelDropMenu{
    if (_hotelTypeIdArr.count) {
        if (![_hotelTypeIdArr[0] isEqualToString:@"酒店类型"]) {
            [_hotelTypeIdArr insertObject:@"酒店类型" atIndex:0];
        }
    }
    if (_hotelLevelArr.count) {
        if (![_hotelLevelArr[0] isEqualToString:@"星级"]) {
            [_hotelLevelArr insertObject:@"星级" atIndex:0];
        }
    }
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:_hotelTypeIdArr, @[@"价格"], _hotelLevelArr, nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[], @[], @[], nil];
    _menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 47) firstArray:data1 secondArray:data2];
    _menu.backgroundColor = APP_WHITECOLOR;
    _menu.delegate = self;
    _menu.ratioLeftToScreen = 0.35;
    [self.view addSubview:_menu];
    
    /*风格*/
    _menu.menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], nil];
    _priceRangeView = [[QDPriceRangeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.38)];
    _priceRangeView.backgroundColor = APP_WHITECOLOR;
    [_priceRangeView.resetBtn addTarget:self action:@selector(priceRangeRest:) forControlEvents:UIControlEventTouchUpInside];
    [_priceRangeView.confirmBtn addTarget:self action:@selector(confirmToSelectPrice:) forControlEvents:UIControlEventTouchUpInside];
    _priceRangeView.slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
        if (maxValue < 900) {
            _minPrice = [NSString stringWithFormat:@"%.f", minValue];
            _maxPrice = [NSString stringWithFormat:@"%.f", maxValue];
            _priceRangeView.priceDetailLab.text = [NSString stringWithFormat:@"%.f-%.f", minValue, maxValue];
            
        }else{
            _minPrice = [NSString stringWithFormat:@"%.f", minValue];
            _maxPrice = @"";
            _priceRangeView.priceDetailLab.text = [NSString stringWithFormat:@"%.f-不限", minValue];
        };
        NSLog(@"minValue = %.f, maxValue = %.f", minValue, maxValue);
    };
    _menu.customViews = [NSMutableArray arrayWithObjects:[NSNull null], _priceRangeView, [NSNull null], nil];
    return _menu;
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView tab_startAnimation];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    self.view = _tableView;
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
//        [self requestHotelHeaderData];
        [self endRefreshing];
    }];
    //手动刷新请求最新数据
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        QDLog(@"sss");
        [self endRefreshing];
        QDLog(@"上拉刷新");
        _pageNum++;
    }];
}

- (void)loadNewData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [_tableView.mj_header endRefreshing];
    });
}

- (void)endRefreshing
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
}

#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hotelListInfoArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 47;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self setHotelDropMenu];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QDHotelTableViewCell";
    QDHotelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDHotelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_hotelListInfoArr.count) {
        [cell fillContentWithModel:_hotelListInfoArr[indexPath.row] andImgURLStr:_hotelImgArr[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_hotelListInfoArr.count) {
//        QDHotelListInfoModel *model = _hotelListInfoArr[indexPath.row];
//        //传递ID
//        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
//        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld&&startDate=%@&&endDate=%@", QD_JSURL, JS_HOTELDETAIL, (long)model.id, _dateInPassedVal, _dateOutPassedVal];
//        QDLog(@"urlStr = %@", bridgeVC.urlStr);
//        bridgeVC.infoModel = model;
//        self.tabBarController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

#pragma mark - emptyDataSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
//    if (self.isLoading) {
//        return [UIImage imageNamed:@"loading_imgBlue" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
//    }
//    else {
//        if (_emptyType == QDNODataError) {
//            return [UIImage imageNamed:@"icon_nodata"];
//        }else if(_emptyType == QDNetworkError){
//            return [UIImage imageNamed:@"icon_noConnect"];
//        }
//    }
    return nil;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 155;
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"页面加载失败";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: APP_BLUECOLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = @"请检查您的手机网络后点击重试";
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
//                                 NSForegroundColorAttributeName: APP_GRAYLINECOLOR,
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
}

#pragma mark - TFDropDownMenuView Delegate
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index{
    QDLog(@"第%ld列 第%ld个", (long)index.column, (long)index.section);
    switch (index.column) {
        case 0:             //酒店类型
            QDLog(@"0");
            _hotelTypeId = (index.section == 0)? @"": ([NSString stringWithFormat:@"%ld", (long)index.section]);
            QDLog(@"_hotelTypeId = %@", _hotelTypeId);
            break;
        case 1:             //价格
            
            QDLog(@"1");
            break;
        case 2:             //星级
            _hotelLevel = (index.section == 0)? @"": ([NSString stringWithFormat:@"%ld", (long)index.section]);
            QDLog(@"_hotelLevel = %@", _hotelLevel);
            break;
        default:
            break;
    }
    [self requestHotelData];
}

- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column{
    QDLog(@"column:%ld", (long)column);
    //让tableView滚动到顶部位置
    [_tableView setContentOffset:CGPointZero animated:YES];
    //    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //    [_tableView scrollToRowAtIndexPath:scrollIndexPath
    //                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
@end
