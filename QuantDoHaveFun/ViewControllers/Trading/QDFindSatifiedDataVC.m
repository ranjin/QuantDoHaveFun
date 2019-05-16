//
//  QDBuyOrSellViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/2/16.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDFindSatifiedDataVC.h"
#import "PPNumberButton.h"
#import "QDRecommendViewController.h"
#import "CWActionSheet.h"
#import "QDLoginAndRegisterVC.h"
#define AddBtnWidth SCREEN_WIDTH*0.075
@interface QDFindSatifiedDataVC ()<UITableViewDelegate, UITableViewDataSource, PPNumberButtonDelegate, UITextFieldDelegate>{
    UITableView *_tableView;
    UIButton *_operateBtn;
    int maxNumber;
    int minNumber;
    int currentNumber;
    NSDecimalNumber *_priceTick;
    NSDecimalNumber *_amountTick;
    BOOL isHaveDian;
}
@property (nonatomic, strong) PPNumberButton *amountNumBtn;
@property (nonatomic, strong) PPNumberButton *priceNumBtn;

@property (nonatomic, strong) UILabel *transferLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UILabel *situationLab;
@property (nonatomic, strong) NSString *isPartialDeal;

@property (nonatomic, strong) UITextField *amountTF;
@property (nonatomic, strong) UITextField *priceTF;

@end

@implementation QDFindSatifiedDataVC

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

- (void)setLeftBtnItem{
    UIImage *backImage = [UIImage imageNamed:@"icon_return"];
    UIImage *selectedImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
}

- (void)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isHaveDian = NO;
    minNumber = 0;
    maxNumber = 5;
    _isPartialDeal = @"1";
    _priceTick = [NSDecimalNumber decimalNumberWithString:@"0.01"]; //价格
    _amountTick = [NSDecimalNumber decimalNumberWithString:@"1"];   //数量
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
    if ([_typeStr isEqualToString:@"1"]) {
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

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+10, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    _operateBtn = [[UIButton alloc] init];
    if ([_typeStr isEqualToString:@"1"]) {
        [_operateBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    }else{
        [_operateBtn setTitle:@"确认卖出" forState:UIControlStateNormal];
    }
    [_operateBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
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
    if ([_typeStr isEqualToString:@"0"]) {
        [_operateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(299+SafeAreaTopHeight-64+52);
            make.width.mas_equalTo(316);
            make.height.mas_equalTo(50);
        }];
    }else{
        [_operateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(299+SafeAreaTopHeight-64);
            make.width.mas_equalTo(316);
            make.height.mas_equalTo(50);
        }];
    }
}

- (void)popAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
#pragma mark -- tableView delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_typeStr isEqualToString:@"1"]) {
        return 4;
    }else{
        return 5;
    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
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
        [self setupTextField:self.amountTF];
        [cell.contentView addSubview:self.amountTF];
        [_amountTF mas_makeConstraints:^(MASConstraintMaker *make) {
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
    }else if(indexPath.row == 1){
        cell.textLabel.text = @"价格";
        cell.textLabel.font = QDFont(16);
        [self setupTextField:self.priceTF];
        [cell.contentView addSubview:self.priceTF];
        [_priceTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.1));
            make.width.mas_equalTo(145);
            make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
        }];
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"元";
        lab.textColor = APP_BLACKCOLOR;
        lab.font = QDFont(15);
        [cell.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
            make.height.mas_equalTo(SCREEN_HEIGHT*0.06);
        }];
    }else if (indexPath.row == 2){
        cell.textLabel.text = @"金额";
        cell.textLabel.font = QDFont(16);
        [cell.contentView addSubview:self.priceLab];
        self.priceLab.text = [NSString stringWithFormat:@"%.2lf元", [_priceTF.text doubleValue] * [_amountTF.text doubleValue]];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
        }];
    }else{
        if ([_typeStr isEqualToString:@"1"]) {
            cell.textLabel.text = @"是否可零售";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = QDFont(16);
            [cell.contentView addSubview:self.situationLab];
            [_situationLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.contentView);
                make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
            }];
        }else{
            if (indexPath.row == 3) {
                cell.textLabel.text = @"手续费";
                cell.textLabel.font = QDFont(16);
                [cell.contentView addSubview:self.transferLab];
                //手续费
                self.transferLab.text = [NSString stringWithFormat:@"%.2lf元", [_priceTF.text doubleValue] * [_amountTF.text doubleValue]];
//                NSString *ss = _
                [_transferLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView);
                    make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
                }];
            }else{
                cell.textLabel.text = @"是否可零售";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = QDFont(16);
                [cell.contentView addSubview:self.situationLab];
                [_situationLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(cell.contentView);
                    make.right.equalTo(cell.contentView.mas_right).offset(-(SCREEN_WIDTH*0.05));
                }];
            }
        }
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_typeStr isEqualToString:@"1"]) {
        if (indexPath.row == 3) {
            [self showAlert];
        }
    }else{
        if (indexPath.row == 4) {
            [self showAlert];
        }
    }
}

