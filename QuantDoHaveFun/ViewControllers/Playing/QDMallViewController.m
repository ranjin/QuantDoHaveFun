//
//  QDMallViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMallViewController.h"
#import "QDMallTableCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import "QDMallTableHeaderView.h"
#import "QDMallModel.h"
#import "QDBridgeViewController.h"
#import "QDKeyWordsSearchVC.h"
#import "QDSearchViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "QDMallTableSectionHeaderView.h"
#import "QDPopMenu.h"
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"
#import "QDOrderField.h"
#import "QDLoginAndRegisterVC.h"

//预定酒店 定制游 商城
@interface QDMallViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, QDPopMenuDelegate, UITextFieldDelegate>{
    QDPlayShellType _playShellType;
    UITableView *_tableView;
    QDMallTableHeaderView *_mallHeaderView;
    NSMutableArray *_mallInfoArr;
    QDMallTableSectionHeaderView *_sectionHeaderView;
    QDEmptyType _emptyType;
}
@property (nonatomic, getter=isLoading) BOOL loading;
@property (nonatomic, strong) NSMutableArray *categoryArr;
@property (nonatomic, strong) NSMutableArray *categoryIDArr;

@property (nonatomic, assign) NSInteger menuSelectIndex;   //选中的一栏

@property (nonatomic, strong) NSString *catId;  //商品分类

@property (nonatomic, strong) NSString *sortColumn;     //销量排序：volume，价格排序：price
@property (nonatomic, strong) NSString *sortType;       //排序方式：desc降序，asc升序

@property (nonatomic, strong) NSString *baoyou; //是否包邮

@property (nonatomic, strong) NSString *keywords;   //搜索关键词
@end

@implementation QDMallViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceUp) name:Notification_PriceUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(priceDown) name:Notification_PriceDown object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amuntUp) name:Notification_AmountUp object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(amountDown) name:Notification_AmountDown object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_PriceUp object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_PriceDown object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_AmountUp object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_AmountDown object:nil];
}

- (void)priceUp{
    QDLog(@"priceUp");
    _sortColumn = @"price";
    _sortType = @"asc";
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self requestMallList];
//    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
}

- (void)priceDown{
    QDLog(@"priceDown");
    _sortColumn = @"price";
    _sortType = @"desc";
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self requestMallList];
//    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
}

- (void)amuntUp{
    _sortColumn = @"virtualSales";
    _sortType = @"asc";
    [self requestMallList];
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellpositive"] forState:UIControlStateNormal];
//    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
}

