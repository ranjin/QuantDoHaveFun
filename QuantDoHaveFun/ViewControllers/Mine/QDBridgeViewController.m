
//  QDBridgeViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/16.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDBridgeViewController.h"
#import <WebKit/WebKit.h>
#import "WebViewJavascriptBridge.h"
#import "QDRefreshHeader.h"
#import "QDServiceErrorHandler.h"
#import "QDLoginAndRegisterVC.h"
#import "QDBridgeTViewController.h"
#import "QDRotePlanViewController.h"
#import "QDCalendarViewController.h"
#import "AppDelegate.h"
#import "QDShareView.h"
#import "SnailQuickMaskPopups.h"
#import "OpenShare.h"
#import "OpenShare+QQ.h"
#import "OpenShare+Weibo.h"
#import "OpenShare+Weixin.h"
#import "QYBaseView.h"
#import "QDTestWebViewVC.h"
#define FT_WEIBO_APPKEY         @"2645776991"
#define FT_WEIBO_APPSECRET      @"785818577abc810dfac71fa7c59d1957"
#define FT_WEIBO_CALLBACK_URL   @"http://sns.whalecloud.com/sina2/callback"

@interface QDBridgeViewController ()<WKNavigationDelegate, SnailQuickMaskPopupsDelegate>{
    WebViewJavascriptBridge *_bridge;
    CAReplicatorLayer *_containerLayer;
    UIImage *_weiboImg;
    NSString *_weiboDownUrl;
    NSString *_weiboTitle;
    QYBaseView *_baseView;
}
@property (nonatomic, strong) QDShareView *shareView;
@property (nonatomic, strong) SnailQuickMaskPopups *popups;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic,weak)CALayer * progressLayer;

#pragma mark - H5二级页面新增
//保存本次请求的URL
@property (nonatomic, strong) NSURL *currentUrl;
@property (nonatomic, strong) NSMutableArray *urlArray;
@property (nonatomic, assign) BOOL isbackBool;

@end

@implementation QDBridgeViewController

- (NSMutableArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [NSMutableArray array];
    }
    return _urlArray;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    QDLog(@"viewWillAppear");
    [self.tabBarController.tabBar setHidden:NO];
