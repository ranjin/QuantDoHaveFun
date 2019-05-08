//
//  QDTradingShellsVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDFourViewController.h"
#import "QDTradeShellsSectionHeaderView.h"
#import "RootTableCell.h"
#import "MyTableCell.h"
#import "TFDropDownMenu.h"
#import "SnailQuickMaskPopups.h"
#import "QDFilterTypeThreeView.h"
#import "QDMySaleOrderCell.h"
#import "QDMyPurchaseCell.h"
#import "QDPickUpOrderCell.h"
#import "QDOrderDetailVC.h"
#import <TYAlertView/TYAlertView.h>
#import "BiddingPostersDTO.h"
#import "QDMyPickOrderModel.h"
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDBuyOrSellViewController.h"
#import "QDSettingViewController.h"
#import "QDBridgeViewController.h"
#import "QDLoginAndRegisterVC.h"
#import "QDOrderField.h"

#define K_T_Cell @"t_cell"
#define K_C_Cell @"c_cell"

// 要玩贝  转玩贝  我的报单  我的摘单
typedef enum : NSUInteger {
    QDPlayShells = 0,
    QDTradeShells = 1,
    QDMyOrders = 2,
    QDPickUpOrders = 3
} QDShellType;

@interface QDFourViewController ()<UITableViewDelegate, UITableViewDataSource, SnailQuickMaskPopupsDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>{
    QDTradeShellsSectionHeaderView *_sectionHeaderView;
    UIView *_backView;
    NSMutableArray *_myPickOrdersArr;   //我的摘单
    int _pageSize;
    int _pageNum;
    int _totalPage;
    QDEmptyType _emptyType;
}
@property (nonatomic, strong) UIImageView *emptyView;
@property (nonatomic, strong) UILabel *tipLab;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dicH;
@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) QDFilterTypeThreeView *typeThreeView;

@property (nonatomic, strong) UIView *vv;
@property (nonatomic, getter=isLoading) BOOL loading;

@property (nonatomic, strong) NSString *businessType;   //订单类型：0买入，1卖出
/**QD_WaitForPurchase = 0,    //待付款
QD_HavePurchased = 1,      //已付款
QD_HaveFinished = 2,       //已完成
QD_OverTimeCanceled = 3,   //超时取消
QD_ManualCanceled = 4      //手工取消
 */
@property (nonatomic, strong) NSString *state;

@end

@implementation QDFourViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucceeded:) name:Notification_LoginSucceeded object:nil];
}


- (void)loginSucceeded:(NSNotification *)noti{
    QDLog(@"登录成功");
    [self requestMyZhaiDanData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_LoginSucceeded object:nil];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (UIImageView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[UIImageView alloc] init];
        _emptyView.image = [UIImage imageNamed:@"emptySource@2x"];
        [_tableView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tableView);
            make.top.equalTo(_tableView.mas_top).offset(200);
        }];
    }
    return _emptyView;
}

- (UILabel *)tipLab{
    if (!_tipLab) {
        _tipLab = [[UILabel alloc] init];
        _tipLab.text = @"暂无数据";
        _tipLab.font = QDFont(15);
        _tipLab.textColor = APP_BLACKCOLOR;
        [_tableView addSubview:_tipLab];
        [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tableView);
            make.top.equalTo(_tableView.mas_top).offset(350);
        }];
    }
    return _tipLab;
}

- (void)requestHeaderTopData{
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        [self endRefreshing];
        if (_myPickOrdersArr.count) {
            [_myPickOrdersArr removeAllObjects];
        }
        [self endRefreshing];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        _emptyType = QDNODataError;
//        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
//        loginVC.pushVCTag = @"0";
//        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        if (_myPickOrdersArr.count) {
            [_myPickOrdersArr removeAllObjects];
        }
        NSDictionary * paramsDic = @{@"state":_state,       //订单状态
                                     @"businessType":_businessType,  //订单类型
                                     @"pageNum":@1,
                                     @"pageSize":[NSNumber numberWithInt:_pageSize]
                                     };
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindMyOrder params:paramsDic successBlock:^(QDResponseObject *responseObject) {
            self.loading = NO;
            if (responseObject.code == 0) {
                NSDictionary *dic = responseObject.result;
                NSArray *hotelArr = [dic objectForKey:@"result"];
                _totalPage = [[dic objectForKey:@"totalPage"] intValue];
                if (hotelArr.count) {
                    for (NSDictionary *dic in hotelArr) {
                        QDMyPickOrderModel *infoModel = [QDMyPickOrderModel yy_modelWithDictionary:dic];
                        [_myPickOrdersArr addObject:infoModel];
                    }
                    if ([self.tableView.mj_header isRefreshing]) {
                        [self.tableView.mj_header endRefreshing];
                    }
                    [_tableView reloadData];
                }else{
                    _emptyType = QDNODataError;
                    [_tableView.mj_header endRefreshing];
                    [_tableView reloadData];
                }
            }else{
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            self.loading = NO;
            _emptyType = QDNetworkError;
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
            [self endRefreshing];
            [WXProgressHUD showErrorWithTittle:@"网络异常"];
        }];
    }
}

