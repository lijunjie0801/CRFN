//
//  UIWebView+JavaScriptAlert.h
//  GZB
//
//  Created by fyaex001 on 16/4/29.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScriptAlert)<UIAlertViewDelegate>


- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

- (NSString *) webView:(UIWebView *)view runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)text initiatedByFrame:(id)frame;

@end