//    [_webView removeFromSuperview];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    QDLog(@"viewWillAppear");
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    QDLog(@"viewDidLoad");
    //初始化UIWebView,设置webView代理
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//    }
    _baseView = [[QYBaseView alloc] initWithFrame:self.view.frame];
    self.view = _baseView;
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;
    CGRect webViewFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (IS_NotchScreen) {
            webViewFrame = CGRectMake(0, 19, SCREEN_WIDTH, SCREEN_HEIGHT-19);
    }
    _webView = [[WKWebView alloc] initWithFrame:webViewFrame configuration:config];
    _webView.backgroundColor = APP_WHITECOLOR;
    _webView.navigationDelegate = self;

    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [_baseView addSubview:_webView];
    
    //设置能够进行桥接
    [WebViewJavascriptBridge enableLogging];
    
    //初始化WebViewJavascriptBridge, 设置代理, 进行桥接
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    //加载网页URL
    [self loadWebViewWithURL];
    
    // 添加属性监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    [_bridge registerHandler:@"POST" handler:^(id data, WVJBResponseCallback responseCallback) {
        //data: js页面传过来的参数
        //准备post请求
        QDLog(@"JS调用OC,并传值过来");
        NSDictionary *dataDic = [data objectForKey:@"param"];
        NSString *urlStr = [data objectForKey:@"url"];
        [[QDServiceClient shareClient] requestWithHTMLType:kHTTPRequestTypePOST urlString:urlStr params:dataDic successBlock:^(id responseObject) {
            QDLog(@"responseObject");
            NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
            if (code == 2) {
                //                [QDServiceErrorHandler handleError:code];
                QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
            }else{
                responseCallback(responseObject);
            }
        } failureBlock:^(NSError *error) {
            QDLog(@"11");
        }];
    }];
    
    [_bridge registerHandler:@"getTel" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"getTel");   //拨打电话
        if (data == nil || [data isEqualToString:@""]) {
            [WXProgressHUD showErrorWithTittle:@"未找到酒店电话"];
        }else{
            NSString * telStr = [NSString stringWithFormat:@"tel:%@",data];
            UIWebView * webV = [[UIWebView alloc]init];
            [webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:telStr]]];
            [_baseView addSubview:webV];
        }
    }];
    
    [_bridge registerHandler:@"goBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"goBack");   //返回按钮的点击事件里面的代码
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [_bridge registerHandler:@"POSTFormData" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"POSTFormData");   //返回按钮的点击事件里面的代码
        QDLog(@"JS调用OC,并传值过来");
        NSDictionary *dataDic = [data objectForKey:@"param"];
        NSString *urlStr = [data objectForKey:@"url"];
        NSString *POST_BOUNDS = @"test";
        NSURL *url = [NSURL URLWithString:urlStr];
        NSMutableString *bodyContent = [NSMutableString string];
        for(NSString *key in dataDic.allKeys){
            id value = [dataDic objectForKey:key];
            [bodyContent appendFormat:@"--%@\r\n",POST_BOUNDS];
            [bodyContent appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            [bodyContent appendFormat:@"%@\r\n",value];
        }
        [bodyContent appendFormat:@"--%@--\r\n",POST_BOUNDS];
        NSData *bodyData=[bodyContent dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
        [request addValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",POST_BOUNDS] forHTTPHeaderField:@"Content-Type"];
        [request addValue: [NSString stringWithFormat:@"%zd",bodyData.length] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:bodyData];
        NSLog(@"请求的长度%@",[NSString stringWithFormat:@"%zd",bodyData.length]);
        __autoreleasing NSError *error=nil;
        __autoreleasing NSURLResponse *response=nil;
        NSLog(@"输出Bdoy中的内容>>\n%@",[[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding]);
        NSData *reciveData= [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if(error){
            NSLog(@"出现异常%@",error);
        }else{
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
            NSString *str = [[NSString alloc] initWithData:reciveData encoding:NSUTF8StringEncoding];
            if(httpResponse.statusCode==200){
                QDLog(@"str");
                NSLog(@"服务器成功响应!>>%@",str);
                //                responseCallback(str);
                QDTestWebViewVC *testVC = [[QDTestWebViewVC alloc] init];
                testVC.htmlStr = str;
                [self.navigationController pushViewController:testVC animated:YES];
            }else{
                NSLog(@"服务器返回失败>>%@",str);
            }
        }
    }];
    
    [_bridge registerHandler:@"getShare" handler:^(id data, WVJBResponseCallback responseCallback) {
        QDLog(@"getShare");
        [_baseView addSubview:self.shareView];
        _weiboTitle = [data objectForKey:@"title"];
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"imgeUrl"]]];
        _weiboImg = [UIImage imageWithData:imgData];
        _weiboDownUrl = [data objectForKey:@"url"];
        _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_shareView];
        _popups.presentationStyle = PresentationStyleBottom;
        _popups.delegate = self;
        [_popups presentInView:nil animated:YES completion:NULL];
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
    
    [_baseView addSubview:self.progressView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _baseView.backgroundColor = [UIColor whiteColor];
}

- (void)loadWebViewWithURL{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];

//    [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"https"];
//    reques
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_progressView setProgress:0.2 animated:YES];
}