#pragma mark - 请求我的摘单数据(买入与卖出)
- (void)requestMyZhaiDanData{
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
        loginVC.pushVCTag = @"0";
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        if (_totalPage != 0) {
            if (_pageNum >= _totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
        }
        NSDictionary * paramsDic = @{@"postersStatus":_state,
                                     @"postersType":_businessType,
                                     @"pageNum":[NSNumber numberWithInt:_pageNum],
                                     @"pageSize":[NSNumber numberWithInt:_pageSize]
                                     };
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindMyOrder params:paramsDic successBlock:^(QDResponseObject *responseObject) {
            if (responseObject.code == 0) {
                NSDictionary *dic = responseObject.result;
                NSArray *hotelArr = [dic objectForKey:@"result"];
                _totalPage = [[dic objectForKey:@"totalPage"] intValue];
                if (hotelArr.count) {
                    NSMutableArray *arr = [[NSMutableArray alloc] init];
                    for (NSDictionary *dic in hotelArr) {
                        QDMyPickOrderModel *infoModel = [QDMyPickOrderModel yy_modelWithDictionary:dic];
                        [arr addObject:infoModel];
                    }
                    if (arr) {
                        if (arr.count < _pageSize) {   //不满10个
                            [_myPickOrdersArr addObjectsFromArray:arr];
                            [self.tableView reloadData];
                            if ([self.tableView.mj_footer isRefreshing]) {
                                [self endRefreshing];
                                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                            }
                        }else{
                            [_myPickOrdersArr addObjectsFromArray:arr];
                            self.tableView.mj_footer.state = MJRefreshStateIdle;
                            [self.tableView reloadData];
                        }
                    }
                }else{
                    _emptyType = QDNODataError;
                    [_tableView.mj_footer endRefreshing];
                    [_tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }else{
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            _emptyType = QDNetworkError;
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
            [self endRefreshing];
            [WXProgressHUD showErrorWithTittle:@"网络异常"];
        }];
    }
}
#pragma mark - 用户是否登录
- (void)isLogin{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_IsLogin params:nil successBlock:^(QDResponseObject *responseObject) {
        NSString *cookie = [NSString stringWithFormat:@"%@", [QDUserDefaults getCookies]];
        self.loading = NO;
        if ([responseObject.result intValue] == 0) {
            _emptyType = QDNODataError;
            QDLog(@"未登录, cookie = %@", cookie);
            [QDUserDefaults setObject:@"0" forKey:@"loginType"];
            QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
            loginVC.pushVCTag = @"0";
            [self presentViewController:loginVC animated:YES completion:nil];
            [QDUserDefaults removeCookies]; //未登录的时候移除cookie
        }else if ([responseObject.result intValue] == 1){
            QDLog(@"已登录,cookie = %@", cookie);
            [self requestMyZhaiDanData];
        }
    } failureBlock:^(NSError *error) {
        self.loading = NO;
        _emptyType = QDNetworkError;
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myPickOrdersArr = [[NSMutableArray alloc] init];
    _state = @"";
    _businessType = @"";
    _pageSize = 10;
    _pageNum = 1;
    _totalPage = 0; //总页数默认
    self.view.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [self initTableView];
    [self isLogin];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.estimatedRowHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 120+SafeAreaTopHeight-64, 0);
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_tableView];
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        [self requestHeaderTopData];
    }];
    
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
        _pageNum++;
        [self requestMyZhaiDanData];
    }];
}

- (void)endRefreshing
{
    if (_tableView) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }
}

#pragma mark - 撤单操作
- (void)withdrawAction:(UIButton *)sender{
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"" message:@"真的不买了吗?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        [WXProgressHUD hideHUD];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"真的" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        QDMyPickOrderModel *model = _myPickOrdersArr[sender.tag];
        NSDictionary *dic = @{@"orderId":model.orderId};
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_CancelOrderForm params:dic successBlock:^(QDResponseObject *responseObject) {
            if (responseObject.code == 0) {
                [WXProgressHUD showSuccessWithTittle:@"撤单成功"];
                [_myPickOrdersArr removeObjectAtIndex:sender.tag];
                [_tableView reloadData];
            }else{
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [self endRefreshing];
            [WXProgressHUD showErrorWithTittle:@"网络异常"];
        }];
    }]];
    [alertView setButtonTitleColor:APP_BLACKCOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}


