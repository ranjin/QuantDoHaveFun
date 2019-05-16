//
//  QDDZYViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDResturantVC.h"
#import "QDSegmentControl.h"
#import "QDResutrantViewCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDLocationTopSelectView.h"
#import "QDCustomTourSectionHeaderView.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDBridgeViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "QDOrderField.h"
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "ResturantModel.h"
#import "TFDropDownMenu.h"

//预定酒店 定制游 商城
@interface QDResturantVC ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITextFieldDelegate,TFDropDownMenuViewDelegate>{
    UITableView *_tableView;
    NSMutableArray *_restaurantList;
    NSMutableArray *_restaurantImgArr;
    NSMutableArray *_cuisineTypeArray;
    NSMutableArray *_cuisineTypeIDArray;
    QDEmptyType _emptyType;
    NSString *_travelName;
    int _totalPage;
    int _pageNum;
    int _pageSize;
    TFDropDownMenuView *_menu;
    NSInteger _cuisineTypeID;
}

@end

@implementation QDResturantVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstLaunch:) name:@"FirstLaunch" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FirstLaunch" object:nil];
}

- (void)firstLaunch:(NSNotification *)noti{
    if (_cuisineTypeArray.count == 0) {
        [self finAllMapDic];
    }
    [self requestResturantHeadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _restaurantList = [[NSMutableArray alloc] init];
    _restaurantImgArr = [[NSMutableArray alloc] init];
    _travelName = @"";
    _pageNum = 1;
    _pageSize = 10;
    _totalPage = 0; //总页数默认
    _cuisineTypeID = -1;
    //分段选择按钮
//    [self initTableView];
    [self finAllMapDic];
    [self requestResturantList];
}


- (void)finAllMapDic{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindAllMapDict params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            if ([[dic allKeys] containsObject:@"cuisine"]) {
                NSArray *aaa = [dic objectForKey:@"cuisine"];
                NSLog(@"%@",dic);
                _cuisineTypeArray = [NSMutableArray arrayWithCapacity:10];
                _cuisineTypeIDArray = [NSMutableArray arrayWithCapacity:10];
                for (NSDictionary *dd in aaa) {
                    [_cuisineTypeArray addObject:[dd objectForKey:@"dictName"]];
                    [_cuisineTypeIDArray addObject:[dd objectForKey:@"dictValue"]];
                }
                [_cuisineTypeArray insertObject:@"全部" atIndex:0];
                [_cuisineTypeIDArray insertObject:@-1 atIndex:0];
                [self setDropMenu];
                [self initTableView];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [self setDropMenu];
        [self initTableView];
        [WXProgressHUD hideHUD];
    }];
}
- (void)setDropMenu{
    NSMutableArray *data1 = [NSMutableArray arrayWithObjects:_cuisineTypeArray, nil];
    NSMutableArray *data2 = [NSMutableArray arrayWithObjects:@[], nil];
    _menu = [[TFDropDownMenuView alloc] initWithFrame:CGRectMake(0, 7, SCREEN_WIDTH, 40) firstArray:data1 secondArray:data2];
    _menu.bottomLineView.backgroundColor = APP_WHITECOLOR;
    _menu.backgroundColor = APP_WHITECOLOR;
    _menu.delegate = self;
    _menu.ratioLeftToScreen = 0.35;
    
    /*风格*/
    _menu.menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:TFDropDownMenuStyleTableView], [NSNumber numberWithInteger:TFDropDownMenuStyleCustom], [NSNumber numberWithInteger:TFDropDownMenuStyleTableView], nil];
    [self.view addSubview:_menu];
}
#pragma mark - TFDropDownMenuView Delegate
- (void)menuView:(TFDropDownMenuView *)menu selectIndex:(TFIndexPatch *)index{
    QDLog(@"第%ld列 第%ld个", (long)index.column, (long)index.section);
    _pageNum = 1;
    _cuisineTypeID = [_cuisineTypeIDArray[index.section] integerValue];
    [_restaurantList removeAllObjects];
    [_restaurantImgArr removeAllObjects];
    [self requestResturantList];
}
// 点击了菜单
- (void)menuView:(TFDropDownMenuView *)menu tfColumn:(NSInteger)column{
    QDLog(@"column:%ld", (long)column);
    //让tableView滚动到顶部位置
    [_tableView setContentOffset:CGPointZero animated:YES];
}
#pragma mark - 请求餐厅列表信息
- (void)requestResturantList{
    if (_totalPage != 0) {
        if (_pageNum > _totalPage) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    id cuisineId;
    if (_cuisineTypeID == -1) {
        cuisineId = [NSNull null];
    }else {
        cuisineId = [NSNumber numberWithInteger:_cuisineTypeID];
    }
    NSDictionary * dic1 = @{@"province":@"",
                            @"district":@"",
                            @"restaurantName":_travelName,
                            @"cuisineId":cuisineId,
                            @"pageNum":[NSNumber numberWithInt:_pageNum],
                            @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_resturant params:dic1 successBlock:^(QDResponseObject *responseObject) {
        [self endRefreshing];
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *dzyArr = [dic objectForKey:@"result"];
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            if (dzyArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSMutableArray *imgarr = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dic in dzyArr) {
                    ResturantModel *infoModel = [ResturantModel yy_modelWithDictionary:dic];
                    [arr addObject:infoModel];
                    NSDictionary *dic = [infoModel.restaurantImageList firstObject];
                    NSString *urlStr = [dic objectForKey:@"imageFullUrl"];
                    QDLog(@"urlStr = %@", urlStr);
                    [imgarr addObject:urlStr];
                }
                if (arr.count) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_restaurantList addObjectsFromArray:arr];
                        [_restaurantImgArr addObjectsFromArray:imgarr];
                        [_tableView reloadData];
                        if ([_tableView.mj_footer isRefreshing]) {
                            [self endRefreshing];
                            _tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        }
                    }else{
                        [_restaurantList addObjectsFromArray:arr];
                        [_restaurantImgArr addObjectsFromArray:imgarr];
                        _tableView.mj_footer.state = MJRefreshStateIdle;
                        [_tableView reloadData];
                    }
                }
            }else{
                _emptyType = QDNODataError;
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
        }
        [_tableView tab_endAnimation];
        [self endRefreshing];
    } failureBlock:^(NSError *error) {
        _emptyType = QDNetworkError;
        [self endRefreshing];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_tableView tab_endAnimation];
    }];
}