- (void)showAlert{
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"是", @"否", nil];
    CWActionSheet *sheet = [[CWActionSheet alloc] initWithTitles:@[@"是", @"否"] clickAction:^(CWActionSheet *sheet, NSIndexPath *indexPath) {
        _situationLab.text = titleArr[indexPath.row];
        QDLog(@"123");
        //该笔挂单是否部分成交0-不允许 1-允许
        if (indexPath.row == 0) {
            _isPartialDeal = @"1";
        }else{
            _isPartialDeal = @"0";
        }
    }];
    [sheet show];
}
#pragma mark - 价格加
- (void)addAction:(id)sender{
    NSDecimalNumber *existNum;
    UITextField *textField = (UITextField *)objc_getAssociatedObject(sender, "textField");
    if (textField == _priceTF) {    //价格无最大限制,最小不能小于0
        if ([_priceTF.text isEqualToString:@""]) {
            existNum = [NSDecimalNumber decimalNumberWithString:@"0"];
        }else{
            existNum = [NSDecimalNumber decimalNumberWithString:_priceTF.text];
        }
        textField.text = [[existNum decimalNumberByAdding:_priceTick] stringValue];
    }
    if (textField == _amountTF) {   //数量最小为1,无最大限制
        if ([_amountTF.text isEqualToString:@""]) {
            existNum = [NSDecimalNumber decimalNumberWithString:@"0"];
        }else{
            existNum = [NSDecimalNumber decimalNumberWithString:_amountTF.text];
        }
        textField.text = [[existNum decimalNumberByAdding:_amountTick] stringValue];
    }
    self.priceLab.text = [NSString stringWithFormat:@"%.2lf元", [_priceTF.text doubleValue] * [_amountTF.text doubleValue]];
    [self getFee];
}

#pragma mark - 价格减
- (void)subAction:(id)sender{
    NSDecimalNumber *existNum;
    UITextField *textField = (UITextField *)objc_getAssociatedObject(sender, "textField");
    if (textField == _priceTF) {
        existNum = [NSDecimalNumber decimalNumberWithString:_priceTF.text];
        textField.text = [[existNum decimalNumberBySubtracting:_priceTick] stringValue];
        if ([textField.text isEqualToString:@"0"] || [textField.text isEqualToString:@""]) {
            textField.text = [_priceTick stringValue];
            [WXProgressHUD showInfoWithTittle:@"价格不能为0"];
        }
        if ([textField.text isEqualToString:@"-0.01"]) {
            textField.text = @"0.00";
            [WXProgressHUD showInfoWithTittle:@"价格不能为0"];
        }
    }
    if (textField == _amountTF) {
        existNum = [NSDecimalNumber decimalNumberWithString:_amountTF.text];
        textField.text = [[existNum decimalNumberBySubtracting:_amountTick] stringValue];
        if ([textField.text isEqualToString:@"0"] || [textField.text isEqualToString:@""]) {
            textField.text = [_amountTick stringValue];
            [WXProgressHUD showInfoWithTittle:@"数量不能为0"];
        }
    }
    self.priceLab.text = [NSString stringWithFormat:@"%.2lf元", [_priceTF.text doubleValue] * [_amountTF.text doubleValue]];
    [self getFee];
}

- (void)payAction:(UIButton *)sender{
    if ([_amountTF.text isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"数量不能为空"];
        return;
    }
    if ([_priceTF.text isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"价格不能为空"];
        return;
    }
    //总金额不能为0
    if ([self.priceLab.text doubleValue] == 0) {
        [WXProgressHUD showInfoWithTittle:@"金额不能为0"];
        return;
    }
    [self saveIntentionPosters];
}


