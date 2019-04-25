//
//  QDLoginAndRegisterVC.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDLoginAndRegisterVC.h"
#import "QDMemberDTO.h"
#import "QDProtocolVC.h"
#import "QDBridgeViewController.h"
@interface QDLoginAndRegisterVC ()<getTextFieldContentDelegate>

@property (nonatomic, strong) QDMemberDTO *qdMemberTDO;
#pragma mark - 注册人手机号跟用户名
@property (nonatomic, strong) NSString *userPhoneNum;
@property (nonatomic, strong) NSString *userName;

@end

@implementation QDLoginAndRegisterVC

- (void)viewWillAppear:(BOOL)animated{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    _isResetPwdNextStep = NO;
    [_loginBtn setHidden:YES];
    [_registerBtn setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //登录页面
    _loginView = [[QDLoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_loginView.gotologinBtn addTarget:self action:@selector(userLogin:) forControlEvents:UIControlEventTouchUpInside];
    //保留用户名
    if ([QDUserDefaults getObjectForKey:@"userID"] != nil) {
        QDLog(@"123 = %@", [QDUserDefaults getObjectForKey:@"userID"]);
        _loginView.phoneTF.text = [QDUserDefaults getObjectForKey:@"userID"];
    }
    [_loginView.forgetPWD addTarget:self action:@selector(forgetPWD:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_loginView];
    [_loginView setHidden:NO];

    //注册页面
    _registerView = [[QDRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_registerView.nextBtn addTarget:self action:@selector(registNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerView];
    [_registerView setHidden:YES];
    [self.view addSubview:_registerView];

    //身份验证页面
    _identifyView = [[IdentifyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_identifyView];
    [_identifyView setHidden:YES];

    //协议富文本
    _yyLabel = [[YYLabel alloc]init];
//    _yyLabel = [[YYLabel alloc]initWithFrame:CGRectMake(21, 327+SafeAreaTopHeight, 300, 44)];
    _yyLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    _yyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_yyLabel];
    [_yyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(21);
        make.top.equalTo(_registerView.userNameLine.mas_bottom).offset(20);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(44);
    }];
    [self protocolIsSelect:NO];
    [_yyLabel setHidden:YES];
    
    //_identifyInputView
    _identifyInputView = [[VertificationCodeInputView alloc]initWithFrame:CGRectMake(50,SCREEN_HEIGHT*0.48,SCREEN_WIDTH - 100,55)];
    _identifyInputView.delegate = self;
    _identifyInputView.numberOfVertificationCode = 4;
    _identifyInputView.secureTextEntry =NO;
    [self.view addSubview:_identifyInputView];
    [_identifyInputView setHidden:YES];
    
    //_msgInputView
    _msgInputView = [[VertificationCodeInputView alloc]initWithFrame:CGRectMake(50,SCREEN_HEIGHT*0.34,SCREEN_WIDTH - 100,55)];
    _msgInputView.delegate = self;
    /****** 设置验证码/密码的位数默认为四位 ******/
    _msgInputView.numberOfVertificationCode = 4;
    /*********验证码（显示数字）YES,隐藏形势 NO，数字形式**********/
    _msgInputView.secureTextEntry =NO;
    [self.view addSubview:_msgInputView];
    [_msgInputView setHidden:YES];
    
    //短信验证码
    _msgVerifyView = [[QDMsgVerifyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _msgVerifyView.legalPhone = _userPhoneNum;
    [self.view addSubview:_msgVerifyView];
    [_msgVerifyView setHidden:YES];
    
    //设置登录密码
    _setLogPwdView = [[QDSetLoginPwdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_setLogPwdView.registerBtn addTarget:self action:@selector(setLoginPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setLogPwdView];
    [_setLogPwdView setHidden:YES];
    
    //忘记密码view
    _forgetPwdView = [[QDForgetPwdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    11
    [_forgetPwdView.nextStepBtn addTarget:self action:@selector(resetPwdNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPwdView];
    [_forgetPwdView setHidden:YES];
    
    //
    _resetLoginPwdView  = [[QDResetLoginPwdView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_resetLoginPwdView.confirmBtn addTarget:self action:@selector(confirmToModeifyPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetLoginPwdView];
    [_resetLoginPwdView setHidden:YES];
    
    [self setSideBtn];
}

#pragma mark - 注册验证码验证
- (void)refreshVerifyCode:(UIButton *)sender{
    
}

- (void)setSideBtn{
    _cancelBtn = [[UIButton alloc] init];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cancelBtn];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SCREEN_HEIGHT*0.054);
        make.left.equalTo(self.view.mas_left).offset(SCREEN_WIDTH*0.056);
    }];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
//    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.89, SCREEN_HEIGHT*0.08);
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
//    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
//    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
//    [_loginBtn.layer addSublayer:gradientLayer];
//    _loginBtn.titleLabel.font = QDFont(19);
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
//        make.height.mas_equalTo(SCREEN_WIDTH*0.89);
//        make.width.mas_equalTo(SCREEN_HEIGHT*0.08);
        make.right.equalTo(self.view.mas_right).offset(-(SCREEN_WIDTH*0.056));
    }];
    
    _registerBtn = [[UIButton alloc] init];
    [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_registerBtn addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancelBtn);
        make.right.equalTo(self.view.mas_right).offset(-(SCREEN_WIDTH*0.056));
    }];
    
}

//取消按钮
- (void)cancelAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击右上角登录按钮
- (void)loginAction:(UIButton *)sender{
    [_registerBtn setHidden:NO];
    [_loginBtn setHidden:YES];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [_registerView.layer addAnimation:animation forKey:nil];
    _registerView.hidden = YES;
    [_loginView setHidden:NO];
    [_yyLabel setHidden:YES];
    //
    [_msgVerifyView setHidden:YES];
    [_setLogPwdView setHidden:YES];
    [_identifyView setHidden:YES];
    [_msgInputView setHidden:YES];
    [_identifyInputView setHidden:YES];
}

//点击右上角注册按钮
- (void)registerAction:(UIButton *)sender{
    _resetLoginPwdView.hidden = YES;
    [_registerBtn setHidden:YES];
    [_loginBtn setHidden:NO];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [_loginView.layer addAnimation:animation forKey:nil];
    _loginView.hidden = YES;
    [_registerView setHidden:NO];
    [_yyLabel setHidden:NO];
}

- (void)findNoticeByTypeIdWithTypeStr:(NSString *)typeStr{
    NSDictionary *dic = @{@"noticeType":typeStr};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_findNoticeByTypeId params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            NSDictionary *dic = responseObject.result;
            NSString *contentStr = [dic objectForKey:@"content"];
            QDProtocolVC *protocolVC = [[QDProtocolVC alloc] init];
            protocolVC.contentStr = contentStr;
            [self presentViewController:protocolVC animated:YES completion:nil];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
- (void)protocolIsSelect:(BOOL)isSelect{
    //设置整段字符串的颜色
    UIColor *color = self.isSelect ? [UIColor blackColor] : [UIColor lightGrayColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:13], NSForegroundColorAttributeName: color};
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"    已阅读并同意《用户注册服务协议》、《隐私政策》、《软件许可及服务协议》" attributes:attributes];
    //设置高亮色和点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《用户注册服务协议》"] color:[UIColor blackColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《用户协议》");
//        [self protocolBridgeVC:@"0"];
        [self findNoticeByTypeIdWithTypeStr:@"0"];
    }];
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《隐私政策》"] color:[UIColor blackColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"点击了《隐私政策》");
//        [self protocolBridgeVC:@"1"];
        [self findNoticeByTypeIdWithTypeStr:@"1"];
    }];
    [text yy_setTextHighlightRange:[[text string] rangeOfString:@"《软件许可及服务协议》"] color:[UIColor blackColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self findNoticeByTypeIdWithTypeStr:@"2"];
//        [self protocolBridgeVC:@"2"];
    }];
    //添加图片
    UIImage *image = [UIImage imageNamed:self.isSelect == NO ? @"unSelectIcon" : @"selectIcon"];
    NSMutableAttributedString *attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(16, 16) alignToFont:[UIFont fontWithName:@"PingFangSC-Regular"  size:12] alignment:(YYTextVerticalAlignment)YYTextVerticalAlignmentCenter];
    //将图片放在最前面
    [text insertAttributedString:attachment atIndex:1];
    //添加图片的点击事件
    [text yy_setTextHighlightRange:[[text string] rangeOfString:[attachment string]] color:[UIColor clearColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        __weak typeof(self) weakSelf = self;
        weakSelf.isSelect = !weakSelf.isSelect;
        if (weakSelf.isSelect) {
            _registerView.nextBtn.enabled = YES;
            [_registerView.nextBtn setSelected:YES];
        }else{
            _registerView.nextBtn.enabled = NO;
            [_registerView.nextBtn setSelected:NO];
        }
        [weakSelf protocolIsSelect:self.isSelect];
    }];
    _yyLabel.attributedText = text;
    _yyLabel.numberOfLines = 0;
    //居中显示一定要放在这里，放在viewDidLoad不起作用
