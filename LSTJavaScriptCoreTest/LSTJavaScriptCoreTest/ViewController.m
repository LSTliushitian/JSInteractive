//
//  ViewController.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/7.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "ViewController.h"
#import "LSTJSCallOCVC.h"
#import "LSTOCCallJSVC.h"
#import "LSTWKWebView.h"
#import "LSTViewController.h"
#import "WebViewJSBridgeVC.h"
#import "LSTJSTestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - ButtonClick
- (IBAction)JSCallOCButtonClick:(id)sender {
    LSTJSCallOCVC * vc = [[LSTJSCallOCVC alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)OCCallJSButtonClick:(id)sender {
    LSTOCCallJSVC * vc = [[LSTOCCallJSVC alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (IBAction)WKWebViewButtonClick:(id)sender {
    LSTWKWebView * vc = [[LSTWKWebView alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)MJRefreshButtonClick:(id)sender {
    LSTViewController * vc = [[LSTViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)WebViewJSBridgeButtonClick:(id)sender {
    WebViewJSBridgeVC * bridgeVC = [[WebViewJSBridgeVC alloc] init];
    [self.navigationController pushViewController:bridgeVC animated:YES];
}

- (IBAction)JSTestButtonClick:(id)sender {
    LSTJSTestViewController * jsTestVC = [[LSTJSTestViewController alloc] init];
    [self.navigationController pushViewController:jsTestVC animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