//页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    QDLog(@"webViewDidFinishLoad");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_progressView setProgress:1.0 animated:YES];
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
        if ([URL.path isEqualToString:@"/Map"]) {
            QDRotePlanViewController *roteVC = [[QDRotePlanViewController alloc] init];
            roteVC.cityStr = [dic objectForKey:@"city"];
            roteVC.addressStr = [dic objectForKey:@"address"];
            if (_infoModel) {
                roteVC.infoModel = _infoModel;
            }
            [self.navigationController pushViewController:roteVC animated:YES];
        }else if ([URL.path isEqualToString:@"/Login"]){
            [WXProgressHUD showErrorWithTittle:@"未登录"];
            QDLoginAndRegisterVC *loginVC = [[QDLoginAndRegisterVC alloc] init];
            [self presentViewController:loginVC animated:YES completion:nil];
        }else if ([URL.path isEqualToString:@"/Main"]){
            //跳转到首页
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            UITabBarController *tabVC = (UITabBarController *)delegate.window.rootViewController;
//            [tabVC setSelectedIndex:0];
//            [_webView removeFromSuperview];
            [self.navigationController popToRootViewControllerAnimated:YES];
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
        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = APP_BLUECOLOR.CGColor;
        [_progressView.layer addSublayer:layer];
        self.progressLayer = layer;
    }
    return _progressView;
}

