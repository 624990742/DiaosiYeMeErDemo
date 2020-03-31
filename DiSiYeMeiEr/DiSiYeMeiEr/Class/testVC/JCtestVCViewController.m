//
//  JCtestVCViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/4.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCtestVCViewController.h"
#import <WebKit/WebKit.h>
@interface JCtestVCViewController ()<WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, WKScriptMessageHandler>
{
    BOOL isShowRightBtn;
    NSInteger count;
}

@property (nonatomic, strong) WKWebView *webViewWK;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIButton *nextBtn;
@property (strong, nonatomic) NSString *urlUniqueIdentifier;

@end

@implementation JCtestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc {

    [_webViewWK removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webViewWK removeObserver:self forKeyPath:@"title"];
    [_webViewWK removeObserver:self forKeyPath:@"canGoBack"];
    [_webViewWK removeObserver:self forKeyPath:@"canGoForward"];
    [_webViewWK setNavigationDelegate:nil];
    [_webViewWK setUIDelegate:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view bringSubviewToFront:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    /**任务中心返回通知刷新接口*/
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TaskCentterNotifation" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReshreMineNotification" object:nil];
    [self.navigationController setToolbarHidden:YES animated:YES];
    //通知提现界面，刷新接口
    [[NSNotificationCenter defaultCenter]postNotificationName:@"xueDianDaShiNotifacation" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:!self.hiddenToolBar animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshWebView) name:@"shipinfengxiang" object:nil];
    
    [self progressView];
    count = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.webViewWK addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.webViewWK addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.webViewWK addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.webViewWK addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    [self.webViewWK loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@""]]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshWebView) name:@"XueDianDaShiReshreNotifacation" object:nil];
    
}





-(void)refreshWebView{
    [self.webViewWK reload];
}



#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    [MBProgressHUD showWarning:message toView:self.view];
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler {
    completionHandler(defaultText);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    completionHandler(YES);
}

#pragma mark - WKNavigationDelegate

// 请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    /*   NSURL *currentURL = navigationAction.request.URL;
     NSString * urlStr = [[currentURL absoluteString] stringByRemovingPercentEncoding];
     self.urlUniqueIdentifier = urlStr;
     if([urlStr containsString:@"xuedian_inApp_vue/agentHome"]){//代理商数据
     self.xd_navgationBar.backgroundColor = [UIColor colorWithHexString:@"#dabc68"];
     [self setupNavgationLeftImageName:@"返回白色"];
     
     }else if ([urlStr containsString:@"xuedian_inApp_vue/channelDetails"]){//渠道详情
     self.xd_navgationBar.backgroundColor = [UIColor colorWithHexString:@"#dabc68"];
     [self setupNavgationLeftImageName:@"返回白色"];
     
     }else{
     self.xd_navgationBar.backgroundColor = [UIColor whiteColor];
     [self setupNavgationLeftImageName:@"返回"];
     
     }*/
    //需要判断targetFrame是否为nil，如果为空则重新请求
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)setupNavgationLeftImageName:(NSString *)leftImge{
    UIButton * leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    [leftButton setImage:[UIImage imageNamed:leftImge] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:leftImge] forState:UIControlStateSelected];
    self.xd_navgationBar.leftView = leftButton;
}

//修改导航字体颜色
- (NSMutableAttributedString *)changeNavgationTitle:(NSString *)curTitle titleColor:(UIColor *)titleColor{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
    [title addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, title.length)];
    [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kNavTitleFontSize] range:NSMakeRange(0, title.length)];
    return title;
}



