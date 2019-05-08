//
//  TableViewController.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "RankSecondViewController.h"
#import "TheCityModel.h"
#import "RanklistDTO.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDBridgeViewController.h"
static float kLeftTableViewWidth = 92.f;

@interface RankSecondViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_destinationArr;
    NSMutableArray *_rankDTOList;
}

@property (nonatomic, strong) NSMutableArray *categoryData;
@property (nonatomic, strong) NSMutableArray *foodData;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@end

@implementation RankSecondViewController
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _destinationArr = [[NSMutableArray alloc] init];
    _rankDTOList = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionNone];
    [self findAllDestinationList];
}

#pragma mark - 目的地列表查询
- (void)findAllDestinationList{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_findAllDestinationList params:nil successBlock:^(QDResponseObject *responseObject) {
        [_leftTableView tab_endAnimation];
        if (responseObject.code == 0) {
            if (_destinationArr.count) {
                [_destinationArr removeAllObjects];
            }
            NSArray *arr = responseObject.result;
            if (arr.count) {
                for (NSDictionary *dic in arr) {
                    TheCityModel *model = [TheCityModel yy_modelWithDictionary:dic];
                    [_destinationArr addObject:model];
                }
            }
            if (_destinationArr.count) {
                [self findFirstDetailList:_destinationArr[0]];
            }
            [_leftTableView reloadData];
            [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    } failureBlock:^(NSError *error) {
        [_leftTableView tab_endAnimation];
    }];
}

#pragma mark - 第一个目的地对应的榜单列表查询
- (void)findFirstDetailList:(TheCityModel *)cityModel{
    if (_rankDTOList.count) {
        [_rankDTOList removeAllObjects];
    }
    NSDictionary *dic = @{
                          @"listStatus":@"1",
                          @"destinationId":cityModel.id
                          };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_RankedSorting params:dic successBlock:^(QDResponseObject *responseObject) {
        [_rightTableView tab_endAnimation];
        if (responseObject.code == 0) {
            NSArray *arr = [responseObject.result objectForKey:@"result"];
            if (arr.count) {
                for (NSDictionary *dic in arr) {
                    RanklistDTO *listDTO = [RanklistDTO yy_modelWithDictionary:dic];
                    [_rankDTOList addObject:listDTO];
                }
                [_rightTableView reloadData];
            }
        }
    } failureBlock:^(NSError *error) {
        [_rightTableView tab_endAnimation];
    }];
}
#pragma mark - Getters

- (NSMutableArray *)categoryData
{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

- (NSMutableArray *)foodData
{
    if (!_foodData)
    {
        _foodData = [NSMutableArray array];
    }
    return _foodData;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, SCREEN_HEIGHT)];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight = 44;
//        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        [_leftTableView tab_startAnimation];
        _leftTableView.separatorColor = APP_LIGTHGRAYLINECOLOR;
        [_leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, SCREEN_WIDTH-kLeftTableViewWidth, SCREEN_HEIGHT)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 125;
        _rightTableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView tab_startAnimation];
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
            [self endRefreshing];
        }];
        
        _rightTableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
            [self endRefreshing];
            [_rightTableView.mj_footer endRefreshingWithNoMoreData];
        }];
        [_rightTableView registerClass:[RightTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Right];
    }
    return _rightTableView;
}

- (void)endRefreshing
{
    if (_rightTableView) {
        [_rightTableView.mj_header endRefreshing];
        [_rightTableView.mj_footer endRefreshing];
    }
}
#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_leftTableView == tableView)
    {
        return _destinationArr.count;
    }
    else
    {
        return _rankDTOList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_leftTableView == tableView)
    {
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
        cell.backgroundColor = APP_WHITECOLOR;
        if (_destinationArr.count) {
            TheCityModel *model = _destinationArr[indexPath.row];
            cell.name.text = model.destination;
        }
        return cell;
    }
    else
    {
        RightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Right forIndexPath:indexPath];
        cell.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        if (_rankDTOList.count) {
            [cell loadDataWithRankModel:_rankDTOList[indexPath.row]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && !_isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((_rightTableView == tableView)
        && _isScrollDown
        && (_rightTableView.dragging || _rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [_leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
        [self findFirstDetailList:_destinationArr[_selectIndex]];
    }
    if (_rightTableView == tableView) {
        //榜单详情页
        [_rightTableView deselectRowAtIndexPath:indexPath animated:NO];
        RanklistDTO *dto = _rankDTOList[indexPath.row];
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?ranklistId=%ld", QD_TESTJSURL, JS_RANKLIST, (long)dto.id];
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (_rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
