//
//  LSTOCCallJSVC.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/8.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "LSTOCCallJSVC.h"

@interface LSTOCCallJSVC ()

@end

@implementation LSTOCCallJSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"test.js"];
    NSString * jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:jsStr];

}

- (IBAction)ocCallJSButtonClick:(UIButton *)sender {
    JSValue * func = [self.context objectForKeyedSubscript:@"factorial"];
    JSValue * result = [func callWithArguments:@[@(arc4random()%10)]];
    
    [sender setTitle:[NSString stringWithFormat:@"%@", result] forState:UIControlStateNormal];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
