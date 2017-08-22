//
//  AppDelegate.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "SwitchViewController.h"
#import "IQKeyboardManager.h"
#import "WXApiManager.h"
#import "BaseWkWebViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //把状态栏的中的颜色改为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
  
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    self.window = _window;
    
    _window.rootViewController = [[SwitchViewController sharedSVC] rootNaviController];
    
    
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLIos]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        if([responseObject[@"is_verify"] intValue] ==1){
            
            
            
        }else{
            
         
            
            if (![AppDataManager defaultManager].hasLogin) {
                
                [[SwitchViewController sharedSVC] presentViewController:[SwitchViewController sharedSVC].loginViewController];
                
            }
            
            
            
        }
        
        
    } progress:^(NSProgress *progress) {
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

        
//        if (![AppDataManager defaultManager].hasLogin) {
//            
//            [[SwitchViewController sharedSVC] presentViewController:[SwitchViewController sharedSVC].loginViewController];
//            
//        }
        
        
    }];
    
    
    
    
    
    
    
    
    //    // 初始化键盘管理控制器
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES; //控制整个功能是否启动
    manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
    manager.shouldToolbarUsesTextFieldTintColor = YES;//控制键盘上的工具条文字颜色是否用户自定义。
    manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条。
    
    
    //向微信注册wx24248ffbaba9ae77  
    [WXApi registerApp:@"wx24248ffbaba9ae77"];
    
    
    
    
    
    
    
    
    
    
    
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    
    
    
}

#pragma mark ----支付宝支付回调的方法----

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                //支付成功,这里放你们想要的操作
                //NSLog(@"支付成功了啊9.0");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Alipay" object:@{@"message":@"支付成功"}];
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Alipay" object:@{@"message":@"取消支付"}];
                
            }else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Alipay" object:@{@"message":@"支付失败"}];
            }
            
        }];
        return YES;
    }else{
        
        //        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
        //        return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    
}






// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                //支付成功,这里放你们想要的操作
                //NSLog(@"支付成功了啊9.0");
                
                NSString *result = resultDic[@"result"];
                NSError *error = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: [result dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options: NSJSONReadingMutableContainers
                                                                      error: &error];
                
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Alipay" object:self userInfo:@{@"message":@"支付成功"}];
                
            }else if ([resultDic[@"resultStatus"] isEqualToString:@"6001"]){
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Alipay" object:self userInfo:@{@"message":@"取消支付"}];
                
            }else{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Alipay" object:self userInfo:@{@"message":@"支付失败"}];
            }
            
        }];
        
        return YES;
    }else{
        
        //return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    
}



//让手机禁止横屏
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


//当程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
