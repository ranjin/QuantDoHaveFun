//
//  QDTradingFlowVC.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/8.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDTradingFlowVC.h"
#import "QDCreditOrderTableViewCell.h"
#import "TFDropDownMenu.h"
#import "QDFiltrateDropdownMenu.h"
#import "QDCalendarViewController.h"
#import "QDDateUtils.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface QDTradingFlowVC ()<UITableViewDelegate,UITableViewDataSource,QDFiltrateDropdownMenuDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *orderArray;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong)QDFiltrateDropdownMenu *filtrateMenuView;
@property(nonatomic,strong)NSArray *seedTitleArray;
@property(nonatomic,assign)NSInteger tradingDirectionIndex;
@property(nonatomic,assign)NSInteger tradingTypeIndex;
@property(nonatomic,strong)NSString *tradingDate;
@end

@implementation QDTradingFlowVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kNotificationDropDownMenuDidLoaded" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    self.navigationController.navigationBar.translucent = NO;
    self.rt_disableInteractivePop = YES;
    self.title = @"资金明细";
    
    UIImage *backImage = [UIImage imageNamed:@"icon_return"];
    UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackAction)];
    [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
    
    self.tradingDirectionIndex = -1;
    [self setupViews];
    [self getCreditOrderList:1];
    
}
- (void)navigationBackAction {
    [self.filtrateMenuView.dropDownView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
- (QDFiltrateDropdownMenu *)filtrateMenuView {
    if (!_filtrateMenuView) {
        self.seedTitleArray = @[@[@"全部",@"收入",@"支出"],TradingOrderTypeNames];
        _filtrateMenuView = [QDFiltrateDropdownMenu menuWithLeftTitles:@[@"类型",@"踪影"] seedTitles:self.seedTitleArray canSelectDate:NO];
        _filtrateMenuView.frame = CGRectMake(0, 10, LD_SCREENWIDTH, 35);
        _filtrateMenuView.delegate = self;
    }
    return _filtrateMenuView;
}
- (void)setupViews {
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, LD_SCREENWIDTH,LD_SCREENHEIGHT-Height_NavAndStatusBar-45) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[QDCreditOrderTableViewCell class] forCellReuseIdentifier:@"QDCreditOrderTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.filtrateMenuView];
    
    
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        [self getCreditOrderListWithTradingDirection:self.tradingDirectionIndex tradingtype:self.tradingTypeIndex tradingDate:self.tradingDate];
    }];
    //
    //    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
    //        _pageNum++;
    //        [self getCreditOrderList:_pageNum];
    //    }];
}
- (void)getCreditOrderList:(NSInteger)pageNum {
    
    NSDictionary *dic = @{@"pageNum":[NSNumber numberWithInteger:pageNum],@"pageSize":@500};
    [[QDServiceClient shareClient]requestWithType:kHTTPRequestTypePOST urlString:api_findTradingFlowList params:dic successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"%@",responseObject.result);
        //        NSInteger totalPage = [[responseObject.result valueForKey:@"totalPage"] integerValue];
        self.orderArray = [NSMutableArray arrayWithCapacity:10];
        NSArray *array = [responseObject.result valueForKey:@"result"];
        for (NSDictionary *dic in array) {
            QDTradingOrder *order = [[QDTradingOrder alloc]init];
            [order setValuesForKeysWithDictionary:dic];
            [self.orderArray addObject:order];
        }
        self.pageNum = pageNum;
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
        
    }];
}
- (void)getMoreCreditOrderList {
    [self getCreditOrderList:self.pageNum+1];
}
//- (void)endRefreshing
//{
//    if (_tableView) {
//        [_tableView.mj_header endRefreshing];
//        [_tableView.mj_footer endRefreshing];
//    }
//}
- (void)getCreditOrderListWithTradingDirection:(NSInteger)tradingDirection tradingtype:(NSInteger)tradingtype tradingDate:(NSString *)tradingDate {
    [self.tableView setContentOffset:CGPointZero animated:NO];
    // 参数null表示 全部
    NSDictionary *dic = @{@"tradingDirection":tradingDirection<0?[NSNull null]:[NSNumber numberWithInteger:tradingDirection],@"tradingtype":TradingOrderTypeIDs[tradingtype],@"tradingDate":tradingDate?tradingDate:[NSNull null],@"pageNum":[NSNumber numberWithInteger:1],@"pageSize":@500};
    [[QDServiceClient shareClient]requestWithType:kHTTPRequestTypePOST urlString:api_findTradingFlowList params:dic successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"%@",responseObject.result);
        self.orderArray = [NSMutableArray arrayWithCapacity:10];
        NSArray *array = [responseObject.result valueForKey:@"result"];
        for (NSDictionary *dic in array) {
            QDTradingOrder *order = [[QDTradingOrder alloc]init];
            [order setValuesForKeysWithDictionary:dic];
            [self.orderArray addObject:order];
        }
        //        self.pageNum = pageNum;
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        [_tableView.mj_header endRefreshing];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCreditOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QDCreditOrderTableViewCell" forIndexPath:indexPath];
    cell.tradingOrder = self.orderArray[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
}

- (void)didSelectedItemIndex:(NSInteger)itemIndex menuIndex:(NSInteger)menuIndex {
    NSLog(@"didSelectedItem title: %@",self.seedTitleArray[itemIndex][menuIndex]);
    
    switch (itemIndex) {
        case 0:
            self.tradingDirectionIndex = menuIndex - 1;
            break;
        case 1:
            self.tradingTypeIndex = menuIndex;
            break;
        default:
            break;
    }
    [self getCreditOrderListWithTradingDirection:self.tradingDirectionIndex tradingtype:self.tradingTypeIndex tradingDate:self.tradingDate];
}


#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"icon_nodata"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//- (void)didSelectedCalendarDate:(NSDate *)date {
//    [self getCreditOrderListWithTradingDirection:-1 tradingtype:-1 tradingDate:[QDDateUtils dateFormate:@"yyyy-MM-dd" WithDate:date]];
//}

@end
