//
//  QDBridgeTViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/16.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDBridgeTViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "QDRefreshHeader.h"
#import "QDBridgeTViewController.h"
#import "QDServiceErrorHandler.h"
#import "QDLoginAndRegisterVC.h"
#import "QDRotePlanViewController.h"
#import "AppDelegate.h"
#import "QDCalendarCustomerTourVC.h"
#import "QYBaseView.h"
#import "QDCalendarViewController.h"
#import "QDCreditOrderHistoryVC.h"
@interface QDBridgeTViewController ()<WKNavigationDelegate>{
    WebViewJavascriptBridge *_bridge;
    CAReplicatorLayer *_containerLayer;
    QYBaseView *_baseView;
}

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic,weak)CALayer * progressLayer;

#pragma mark - H5二级页面新增
//保存本次请求的URL
@property (nonatomic, strong) NSURL *currentUrl;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, assign) BOOL isbackBool;

@end

@implementation QDBridgeTViewController

- (NSMutableArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_bridge setWebViewDelegate:nil];
    _bridge = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化UIWebView,设置webView代理
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _baseView = [[QYBaseView alloc] initWithFrame:self.view.frame];
    self.view = _baseView;
    CGRect webViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    if (IS_NotchScreen) {
//        webViewFrame = CGRectMake(0, 19, SCREEN_WIDTH, SCREEN_HEIGHT-19);
//    }
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;
    _webView = [[WKWebView alloc] initWithFrame:webViewFrame configuration:config];
    _webView.navigationDelegate = self;
    [_baseView addSubview:_webView];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    //设置能够进行桥接
    [WebViewJavascriptBridge enableLogging];
    
    //初始化WebViewJavascriptBridge, 设置代理, 进行桥接
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    //加载网页URL
    [self loadWebViewWithURL];
    
    // 添加属性监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条
    UIView * progress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 2)];
    progress.backgroundColor = [UIColor clearColor];
    [_baseView addSubview:progress];
    
    // 隐式动画
    CALayer * layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = APP_BLUECOLOR.CGColor;
    [progress.layer addSublayer:layer];
    self.progressLayer = layer;
    
    [_bridge registerHandler:@"POST" handler:^(id data, WVJBResponseCallback responseCallback) {
        //data: js页面传过来的参数
        //准备post请求
        QDLog(@"JS调用OC,并传值过来");
        NSDictionary *dataDic = [data objectForKey:@"param"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:dataDic];
        if(![dic count]){
            dic = nil;
        }
        if ([[dic allKeys] containsObject:@"shareroomAmount"]) {
            double shareroomAmountDouble = [[dic objectForKey:@"shareroomAmount"] doubleValue];
            [dic setObject:[self decimalNumberWithDouble:shareroomAmountDouble] forKey:@"shareroomAmount"];
        }
        NSString *urlStr = [data objectForKey:@"url"];
        [[QDServiceClient shareClient] requestWithHTMLType:kHTTPRequestTypePOST urlString:urlStr params:dic successBlock:^(id responseObject) {
            QDLog(@"responseObject");
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            if (code == 2) {
                QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
            }else{
                responseCallback(responseObject);
            }
        } failureBlock:^(NSError *error) {
            QDLog(@"11");
        }];
    }];
    
    [_bridge registerHandler:@"goBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"goBack");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    //调用日历 多选
    [_bridge registerHandler:@"getRangeDate" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"getRangeDate");
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        QDCalendarViewController *calendar = [[QDCalendarViewController alloc] init];
        [self presentViewController:calendar animated:YES completion:nil];
        calendar.returnDateBlock = ^(NSString * _Nonnull startDate, NSString * _Nonnull endDate, NSString * _Nonnull dateInPassedVal, NSString * _Nonnull dateOutPassedVal, int totayDays) {
            [dic setObject:dateInPassedVal forKey:@"startDate"];
            [dic setObject:dateOutPassedVal forKey:@"endDate"];
            responseCallback(dic);
        };
    }];
    //当前网络环境
    [_bridge registerHandler:@"wifiScanner" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"wifiScanner");
        NSString *ss = [QDUserDefaults getObjectForKey:@"networkStatus"];
        QDLog(@"ss = %@", ss);
        responseCallback(ss);
    }];
    
    //调用日历 单选
    [_bridge registerHandler:@"getSingleDate" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"getSingleDate");
        NSString *allowStartDate = [data objectForKey:@"allowStartDate"];
        QDCalendarCustomerTourVC *calendar = [[QDCalendarCustomerTourVC alloc] init];
        calendar.allowStartDate = allowStartDate;
        [self presentViewController:calendar animated:YES completion:nil];
        calendar.returnSingleDateBlock = ^(NSString * _Nonnull singleDate) {
            responseCallback(singleDate);
        };
    }];
    [_baseView addSubview:self.progressView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)loadWebViewWithURL{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_webView loadRequest:request];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        //        NSLog(@"change == %@",change);
        self.progressLayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[NSKeyValueChangeNewKey] floatValue] < [change[NSKeyValueChangeOldKey] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
//                _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKWebView Delegate
//页面开始加载时调用
- (void) webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    QDLog(@"webViewDidStartLoad");
    [_progressView setProgress:0.2 animated:YES];
}

