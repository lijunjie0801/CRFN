//
//  BaseWkWebViewController.m
//  CRFN
//
//  Created by zlkj on 2017/3/4.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseWkWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJS.h"
#import "WeakScriptMessageDelegate.h"

@interface BaseWkWebViewController ()<WKNavigationDelegate, WKUIDelegate,WKScriptMessageHandler>


@property (strong, nonatomic) WKWebView *webView;

@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;
@property(nonatomic, strong) NSURL *url;

@property(nonatomic, strong) NSString *requestType;

//@property(nonatomic, strong) WebViewJS *webviewJs;



@end

@implementation BaseWkWebViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    _intentDic = intentDic;
    
    _url  = [NSURL URLWithString:_intentDic[@"url"]];
    _requestType = _intentDic[@"type"];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    self.title = @"列表";
    
    
    
//    //高端配置
//    //创建配置
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//    //    config.preferences.javaScriptEnabled = YES;
//    //    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
//    
//    //创建UserContentController(提供javaScript向webView发送消息的方法)
//    WKUserContentController *userContent = [[WKUserContentController alloc] init];
//    //添加消息处理，注意：self指代的是需要遵守WKScriptMessageHandler协议，结束时需要移除
//    //    [userContent addScriptMessageHandler:self name:@"obj.callphone"];
//    //将UserContentController设置到配置文件中
//    config.userContentController = userContent;
//    [config.userContentController addScriptMessageHandler:self name:@"obj"];
    
    
    NSString *sendToken = [NSString stringWithFormat:@"localStorage.setItem(\"accessToken\",'%@');",@"74851c23358c"];
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:sendToken injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
    
    
//    WeakScriptMessageDelegate *weakScript = [[WeakScriptMessageDelegate alloc] init];
//    weakScript.scriptDelegate = self
    
      WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"obj"];
    
    //注入js
    [config.userContentController addUserScript:wkUScript];
    
    
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    //对视图进行适配
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    
    

    
    
    
  


//    _webviewJs = [[WebViewJS alloc] init];
//    _webviewJs.delegate = self;
    
    [self createRequest];
    
}


//webview界面要带的协议头
-(void)createRequest
{
    
//    _url = [NSURL URLWithString:@"http://hc.hcsxj.cn/sindex/hcdjt"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:_url cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
    
//    if ([self.requestType isEqualToString:@"POST"]) {
//        
//        [req setHTTPMethod:@"POST"];
//    }else{
//        
//        [req setHTTPMethod:@"GET"];
//    }
    
    [req setHTTPMethod:@"GET"];
    
//    NSString *body = @"";
//    
//    body= [NSString stringWithFormat:@"token=%@",[AppDataManager defaultManager].identifier];
//
//    [req setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
//    
//
//    [req setValue:[AppDataManager defaultManager].identifier forHTTPHeaderField:@"TOKEN"];
//    
//    
//    if ([AppDataManager defaultManager].ProvinceId) {
//        
//        //把汉字转换成coding类型
//        NSString* string2 = [[AppDataManager defaultManager].ProvinceId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [req setValue:string2 forHTTPHeaderField:@"LOCATION"];
//        
//    }
    
    
    
    [self.webView loadRequest:req];
    
    
}


#pragma mark - WKNavigationDelegate

/**
 *  页面开始加载时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
    _weakProgressHUD = [MessageTool showProcessMessage:@"加载中..." view:self.view];
    
}

/**
 *  当内容开始返回时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  页面加载完成之后调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
    [_weakProgressHUD hide:YES];
    
    self.title = self.webView.title;
    

    
    
}

/**
 *  加载失败时调用
 *
 *  @param webView    实现该代理的webview
 *  @param navigation 当前navigation
 *  @param error      错误
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
  [_weakProgressHUD hide:YES];
    NSLog(@"%s", __FUNCTION__);
}

/**
 *  接收到服务器跳转请求之后调用
 *
 *  @param webView      实现该代理的webview
 *  @param navigation   当前navigation
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);

    
    
}









/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    
//    
//
//    
//    // 如果响应的地址是百度，则允许跳转
//    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//        
//        // 允许跳转
//        decisionHandler(WKNavigationResponsePolicyAllow);
//        return;
//    }
////    // 不允许跳转
//    decisionHandler(WKNavigationResponsePolicyCancel);
//}

/**
 *  在发送请求之前，决定是否跳转
 *
 *  @param webView          实现该代理的webview
 *  @param navigationAction 当前navigation
 *  @param decisionHandler  是否调转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
//    // 如果请求的是百度地址，则延迟5s以后跳转
//    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
//        
//        //        // 延迟5s之后跳转
//        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //
//        //            // 允许跳转
//        //            decisionHandler(WKNavigationActionPolicyAllow);
//        //        });
//        
//        // 允许跳转
//        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//    }
//    // 不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
    
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
//        
//        [_svc pushViewController:_svc.baseWkWebViewController withObjects:@{@"url":navigationAction.request.URL.absoluteString}];
//        
//        decisionHandler(WKNavigationActionPolicyAllow);
//        return;
//       
//    }
//    
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    
    
    
}




-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        
        [_svc pushViewController:_svc.baseWkWebViewController withObjects:@{@"url":navigationAction.request.URL.host.lowercaseString}];
        return [[WKWebView alloc] init];
    }
    
    return webView;
}



//-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
//{
//    
//    NSLog(@"message====%@",message.name);
//    
//    NSString *messageName = message.name;
//    //拨打电话
//    if ([@"callphone" isEqualToString:messageName]) {
//        id messageBody = message.body;
//        NSLog(@"%@",messageBody);
//    }
//}


- (void)callphone:(id)body {
    
    NSLog(@"%@",body);
    
    
    
    if ([body isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)body;
        // oc调用js代码
        NSString *jsStr = [NSString stringWithFormat:@"ocCallJS('%@')", [dict objectForKey:@"data"]];
        [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
            if (error) {
                NSLog(@"错误:%@", error.localizedDescription);
            }
        }];
    }
}


-(void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    
    NSLog(@"%@===",javaScriptString);
    NSLog(@"dfdsfdssf");
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"方法名:%@", message.name);
    NSLog(@"参数:%@", message.body);
    // 方法名
    NSString *methods = [NSString stringWithFormat:@"%@:", message.name];
    SEL selector = NSSelectorFromString(methods);
    // 调用方法
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:message.body];
    } else {
        NSLog(@"未实行方法：%@", methods);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