//    _yyLabel.backgroundColor = APP_BLUECOLOR;
    _yyLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)login{
    [WXProgressHUD showHUD];
    [[QDServiceClient shareClient] loginWithUserName:_loginView.phoneTF.text password:_loginView.userNameTF.text userType:@"member" successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [WXProgressHUD hideHUD];
            [QDUserDefaults setObject:responseObject.result forKey:@"Token"];
            QDLog(@"Token = %@", responseObject.result);
            [WXProgressHUD showSuccessWithTittle:@"登录成功"];
            [QDUserDefaults setObject:_loginView.phoneTF.text forKey:@"userID"];
            [QDUserDefaults setObject:_loginView.userNameTF.text forKey:@"userPwd"];
            if ([_pushVCTag isEqualToString:@"0"]) {
                [self findMyUserCreditWithUrlStr:api_GetUserDetail];
            }else{
                [self findMyUserCreditWithUrlStr:api_GetUserDetail];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 用户登录
- (void)userLogin:(UIButton *)sender{
    //先验证手机是否注册
    NSDictionary * dic = @{@"legalPhone":_loginView.phoneTF.text};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_VerificationIsRegister params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [self checkLoginNumWithPhone:_loginView.phoneTF.text];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 用户重复登录次数控制
- (void)checkLoginNumWithPhone:(NSString *)phoneStr{
    NSDictionary *dic = @{@"legalPhone":phoneStr};
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_checkLoginNum params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [self login];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

#pragma mark - 个人积分账户详情
- (void)findMyUserCreditWithUrlStr:(NSString *)urlStr{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:urlStr params:nil successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"responseObject = %@", responseObject);
        if (responseObject.code == 0) {
            if (responseObject.result != nil) {
                [WXProgressHUD hideHUD];
                self.qdMemberTDO = [QDMemberDTO yy_modelWithDictionary:responseObject.result];
                if ([self.qdMemberTDO.isYepay isEqualToString:@"0"] || self.qdMemberTDO.isYepay == nil) {
                    //未开通资金帐户
                    [QDUserDefaults setObject:@"1" forKey:@"loginType"];
                }else{
                    //已开通资金帐户
                    [QDUserDefaults setObject:@"2" forKey:@"loginType"];
                }
                [self dismissViewControllerAnimated:YES completion:^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_LoginSucceeded object:nil];
                }];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络异常"];
    }];
}

- (void)findMyUserCredit{
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_GetUserDetail params:nil successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"responseObject = %@", responseObject);
    } failureBlock:^(NSError *error) {
        
    }];
}
#pragma mark - 忘记密码
- (void)forgetPWD:(UIButton *)sender{
    [_registerBtn setHidden:YES];
    [_loginView setHidden:YES];
    [_forgetPwdView setHidden:NO];
}

