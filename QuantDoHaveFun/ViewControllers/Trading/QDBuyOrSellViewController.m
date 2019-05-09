//
//  QDBuyOrSellViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDBuyOrSellViewController.h"
#import "PPNumberButton.h"
#import <TYAlertView.h>
#import "QDBridgeViewController.h"
#define AddBtnWidth SCREEN_WIDTH*0.075
@interface QDBuyOrSellViewController ()<UITableViewDelegate, UITableViewDataSource, PPNumberButtonDelegate>{
    UITableView *_tableView;
    UIButton *_operateBtn;
}
@property (nonatomic, strong) PPNumberButton *numberButton;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *balanceLab;

@property (nonatomic, strong) UILabel *amountLab;   //不可部分成交时的数量显示

@end

@implementation QDBuyOrSellViewController

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
    self.view.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
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
    if ([_operateModel.postersType isEqualToString:@"1"]) {
        titleLab.text = @"买买";
    }else{
        titleLab.text = @"卖卖";
    }
    titleLab.textColor = APP_BLACKCOLOR;
    titleLab.font = QDFont(17);
    [backView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(returnBtn);
    }];
    [self initTableView];
}
- (void)popAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _operateBtn = [[UIButton alloc] init];
    if ([_operateModel.postersType isEqualToString:@"1"]) {
        [_operateBtn setTitle:@"确认购买" forState:UIControlStateNormal];
        [_operateBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_operateBtn setTitle:@"确认卖出" forState:UIControlStateNormal];
        [_operateBtn addTarget:self action:@selector(sellAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_operateBtn setTitleColor:APP_BLUECOLOR forState:UIControlStateNormal];
    [_operateBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 316, 50);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
    gradientLayer.masksToBounds = YES;
    gradientLayer.cornerRadius = 25;

    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#21C6A5"] CGColor],(id)[[UIColor colorWithHexString:@"#00AFAD"] CGColor]]];//渐变数组
    [_operateBtn.layer addSublayer:gradientLayer];
    _operateBtn.titleLabel.font = QDFont(16);
    [_tableView addSubview:_operateBtn];
    [_operateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(242+SafeAreaTopHeight-64);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(316);
    }];
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark -- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return _cellCount;
    return 3;
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
    cell.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"数量";
        cell.textLabel.font = QDFont(16);
        if ([_operateModel.isPartialDeal isEqualToString:@"0"]) {
            //不可部分成交
            self.amountLab.text = _operateModel.surplusVolume;
            [cell.contentView addSubview:self.amountLab];
            [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-35);
            }];
            UILabel *lab = [[UILabel alloc] init];
            lab.text = @"个";
            lab.textColor = APP_GRAYCOLOR;
            lab.font = QDFont(15);
            [cell.contentView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-17);
            }];
        }else{
            [cell.contentView addSubview:self.numberButton];
            [_numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.1));
                make.width.mas_equalTo(145);
                make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
            }];
            UILabel *lab = [[UILabel alloc] init];
            lab.text = @"个";
            lab.textColor = APP_BLACKCOLOR;
            lab.font = QDFont(15);
            [cell.contentView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
                make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
            }];
        }
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"价格";
        cell.textLabel.font = QDFont(16);
        self.priceLab.text = [NSString stringWithFormat:@"%@元", _operateModel.price];
        [cell.contentView addSubview:self.priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
        }];
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"金额";
        cell.textLabel.font = QDFont(16);
        self.balanceLab.text = [NSString stringWithFormat:@"%.2f元", self.numberButton.currentNumber * [_operateModel.price floatValue]];
        [cell.contentView addSubview:self.balanceLab];
        [_balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
        }];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addAction:(id)sender{
    
}

- (void)subAction:(id)sender{
    
}

- (void)payAction:(UIButton *)sender{
    //直接购买
    if ([_numberButton.textField.text isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"数量不能为空"];
        return;
    }
    if ([_numberButton.textField.text intValue] > [_operateModel.surplusVolume intValue]) {
        [WXProgressHUD showInfoWithTittle:@"数量输入不合法,请重新输入"];
    }else{
        [WXProgressHUD showHUD];
        NSString *balance = self.balanceLab.text;
        NSString *balanceStr = [balance substringToIndex:[balance length] - 1];
        NSDictionary *paramsDic = @{
                                    @"userId":_operateModel.userId,
                                    @"creditCode":_operateModel.creditCode,
                                    @"price":[NSNumber numberWithDouble:[_operateModel.price doubleValue]],
                                    @"buyVolume":[NSNumber numberWithFloat:_numberButton.currentNumber],
                                    @"balance":balanceStr,
                                    @"postersId":_operateModel.postersId,
                                    @"postersType":_operateModel.postersType,
                                    @"isPartialDeal":_operateModel.isPartialDeal    //是否允许部分成交
                                    };
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_BuyAndSellBiddingPosters params:paramsDic successBlock:^(QDResponseObject *responseObject) {
            if (responseObject.code == 0) {
                [WXProgressHUD showSuccessWithTittle:@"订单生成"];
                //摘单生成的订单号
                NSString *str = responseObject.result;
                //是否确认付款
                [WXProgressHUD hideHUD];
                TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"确认付款" message:@"您确定要对这笔订单进行付款操作吗?"];
                [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
                    [WXProgressHUD hideHUD];
                }]];
                [alertView addAction:[TYAlertAction actionWithTitle:@"真的" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
                    QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
                    NSString *balance = [NSString stringWithFormat:@"%.2f", [_balanceLab.text doubleValue]];
                    bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?amount=%@&id=%@", QD_JSURL, JS_PAYACTION, balance, str];
                    [self.navigationController pushViewController:bridgeVC animated:YES];
                }]];
                [alertView setButtonTitleColor:APP_BLACKCOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
                [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
                [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
                [alertView show];
            }else{
                [WXProgressHUD hideHUD];
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [WXProgressHUD showErrorWithTittle:@"网络请求失败"];
        }];
    }
}

