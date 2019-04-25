//
//  QDHomeRankListVC.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/21.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDHomeRankListVC.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDHomePageViewCell.h"
#import "QDBridgeViewController.h"
#import "RanklistDTO.h"
@interface QDHomeRankListVC ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    UITableView *_tableView;
    NSMutableArray *_rankListArr;
}
@end

@implementation QDHomeRankListVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    [self findHomeRankType];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    _rankListArr = [[NSMutableArray alloc] init];
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_WHITECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //    [_tableView tab_startAnimation];
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 130, 0);
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
//    [self.view addSubview:_tableView];
        self.view = _tableView;
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
//        [self requestHeaderTopData];
        [self endRefreshing];
    }];
    
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        QDLog(@"上拉刷新");
        [self endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rankListArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT*0.68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_HEIGHT*0.075;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"QDHomePageViewCell";
    QDHomePageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDHomePageViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_rankListArr.count) {
        [cell loadTableViewCellDataWithModel:_rankListArr[indexPath.row]];
    }else{
        [_tableView reloadEmptyDataSet];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = APP_WHITECOLOR;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_rankListArr.count) {
        RanklistDTO *dto = _rankListArr[indexPath.row];
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?ranklistId=%ld", QD_TESTJSURL, JS_RANKLIST, (long)dto.id];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

/**
 榜单类型排序查询
 */
- (void)findHomeRankType{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindRankTypeToSort params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSArray *resultArr = responseObject.result;
            NSDictionary *dic = resultArr[0];
            [self getRankedSortingWithTypeStr:[dic objectForKey:@"rankType"]];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [self initTableView];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
    }];
}

- (void)getRankedSortingWithTypeStr:(NSString *)typeStr{
    if (_rankListArr.count) {
        [_rankListArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"listType":typeStr};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_RankedSorting params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            for (NSDictionary *dic in hotelArr) {
                RanklistDTO *listDTO = [RanklistDTO yy_modelWithDictionary:dic];
                [_rankListArr addObject:listDTO];
            }
            [_tableView reloadData];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
    }];
}

- (void)endRefreshing
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
}
@end