// 接收到相应数据后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    if (!navigationResponse.isForMainFrame){
        decisionHandler(WKNavigationResponsePolicyCancel);
    }else{
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    NSLog(@"333333");
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"22222222当Web内容开始在Web视图中加载时调用");
}
// 主机地址被重定向时调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"090909090");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"44444当Web视图开始接收Web内容时调用");
}
// 页面加载完毕时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"55555导航完成时调用。");
}
//跳转失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@" %s,change = %@", __FUNCTION__, change);
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webViewWK) {
            if ([self.urlUniqueIdentifier containsString:@"xuedian_inApp_vue/channelDetails"] || [self.urlUniqueIdentifier containsString:@"xuedian_inApp_vue/agentHome"]){//代理商数据、渠道详情
                [self.progressView setTintColor:[UIColor colorWithHexString:@"#68502a"]];
                
                self.webViewWK.opaque = NO;
                self.webViewWK.backgroundColor =[UIColor colorWithHexString:@"#dabc68"];
                
                
            }else{
                [self.progressView setTintColor:[UIColor colorWithHexString:@"#DABC68"]];
                self.webViewWK.opaque = NO;
                self.webViewWK.backgroundColor = [UIColor whiteColor];
                
            }
            
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:_webViewWK.estimatedProgress animated:YES];
            if(_webViewWK.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webViewWK) {
            
            NSString *webTitleStr = self.webViewWK.title;
            self.navigationItem.title = webTitleStr;
            if ([self.urlUniqueIdentifier containsString:@"xuedian_inApp_vue/channelDetails"] || [self.urlUniqueIdentifier containsString:@"xuedian_inApp_vue/agentHome"]){//代理商数据、渠道详情
                
                self.xd_navgationBar.title = [self changeNavgationTitle:webTitleStr titleColor:[UIColor whiteColor]];
            }else{
                
                self.xd_navgationBar.title = [self changeNavgationTitle:webTitleStr titleColor:[UIColor blackColor]];
            }
            
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else if ([keyPath isEqualToString:@"canGoForward"]) {
        [self refreshBottomButtonState];
    }
    else if ([keyPath isEqualToString:@"canGoBack"]) {
        [self refreshBottomButtonState];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}








- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"skipUI"]) {
        
    }else if ([message.name isEqualToString:@"dashiPay"]){
        [self ambassadorClickPay];
        NSLog(@"成为学点大使");
        
    }else if ([message.name isEqualToString:@"extract"]){
        //        XDExtractController * exract = [[XDExtractController alloc]init];
        XDWeCWithdrawalController * exract = [[XDWeCWithdrawalController alloc]init];
        [self.navigationController pushViewController:exract animated:YES];
        NSLog(@"提现");
    }else if ([message.name isEqualToString:@"shareMoney"]){
        NSString * str = message.body;
        NSArray *array = [str componentsSeparatedByString:@","];
        [[ONEShareTool sharedInstance]showShareViewWithTitle:array[0] andIntro:array[1] andPic:array[3] audioURL:@"" type:ShareTypeDefault ShareUrl:array[2] videoId:@""];
        NSLog(@"立即分享赚现金");
    }else if ([message.name isEqualToString:@"iosTopBarColor"]){//根据链接修改导航颜色
        
        DLog(@"修改导航颜色%@",message.body);
        //         self.xd_navgationBar.backgroundColor = [UIColor colorWithHexString:message.body];
        //type  1 深色  白色箭头 白色标题  2 浅色
        
    }
    
    
}

#pragma mark - 学点大使点击付费跳转事件
-(void)ambassadorClickPay{
    XDHPushPayController * pay = [[XDHPushPayController alloc]init];
    [self.navigationController pushViewController:pay animated:YES];
    
}

#pragma mark - 打开微信取消
-(void)cancenlButton{
    [SMAlert hide];
}

/// 刷新按钮是否允许点击
- (void)refreshBottomButtonState {
    self.backBtn.enabled = [self.webViewWK canGoBack];
    self.backBtn.selected = [self.webViewWK canGoBack];
    self.nextBtn.enabled = [self.webViewWK canGoForward];
    self.nextBtn.selected = [self.webViewWK canGoForward];
}

