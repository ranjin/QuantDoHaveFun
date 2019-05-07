//
//  QDCreditOrderHistoryVC.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/7.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDCreditOrderHistoryVC.h"
#import "QDCreditOrderTableViewCell.h"

@interface QDCreditOrderHistoryVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *orderArray;
@property(nonatomic,assign)NSInteger pageNum;
@end

@implementation QDCreditOrderHistoryVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    self.title = @"玩贝踪影";
    [self showBack:YES];

    [self setupViews];
    [self getCreditOrderList:0];
    
}
- (void)setupViews {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, LD_SCREENWIDTH,LD_SCREENHEIGHT-Height_NavAndStatusBar-20) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[QDCreditOrderTableViewCell class] forCellReuseIdentifier:@"QDCreditOrderTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)getCreditOrderList:(NSInteger)pageNum {
    
    NSDictionary *dic = @{@"pageNum":[NSNumber numberWithInteger:pageNum],@"pageSize":@12};
    [[QDServiceClient shareClient]requestWithType:kHTTPRequestTypePOST urlString:api_getCreditOrderList params:dic successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"%@",responseObject.result);
        self.pageNum = pageNum;
    } failureBlock:^(NSError *error) {
        
    }];
}
- (void)getMoreCreditOrderList {
    [self getCreditOrderList:self.pageNum+1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCreditOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QDCreditOrderTableViewCell" forIndexPath:indexPath];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
