//
//  QDHotelsInAreaViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/25.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDHotelsInAreaViewController.h"
#import "QDHotelsInAreaView.h"
#import "QDSegmentControl.h"
#import "QDHotelsInAreaViewTableViewCell.h"
#import "QDStrategyTableViewCell.h"
#import "QDHotelAndStrategyFilterView.h"
#import "QDHotelListInfoModel.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDStrategyDTO.h"
typedef enum : NSUInteger {
    QDHotelsInArea,
    QDStrategyInArea,
} QDHotelTypeInArea;

@interface QDHotelsInAreaViewController ()<UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>{
    QDHotelTypeInArea _hotelType;
    
    NSMutableArray *_strategyImgArr;
    NSMutableArray *_strategryArr;
    
    NSMutableArray *_hotelListInfoArr;
    NSMutableArray *_hotelImgArr;
    BOOL showMenu;

}

@property (nonatomic, strong) QDHotelsInAreaView *hotelsTopView;
@property (nonatomic, strong) QDHotelAndStrategyFilterView *filterView;
@property (nonatomic, strong) QDSegmentControl *segmentControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *menuView;
@end

@implementation QDHotelsInAreaViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    showMenu = NO;
    [self.navigationController.navigationBar setHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    _hotelType = QDHotelsInArea;
    [self requestHotelInfoWithURL:api_GetHotelCondition];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_GRAYCOLOR;
    _strategyImgArr = [[NSMutableArray alloc] init];
    _strategryArr = [[NSMutableArray alloc] init];
    
    _hotelListInfoArr = [[NSMutableArray alloc] init];
    _hotelImgArr = [[NSMutableArray alloc] init];

    [self initUI];
    [self setSegments];
    [self initSwitchPage];
    [self initTableView];
    _menuView = [[UIView alloc] init];
    _menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_menuView];
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_filterView.mas_bottom);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.08);
    }];
    [_menuView setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    _hotelsTopView = [[QDHotelsInAreaView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.17)];
    _hotelsTopView.backgroundColor = [UIColor whiteColor];
    [_hotelsTopView.backBtn addTarget:self action:@selector(navBack:) forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:_hotelsTopView];
}

#pragma mark - 分段选择按钮
- (void)setSegments{
    NSArray *segmentedTitles = @[@"酒店",@"攻略"];
    _segmentControl = [[QDSegmentControl alloc] initWithSectionTitles:segmentedTitles];
    [_segmentControl addTarget:self action:@selector(segmentedClicked:) forControlEvents:UIControlEventValueChanged];
    _segmentControl.selectionIndicatorColor = APP_BLUECOLOR;
    _segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segmentControl.selectionIndicatorBoxColor = [UIColor redColor];
    [_hotelsTopView addSubview:_segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_hotelsTopView.mas_bottom).offset(-10);
        make.centerX.equalTo(_hotelsTopView);
        make.width.mas_equalTo(SCREEN_WIDTH*0.4);
        make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
    }];
}

- (void)initSwitchPage{
    _filterView = [[QDHotelAndStrategyFilterView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.17, SCREEN_WIDTH, SCREEN_HEIGHT*0.09)];
    _filterView.backgroundColor = [UIColor whiteColor];
    [_filterView.switchBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_filterView];
}

