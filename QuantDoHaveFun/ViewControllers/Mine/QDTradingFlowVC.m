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

@interface QDTradingFlowVC ()<UITableViewDelegate,UITableViewDataSource,QDFiltrateDropdownMenuDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *orderArray;
@property(nonatomic,assign)NSInteger pageNum;
@property(nonatomic,strong)QDFiltrateDropdownMenu *filtrateMenuView;
@property(nonatomic,strong)NSArray *seedTitleArray;

@end

@implementation QDTradingFlowVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBar.translucent = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"kNotificationDropDownMenuDidLoaded" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    self.title = @"资金明细";
    UIImage *backImage = [UIImage imageNamed:@"icon_return"];
    UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackAction)];
    [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
    
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
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, LD_SCREENWIDTH,LD_SCREENHEIGHT-Height_NavAndStatusBar-55) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[QDCreditOrderTableViewCell class] forCellReuseIdentifier:@"QDCreditOrderTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.filtrateMenuView];
    
    
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        [self getCreditOrderList:1];
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
            QDCreditOrder *order = [[QDCreditOrder alloc]init];
            [order setValuesForKeysWithDictionary:dic];
            [self.orderArray insertObject:order atIndex:0];
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
    // 参数null表示 全部
    NSDictionary *dic = @{@"tradingDirection":tradingDirection<0?[NSNull null]:[NSNumber numberWithInteger:tradingDirection],@"tradingtype":tradingtype<0?[NSNull null]:[NSNumber numberWithInteger:tradingtype],@"tradingDate":tradingDate?tradingDate:[NSNull null],@"pageNum":[NSNumber numberWithInteger:1],@"pageSize":@500};
    [[QDServiceClient shareClient]requestWithType:kHTTPRequestTypePOST urlString:api_findTradingFlowList params:dic successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"%@",responseObject.result);
        self.orderArray = [NSMutableArray arrayWithCapacity:10];
        NSArray *array = [responseObject.result valueForKey:@"result"];
        for (NSDictionary *dic in array) {
            QDCreditOrder *order = [[QDCreditOrder alloc]init];
            [order setValuesForKeysWithDictionary:dic];
            [self.orderArray insertObject:order atIndex:0];
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
    cell.creditOrder = self.orderArray[indexPath.row];
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
    
}

- (void)didSelectedItemIndex:(NSInteger)itemIndex menuIndex:(NSInteger)menuIndex {
    NSLog(@"didSelectedItem title: %@",self.seedTitleArray[itemIndex][menuIndex]);
    
    NSInteger tradingDirection = -1;
    NSInteger tradingType = -1;
    switch (itemIndex) {
        case 0:
            tradingDirection = menuIndex -1;
            break;
        case 1:
            tradingType = menuIndex - 1;
            break;
        default:
            break;
    }
    [self getCreditOrderListWithTradingDirection:tradingDirection tradingtype:tradingType tradingDate:nil];
}
//- (void)didSelectedCalendarDate:(NSDate *)date {
//    [self getCreditOrderListWithTradingDirection:-1 tradingtype:-1 tradingDate:[QDDateUtils dateFormate:@"yyyy-MM-dd" WithDate:date]];
//}

@end
