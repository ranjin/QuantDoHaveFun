//
//  QDTradingShellsVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDTradingShellsVC.h"
#import "QDTradeShellsSectionHeaderView.h"
#import "RootTableCell.h"
#import "MyTableCell.h"
#import "TFDropDownMenu.h"
#import "SnailQuickMaskPopups.h"
#import "QDFilterTypeOneView.h"
#import "QDFilterTypeTwoView.h"
#import "QDFilterTypeThreeView.h"
#import "QDShellRecommendVC.h"
#import "QDMySaleOrderCell.h"
#import "QDPickUpOrderCell.h"
#import "QDOrderDetailVC.h"
#import <TYAlertView/TYAlertView.h>
#import "BiddingPostersDTO.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

#define K_T_Cell @"t_cell"
#define K_C_Cell @"c_cell"

// 要玩贝  转玩贝  我的报单  我的摘单
typedef enum : NSUInteger {
    QDPlayShells = 0,
    QDTradeShells = 1,
    QDMyOrders = 2,
    QDPickUpOrders = 3
} QDShellType;

@interface QDTradingShellsVC ()<UITableViewDelegate, UITableViewDataSource, RootCellDelegate, SnailQuickMaskPopupsDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>{
    QDTradeShellsSectionHeaderView *_sectionHeaderView;
    QDShellType _shellType;
    UIView *_backView;
    UIButton *_optionBtn;    //要玩贝操作按钮
    NSMutableArray *_ordersArr;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataAry;
@property (nonatomic, strong) NSMutableDictionary *dicH;
@property (nonatomic, strong) SnailQuickMaskPopups *popups;
@property (nonatomic, strong) QDFilterTypeOneView *typeOneView;
@property (nonatomic, strong) QDFilterTypeTwoView *typeTwoView;
@property (nonatomic, strong) QDFilterTypeThreeView *typeThreeView;




@end

@implementation QDTradingShellsVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestCanTradeData:api_FindCanTrade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _shellType = QDPlayShells;
    _ordersArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.dataAry = @[@[@"1元", @"2元", @"3元", @"4元", @"10元", @"20元", @"30元", @"40元", @"11元", @"22元", @"33元", @"1元", @"2元", @"3元", @"4元", @"5元", @"6元", @"8元"]];
    [self setTopView];
    [self initTableView];
//    [self requestCanTradeData:api_FindCanTrade];
}

/**
 NO_TRADED(0,"未成交"), // 未成交
 PART_TRADED(1,"部分成交"), // 部分成交
 ALL_TRADED(2,"全部成交"), // 全部成交
 ALL_CANCELED(3,"全部撤单"), // 全部撤单
 PART_CANCELED(4,"部分成交部分撤单"), // 部分成交部分撤单
 IS_CANCELED(5,"已取消"), // 已取消
 INTENTION(6,"意向单") ; // 意向单
 */
