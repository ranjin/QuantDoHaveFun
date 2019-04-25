//
//  QDProtocolVC.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/29.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDProtocolVC.h"

@interface QDProtocolVC (){
    UILabel *_titleLab;
    UITextView *_textView;
}

@end

@implementation QDProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    topView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:topView];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [topView addSubview:btn];
    [btn addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(34);
        make.left.equalTo(topView.mas_left).offset(10);
        make.width.and.height.mas_equalTo(30);
    }];
    
    _textView = [[UITextView alloc]init];
    _textView.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    _textView.editable = NO;    //禁止编辑
    _textView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(SafeAreaTopHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-SafeAreaTopHeight);
    }];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData: [_contentStr dataUsingEncoding:NSUnicodeStringEncoding] options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes: nil error: nil];
    _textView.attributedText = attributedString;
}

- (void)returnAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
