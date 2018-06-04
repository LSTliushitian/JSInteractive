//
//  WebViewJSBridgeVC.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/9.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "WebViewJSBridgeVC.h"
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>

@interface WebViewJSBridgeVC ()<WKNavigationDelegate>

@property (strong, nonatomic) WKWebView * webView;
@property (strong, nonatomic) WebViewJavascriptBridge * bridge;

@end

@implementation WebViewJSBridgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        NSString * path = [[NSBundle mainBundle] pathForResource:@"example" ofType:@"html"];
        NSString * htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSURL * htmlUrl = [NSURL fileURLWithPath:path];
        [_webView loadHTMLString:htmlStr baseURL:htmlUrl];
        
        _webView.navigationDelegate = self;
        
        _webView;
    })];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    [self JS2OC];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self OC2JS];
    });
}

- (void) JS2OC {
    [_bridge registerHandler:@"loginAction" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary * dataDic = (NSDictionary *) data;
        NSLog(@">>>%@", dataDic);
        
        responseCallback(@"啦啦啦啦啦");
    }];
}

- (void) OC2JS {
    [_bridge callHandler:@"registerAction" data:@"uid:123 pwd:123" responseCallback:^(id responseData) {
        NSLog(@"%@", responseData);
    }];
}

@end
