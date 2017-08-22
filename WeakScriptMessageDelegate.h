//
//  WeakScriptMessageDelegate.h
//  CRFN
//
//  Created by zlkj on 2017/4/11.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WKScriptMessageHandler.h>

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property(nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;
-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>) scriptDelegate;

@end