#pragma mark - 请求餐厅列表头部信息
- (void)requestResturantHeadData{
    _pageNum = 1;
    if (_restaurantList.count) {
        [_restaurantList removeAllObjects];
        [_restaurantImgArr removeAllObjects];
    }

    NSDictionary * dic1 = @{@"province":@"",
                            @"district":@"",
                            @"restaurantName":_travelName,
                            @"pageNum":[NSNumber numberWithInt:_pageNum],
                            @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_resturant params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *dzyArr = [dic objectForKey:@"result"];
            if (dzyArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSMutableArray *imgarr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in dzyArr) {
                    ResturantModel *infoModel = [ResturantModel yy_modelWithDictionary:dic];
                    [arr addObject:infoModel];
                    NSDictionary *dic = [infoModel.restaurantImageList firstObject];
                    [imgarr addObject:[dic objectForKey:@"imageFullUrl"]];
                }
                if (arr.count) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_restaurantList addObjectsFromArray:arr];
                        [_restaurantImgArr addObjectsFromArray:imgarr];
                        [_tableView reloadData];
                        if ([_tableView.mj_footer isRefreshing]) {
                            [self endRefreshing];
                            _tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        }
                    }else{
                        [_restaurantList addObjectsFromArray:arr];
                        [_restaurantImgArr addObjectsFromArray:imgarr];
                        _tableView.mj_footer.state = MJRefreshStateIdle;
                        [_tableView reloadData];
                    }
                }
                [_tableView reloadData];
            }else{
                _emptyType = QDNODataError;
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
        }
        [_tableView tab_endAnimation];
        [self endRefreshing];
    } failureBlock:^(NSError *error) {
        _emptyType = QDNetworkError;
        [self endRefreshing];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_tableView tab_endAnimation];
    }];
}


- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView tab_startAnimation];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 110, 0);
    _tableView.estimatedRowHeight = 149;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    [self.view addSubview: _tableView];
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        if (_cuisineTypeArray.count == 0) {
            [self finAllMapDic];
        }
        [self requestResturantHeadData];
    }];
    
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        _pageNum++;
        [self requestResturantList];
    }];
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
    return _restaurantList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 149;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QDResutrantViewCell";
    QDResutrantViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDResutrantViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_restaurantList.count > 0) {
        [cell fillRestaurant:_restaurantList[indexPath.row] andImgURL:_restaurantImgArr[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_restaurantList.count) {
        ResturantModel *model = _restaurantList[indexPath.row];
        //传递ID
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld", QD_JSURL, JS_RESTAURANTDETAIL, (long)model.id];
        QDLog(@"urlStr = %@", bridgeVC.urlStr);
        bridgeVC.resModel = model;
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

#pragma mark - DZNEmtpyDataSet Delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (_emptyType == QDNODataError) {
        return [UIImage imageNamed:@"icon_nodata"];
    }else if(_emptyType == QDNetworkError){
        return [UIImage imageNamed:@"icon_noConnect"];
    }
    return nil;
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
    NSString *text;
    if (_emptyType == QDNetworkError) {
        text = @"网络异常";
    }else{
        text = @"暂无数据";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: APP_BLUECOLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *imageName = @"button_background_kickstarter";
    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
    UIEdgeInsets capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0);
    UIEdgeInsets rectInsets = UIEdgeInsetsMake(0.0, -20, 0.0, -20);
    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (_emptyType == QDNODataError) {
        return nil;
    }else{
        NSString *text = @"请检查您的手机网络后点击重试";
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                     NSForegroundColorAttributeName: APP_GRAYLINECOLOR,
                                     NSParagraphStyleAttributeName: paragraphStyle};
        return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    }
}
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

@end