//页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    QDLog(@"webViewDidFinishLoad");
    [_progressView setProgress:1 animated:YES];
    [_progressView setHidden:YES];
//    _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.progressView setProgress:0.0f animated:YES];
}

//接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

//在收到响应后,决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}


-(NSDictionary *) getUrlParameterWithUrl:(NSURL *)url {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    return parm;
}

//在发送请求之前,决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *strRequest = [navigationAction.request.URL.absoluteString stringByRemovingPercentEncoding];
    if ([strRequest hasPrefix:@"xl://quantdo:8888/"]) {
        NSURL *URL = navigationAction.request.URL;
        NSString *ss = URL.scheme;
        NSString *dd = URL.host;
        NSString *ee = URL.path;
        NSString *pp = URL.parameterString;
        NSString *oo = URL.query ;
        NSDictionary *dic = [self getUrlParameterWithUrl:URL];
        NSArray *arr = [oo componentsSeparatedByString:@"url="];
        QDLog(@"arr = %@", arr);
        QDLog(@"ss = %@, dd = %@, ee = %@, oo = %@, pp = %@", ss, dd, ee, oo, pp);
        QDLog(@"path = %@", URL.path);
        if ([URL.path isEqualToString:@"/Map"]) {
            QDRotePlanViewController *roteVC = [[QDRotePlanViewController alloc] init];
            roteVC.cityStr = [dic objectForKey:@"city"];
            roteVC.addressStr = [dic objectForKey:@"address"];
            roteVC.infoModel = _infoModel;
            [self.navigationController pushViewController:roteVC animated:YES];
        }else if ([URL.path isEqualToString:@"/Login"]){
            [WXProgressHUD showErrorWithTittle:@"未登录"];
            QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }else if ([URL.path isEqualToString:@"/Main"]){
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else if ([URL.path isEqualToString:@"/creditOrder"]){
            [self.navigationController pushViewController:[[QDCreditOrderHistoryVC alloc]init] animated:YES];
        }
        else{
            QDBridgeTViewController *bridgeVC = [[QDBridgeTViewController alloc] init];
            NSString *sss = [NSString stringWithFormat:@"%@%@",QD_TESTJSURL, arr.lastObject];
            QDLog(@"sss = %@", sss);
            bridgeVC.urlStr = sss;
            [self.navigationController pushViewController:bridgeVC animated:YES];
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.progressView setProgress:0.0f animated:NO];
}

- (UIProgressView *)progressView
{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        _progressView.progressTintColor = APP_BLUECOLOR;   //已完成的进度的颜色
        _progressView.trackTintColor = [UIColor whiteColor];       //未完成的进度的颜色
        _progressView.progress = 0.1;
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
    }
    return _progressView;
}

- (NSString *)decimalNumberWithDouble:(double)conversionValue{
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}
@end
