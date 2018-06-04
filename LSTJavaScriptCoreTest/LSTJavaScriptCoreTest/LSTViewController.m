//
//  LSTViewController.m
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/9.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import "LSTViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface LSTViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LSTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    MJRefreshGifHeader * header = [[MJRefreshGifHeader alloc] init];
    [header setImages:@[[UIImage imageNamed:@"0"], [UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]] duration:3.0 forState:MJRefreshStateRefreshing];
    header.refreshingTarget = self;
    header.refreshingAction = @selector(refreshAction);
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
}

- (void) refreshAction {
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

@end