- (void)showMenu:(UIButton *)sender{
    showMenu = !showMenu;
    if (showMenu) {
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFromTop;
        animation.duration = 0.4;
        [_menuView.layer addAnimation:animation forKey:nil];
        [_menuView setHidden:NO];
    }else{
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFromBottom;
        animation.duration = 0.4;
        [_menuView.layer addAnimation:animation forKey:nil];
        [_menuView setHidden:YES];
    }
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.26, SCREEN_WIDTH, SCREEN_HEIGHT*0.74-44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (void)segmentedClicked:(QDSegmentControl *)segmentControl{
    NSInteger ss = segmentControl.selectedSegmentIndex;
    switch (ss) {
        case 0:
            QDLog(@"0");
            _hotelType = QDHotelsInArea;
            [self requestHotelInfoWithURL:api_GetHotelCondition];
            break;
        case 1:
            QDLog(@"1");
            _hotelType = QDStrategyInArea;
            [self requestStrategyInfoWithURL:api_FindDifferentStrategyDTO];
            break;
        default:
            break;
    }
}

- (void)navBack:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_hotelType == QDHotelsInArea) {
        return SCREEN_HEIGHT*0.855;
    }else{
        return SCREEN_HEIGHT*0.255;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_hotelType == QDHotelsInArea) {
        return _hotelListInfoArr.count;
    }else{
        return _strategryArr.count;
    }
    return 3;
}

#pragma mark - 请求酒店列表
- (void)requestHotelInfoWithURL:(NSString *)urlStr{
    if (_hotelListInfoArr.count) {
        [_hotelListInfoArr removeAllObjects];
        [_hotelImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"label":@"",
                            @"pageNum":@1,
                            @"pageSize":@20
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"result"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    QDHotelListInfoModel *infoModel = [QDHotelListInfoModel yy_modelWithDictionary:dic];
                    [_hotelListInfoArr addObject:infoModel];
                    NSDictionary *dic = [infoModel.imageList firstObject];
                    NSString *urlStr = [dic objectForKey:@"imageFullUrl"];
                    QDLog(@"urlStr = %@", urlStr);
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
                    [_hotelImgArr addObject:imgData];
                }
                QDLog(@"_hotelListInfoArr = %@", _hotelListInfoArr);
                [self.tableView reloadData];
            }else{
                [_hotelListInfoArr removeAllObjects];
                [_hotelImgArr removeAllObjects];
                [WXProgressHUD showInfoWithTittle:responseObject.message];
                [_tableView reloadData];
                [_tableView reloadEmptyDataSet];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 请求攻略列表
- (void)requestStrategyInfoWithURL:(NSString *)urlStr{
    if (_strategryArr.count) {
        [_strategryArr removeAllObjects];
        [_strategyImgArr removeAllObjects];
    }
    NSDictionary * dic1 = @{@"pageNum":@1,
                            @"pageSize":@20,
                            @"findStrategyDTOType":@"2"
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:dic1 successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *strategyArr = [dic objectForKey:@"result"];
            if (strategyArr.count) {
                for (NSDictionary *dic in strategyArr) {
                    QDStrategyDTO *strategyModel = [QDStrategyDTO yy_modelWithDictionary:dic];
                    [_strategryArr addObject:strategyModel];
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strategyModel.litimg]];
                    [_strategyImgArr addObject:imgData];
                }
                [self.tableView reloadData];
            }
        }else{
            [_strategryArr removeAllObjects];
            [_strategyImgArr removeAllObjects];
            [WXProgressHUD showInfoWithTittle:responseObject.message];
            [_tableView reloadData];
            [_tableView reloadEmptyDataSet];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_hotelType == QDHotelsInArea) {
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        static NSString *ID = @"QDHotelsInAreaViewTableViewCell";
        QDHotelsInAreaViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[QDHotelsInAreaViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        if (_hotelListInfoArr.count > 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell fillContentWithModel:_hotelListInfoArr[indexPath.row] andImgData:_hotelImgArr[indexPath.row]];
            [cell.detailBtn addTarget:self action:@selector(detailInfo:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else{
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        static NSString *ID = @"QDStrategyTableViewCell";
        QDStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[QDStrategyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }

        cell.backgroundColor = [UIColor whiteColor];
        if (_strategryArr.count > 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell fillContentWithModel:_strategryArr[indexPath.row] andImgData:_strategyImgArr[indexPath.row]];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)detailInfo:(UIButton *)sender{
    QDLog(@"detailInfo");
}

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"emptySource"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"未找到相关攻略信息";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
@end
