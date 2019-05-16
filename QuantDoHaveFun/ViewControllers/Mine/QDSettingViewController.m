//
//  QDSettingViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/16.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDSettingViewController.h"
#import "QDBridgeViewController.h"
//#import "QDLoginAndRegisterVC.h"
#import <TYAlertView.h>

@interface QDSettingViewController ()<UITableViewDelegate, UITableViewDataSource>{
    UITableView *_tableView;
    UILabel *_exitCurrent;
    UILabel *_versionLab;
}

@property (nonatomic, strong) NSString *version;

@end

@implementation QDSettingViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70+SafeAreaTopHeight-64)];
    backView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:backView];
    
    UIButton *returnBtn = [[UIButton alloc] init];
    [returnBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(popAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:returnBtn];
    [returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(SafeAreaTopHeight-50);
        make.width.and.height.mas_equalTo(45);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"设置";
    titleLab.textColor = APP_BLACKCOLOR;
    titleLab.font = QDFont(17);
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(returnBtn);
    }];
    [self requestVersion];
}

- (void)popAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestVersion{
    [WXProgressHUD showHUD];
    NSString *URLString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@", APP_ID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:URLString]];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:15.0f];
    __weak __typeof(&*self)weakSelf = self;
    __block NSHTTPURLResponse *urlResponse = nil;
    __block NSError *error = nil;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        if (recervedData && recervedData.length > 0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:recervedData options:NSJSONReadingMutableLeaves error:&error];
            NSArray *infoArray = [dict objectForKey:@"results"];
            [WXProgressHUD hideHUD];
            if (infoArray && infoArray.count > 0) {
                _version = [infoArray.firstObject objectForKey:@"version"];
                [self initTableView];
                [self addLogoutBtn];
            }
        }
    }];
}
- (void)addLogoutBtn{
    UIButton *recommendBtn = [[UIButton alloc] init];
    [recommendBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [recommendBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [recommendBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 316, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
    [recommendBtn.layer addSublayer:gradientLayer];
    recommendBtn.titleLabel.font = QDFont(16);
    recommendBtn.layer.cornerRadius = 25;
    recommendBtn.layer.masksToBounds = YES;
    [_tableView addSubview:recommendBtn];
    [recommendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_tableView);
        make.top.equalTo(self.view.mas_top).offset(280+SafeAreaTopHeight-64);
        make.width.mas_equalTo(316);
        make.height.mas_equalTo(50);
    }];
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        recommendBtn.hidden = YES;
    }else{
        recommendBtn.hidden = NO;
    }
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 72+SafeAreaTopHeight-64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.sectionHeaderHeight = 2;
    _tableView.sectionFooterHeight = 1;
    _tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark -- tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    [self customSeparateLineToCell:cell];
    //设置cell点击时的颜色
    if (indexPath.section == 0) {
        cell.textLabel.font = QDFont(16);
        cell.textLabel.textColor = APP_BLACKCOLOR;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"升级检查";
            _versionLab = [[UILabel alloc] init];
            //此处最好是获取商店的版本信息
            _versionLab.text = [NSString stringWithFormat:@"当前版本%@", _version];
            _versionLab.textAlignment = NSTextAlignmentRight;
            _versionLab.font = QDFont(16);
            _versionLab.textColor = APP_GRAYLINECOLOR;
            cell.accessoryType = UITableViewCellAccessoryNone; //显示最右边的箭头
            [cell.contentView addSubview:_versionLab];
            [_versionLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-(30));
            }];
        }else if (indexPath.row == 1){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            cell.textLabel.text = @"关于我们";
        }
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.textLabel.text = @"帮助中心";
        cell.textLabel.font = QDFont(16);
        cell.textLabel.textColor = APP_BLACKCOLOR;
    }
    return cell;
}

#pragma mark - 用户登出接口
- (void)logout{
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"退出登录" message:@"确定退出当前用户?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        [WXProgressHUD hideHUD];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        //先判断用户是否登录
        [[QDServiceClient shareClient] logoutWitStr:api_UserLogout SuccessBlock:^(QDResponseObject *responseObject) {
            [WXProgressHUD hideHUD];
            if (responseObject.code == 0) {
                //移除cookie
                [WXProgressHUD showSuccessWithTittle:@"退出登录成功"];
                [QDUserDefaults setObject:@"0" forKey:@"loginType"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadLoginView" object:nil];
                [QDUserDefaults removeCookies];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [WXProgressHUD showErrorWithTittle:@"网络异常"];
        }];
    }]];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}
- (void)showAlertView{
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"提示" message:@"确定退出当前账户?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        [self logout];
    }]];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            //关于我们
        }
    }else{
//        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
//        bridgeVC.urlStr = [QD_JSURL stringByAppendingString:JS_PROTOCOLS];
//        self.navigationController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

-(void)customSeparateLineToCell:(UITableViewCell *)cell{
    UIView *separateLineBottom = [[UIView alloc] init];
    [separateLineBottom setBackgroundColor:[UIColor colorWithHexString:@"#DDDDDD"]];
    [cell.contentView addSubview:separateLineBottom];
    [separateLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView);
        make.centerX.equalTo(cell.contentView);
        make.width.mas_equalTo(355);
        make.height.mas_equalTo(0.5);
    }];
}

@end
