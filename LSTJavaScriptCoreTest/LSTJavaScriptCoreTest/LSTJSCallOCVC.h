;//
//  LSTJSCallOCVC.h
//  LSTJavaScriptCoreTest
//
//  Created by 兰科 on 2018/5/8.
//  Copyright © 2018年 兰科guagua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSTestExport <JSExport>

JSExportAs(calculateForJS,
- (void) ocCalculateValue:(NSNumber *) value ForJS:(NSString *) jsStr
);

- (void) pushViewController:(NSString *)vc Title:(NSString *)vc;

- (void) getAlert:(NSString *) alert;

@end

@interface LSTJSCallOCVC : UIViewController<UIWebViewDelegate, JSTestExport>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) JSContext * context;

@end
