//
//  VIPRightsViewController.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/25.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "VIPRightsViewController.h"
#import "VIPRightsView.h"
#import "NewPagedFlowView.h"
#import "PGCustomBannerView.h"
#import "QDLoginAndRegisterVC.h"
#import "QDMemberDTO.h"
#import "AppDelegate.h"
#import "QDReadyToCreateOrderVC.h"
@interface VIPRightsViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>{
    VIPRightsView *_rightsView;
    BOOL _selected;
    VipCardDTO *_currentModel;
    NSString *_isYePay;
}

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *cardArr;

/**
 轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;

@end

@implementation VIPRightsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshVipInfo:) name:Notification_LoginSucceeded object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Notification_LoginSucceeded object:nil];
}

#pragma mark - 登录成功
- (void)refreshVipInfo:(NSNotification *)noti{
    [self requestUserStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_WHITECOLOR;
    _imageArray = [[NSMutableArray alloc] init];
    _cardArr = [[NSMutableArray alloc] init];
    _rightsView = [[VIPRightsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _rightsView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
    [_rightsView.noLoginHeadView.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightsView.payButton addTarget:self action:@selector(confirmToBuy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightsView];
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        _rightsView.loginHeadView.hidden = YES;
        _rightsView.noLoginHeadView.hidden = NO;
        _rightsView.bottomWhiteView.hidden = YES;
    }else{
        //登录状态下的显示
        [self requestUserStatus];
        _rightsView.loginHeadView.hidden = NO;
        _rightsView.noLoginHeadView.hidden = YES;
        _rightsView.bottomWhiteView.hidden = NO;
    }
    [self queryOrderPay];
    [self getBasicPrice];
    [self setupCardUI];
}

#pragma mark - 查询基准价信息
- (void)getBasicPrice{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetBasicPrice params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            _rightsView.basePrice = [responseObject.result doubleValue];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
    }];
}
#pragma mark - 积分充值卡查询
- (void)queryOrderPay{
    [WXProgressHUD showHUD];
    if (_cardArr.count) {
        [_cardArr removeAllObjects];
    }
    //先查询全部
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_FindPurchaseInfos params:nil successBlock:^(QDResponseObject *responseObject) {
        [WXProgressHUD hideHUD];
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSArray *hotelArr = [dic objectForKey:@"vipCardInfos"];
            if (hotelArr.count) {
                for (NSDictionary *dic in hotelArr) {
                    VipCardDTO *model = [VipCardDTO yy_modelWithDictionary:dic];
                    [_cardArr addObject:model];
                }
                [self.pageFlowView reloadData];
                //默认数据
                if (_cardArr.count) {
                    VipCardDTO *model = _cardArr.firstObject;
                    //折合玩贝
                    double ss = floor([[model.vipMoney stringByDividingBy:model.basePrice] doubleValue]);
                    NSString *sss = [NSString stringWithFormat:@"%.lf", ss];
                    _rightsView.bottomLab2.text = sss;
                    _rightsView.price.text = model.vipMoney;
                    _rightsView.priceTF.hidden = YES;
                }
                [_rightsView layoutSubviews];
            }else{
                [WXProgressHUD showErrorWithTittle:@"暂无VIP售卡信息"];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 请求用户信息
- (void)requestUserStatus{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetUserDetail params:nil successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            QDMemberDTO *currentQDMemberTDO = [QDMemberDTO yy_modelWithDictionary:responseObject.result];
            _isYePay = currentQDMemberTDO.isYepay;
            _rightsView.loginHeadView.hidden = NO;
            _rightsView.noLoginHeadView.hidden = YES;
            _rightsView.bottomWhiteView.hidden = NO;
            [_rightsView.loginHeadView loadVipViewWithModel:currentQDMemberTDO];
        }else if (responseObject.code == 2){
            [QDUserDefaults removeCookies];
            [QDUserDefaults setObject:@"0" forKey:@"loginType"];
            _rightsView.loginHeadView.hidden = YES;
            _rightsView.noLoginHeadView.hidden = NO;
            _rightsView.bottomWhiteView.hidden = YES;
        }else{
            [WXProgressHUD showErrorWithTittle:responseObject.message];
            _rightsView.loginHeadView.hidden = YES;
            _rightsView.noLoginHeadView.hidden = NO;
            _rightsView.bottomWhiteView.hidden = YES;
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - 确认购买
- (void)confirmToBuy:(UIButton *)sender{
    NSString *str = [QDUserDefaults getObjectForKey:@"loginType"];
    if ([str isEqualToString:@"0"] || str == nil) { //未登录
        QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
        loginVC.pushVCTag = @"0";
        [self presentViewController:loginVC animated:YES completion:nil];
    }else{
        if ([_rightsView.bottomLab2.text doubleValue] <= 0) {
            [WXProgressHUD showInfoWithTittle:@"小于玩贝的最小申购量,请输入正确的金额"];
            return;
        }
        QDReadyToCreateOrderVC *orderVC = [[QDReadyToCreateOrderVC alloc] init];
        if (_currentModel == nil && _cardArr.count) {
            _currentModel = _cardArr[0];
        }
        if (![_rightsView.priceTF isHidden] && (_rightsView.priceTF.text == nil || [_rightsView.priceTF.text isEqualToString:@""])) {
            [WXProgressHUD showErrorWithTittle:@"请输入充值金额"];
            return;
        }
        if (_cardArr.count == 0) {
            [WXProgressHUD showErrorWithTittle:@"充值卡信息获取失败"];
            return;
        }
        //针对输入金额
        if ([_isYePay isEqualToString:@"0"]) {
            [WXProgressHUD showInfoWithTittle:@"该用户暂无资金账户,无法购买"];
        }else{
            if ([_currentModel.vipMoney isEqualToString:@"0"]) {
                VipCardDTO *cardDTO = [[VipCardDTO alloc] init];
                cardDTO.vipMoney = _rightsView.priceTF.text;
                cardDTO.subscriptCount = _rightsView.bottomLab2.text;
                cardDTO.creditCode = _currentModel.creditCode;
                cardDTO.vipTypeName = _currentModel.vipTypeName;
                cardDTO.id = _currentModel.id;
                cardDTO.basePrice = _currentModel.basePrice;
                cardDTO.isDefault = _currentModel.isDefault;
                orderVC.vipModel = cardDTO;
            }else{
                orderVC.vipModel = _currentModel;
            }
            [self.navigationController pushViewController:orderVC animated:YES];
        }
    }
}
- (void)setupCardUI{
    for (int index = 1; index < 6; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img_card%d", index]];
        [_imageArray addObject:image];
    }
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 206+SafeAreaTopHeight-64, SCREEN_WIDTH, 210)];
    
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.01;
    pageFlowView.isCarousel = NO;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = NO;
    [pageFlowView reloadData];
    [_rightsView addSubview:pageFlowView];
    self.pageFlowView = pageFlowView;
}

#pragma mark - NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView{
    return CGSizeMake(180, 230);
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex{
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    if (_cardArr.count) {
        _currentModel = _cardArr[pageNumber];
        if ([_currentModel.vipMoney doubleValue] == 0) {
            _rightsView.price.hidden = YES;
            _rightsView.priceTF.hidden = NO;
            _rightsView.bottomLab2.text = @"--";
            _rightsView.priceTF.text = @"";
        }else{
            _rightsView.price.hidden = NO;
            _rightsView.price.text = _currentModel.vipMoney;
            //折合玩贝
            double ss = floor([[_currentModel.vipMoney stringByDividingBy:_currentModel.basePrice] doubleValue]);
            NSString *sss = [NSString stringWithFormat:@"%.lf", ss];
            _rightsView.bottomLab2.text = sss;
            _rightsView.priceTF.hidden = YES;
        }
    }
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView{
    return self.imageArray.count;
}


- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGCustomBannerView *bannerView = (PGCustomBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGCustomBannerView alloc] init];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //这里需要加入容错
    bannerView.mainImageView.image = self.imageArray[index];
    if (_cardArr.count) {
        [bannerView loadDataWithModel:_cardArr[index]];
    }
    return bannerView;
}

#pragma mark - 登录
- (void)loginAction:(UIButton *)sender{
    QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
    loginVC.pushVCTag = @"0";
    [self presentViewController:loginVC animated:YES completion:nil];
}


@end
