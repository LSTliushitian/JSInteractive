//
//  LSTWKWebView.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/9.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "LSTWKWebView.h"
#import "WKDelegateController.h"

@interface LSTWKWebView ()
{
    WKUserContentController * userContentController;
}

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation LSTWKWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册方法
    WKDelegateController * delegateController = [[WKDelegateController alloc] init];
    delegateController.delegate = self;
    
    userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:delegateController name:@"sayhello"];
    //window.webkit.messageHandlers.xxx.postMessage({body: 'xxx'});
    
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
//    NSString * path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"s.html"];
//    NSURL * url = [NSURL fileURLWithPath:path];
//    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //在发送请求之前，决定是否跳转
    NSLog(@"%@", navigationAction.request.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //在收到响应后,决定是否跳转
    NSLog(@"%@", navigationResponse.response.URL.absoluteString);
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    //页面开始加载时调用
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    //接收到服务器跳转请求之后调用
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    //页面加载失败时调用
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    //当内容开始返回时调用
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    //页面加载完成之后调用 OC call JS
    [webView evaluateJavaScript:@"say()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@", result);
    }];
    
    //取出cookie
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=([^;]*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";
    
    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *excuteJSString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        [JSCookieString appendString:excuteJSString];
    }
    //执行js
    [webView evaluateJavaScript:JSCookieString completionHandler:nil];
}

#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    //创建一个新的WKWebView
    return [[WKWebView alloc] init];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    //警告框
    NSLog(@"%@", message);
    completionHandler();
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    //确认框
    completionHandler(YES);
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    //输入框
    completionHandler(@"http");
}

#pragma mark - WKDelegate
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"name:%@\nbody:%@\n%@", message.name, message.body, message.frameInfo);
//    [userContentController removeScriptMessageHandlerForName:@"sayhello"];
}

@end