- (void)sellAction:(UIButton *)sender{
    //直接卖出
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"确认卖出" message:@"是否确认卖出?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
        [WXProgressHUD hideHUD];
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"真的" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        [WXProgressHUD showHUD];
        NSString *balance = self.balanceLab.text;
        NSString *balanceStr = [balance substringToIndex:[balance length] - 1];
        NSDictionary *paramsDic = @{
                                    @"userId":_operateModel.userId,
                                    @"creditCode":_operateModel.creditCode,
                                    @"price":[NSNumber numberWithDouble:[_operateModel.price doubleValue]],
                                    @"buyVolume":[NSNumber numberWithFloat:_numberButton.currentNumber],
                                    @"balance":balanceStr,
                                    @"postersId":_operateModel.postersId,
                                    @"postersType":_operateModel.postersType,
                                    @"isPartialDeal":_operateModel.isPartialDeal    //是否允许部分成交
                                    };
        [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_BuyAndSellBiddingPosters params:paramsDic successBlock:^(QDResponseObject *responseObject) {
            if (responseObject.code == 0) {
                [WXProgressHUD showSuccessWithTittle:@"卖出成功"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [WXProgressHUD hideHUD];
                [WXProgressHUD showInfoWithTittle:responseObject.message];
            }
        } failureBlock:^(NSError *error) {
            [WXProgressHUD showErrorWithTittle:@"网络请求失败"];
        }];
    }]];
    [alertView setButtonTitleColor:APP_BLACKCOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

#pragma mark - 数量输入,第一位不能为0,且不能高于superVolume
- (void)verifyNum:(UITextField *)tf{
    if (tf.text.length == 1 && [tf.text isEqualToString:@"0"]) {
        tf.text = @"";
    }else{
        if ([tf.text intValue] > [_operateModel.surplusVolume intValue]) {
            [WXProgressHUD showInfoWithTittle:@"不能高于可成交数量,请重新输入"];
        }
    }
    QDLog(@"123");
}

#pragma mark - lazy
- (PPNumberButton *)numberButton
{
    if (!_numberButton) {
        _numberButton = [[PPNumberButton alloc] initWithFrame:CGRectMake(0, 0, 145, 40)];
        _numberButton.shakeAnimation = YES;
        _numberButton.delegate = self;
        _numberButton.textField.keyboardType = UIKeyboardTypeNumberPad;
        [_numberButton.textField addTarget:self action:@selector(verifyNum:) forControlEvents:UIControlEventEditingChanged];
        // 设置最小值
        if (_operateModel != nil) {
            if ([_operateModel.isPartialDeal isEqualToString:@"0"]) {   //不可部分成交
                _numberButton.currentNumber = [_operateModel.surplusVolume intValue];
                _numberButton.minValue = [_operateModel.surplusVolume intValue];
                _numberButton.maxValue = [_operateModel.surplusVolume intValue];
                _numberButton.increaseImage = [UIImage imageNamed:@"icon_grayIncrease"];
                _numberButton.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
            }else{
                _numberButton.minValue = 1;
                _numberButton.currentNumber = 1;
                // 设置最大值
                _numberButton.maxValue = [_operateModel.surplusVolume floatValue];
                _numberButton.increaseImage = [UIImage imageNamed:@"icon_increase"];
                _numberButton.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
            }
        }else{
            _numberButton.minValue = 1;
            _numberButton.currentNumber = 1;
            // 设置最大值
            _numberButton.maxValue = 10000;
        }
        // 设置输入框中的字体大小
        _numberButton.inputFieldFont = 16;
        _numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            NSLog(@"%lf",number);
        };
    }
    return _numberButton;
}

- (UILabel *)priceLab{
    if(!_priceLab){
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = _operateModel.price;
        _priceLab.font = QDFont(16);
        _priceLab.textColor = APP_BLACKCOLOR;
    }
    return _priceLab;
}

- (UILabel *)balanceLab{
    if(!_balanceLab){
        _balanceLab = [[UILabel alloc] init];
        _balanceLab.text = [NSString stringWithFormat:@"%.2f", self.numberButton.currentNumber * [_operateModel.price floatValue]];
        _balanceLab.font = QDFont(16);
        _balanceLab.textColor = APP_BLACKCOLOR;
    }
    return _balanceLab;
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    NSLog(@"%@",increaseStatus ? @"加运算":@"减运算");
    _balanceLab.text = [NSString stringWithFormat:@"%.2f", number * [_operateModel.price floatValue]];
    if (number == self.numberButton.minValue) {
        _numberButton.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
        _numberButton.increaseImage = [UIImage imageNamed:@"icon_increase"];
    }else if (number == self.numberButton.maxValue) {
        _numberButton.decreaseImage = [UIImage imageNamed:@"icon_decrease"];
        _numberButton.increaseImage = [UIImage imageNamed:@"icon_grayIncrease"];
    }else{
        _numberButton.decreaseImage = [UIImage imageNamed:@"icon_decrease"];
        _numberButton.increaseImage = [UIImage imageNamed:@"icon_increase"];
    }
}

- (UILabel *)amountLab{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc] init];
        _amountLab.textColor = APP_BLACKCOLOR;
        _amountLab.font = QDFont(16);
    }
    return _amountLab;
}

@end
