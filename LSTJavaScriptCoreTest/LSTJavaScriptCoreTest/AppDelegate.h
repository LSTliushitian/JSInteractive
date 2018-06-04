//
//  AppDelegate.h
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/7.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

