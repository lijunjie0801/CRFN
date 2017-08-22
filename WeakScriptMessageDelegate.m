//
//  WeakScriptMessageDelegate.m
//  CRFN
//
//  Created by zlkj on 2017/4/11.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate


-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        
        _scriptDelegate = scriptDelegate;
    }
    return self;
}


-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    
    
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}



@end