- (void)amountDown{
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    _sortColumn = @"virtualSales";
    _sortType = @"desc";
    [self requestMallList];
    [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellreverse"] forState:UIControlStateNormal];
//    [_sectionHeaderView.priceBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _menuSelectIndex = -1;
    _catId = @"";
    _sortColumn = @"";
    _sortType = @"";
    _baoyou = @"";
    _keywords = @"";
    _categoryArr = [[NSMutableArray alloc] init];
    _categoryIDArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = APP_WHITECOLOR;
    _mallInfoArr = [[NSMutableArray alloc] init];
    [self initTableView];
    [self requestMallList];
    //请求商品列表
    [self finGoodsCategory];
}

#pragma mark - 查询商品分类
- (void)finGoodsCategory{
    if (_categoryArr.count) {
        [_categoryArr removeAllObjects];
        [_categoryIDArr removeAllObjects];
    }
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_findCategory params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSArray *arr = responseObject.result;
            for (NSDictionary *dic in arr) {
                [_categoryArr addObject:[dic objectForKey:@"catName"]];
                NSString *str =  [NSString stringWithFormat:@"%d", [[dic objectForKey:@"id"] intValue]];
                [_categoryIDArr addObject:str];
            }
            [_categoryArr insertObject:@"全部" atIndex:0];
            [_categoryIDArr insertObject:@"0" atIndex:0];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

- (void)addToCar:(UIButton *)sender{
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
        loginVC.pushVCTag = @"0";
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
        bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@", QD_JSURL, JS_SHOPCART];
        QDLog(@"urlStr = %@", bridgeVC.urlStr);
        [self.navigationController pushViewController:bridgeVC animated:YES];
    }
}

#pragma mark - 查询商城列表信息
- (void)requestMallList{
    if (_mallInfoArr.count) {
        [_mallInfoArr removeAllObjects];
    }
    NSDictionary * dic1 = @{
                            @"pageNum":@1,
                            @"pageSize":@20,
                            @"catId":_catId,
                            @"sortColumn":_sortColumn,
                            @"sortType":_sortType,
                            @"isShipping":_baoyou,
                            @"goodsName":_keywords
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetMallList params:dic1 successBlock:^(QDResponseObject *responseObject) {
        [self endRefreshing];
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *mallArr = [dic objectForKey:@"result"];
            if (mallArr.count) {
                for (NSDictionary *dic in mallArr) {
                    QDMallModel *mallModel = [QDMallModel yy_modelWithDictionary:dic];
                    [_mallInfoArr addObject:mallModel];
                }
                QDLog(@"_mallInfoArr = %@", _mallInfoArr);
                [_tableView reloadData];
            }else{
                _emptyType = QDNODataError;
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
        [_tableView tab_endAnimation];
        [self endRefreshing];
    } failureBlock:^(NSError *error) {
        [self endRefreshing];
        _emptyType = QDNetworkError;
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [_tableView tab_endAnimation];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_WHITECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    [_tableView tab_startAnimation];
    _mallHeaderView = [[QDMallTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.08)];
    _mallHeaderView.backgroundColor = APP_WHITECOLOR;
    [_mallHeaderView.carBtn addTarget:self action:@selector(addToCar:) forControlEvents:UIControlEventTouchUpInside];
    _mallHeaderView.inputTF.returnKeyType = UIReturnKeySearch;  //变为搜索按钮
    _mallHeaderView.inputTF.delegate = self;
    _tableView.tableHeaderView = _mallHeaderView;
    self.view = _tableView;
//    [self.view addSubview:_tableView];
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        //重置所有选项
        _catId = @"";
        _sortColumn = @"";
        _sortType = @"";
        _baoyou = @"";
        _keywords = @"";
        [_sectionHeaderView.allBtn setTitle:_categoryArr[0] forState:UIControlStateNormal];

        [_sectionHeaderView.amountBtn setImage:[UIImage imageNamed:@"icon_shellDefault"] forState:UIControlStateNormal];
        [_sectionHeaderView.baoyouBtn setImage:[UIImage imageNamed:@"icon_baoyouNormal"] forState:UIControlStateNormal];
        [self requestMallList];
    }];
    
    //手动刷新请求最新数据
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
//        [self requestMallList];
        [self endRefreshing];
        [_tableView.mj_footer endRefreshingWithNoMoreData];
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
    return _mallInfoArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (_playShellType) {
        case QDHotelReserve:
            return SCREEN_HEIGHT*0.21;
            break;
        case QDCustomTour:
            return SCREEN_HEIGHT*0.57;
            break;
        case QDMall:
            return SCREEN_HEIGHT*0.225;
            break;
        default:
            break;
    }
    return 0.1;
}

- (void)allAction:(UIButton *)sender{
    [_tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderView;
}

- (QDMallTableSectionHeaderView *)sectionHeaderView{
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[QDMallTableSectionHeaderView alloc] init];
        _sectionHeaderView.backgroundColor = APP_WHITECOLOR;
        [_sectionHeaderView.allBtn addTarget:self action:@selector(allAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sectionHeaderView.baoyouBtn addTarget:self action:@selector(baoyouAction:) forControlEvents:UIControlEventTouchUpInside];
        [_sectionHeaderView.allBtn addTarget:self action:@selector(chooseCategory:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sectionHeaderView;
}

- (void)chooseCategory:(UIButton *)sender{
    if (_categoryArr.count == 0 || _categoryArr == nil) {
        [WXProgressHUD showErrorWithTittle:@"未获取到商品种类"];
    }else{
        QDPopMenu *menu = [[QDPopMenu alloc] init];
        menu.delegate = self;
        menu.defaultIndex = _menuSelectIndex;
        menu.identityName = @"test";
        menu.menuArray = _categoryArr;
        menu.menuContentSize = CGSizeMake(SCREEN_WIDTH, _categoryArr.count * 38);
        [menu showMenuFromSourceView:sender sourceReact:sender.bounds viewController:self animated:YES];
    }
}

- (void)baoyouAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        QDLog(@"选择包邮");
        _baoyou = @"1";
        [_sectionHeaderView.baoyouBtn setImage:[UIImage imageNamed:@"icon_baoyouSelected"] forState:UIControlStateNormal];
    }else{
        QDLog(@"不包邮");
        [_sectionHeaderView.baoyouBtn setImage:[UIImage imageNamed:@"icon_baoyouNormal"] forState:UIControlStateNormal];
        _baoyou = @"";
    }
    [self requestMallList];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QDMallTableCell";
    QDMallTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDMallTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (_mallInfoArr.count > 0) {
        [cell fillContentWithModel:_mallInfoArr[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = APP_WHITECOLOR;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    QDMallModel *model = _mallInfoArr[indexPath.row];
    QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
    bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?id=%ld", QD_JSURL, JS_SHOPPING, (long)model.id];
    QDLog(@"urlStr = %@", bridgeVC.urlStr);
    bridgeVC.mallModel = model;
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bridgeVC animated:YES];
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
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loading = NO;
    });
}

- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    [_tableView reloadEmptyDataSet];
}

- (void)popMenu:(QDPopMenu *)popMenu didSelectedMenu:(id)menu atIndex:(NSInteger)index{
    QDLog(@"index = %ld", (long)index);
    _menuSelectIndex = index;
    if (index == 0) {
        _catId = @"";
        [self requestMallList];
    }else{
        _catId = _categoryIDArr[index];
        [self requestMallList];
    }
    [_sectionHeaderView.allBtn setTitle:_categoryArr[index] forState:UIControlStateNormal];
}

- (void)dismissPopMenu:(QDPopMenu *)popMenu{
    QDLog(@"dismissPopMenu");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    QDLog(@"搜索商品");
    [_mallHeaderView.inputTF resignFirstResponder];
    _keywords = _mallHeaderView.inputTF.text;
    [self requestMallList];
    return YES;
}
@end