#pragma mark - 下一步按钮:注册这好玩&&找回密码
- (void)registNextStep:(UIButton *)sender{
    if ([_registerView.phoneTF.text isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"请输入手机号"];
        return;
    }
    if ([_registerView.userNameTF.text isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"用户名不能为空"];
        return;
    }
    if (!self.isSelect) {
        [WXProgressHUD showErrorWithTittle:@"请先阅读完注册协议并勾选"];
        return;
    }
    //先验证是否注册
    [self checkIsRegister];
//    if ([_registerView.nextBtn isEnabled]) {
//        _userPhoneNum = _registerView.phoneTF.text;
//        _userName = _registerView.userNameTF.text;
//        _isResetPwdNextStep = NO;
//        QDLog(@"%@", self.presentedViewController.view.class);
//        [_identifyView setHidden:NO];
//        [_loginView setHidden:YES];
//        [_registerView setHidden:YES];
//        [_yyLabel setHidden:YES];
//        //当前为验证身份inputView
//        _currentInputView = _identifyInputView;
//        [_identifyInputView becomeFirstResponder];
//        [_identifyInputView setHidden:NO];
//    }else{
//        [WXProgressHUD showErrorWithTittle:@"请先阅读完注册协议并勾选"];
//    }
}

/**
 verificationType: 0验证是否注册 1表示发送验证码
 */
