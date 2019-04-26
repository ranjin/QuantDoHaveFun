//
//  QDDZYViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/15.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "RankThirdViewController.h"
#import "QDCustomTourCell.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDRefreshHeader.h"
#import "QDRefreshFooter.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "QDOrderField.h"
#import "TABAnimated.h"
#import "TABViewAnimated.h"
#import "UITableView+Animated.h"
#import "UIView+TABControlAnimation.h"

//预定酒店 定制游 商城
@interface RankThirdViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>{
    UITableView *_tableView;
    NSMutableArray *_dzyListInfoArr;
    NSMutableArray *_dzyImgArr;
    QDEmptyType _emptyType;
    NSString *_travelName;
}
@property (nonatomic, getter=isLoading) BOOL loading;

@end

@implementation RankThirdViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_BLUECOLOR;
    _dzyListInfoArr = [[NSMutableArray alloc] init];
    _dzyImgArr = [[NSMutableArray alloc] init];
    _travelName = @"";
    //分段选择按钮
    [self initTableView];
    [self requestDZYList];
}

#pragma mark - 请求定制游列表信息
- (void)requestDZYList{
    self.loading = NO;
    if (_dzyListInfoArr.count) {
        [_dzyListInfoArr removeAllObjects];
        [_dzyImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"travelName":_travelName,
                            @"pageNum":@1,
                            @"pageSize":@20
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetDZYList params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *dzyArr = [dic objectForKey:@"result"];
            if (dzyArr.count) {
                for (NSDictionary *dic in dzyArr) {
                    CustomTravelDTO *infoModel = [CustomTravelDTO yy_modelWithDictionary:dic];
                    [_dzyListInfoArr addObject:infoModel];
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    [_dzyImgArr addObject:[dic objectForKey:@"url"]];
                }
                [_tableView reloadData];
            }else{
                _emptyType = QDNODataError;
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
        }
        [_tableView tab_endAnimation];
        [self endRefreshing];
    } failureBlock:^(NSError *error) {
        _emptyType = QDNetworkError;
        [self endRefreshing];
        [_tableView reloadData];
        [_tableView reloadEmptyDataSet];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
        [_tableView tab_endAnimation];
    }];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.backgroundColor = APP_WHITECOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView tab_startAnimation];
    _tableView.showsVerticalScrollIndicator = NO;
    //    _tableView.contentInset = UIEdgeInsetsMake(0, 0, SafeAreaTopHeight, 0);
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    self.view = _tableView;
    _tableView.mj_header = [QDRefreshHeader headerWithRefreshingBlock:^{
        //重新刷新 查询全部
        [self endRefreshing];
    }];
    
    _tableView.mj_footer = [QDRefreshFooter footerWithRefreshingBlock:^{
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
- (void)setLoading:(BOOL)loading
{
    if (self.isLoading == loading) {
        return;
    }
    _loading = loading;
    [_tableView reloadEmptyDataSet];
}

#pragma mark -- tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dzyListInfoArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 310;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"QDCustomTourCell";
    QDCustomTourCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QDCustomTourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dzyListInfoArr.count > 0) {
        [cell fillCustomTour:_dzyListInfoArr[indexPath.row] andImgURL:_dzyImgArr[indexPath.row]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
        text = @"网络异常";
    }else{
        text = @"暂无数据";
    }
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: APP_BLUECOLOR};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//    NSString *text = @"重新加载";
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
//                                 NSForegroundColorAttributeName: APP_WHITECOLOR,
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}

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
    self.loading = YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    self.loading = YES;
    
}

@end
