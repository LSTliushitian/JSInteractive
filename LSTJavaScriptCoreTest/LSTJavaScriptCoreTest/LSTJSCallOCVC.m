//
//  LSTJSCallOCVC.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/8.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "LSTJSCallOCVC.h"
#import "SecondViewController.h"

@interface LSTJSCallOCVC ()


@end

@implementation LSTJSCallOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"JSCallOC.html"];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [_webView loadRequest:request];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick:)];
    
}

- (void) backItemClick:(UIButton *) sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //打印异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@">>>>%@", exception);
    };
    
    self.context[@"native"] = self;
    
    self.context[@"log"] = ^(NSString *str){
        NSLog(@"%@", str);
    };
}

#pragma JSTestExport
- (void) ocCalculateValue:(NSNumber *)value ForJS:(NSString *)jsStr {
    NSLog(@">>>%@>>>啦啦啦，不会算>>>%@", value, jsStr);
    
    [self.context[@"showResult"] callWithArguments:@[value]];
}

- (void) pushViewController:(NSString *)vc Title:(NSString *)vcTitle {
    Class jumpClass = NSClassFromString(vc);
    id jumpVC = [[jumpClass alloc] init];
    [self.navigationController presentViewController:jumpVC animated:YES completion:nil];
}

- (void)getAlert:(NSString *)alert {
    NSLog(@">>>>%@", alert);

    [self.context[@"alertAction"] callWithArguments:@[@"汪汪汪"]];
}

@end
