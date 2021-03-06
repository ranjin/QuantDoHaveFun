//
//  QDMallViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "RankFirstViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "QDOrderField.h"
#import "RankFirstViewCell.h"
#import "RankFirstHeadView.h"
#import "RankFirstVideoModel.h"
#import "QDBridgeViewController.h"

@interface RankFirstViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITextFieldDelegate>{
    UITableView *_tableView;
    NSMutableArray *_videoList;
    QDEmptyType _emptyType;
    RankFirstHeadView *_headView;
    int _totalPage;
    int _pageNum;
    int _pageSize;
}
@property (nonatomic, assign) NSInteger menuSelectIndex;   //选中的一栏

@property (nonatomic, strong) NSString *catId;  //商品分类

@property (nonatomic, strong) NSString *sortColumn;     //销量排序：volume，价格排序：price
@property (nonatomic, strong) NSString *sortType;       //排序方式：desc降序，asc升序

@property (nonatomic, strong) NSString *baoyou; //是否包邮

@property (nonatomic, strong) NSString *keywords;   //搜索关键词
@end

@implementation RankFirstViewController

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
    if (!_videoList.count) {
        [self getVideoHeadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _menuSelectIndex = -1;
    _catId = @"";
    _sortColumn = @"";
    _sortType = @"";
    _baoyou = @"";
    _keywords = @"";
    _pageNum = 1;
    _pageSize = 10;
    _totalPage = 0; //总页数默认
    _videoList = [[NSMutableArray alloc] init];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [self initTableView];
    [self getVideoList];
}

#pragma mark - 查询商品分类
- (void)getVideoList{
    if (_totalPage != 0) {
        if (_pageNum > _totalPage) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    
    NSDictionary * dic = @{
                           @"pageNum":[NSNumber numberWithInt:_pageNum],
                           @"pageSize":[NSNumber numberWithInt:_pageSize]
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_getVideoList params:dic successBlock:^(QDResponseObject *responseObject) {
        [_tableView tab_endAnimation];
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *videoArr = [dic objectForKey:@"result"];
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            if (videoArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in videoArr) {
                    RankFirstVideoModel *model = [RankFirstVideoModel yy_modelWithDictionary:dic];
                    [arr addObject:model];
                }
                if (arr.count) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_videoList addObjectsFromArray:arr];
                        [_tableView reloadData];
                        if ([_tableView.mj_footer isRefreshing]) {
                            [self endRefreshing];
                            _tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        }
                    }else{
                        [_videoList addObjectsFromArray:arr];
                        _tableView.mj_footer.state = MJRefreshStateIdle;
                        [_tableView reloadData];
                    }
                }
            }else{
                QDLog(@"数据为空");
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

#pragma mark - 查询商品头部列表
- (void)getVideoHeadData{
    _pageNum = 1;
    if (_videoList.count) {
        [_videoList removeAllObjects];
    }
    NSDictionary * dic = @{
                           @"pageNum":[NSNumber numberWithInt:_pageNum],
                           @"pageSize":[NSNumber numberWithInt:_pageSize]
                           };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_getVideoList params:dic successBlock:^(QDResponseObject *responseObject) {
        [_tableView tab_endAnimation];
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *videoArr = [dic objectForKey:@"result"];
            _totalPage = [[dic objectForKey:@"totalPage"] intValue];
            if (videoArr.count) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in videoArr) {
                    RankFirstVideoModel *model = [RankFirstVideoModel yy_modelWithDictionary:dic];
                    [arr addObject:model];
                }
                if (arr.count) {
                    if (arr.count < _pageSize) {   //不满10个
                        [_videoList addObjectsFromArray:arr];
                        [_tableView reloadData];
                        if ([_tableView.mj_footer isRefreshing]) {
                            [self endRefreshing];
                            _tableView.mj_footer.state = MJRefreshStateNoMoreData;
                        }
                    }else{
                        [_videoList addObjectsFromArray:arr];
                        _tableView.mj_footer.state = MJRefreshStateIdle;
                        [_tableView reloadData];
                    }
                }
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _headView = [[RankFirstHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    _tableView.tableHeaderView = _headView;
    _tableView.estimatedRowHeight = 266;
    [_tableView tab_startAnimation];
//    self.view = _tableView;
    [self.view addSubview:_tableView];
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        [self getVideoHeadData];
    }];
    
    //手动刷新请求最新数据
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        _pageNum++;
        [self getVideoList];
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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _videoList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT*0.32;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return self.sectionHeaderView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"RankFirstViewCell";
    RankFirstViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RankFirstViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_videoList.count) {
        [cell loadVideoDataWithArr:_videoList[indexPath.section]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    return cell;
}
/*
 XCHANGE(0,"备兑商"),
 CONTRACT(1,"包销商"), // 包销商
 AGENT(2,"代销商"),  // 代销商
 CONVERT(3,"兑换商"),  // 兑换商
 MAKE(4,"做市商"),  // 做市商
 HOTEL(5,"酒店"),  // 酒店
 SCENIC(6,"景区"),  // 景区
 CATERING(7,"餐饮"),
 TRAVEL(8,"定制游"), // 定制游
 USER(9,"APP用户"),
 SALE_LOAN(10,"卖场"), // 卖场
 TRAVEL_AGENCY(11,"旅行社"), // 旅行社
 GOODS(12,"电商"), // 电商
 PLATFORM(99,"平台");
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_videoList.count) {
        RankFirstVideoModel *model = _videoList[indexPath.section];
        switch ([model.sourceType integerValue]) {
            case 5://酒店
            {
                QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
                bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%@", QD_JSURL, JS_HOTELDETAIL, model.sourceId];
//                    bridgeVC.infoModel = model;
                //model转换
                
                self.tabBarController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:bridgeVC animated:YES];
            }
                break;
            case 7://餐厅
            {
                //传递ID
                QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
                bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%@", QD_JSURL, JS_RESTAURANTDETAIL, model.sourceId];
                QDLog(@"urlStr = %@", bridgeVC.urlStr);
                [self.navigationController pushViewController:bridgeVC animated:YES];
            }
                break;
            case 8://定制游
            {
                QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
                bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%@", QD_JSURL, JS_CUSTOMERTRAVEL, model.sourceId];
                QDLog(@"urlStr = %@", bridgeVC.urlStr);
                //            bridgeVC.customTravelModel = model;
                [self.navigationController pushViewController:bridgeVC animated:YES];
            }
                break;
            default:
                break;
        }
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
    if (_emptyType == QDNODataError) {
        text = @"暂无数据";
    }else{
        text = @"页面加载失败";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: APP_BLUECOLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    if (_emptyType == QDNODataError) {
//        return nil;
//    }else{
//        NSString *text = @"重新加载";
//        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//        paragraphStyle.alignment = NSTextAlignmentCenter;
//
//        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
//                                     NSForegroundColorAttributeName: APP_WHITECOLOR,
//                                     NSParagraphStyleAttributeName: paragraphStyle};
//        return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//    }
//}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *imageName = @"button_background_kickstarter";
    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
    
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
        NSString *text = @"请检查您的手机网络后重试";
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

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -100;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *text;
    if (_emptyType == QDNetworkError) {
        text = @"重新加载";
    }else{
        text = @"点击刷新";
    }
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName: APP_WHITECOLOR,
                                 NSParagraphStyleAttributeName: paragraphStyle};
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    [self getVideoHeadData];
}
@end