- (QDShareView *)shareView{
    if (!_shareView) {
        _shareView = [[QDShareView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
        _shareView.userInteractionEnabled = YES;
        [_shareView.weiboBtn addTarget:self action:@selector(btnViewHandler:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView.pyqBtn addTarget:self action:@selector(btnViewHandler:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView.weixinBtn addTarget:self action:@selector(btnViewHandler:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView.qqQBtn addTarget:self action:@selector(btnViewHandler:) forControlEvents:UIControlEventTouchUpInside];

        [_shareView.qqBtn addTarget:self action:@selector(btnViewHandler:) forControlEvents:UIControlEventTouchUpInside];
        [_shareView.cancelBtn addTarget:self action:@selector(dismissShareView:) forControlEvents:UIControlEventTouchUpInside];
        _shareView.backgroundColor = APP_WHITECOLOR;
    }
    return _shareView;
}

#pragma mark - 微博Handler
-(void)btnViewHandler:(UIButton*)btn{
    if (btn.tag == 1001) {
        [OpenShare connectWeiboWithAppKey:FT_WEIBO_APPKEY];
        OSMessage *msg=[[OSMessage alloc]init];
        msg.title = _weiboTitle;
        msg.image = _weiboImg;
        msg.link = _weiboDownUrl;
        msg.desc = _weiboTitle;
//        msg.thumbnail = _weiboImgUrl;
        [OpenShare shareToWeibo:msg Success:^(OSMessage *message) {
            QDLog(@"分享到sina微博成功:\%@",message);
            [self hideMaskViewSucceedWithStr:@"分享到sina微博成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            QDLog(@"分享到sina微博失败:\%@\n%@",message,error);
            [self hideMaskViewFailedWithStr:@"分享到sina微博失败"];
        }];
    }else if (btn.tag == 1002){
        OSMessage *msg=[[OSMessage alloc]init];
        msg.desc = _weiboTitle;
        msg.title = _weiboTitle;
        msg.image = _weiboImg;
        msg.link = _weiboDownUrl;
        [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
            QDLog(@"微信分享到朋友圈成功：\n%@",message);
            [self hideMaskViewSucceedWithStr:@"分享到朋友圈成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            QDLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
            [self hideMaskViewFailedWithStr:@"分享到朋友圈失败"];
        }];
    }else if (btn.tag == 1003){
        OSMessage *msg=[[OSMessage alloc]init];
        msg.desc = _weiboTitle;
        msg.title = _weiboTitle;
        msg.link = _weiboDownUrl;
        msg.image = _weiboImg;
        [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
            QDLog(@"微信分享到会话成功：\n%@",message);
            [self hideMaskViewSucceedWithStr:@"微信分享到会话成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            QDLog(@"微信分享到会话失败：\n%@\n%@",error,message);
            [self hideMaskViewFailedWithStr:@"微信分享到会话失败"];
        }];
    }else if (btn.tag == 1004){
        OSMessage *msg=[[OSMessage alloc]init];
        msg.desc = _weiboTitle;
        msg.title = _weiboTitle;
        msg.image = _weiboImg;
        [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
            QDLog(@"分享到QQ空间成功:%@",msg);
            [self hideMaskViewSucceedWithStr:@"分享到QQ空间成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            QDLog(@"分享到QQ空间失败:%@\n%@",msg,error);
            [self hideMaskViewFailedWithStr:@"分享到QQ空间失败"];
        }];
    }else{     //QQ好友 带有链接的标准格式 参考OpenShare+QQ.m文件
        OSMessage *msg=[[OSMessage alloc]init];
        msg.title = _weiboTitle;
        msg.desc = _weiboTitle;
        msg.image = _weiboImg;
        msg.link = _weiboDownUrl;
        msg.multimediaType = OSMultimediaTypeNews;
        [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
            QDLog(@"分享到QQ好友成功:%@",msg);
            [self hideMaskViewSucceedWithStr:@"分享到QQ好友成功"];
        } Fail:^(OSMessage *message, NSError *error) {
            QDLog(@"分享到QQ好友失败:%@\n%@",msg,error);
            [self hideMaskViewFailedWithStr:@"分享到QQ好友失败"];
        }];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

- (void)dismissShareView:(UIButton *)sender{
    [_popups dismissAnimated:YES completion:nil];
}

- (void)hideMaskViewSucceedWithStr:(NSString *)str{
    [WXProgressHUD showSuccessWithTittle:str];
    [_popups dismissAnimated:YES completion:nil];
}

- (void)hideMaskViewFailedWithStr:(NSString *)str{
    [WXProgressHUD showErrorWithTittle:str];
    [_popups dismissAnimated:YES completion:nil];
}
//-(void)qqViewHandler:(UIButton*)btn{
//    UISegmentedControl *seg=(UISegmentedControl*)[panel viewWithTag:2002];
//    OSMessage *msg=[[OSMessage alloc] init];
//    msg.title=[NSString stringWithFormat:@"Hello OpenShare (msg.title) %f",[[NSDate date] timeIntervalSince1970]];
//    if (btn.tag>=2) {
//        msg.image=testImage;
//        msg.thumbnail=testThumbImage;
//        msg.desc=[NSString stringWithFormat:@"这里写的是msg.description %f",[[NSDate date] timeIntervalSince1970]];
//    }
//    if(btn.tag==3){
//        msg.link=@"http://sports.qq.com/a/20120510/000650.htm";
//    }else if(btn.tag==4){
//        msg.link=@"http://wfmusic.3g.qq.com/s?g_f=0&fr=&aid=mu_detail&id=2511915";
//        msg.multimediaType=OSMultimediaTypeAudio;
//    }else if(btn.tag==5){
//        msg.link=@"http://v.youku.com/v_show/id_XOTU2MzA0NzY4.html";
//        msg.multimediaType=OSMultimediaTypeVideo;
//    }
//    switch (seg.selectedSegmentIndex) {
//        case 1:
//        {
//            [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
//                ULog(@"分享到QQ好友成功:%@",msg);
//            } Fail:^(OSMessage *message, NSError *error) {
//                ULog(@"分享到QQ好友失败:%@\n%@",msg,error);
//            }];
//        }
//            break;
//
//        case 2:
//        {
//            [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//                ULog(@"分享到QQ空间成功:%@",msg);
//            } Fail:^(OSMessage *message, NSError *error) {
//                ULog(@"分享到QQ空间失败:%@\n%@",msg,error);
//            }];
//        }
//            break;
//        case 3:
//        {
//            [OpenShare shareToQQFavorites:msg Success:^(OSMessage *message) {
//                ULog(@"分享到QQ收藏成功:%@",msg);
//            } Fail:^(OSMessage *message, NSError *error) {
//                ULog(@"分享到QQ收藏失败:%@\n%@",msg,error);
//            }];
//        }
//            break;
//
//        case 4:
//        {
//            [OpenShare shareToQQDataline:msg Success:^(OSMessage *message) {
//                ULog(@"分享到QQ数据线成功:%@",msg);
//            } Fail:^(OSMessage *message, NSError *error) {
//                ULog(@"分享到QQ数据线失败:%@\n%@",msg,error);
//            }];
//        }
//            break;
//        default:
//            break;
//    }
//
//}
@end
