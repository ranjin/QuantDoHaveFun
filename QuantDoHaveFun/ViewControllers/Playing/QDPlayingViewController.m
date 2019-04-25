//
//  QDPlayingViewController.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/17.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDPlayingViewController.h"

@interface QDPlayingViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
}

@end

@implementation QDPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view.
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#F3F7F9"];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    view.backgroundColor = APP_BLUECOLOR;
//    _tableView.tableHeaderView = view;
    [self.view addSubview:_tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    view.backgroundColor = APP_BLUECOLOR;
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    [self customSeparateLineToCell:cell];
    cell.textLabel.textColor = APP_BLACKCOLOR;
    cell.textLabel.font = QDFont(16);
    cell.textLabel.text = @"TEATSfsdf";
    return cell;
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