- (void)deleteWebCacheWithisAll:(BOOL)isAll {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = nil;
        
        if (isAll) {
            websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        }
        else {
            websiteDataTypes = [NSSet setWithArray:@[
                                                     WKWebsiteDataTypeDiskCache,
                                                     WKWebsiteDataTypeOfflineWebApplicationCache,
                                                     WKWebsiteDataTypeMemoryCache,
                                                     WKWebsiteDataTypeLocalStorage,
                                                     WKWebsiteDataTypeCookies,
                                                     WKWebsiteDataTypeSessionStorage,
                                                     WKWebsiteDataTypeIndexedDBDatabases,
                                                     WKWebsiteDataTypeWebSQLDatabases
                                                     ]];
        }
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
    }
    else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity {
    if (velocity.y > 0) {
        [self.navigationController setToolbarHidden:YES animated:YES];
    }
    else {
        [self.navigationController setToolbarHidden:NO animated:YES];
    }
}

- (void)backAction {
    if ([self.webViewWK canGoBack]) {
        [self.webViewWK goBack];
    }
    [self refreshBottomButtonState];
}

- (void)nextAction {
    if ([self.webViewWK canGoForward]) {
        [self.webViewWK goForward];
    }
    [self refreshBottomButtonState];
}

- (void)refreshAction {
    DLog(@"self.url==%@",self.url);
    count++;
    if (count % 3 == 0) {
        [self deleteWebCacheWithisAll:YES];
    }
    else {
        [self deleteWebCacheWithisAll:NO];
    }
    [self.webViewWK reload];
    [self refreshBottomButtonState];
}

- (WKWebView *)webViewWK {
    if (!_webViewWK) {
        WKUserContentController *userCC = [[WKUserContentController alloc] init];
        [userCC addScriptMessageHandler:self name:@"popInvite"];
        [userCC addScriptMessageHandler:self name:@"username"];
        [userCC addScriptMessageHandler:self name:@"skipUI"];
        [userCC addScriptMessageHandler:self name:@"callFunction"];
        [userCC addScriptMessageHandler:self name:@"shareMoney"];
        [userCC addScriptMessageHandler:self name:@"extract"];
        [userCC addScriptMessageHandler:self name:@"dashiPay"];
        [userCC addScriptMessageHandler:self name:@"iosTopBarColor"];
        
        WKWebViewConfiguration *webViewConfig = WKWebViewConfiguration.new;
        webViewConfig.userContentController = userCC;
        CGRect frame = CGRectMake(0, XD_STATUSBAR_NAVBAR_HEIGHT, XD_SCREEN_WIDTH, XD_SCREEN_HEIGHT-XD_STATUSBAR_NAVBAR_HEIGHT);
        if (self.hiddenToolBar == NO) {//隐藏底部工具条
            frame = CGRectMake(0, XD_STATUSBAR_NAVBAR_HEIGHT, XD_SCREEN_WIDTH, XD_SCREEN_HEIGHT-XD_STATUSBAR_NAVBAR_HEIGHT-XD_SAVEAREA_BTM);
        }
        _webViewWK = [[WKWebView alloc] initWithFrame:frame configuration:webViewConfig];
        _webViewWK.UIDelegate = self;
        _webViewWK.navigationDelegate = self;
        _webViewWK.allowsBackForwardNavigationGestures = YES;
        //          _webViewWK.scrollView.backgroundColor = [UIColor colorWithHexString:@"#dabc68"];
        [self.view addSubview:_webViewWK];
    }
    return _webViewWK;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, XD_STATUSBAR_NAVBAR_HEIGHT, XD_SCREEN_WIDTH, .5)];
        _progressView.progressViewStyle = UIProgressViewStyleBar;
        _progressView.trackTintColor = [UIColor clearColor];
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"backBtnUnSelected"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"backBtnSelected"] forState:UIControlStateSelected];
        _backBtn.frame = CGRectMake(0, 0, 30, 30);
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setImage:[UIImage imageNamed:@"nextBtnUnSelected"] forState:UIControlStateNormal];
        [_nextBtn setImage:[UIImage imageNamed:@"nextBtnSelected"] forState:UIControlStateSelected];
        _nextBtn.frame = CGRectMake(0, 0, 30, 30);
        [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}




-(void)leftButtonEvent:(UIButton *)sender navigationBar:(XDNavigationBar *)navigationBar {
    if (self.webViewWK.canGoBack) {
        [self.webViewWK goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightButtonEvent:(UIButton *)sender navigationBar:(XDNavigationBar *)navigationBar {
    
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