- (void)requestCanTradeData:(NSString *)urlStr{
    if (_ordersArr.count) {
        [_ordersArr removeAllObjects];
    }
    [_tableView reloadData];
    [_tableView reloadEmptyDataSet];
    NSDictionary * dic1 = @{@"postersStatus":@"",
                            @"postersType":@"1",
                            @"pageNum":@1,
                            @"pageSize":@20,
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    BiddingPostersDTO *infoModel = [BiddingPostersDTO yy_modelWithDictionary:dic];
                    [_ordersArr addObject:infoModel];
                }
                [self.tableView reloadData];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [_tableView reloadData];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

-(void)leftClick
{
    //下落动画 时间短一些
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    _backView.frame=CGRectMake(0,40, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
    
    //恢复动画 时间长一些
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.5];
    _backView.frame=CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
    
}
-(void)tapclick
{
    [UIView beginAnimations:@"text" context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    _backView.frame=CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height);
    [UIView commitAnimations];
}
- (void)setTopView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.17)];
    topView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:topView];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"转贝";
    titleLab.font = QDFont(17);
    [topView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SCREEN_HEIGHT*0.046);
        make.centerX.equalTo(self.view);
    }];
    //分段选择按钮
    NSArray *segmentedTitles = @[@"买买",@"卖卖",@"我的发布",@"我的摘单"];
    _segmentControl = [[QDSegmentControl alloc] initWithSectionTitles:segmentedTitles];
    [_segmentControl addTarget:self action:@selector(segmentedClicked:) forControlEvents:UIControlEventValueChanged];
    _segmentControl.selectionIndicatorColor = APP_BLACKCOLOR;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [topView addSubview:_segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(topView);
        make.top.equalTo(topView.mas_top).offset(SCREEN_HEIGHT*0.11);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.17 + 3, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SCREEN_HEIGHT*0.24, 0);
    [self.view addSubview:_tableView];
    

    _optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.31, SCREEN_HEIGHT*0.83, SCREEN_WIDTH*0.37, SCREEN_HEIGHT*0.06)];
    [_optionBtn addTarget:self action:@selector(operateAction:) forControlEvents:UIControlEventTouchUpInside];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.37, SCREEN_HEIGHT*0.06);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
    [_optionBtn.layer addSublayer:gradientLayer];
    [_optionBtn setTitle:@"买买" forState:UIControlStateNormal];
    _optionBtn.layer.cornerRadius = 12;
    _optionBtn.layer.masksToBounds = YES;
    _optionBtn.titleLabel.font = QDFont(17);
    [self.view addSubview:_optionBtn];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.23)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = headerView;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.05, SCREEN_WIDTH*0.03, SCREEN_WIDTH*0.89, SCREEN_HEIGHT*0.225)];
    imgView.image = [UIImage imageNamed:@"shellBanner"];
    [headerView addSubview:imgView];
}