#pragma mark - 付款操作
- (void)payAction:(UIButton *)sender{
    QDLog(@"payAction");
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"付款" message:@"您确定要对这笔订单进行付款吗?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        QDLog(@"取消付款");
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        QDMyPickOrderModel *model = _myPickOrdersArr[sender.tag];
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        NSString *balance = model.amount;
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?amount=%@&&id=%@", QD_JSURL, JS_PAYACTION,balance, model.orderId];
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }]];
    [alertView setButtonTitleColor:APP_BLACKCOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

#pragma mark -- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myPickOrdersArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"QDPickUpOrderCell";
    QDPickUpOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDPickUpOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    cell.payBtn.tag = (long)_myPickOrdersArr[indexPath.row];
    cell.withdrawBtn.tag = (long)_myPickOrdersArr[indexPath.row];
    [cell.payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.withdrawBtn addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.payBtn.tag = indexPath.row;
    cell.withdrawBtn.tag = indexPath.row;
    if (_myPickOrdersArr.count) {
        [cell loadPickOrderWithModel:_myPickOrdersArr[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _vv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    _vv.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [_vv addSubview:self.filterBtn];
    [self.filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_vv);
        make.right.equalTo(_vv.mas_right).offset(-14);
    }];
    return _vv;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QDMyPickOrderModel *model = _myPickOrdersArr[indexPath.row];
    QDOrderDetailVC *detailVC = [[QDOrderDetailVC alloc] init];
    detailVC.orderModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)confirmOptions:(UIButton *)sender{
    [_popups dismissAnimated:YES completion:nil];
    [self requestHeaderTopData];
}

- (void)resetOptions:(UIButton *)sender{
    _businessType = @"";
    _state = @"";
}
- (void)filterAction:(UIButton *)sender{
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    if (!_typeThreeView) {
        _typeThreeView = [[QDFilterTypeThreeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 244)];
        [_typeThreeView.confirmBtn addTarget:self action:@selector(confirmOptions:) forControlEvents:UIControlEventTouchUpInside];
        [_typeThreeView.resetbtn addTarget:self action:@selector(resetOptions:) forControlEvents:UIControlEventTouchUpInside];

        //状态
        _typeThreeView.sdStatusStatusBlock = ^(NSString * _Nonnull statusID) {
            _state = statusID;
        };
        _typeThreeView.sdDirectionBlock = ^(NSString * _Nonnull directionID) {
            QDLog(@"directionID = %@", directionID);
            _businessType = directionID;
        };
        _typeThreeView.backgroundColor = APP_WHITECOLOR;
    }
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_typeThreeView];
    _popups.presentationStyle = PresentationStyleTop;
    _popups.maskAlpha = 0.5;
    _popups.delegate = self;
    [_popups presentInView:self.tableView animated:YES completion:NULL];
}
- (SPButton *)filterBtn{
    if (!_filterBtn) {
        _filterBtn = [[SPButton alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
        _filterBtn.imagePosition = SPButtonImagePositionRight;
        [_filterBtn setImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
        _filterBtn.titleLabel.font = QDFont(14);
        [_filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
        [_filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_filterBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
    }
    return _filterBtn;
}

- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
}

#pragma mark - DZNEmtpyDataSet Delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) {
        return [UIImage imageNamed:@"loading_imgBlue" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    }
    else {
        if (_emptyType == QDNODataError) {
            return [UIImage imageNamed:@"icon_nodata"];
        }else if(_emptyType == QDNetworkError){
            return [UIImage imageNamed:@"icon_noConnect"];
        }
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
        text = @"页面加载失败";
    }else{
        NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
        if ([str isEqualToString:@"0"] || str == nil) { //未登录
            text = @"未登录";
        }else{
            text = @"暂无数据";
        }
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: APP_BLUECOLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *text;
    if (_emptyType == QDNetworkError) {
        return nil;
    }else{
        NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
        if ([str isEqualToString:@"0"] || str == nil) { //未登录
            text = @"前往登录";
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

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return self.isLoading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
//    self.loading = YES;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        [self isLogin];
    }else{
        [self requestHeaderTopData];
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -80;
}
@end