#pragma mark - 请求挂单编号
- (void)saveIntentionPosters{
    NSDictionary * paramsDic = @{@"creditCode":@"10001",
                                 @"price":self.priceTF.text,
                                 @"postersType":_typeStr,
                                 @"volume":self.amountTF.text,
                                 @"isPartialDeal": _isPartialDeal
                                 };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_SaveIntentionPosters params:paramsDic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            QDRecommendViewController *recommendVC = [[QDRecommendViewController alloc] init];
            recommendVC.price = self.priceTF.text;
            recommendVC.volume = self.amountTF.text;
            recommendVC.isPartialDeal = _isPartialDeal;
            recommendVC.postersType = _typeStr;
            [self.navigationController pushViewController:recommendVC animated:YES];
        }else if (responseObject.code == 2){    //未登录情况
            [QDUserDefaults setObject:@"0" forKey:@"loginType"];
            QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
            loginVC.pushVCTag = @"0";
            [self presentViewController:loginVC animated:YES completion:nil];
            [QDUserDefaults removeCookies]; //未登录的时候移除cookie
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}
#pragma mark - 价格输入框
- (UITextField *)priceTF{
    if (!_priceTF) {
        _priceTF = [[UITextField alloc] init];
        _priceTF.delegate = self;
        [_priceTF addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _priceTF.textColor = APP_BLACKCOLOR;
        _priceTF.font = QDFont(16);
        _priceTF.text = @"0";
    }
    return _priceTF;
}

#pragma mark - 数量输入框
- (UITextField *)amountTF{
    if (!_amountTF) {
        _amountTF = [[UITextField alloc] init];
        [_amountTF addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _amountTF.textColor = APP_BLACKCOLOR;
        _amountTF.delegate = self;
        _amountTF.font = QDFont(16);
        _amountTF.text = @"1";
    }
    return _amountTF;
}

#pragma mark - 价格
- (PPNumberButton *)priceNumBtn
{
    if (!_priceNumBtn) {
        _priceNumBtn = [[PPNumberButton alloc] initWithFrame:CGRectMake(0, 0, 145, 28)];
        _priceNumBtn.shakeAnimation = YES;
        _priceNumBtn.stepValue = 0.1;
        _priceNumBtn.decimalNum = YES;
        // 设置最小值
        _priceNumBtn.minValue = 0.1;
        _priceNumBtn.currentNumber = 0.1;
        // 设置最大值
//        [_priceNumBtn.textField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _priceNumBtn.maxValue = 10000;
        _priceNumBtn.delegate = self;
        _priceNumBtn.increaseImage = [UIImage imageNamed:@"icon_increase"];
        _priceNumBtn.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
        _priceNumBtn.currentNumber = currentNumber;
        
        // 设置输入框中的字体大小
        _priceNumBtn.inputFieldFont = 16;
        _priceNumBtn.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            NSLog(@"%lf",number);
        };
    }
    return _priceNumBtn;
}

#pragma mark - 数量
- (PPNumberButton *)amountNumBtn
{
    if (!_amountNumBtn) {
        _amountNumBtn = [[PPNumberButton alloc] initWithFrame:CGRectMake(0, 0, 145, 28)];
        _amountNumBtn.shakeAnimation = YES;
        _amountNumBtn.stepValue = 1;
        // 设置最小值
        _amountNumBtn.minValue = 1;
        _amountNumBtn.currentNumber = 1;
        // 设置最大值
        _amountNumBtn.maxValue = 10000;
        _amountNumBtn.delegate = self;
        [_amountNumBtn.textField addTarget:self action:@selector(textfieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _amountNumBtn.increaseImage = [UIImage imageNamed:@"icon_increase"];
        _amountNumBtn.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
        _amountNumBtn.currentNumber = currentNumber;
        
        // 设置输入框中的字体大小
        _amountNumBtn.inputFieldFont = 16;
        _amountNumBtn.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            NSLog(@"%lf",number);
        };
    }
    return _amountNumBtn;
}
- (UILabel *)priceLab{
    if(!_priceLab){
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = QDFont(16);
        _priceLab.textColor = APP_BLACKCOLOR;
    }
    return _priceLab;
}

- (UILabel *)transferLab{
    if(!_transferLab){
        _transferLab = [[UILabel alloc] init];
        _transferLab.font = QDFont(16);
        _transferLab.textColor = APP_BLACKCOLOR;
    }
    return _transferLab;
}

- (UILabel *)situationLab{
    if(!_situationLab){
        _situationLab = [[UILabel alloc] init];
        _situationLab.text = @"是";
        _situationLab.font = QDFont(16);
        _situationLab.textColor = APP_BLACKCOLOR;
    }
    return _situationLab;
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    NSLog(@"%@",increaseStatus ? @"加运算":@"减运算");
    _priceLab.text = [NSString stringWithFormat:@"%.2lf", _amountNumBtn.currentNumber * _priceNumBtn.currentNumber];
    if (numberButton == self.amountNumBtn) {
        if (number ==  self.amountNumBtn.minValue ) {
            _amountNumBtn.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
            _amountNumBtn.increaseImage = [UIImage imageNamed:@"icon_increase"];
        }else if (number == maxNumber) {
            _amountNumBtn.decreaseImage = [UIImage imageNamed:@"icon_decrease"];
            _amountNumBtn.increaseImage = [UIImage imageNamed:@"icon_grayIncrease"];
        }else{
            _amountNumBtn.decreaseImage = [UIImage imageNamed:@"icon_decrease"];
            _amountNumBtn.increaseImage = [UIImage imageNamed:@"icon_increase"];
        }
    }else{
        if (number == self.priceNumBtn.minValue) {
            _priceNumBtn.decreaseImage = [UIImage imageNamed:@"icon_grayDecrease"];
            _priceNumBtn.increaseImage = [UIImage imageNamed:@"icon_increase"];
        }else if (number == maxNumber) {
            _priceNumBtn.decreaseImage = [UIImage imageNamed:@"icon_decrease"];
            _priceNumBtn.increaseImage = [UIImage imageNamed:@"icon_grayIncrease"];
        }else{
            _priceNumBtn.decreaseImage = [UIImage imageNamed:@"icon_decrease"];
            _priceNumBtn.increaseImage = [UIImage imageNamed:@"icon_increase"];
        }
    }
}

- (void)setupTextField:(UITextField *)textField
{
    if(textField == _priceTF){
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (textField == _amountTF){
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    textField.textAlignment = NSTextAlignmentCenter;
    
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.frame = CGRectMake(0, 0, 28, 28);
    [subBtn setImage:[UIImage imageNamed:@"icon_decrease"] forState:UIControlStateNormal];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 28, 28);
    [addBtn setImage:[UIImage imageNamed:@"icon_increase"] forState:UIControlStateNormal];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [leftView addSubview:subBtn];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [rightView addSubview:addBtn];
    
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.and.right.equalTo(rightView);
        make.width.mas_equalTo(28);
    }];
    
    [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.height.and.right.equalTo(leftView);
        make.width.mas_equalTo(28);
    }];
    
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightView = rightView;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    objc_setAssociatedObject(addBtn, "textField", textField, OBJC_ASSOCIATION_ASSIGN);
    [addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(subBtn, "textField", textField, OBJC_ASSOCIATION_ASSIGN);
    [subBtn addTarget:self action:@selector(subAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addssAction:(id)sender{
    [sender setImage:[UIImage imageNamed:@"icon_grayDecrease"] forState:UIControlStateNormal];
}

- (void)textfieldDidChange:(UITextField *)textField{
    self.priceLab.text = [NSString stringWithFormat:@"%.2lf", [_priceTF.text doubleValue] * [_amountTF.text doubleValue]];
    [self getFee];
}

#pragma mark - 挂单手续费
- (void)getFee{
    double ss = [_amountTF.text doubleValue];
    double sss = [_priceTF.text doubleValue];

    NSDictionary *dic = @{
                          @"creditCode":@"10001",
                          @"volume":[NSNumber numberWithDouble:ss],
                          @"price":[NSNumber numberWithDouble:sss]
                          };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_getPostersFee params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            _transferLab.text = [NSString stringWithFormat:@"%@元", responseObject.result];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"挂单手续费请求失败"];
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _priceTF) {
        /*
         * 不能输入.0-9以外的字符。
         * 设置输入框输入的内容格式
         * 只能有一个小数点
         * 小数点后最多能输入两位
         * 如果第一位是.则前面加上0.
         * 如果第一位是0则后面必须输入点，否则不能输入。
         */
        
        // 判断是否有小数点
        if ([textField.text containsString:@"."]) {
            isHaveDian = YES;
        }else{
            isHaveDian = NO;
        }
        
        if (string.length > 0) {
            
            //当前输入的字符
            unichar single = [string characterAtIndex:0];
            
            // 不能输入.0-9以外的字符
            if (!((single >= '0' && single <= '9') || single == '.'))
            {
                [WXProgressHUD showInfoWithTittle:@"您的输入格式不正确"];
                return NO;
            }
            
            // 只能有一个小数点
            if (isHaveDian && single == '.') {
                [WXProgressHUD showInfoWithTittle:@"最多只能输入一个小数点"];
                return NO;
            }
            
            // 如果第一位是.则前面加上0.
            if ((textField.text.length == 0) && (single == '.')) {
                textField.text = @"0";
            }
            
            // 如果第一位是0则后面必须输入点，否则不能输入。
            if ([textField.text hasPrefix:@"0"]) {
                if (textField.text.length > 1) {
                    NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                    if (![secondStr isEqualToString:@"."]) {
                        [WXProgressHUD showInfoWithTittle:@"第二个字符需要是小数点"];
                        return NO;
                    }
                }else{
                    if (![string isEqualToString:@"."]) {
                        [WXProgressHUD showInfoWithTittle:@"第二个字符需要是小数点"];
                        return NO;
                    }
                }
            }
            
            // 小数点后最多能输入两位
            if (isHaveDian) {
                NSRange ran = [textField.text rangeOfString:@"."];
                // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
                if (range.location > ran.location) {
                    if ([textField.text pathExtension].length > 1) {
                        [WXProgressHUD showInfoWithTittle:@"小数点后最多有两位小数"];
                        return NO;
                    }
                }
            }
        }
    }
    return YES;
}
@end