- (void)checkIsRegister{
    NSDictionary * dic = @{@"legalPhone":_registerView.phoneTF.text,
                           @"userName":_registerView.userNameTF.text,
                           @"verificationType":@"0"
                           };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_VerificationRegister params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            if ([_registerView.nextBtn isEnabled]) {
                _userPhoneNum = _registerView.phoneTF.text;
                _userName = _registerView.userNameTF.text;
                _isResetPwdNextStep = NO;
                QDLog(@"%@", self.presentedViewController.view.class);
                [_identifyView setHidden:NO];
                [_loginView setHidden:YES];
                [_registerView setHidden:YES];
                [_yyLabel setHidden:YES];
                //当前为验证身份inputView
                _currentInputView = _identifyInputView;
                [_identifyInputView becomeFirstResponder];
                [_identifyInputView setHidden:NO];
            }else{
                [WXProgressHUD showErrorWithTittle:@"请先阅读完注册协议并勾选"];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

/**
 忘记密码的时候看手机是否注册
 verificationType: 0验证是否注册 1表示发送验证码
 */
#pragma mark - 忘记密码页面的下一步按钮
- (void)resetPwdNextStep:(UIButton *)sender{
    NSDictionary * dic = @{@"legalPhone":_forgetPwdView.phoneTF.text,
                           };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_VerificationIsRegister params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            _isResetPwdNextStep = YES;
            QDLog(@"%@", self.presentedViewController.view.class);
            //当前为验证身份inputView
            [_registerBtn setHidden:YES];
            [_loginBtn setHidden:NO];
            [_forgetPwdView setHidden:YES];
            _currentInputView = _identifyInputView;
            [_identifyInputView becomeFirstResponder];
            [_identifyInputView setHidden:NO];
            [_identifyView setHidden:NO];
            _userPhoneNum = _forgetPwdView.phoneTF.text;
            QDLog(@"_userPhoneNum = %@", _userPhoneNum);
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {

    }];
}

#pragma mark --------- 获取验证码
-(void)returnTextFieldContent:(NSString *)content{
    NSLog(@"%@================验证码",content);
    if (_currentInputView == _identifyInputView) {
        QDLog(@"_identifyView.pooCodeView.changeString = %@", [_identifyView.pooCodeView.changeString lowercaseString]);
        NSString *str = [_identifyView.pooCodeView.changeString lowercaseString];
        if ([content isEqualToString:str]) {
            //验证码成功,发送短信
            [_identifyView setHidden:YES];
            [_identifyInputView setHidden:YES];
            [_msgVerifyView setHidden:NO];
            _msgVerifyView.legalPhone = _userPhoneNum;
            [_msgInputView setHidden:NO];
            _currentInputView = _msgInputView;
            [_msgInputView becomeFirstResponder];
        }else{
            [_identifyView.pooCodeView changeCode];
            [_identifyInputView errorSMSAnim];
        }
    }else if (_currentInputView == _msgInputView){
        //输入完成 验证码校验
        [self codeVerification:content];
    }
}

#pragma mark - 验证码验证
- (void)codeVerification:(NSString *)code{
    NSDictionary * dic = @{@"legalPhone":_userPhoneNum,
                            @"verificationCode":code,
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_VerificationCode params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [WXProgressHUD showSuccessWithTittle:@"验证成功"];
            [QDUserDefaults setObject:code forKey:@"verificationCode"];
            [_msgVerifyView setHidden:YES];
            [_msgInputView setHidden:YES];
            if (_isResetPwdNextStep) {
                //请重置登录密码
                [_resetLoginPwdView setHidden:NO];
            }else{
                [_setLogPwdView setHidden:NO];
            }
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6 && [pass length] <= 16){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

#pragma mark - 设置登录密码
- (void)setLoginPwd:(UIButton *)sender{
    //密码必填 忘记密码和注册的密码长度，和数字字母校验
    NSString *pwdStr = _setLogPwdView.pwdTF.text;
    NSString *confirmPwdStr = _setLogPwdView.confirmPwdTF.text;

    if ([pwdStr isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"请设置登录密码"];
        return;
    }
    if ([confirmPwdStr isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"请确认登录密码"];
        return;
    }
    if (![pwdStr isEqualToString:confirmPwdStr]) {
        [WXProgressHUD showInfoWithTittle:@"两次密码输入不一致"];
        return;
    }
    if (![self judgePassWordLegal:pwdStr]) {
        [WXProgressHUD showInfoWithTittle:@"密码要求为6～16位字母与数字组合"];
        return;
    }
  
    if ([_setLogPwdView.inviteTF.text isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"邀请码不能为空"];
        return;
    }
    [WXProgressHUD showHUD];
    NSString *code = [QDUserDefaults getObjectForKey:@"verificationCode"];
    NSDictionary * dic = @{@"legalPhone":_userPhoneNum,
                           @"userName":_userName,
                           @"userPwd":_setLogPwdView.pwdTF.text,
                           @"confirmUserPwd":_setLogPwdView.confirmPwdTF.text,
                           @"beInvitedCode":_setLogPwdView.inviteTF.text,
                           @"verificationCode":code
                           };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_TryToRegister params:dic successBlock:^(QDResponseObject *responseObject) {
        [WXProgressHUD hideHUD];
        if (responseObject.code == 0) {
            [WXProgressHUD showSuccessWithTittle:@"注册成功,请前往登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
        [WXProgressHUD showErrorWithTittle:@"网络请求失败"];
    }];
}

#pragma mark - 重置登录密码
- (void)confirmToModeifyPwd:(UIButton *)sender{
    NSString *pwdStr = _resetLoginPwdView.theNewPwdTF.text;
    NSString *confirmPwdStr = _resetLoginPwdView.confirmPwdTF.text;
    
    if ([pwdStr isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"请设置新密码"];
        return;
    }
    if ([confirmPwdStr isEqualToString:@""]) {
        [WXProgressHUD showInfoWithTittle:@"请确认新密码"];
        return;
    }
    if (![pwdStr isEqualToString:confirmPwdStr]) {
        [WXProgressHUD showInfoWithTittle:@"两次密码输入不一致"];
        return;
    }
    if (![self judgePassWordLegal:pwdStr]) {
        [WXProgressHUD showInfoWithTittle:@"密码要求为6～16位字母与数字组合"];
        return;
    }
    QDLog(@"resetPWD");
    NSDictionary * dic = @{@"legalPhone":_userPhoneNum,
                           @"userPwd":_resetLoginPwdView.theNewPwdTF.text,
                           @"confirmUserPwd":_resetLoginPwdView.confirmPwdTF.text,
                           };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_ChangePwd params:dic successBlock:^(QDResponseObject *responseObject) {
        if (responseObject.code == 0) {
            [WXProgressHUD showSuccessWithTittle:@"重置密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD showErrorWithTittle:@"网络请求失败"];
    }];
}

- (void)protocolBridgeVC:(NSString *)typeStr{
    QDBridgeViewController *bridgeVC = [[QDBridgeViewController alloc] init];
    bridgeVC.urlStr = [NSString stringWithFormat:@"%@%@?noticeType=%@", QD_TESTJSURL, JS_NOTICETYPE, typeStr];
    [self presentViewController:bridgeVC animated:YES completion:nil];
}
@end
