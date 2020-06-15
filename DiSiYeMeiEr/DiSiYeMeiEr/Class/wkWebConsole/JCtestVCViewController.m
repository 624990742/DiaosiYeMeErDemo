//
//  JCtestVCViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/6/15.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCtestVCViewController.h"
#import "SKWebView.h"
#import "WKWebViewConfiguration+Console.h"
@interface JCtestVCViewController ()<WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) SKWebView *webView;

@end

@implementation JCtestVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.showConsole = YES;

    self.webView = [[SKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2) configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
}



// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSString * jsStr = [NSString stringWithFormat:@"testMethon('%@')",@"西贝先生"];
        [self.webView  evaluateJavaScript:jsStr completionHandler:nil];
   
}

// 页面加载完毕时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

//   NSString * jsStr = [NSString stringWithFormat:@"testMethon('%@')",@"西贝先生"];
//    [self.webView  evaluateJavaScript:jsStr completionHandler:nil];
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
