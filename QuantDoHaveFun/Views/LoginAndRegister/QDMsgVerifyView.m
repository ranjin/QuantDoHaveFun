//
//  QDMsgVerifyView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDMsgVerifyView.h"

@implementation QDMsgVerifyView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _identifyLab = [[UILabel alloc] init];
        _identifyLab.text = @"输入验证码";
        _identifyLab.font = QDFont(25);
        [self addSubview:_identifyLab];

        _sendBtn = [[GBverifyButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.053, SCREEN_HEIGHT*0.48, SCREEN_WIDTH*0.89, SCREEN_HEIGHT*0.075) delegate:self Target:self Action:@selector(sendPhoneMsg)];
        [_sendBtn addTarget:self action:@selector(sendPhoneMsg) forControlEvents:UIControlEventTouchUpInside];
        _sendBtn.titleLabel.font = QDFont(19);
        _sendBtn.backgroundColor = APP_BLUECOLOR;
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_sendBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_identifyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(19);
        make.top.equalTo(self.mas_top).offset(106+SafeAreaTopHeight-64);
    }];
}

#pragma mark - 短信发送
-(void)sendPhoneMsg{
    [WXProgressHUD showHUD];
    NSDictionary * dic1 = @{@"legalPhone":_legalPhone,
                            @"smsType":@"0"
                            };
    [[QDServiceClient shareClient] requestWithType:kHTTPRequestTypePOST urlString:api_SendVerificationCode params:dic1 successBlock:^(QDResponseObject *responseObject) {
        QDLog(@"responseObject =%@", responseObject);
        if (responseObject.code == 0) {
            [WXProgressHUD hideHUD];
            [WXProgressHUD showSuccessWithTittle:@"短信发送成功"];
            [_sendBtn startGetMessage];
        }else{
            [WXProgressHUD showInfoWithTittle:responseObject.message];
        }
    } failureBlock:^(NSError *error) {
        [WXProgressHUD hideHUD];
        [WXProgressHUD showErrorWithTittle:@"短信发送失败"];
    }];
}
@end
