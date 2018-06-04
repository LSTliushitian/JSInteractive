//
//  LSTJumpTestVC.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/8.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