- (void)segmentedClicked:(QDSegmentControl *)segmentControl{
    _shellType = (QDShellType)segmentControl.selectedSegmentIndex;
    switch (_shellType) {
        case QDPlayShells: //要玩贝
            QDLog(@"0");
            [_optionBtn setHidden:NO];
            [_optionBtn setTitle:@"买买" forState:UIControlStateNormal];
            [_tableView reloadData];
            break;
        case QDTradeShells: //转玩贝   按钮
            QDLog(@"1");
            [_optionBtn setHidden:NO];
            [_optionBtn setTitle:@"卖卖" forState:UIControlStateNormal];
            [_tableView reloadData];
            break;
        case QDMyOrders: //我的报单
            [_optionBtn setHidden:YES];
            [_tableView reloadData];
            QDLog(@"2");
            break;
        case QDPickUpOrders: //我的摘单
            QDLog(@"3");
            [_optionBtn setHidden:YES];
            [_tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - 撤单操作
- (void)withdrawAction:(UIButton *)sender{
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"撤销订单" message:@"您确定要撤销这笔订单吗?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        [WXProgressHUD hideHUD];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        [self cancelOrderForm];
    }]];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

- (void)cancelOrderForm{
}
#pragma mark - 付款操作
- (void)payAction:(UIButton *)sender{
    QDLog(@"payAction");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_shellType == QDPlayShells || _shellType == QDTradeShells) {
        return _ordersArr.count;
    }else{
        return _ordersArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SCREEN_HEIGHT*0.075;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_shellType == QDPlayShells || _shellType == QDTradeShells) {
        if (self.dicH[indexPath]) {
            QDLog(@"dicH = %@", self.dicH);
            NSNumber *num = self.dicH[indexPath];
            return [num floatValue];
        } else {
            return 60;
        }
    }else if (_shellType == QDMyOrders){
        return SCREEN_HEIGHT*0.3;
    }else{
        if (_ordersArr.count) {
            if ([_ordersArr[indexPath.row] isEqualToString:@"1"]) {
                return SCREEN_HEIGHT*0.28;
            }else{
                return SCREEN_HEIGHT*0.33;
            }
        }
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_shellType == QDPlayShells || _shellType == QDTradeShells) {
        if (_ordersArr.count) {
            [tableView registerClass:[RootTableCell class] forCellReuseIdentifier:K_C_Cell];
            RootTableCell *cell = [tableView dequeueReusableCellWithIdentifier:K_C_Cell forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.delegate = self;
            cell.indexPath = indexPath;
            cell.dataAry = _ordersArr;
            return cell;

        }
        
    }else if (_shellType == QDMyOrders){
        static NSString *identifier = @"QDMySaleOrderCell";
        QDMySaleOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[QDMySaleOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
//        [cell.operateBtn addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = APP_WHITECOLOR;
        return cell;
    }else{
        //我的摘单 分两种情况 已成交&&未成交
        NSString *ss = _ordersArr[indexPath.row];
        if ([ss isEqualToString:@"1"]) {    //已成交
            static NSString *identifier = @"QDPickUpOrderCell";
            QDPickUpOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[QDPickUpOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = APP_WHITECOLOR;
            return cell;
        }else if ([ss isEqualToString:@"2"]){
        }
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _sectionHeaderView = [[QDTradeShellsSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    [_sectionHeaderView.filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
    _sectionHeaderView.backgroundColor = APP_WHITECOLOR;
    return _sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_shellType == QDMyOrders) {
        QDOrderDetailVC *detailVC = [[QDOrderDetailVC alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
#pragma mark ====== RootTableCellDelegate ======
- (void)updateTableViewCellHeight:(RootTableCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.dicH[indexPath] isEqualToNumber:@(height)]) {
        self.dicH[indexPath] = @(height);
//        [self.tableView reloadData];
    }
}


//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (NSMutableDictionary *)dicH {
    if (!_dicH) {
        _dicH = [[NSMutableDictionary alloc] init];
    }
    return _dicH;
}

- (QDFilterTypeOneView *)typeOneView{
    if (_typeOneView) {
        _typeOneView = [[QDFilterTypeOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.57)];
        _typeOneView.backgroundColor = APP_WHITECOLOR;
    }
    return _typeOneView;
}

- (void)confirmOptions:(UIButton *)sender{
    [_popups dismissAnimated:YES completion:nil];
}


#pragma mark - 要/转玩贝操作按钮
- (void)operateAction:(UIButton *)sender{
    
    QDShellRecommendVC *recommendVC = [[QDShellRecommendVC alloc] init];
    if (_shellType == QDPlayShells) {
        recommendVC.recommendType = 0;
    }else if (_shellType == QDTradeShells){
        recommendVC.recommendType = 1;
    }
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (void)filterAction:(UIButton *)sender{
    QDLog(@"filter");
    if (_shellType == QDPlayShells || _shellType == QDTradeShells) {
        if (!_typeOneView) {
            _typeOneView = [[QDFilterTypeOneView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.57)];
            [_typeOneView.confirmBtn addTarget:self action:@selector(confirmOptions:) forControlEvents:UIControlEventTouchUpInside];
            _typeOneView.backgroundColor = APP_WHITECOLOR;
        }
        _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_typeOneView];
        _popups.presentationStyle = PresentationStyleTop;
        
        _popups.delegate = self;
        [_popups presentInView:_tableView animated:YES completion:NULL];
    }else if(_shellType == QDMyOrders){
        if (!_typeTwoView) {
            _typeTwoView = [[QDFilterTypeTwoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.57)];
            [_typeTwoView.confirmBtn addTarget:self action:@selector(confirmOptions:) forControlEvents:UIControlEventTouchUpInside];
            _typeTwoView.backgroundColor = APP_WHITECOLOR;
        }
        _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_typeTwoView];
        _popups.presentationStyle = PresentationStyleBottom;
        _popups.delegate = self;
        [_popups presentInView:self.view animated:YES completion:NULL];
    }else{
        if (!_typeThreeView) {
            _typeThreeView = [[QDFilterTypeThreeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.57)];
            [_typeThreeView.confirmBtn addTarget:self action:@selector(confirmOptions:) forControlEvents:UIControlEventTouchUpInside];
            _typeThreeView.backgroundColor = APP_WHITECOLOR;
        }
        _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_typeThreeView];
        _popups.presentationStyle = PresentationStyleBottom;
        _popups.delegate = self;
        [_popups presentInView:self.view animated:YES completion:NULL];
    }
}

- (void)snailQuickMaskPopupsWillPresent:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsWillPresent");
}

- (void)snailQuickMaskPopupsWillDismiss:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsWillDismiss");
}

- (void)snailQuickMaskPopupsDidPresent:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsDidPresent");
}

- (void)snailQuickMaskPopupsDidDismiss:(SnailQuickMaskPopups *)popups{
    QDLog(@"snailQuickMaskPopupsDidDismiss");
}

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"emptySource"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"未找到相关数据,请重试";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
