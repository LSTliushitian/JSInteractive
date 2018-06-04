//
//  LSTJSTestViewController.h
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/10.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSTestExpert <JSExport>

- (void) call;

@end

@interface LSTJSTestViewController : UIViewController<JSTestExpert>

@property (strong, nonatomic) JSContext * context;

@end
