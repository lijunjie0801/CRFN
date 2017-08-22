//
//  SwitchViewController.h
//  NewKuangJia
//
//  Created by fyaex001 on 2017/1/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BaseViewController;
@interface SwitchViewController : NSObject

+(instancetype)sharedSVC;

@property(nonatomic ,readonly)UINavigationController *rootNaviController;

-(UINavigationController *)topNavigationController;


/**
 *  展示信息到window
 */
-(void)showMessage:(NSString *)message;
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;
-(void)setHudMessage:(NSString*)message;

-(void)showLoadingWithMessage:(NSString*)message;
-(void)hideHud;
-(void)hideHudAfterDelay:(NSTimeInterval)delay;

-(void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view;
-(void)hideLoadingView;

-(void)pushViewController:(BaseViewController*)vc;
-(void)pushViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;
-(BaseViewController*)popViewController;
-(void)popToViewController:(UIViewController *)vc;

-(void)presentViewController:(BaseViewController*)vc;

//跳转页面
-(void)presentViewController:(BaseViewController*)vc withObjects:(NSDictionary*)intentDic;

-(void)dismissTopViewControllerCompletion:(void (^)(void))completion;





//到登录界面
-(BaseViewController *)loginViewController;
//忘记密码界面
-(BaseViewController *)forgetViewController;
//忘记密码下一步
-(BaseViewController *)forgetNextViewController;
//注册
-(BaseViewController *)registerViewController;
//注册下一步
-(BaseViewController *)registerNextViewController;

//等待审核
-(BaseViewController *)waitCheckViewController;
//审核成功
-(BaseViewController *)checkSuccessViewController;
//审核失败
-(BaseViewController *)checkDefeatedViewController;
//个人基本信息
-(BaseViewController *)myselfDetailViewController;
//修改密码
-(BaseViewController *)restPwdViewController;

-(BaseViewController *)baseWebViewViewController;

-(BaseViewController *)baseWkWebViewController;

-(BaseViewController *)searchWebViewViewController;

-(BaseViewController *)baseWebViewView1Controller;








@end
