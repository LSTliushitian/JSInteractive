//
//  LSTJSTestViewController.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/10.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "LSTJSTestViewController.h"

@interface LSTJSTestViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LSTJSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView.delegate = self;
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://47.92.138.97/smbjd/testios.html"]]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://47.92.138.97/smbjd/sendMail.html"]]];
    
//    NSString * fileStr = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:fileStr]]];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //打印异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@">>>>%@", exception);
    };
    
    self.context[@"tianbai"] = self;
    
    self.context[@"Callback"] = ^{
        NSLog(@"噜噜噜噜");
    };
    
    [self.context[@"setphone"] callWithArguments:nil];
    
}

- (void)call {
    NSLog(@"啦啦啦啦");
    
    JSValue * callback = self.context[@"alerCallback"];
    [callback callWithArguments:nil];
    
//    JSValue * callback2 = self.context[@"Callback"];
//    [callback2 callWithArguments:@[@"..."]];
    
}

@end
