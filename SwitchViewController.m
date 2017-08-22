//
//  SwitchViewController.m
//  NewKuangJia
//
//  Created by fyaex001 on 2017/1/6.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "SwitchViewController.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"
#import "RootViewController.h"
#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "ForgetNextViewController.h"
#import "RegisterViewController.h"
#import "RegisterNextViewController.h"
#import "WaitCheckViewController.h"
#import "CheckSuccessViewController.h"
#import "CheckDefeatedViewController.h"
#import "MyselfDetailViewController.h"
#import "RestPwdViewController.h"
#import "BaseWebViewViewController.h"
#import "BaseWkWebViewController.h"
#import "SearchWebViewViewController.h"


@interface SwitchViewController()

{
    UINavigationController __weak* _topNavigationController;
    NSCache *_cacher;
}

@property(nonatomic, weak) UINavigationController *topNavigationController;
@property(nonatomic, strong) MBProgressHUD *hud;
@property(nonatomic, strong) MBProgressHUD *showMessage;

@end

@implementation SwitchViewController



+(instancetype)sharedSVC
{
    static SwitchViewController *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [SwitchViewController new];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cacher = [[NSCache alloc] init];
        //发出通知监听内存警告
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

//当发出内存警告，就释放缓存中的数据
-(void)didReceiveMemoryWarning
{
    [_cacher removeAllObjects];
}

-(void)hideHud
{
    [self.hud hide:YES];
}

-(void)hideLoadingView
{
    [_showMessage hide:YES];
}

-(void)hideHudAfterDelay:(NSTimeInterval)delay
{
    [self.hud hide:YES afterDelay:delay];
}


-(MBProgressHUD *)hud
{
    if (!_hud) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _hud = [[MBProgressHUD alloc] initWithWindow:keyWindow];
        _hud.detailsLabelFont = [UIFont systemFontOfSize:16];
        self.hud.animationType = MBProgressHUDAnimationZoomIn;
        self.hud.cornerRadius = 5;
        [keyWindow addSubview:self.hud];
    }
    return _hud;
}

-(void)showMessage:(NSString *)message
{
    [self showMessage:message duration:2.0];
}

-(void)showMessage:(NSString *)message duration:(NSTimeInterval)time
{
    self.hud.mode = MBProgressHUDModeText;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:time];
}

-(void)setHudMessage:(NSString *)message
{
    self.hud.detailsLabelText = message;
}


-(void)showLoadingWithMessage:(NSString *)message
{
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
}



-(void)showLoadingWithMessage:(NSString *)message inView:(UIView *)view
{
    [_showMessage removeFromSuperview];
    
    _showMessage = [[MBProgressHUD alloc] initWithView:view];
    
    [view addSubview:_showMessage];
    
    _showMessage.labelText = message;
    [_showMessage show:YES];
}



-(void)pushReuseObject:(NSObject *)obj
{
    NSString *key = NSStringFromClass(obj.class);
    NSCache *cache = [_cacher objectForKey:key];
    if (!cache) {
        cache = [[NSCache alloc] init];
        //当缓存的数量超过countLimit，或者cost之和超过totalCostLimit，NSCache会自动释放部分缓存。
        [cache setCountLimit:1];
        [_cacher setObject:cache  forKey:key];
    }
    [cache setObject:obj forKey:key];
}

-(void)presentViewController:(BaseViewController *)vc
{
    UINavigationController *nav =[self aNavigationControllerWithRootViewController:vc];
    //模态视图的动画效果
    //    nav.modalPresentationStyle = UIModalPresentationCustom;
    //    nav.transitioningDelegate = [TXTransition sharedtransition];
    
    [self.topNavigationController presentViewController:nav animated:YES completion:NULL];
    self.topNavigationController = nav;
}


-(void)presentViewController:(BaseViewController *)vc withObjects:(NSDictionary *)intentDic
{
    vc.intentDic = intentDic;
    
    [self presentViewController:vc];
}


-(void)setTopNavigationController:(UINavigationController *)topNavigationController
{
    if ([topNavigationController isKindOfClass:[UINavigationController class]]) {
        
        _topNavigationController = topNavigationController;
    }else {
        
        _topNavigationController = nil;
    }
}




#pragma mark --getters

-(UINavigationController *)topNavigationController {
    if (!_topNavigationController) {
        _topNavigationController = self.rootNaviController;
        if (!_topNavigationController) {
            return nil;
        }
        UINavigationController* vc = (UINavigationController*)_topNavigationController.presentedViewController;
        while (vc) {
            _topNavigationController = vc;
            //此视图控制器的视图控制器或其最近的祖先。
            vc = (UINavigationController*)_topNavigationController.presentedViewController;
        }
    }
    
    
    return _topNavigationController;
}


@synthesize rootNaviController = _rootNaviController;

-(UINavigationController *)rootNaviController
{
    if (!_rootNaviController) {
        
        RootViewController *vc=[[RootViewController alloc] init];
        _rootNaviController = [self aNavigationControllerWithRootViewController:vc];
    }
    return _rootNaviController;
}



-(UINavigationController *)aNavigationControllerWithRootViewController:(BaseViewController *)vc
{
    UINavigationController *navi=[[UINavigationController alloc] init];
    [navi pushViewController:vc animated:NO];
    return navi;
}

-(void)pushViewController:(BaseViewController *)vc
{
    [self.topNavigationController pushViewController:vc animated:YES];
}

-(void)pushViewController:(BaseViewController *)vc withObjects:(NSDictionary *)intentDic
{
    vc.intentDic = intentDic;
    [self pushViewController:vc];
}


-(void)popToViewController:(UIViewController *)vc
{
    [self.topNavigationController popToViewController:vc animated:YES];
}

//推出一个视图
-(BaseViewController *)popViewController
{
    BaseViewController *vc =(BaseViewController *)[self.topNavigationController popViewControllerAnimated:YES];
    if (vc.canBeCached) {
        
        [self pushReuseObject:vc];
    }
    return vc;
}

//重新进入一个视图，并且释放缓存
-(NSObject *)popReuseObjectForClass:(Class)class
{
    //把class类型转换成NString,就是获取class的类名
    NSString *key = NSStringFromClass(class);
    
    NSCache *cache = [_cacher objectForKey:key];
    NSObject *obj = [cache objectForKey:key];
    [cache removeObjectForKey:key];
    return obj;
    
}

-(void)dismissTopViewControllerCompletion:(void (^)(void))completion
{
    UINavigationController* navi = (UINavigationController*)self.topNavigationController.presentingViewController;
    NSArray* vcs = self.topNavigationController.viewControllers;
    
    [self.topNavigationController dismissViewControllerAnimated:YES completion:^{
        [vcs enumerateObjectsUsingBlock:^(BaseViewController *vc, NSUInteger idx, BOOL *stop) {
            if ([vc respondsToSelector:@selector(canBeCached)]) {
                if ([vc canBeCached]) {
                    [self pushReuseObject:vc];
                }
            }
        }];
        self.topNavigationController = navi;
        if (completion) {
            completion();
        }
    }];
    
}



#pragma mark -------跳转界面-----
-(BaseViewController *)loginViewController
{
  
    LoginViewController *vc = (LoginViewController *)[self popReuseObjectForClass:[LoginViewController class]];
    if (!vc) {
        
        vc = [[LoginViewController alloc] init];
    }
    return vc;
}

//忘记密码界面
-(BaseViewController *)forgetViewController
{
    ForgetViewController *vc = (ForgetViewController *)[self popReuseObjectForClass:[ForgetViewController class]];
    if (!vc) {
        
        vc = [[ForgetViewController alloc] init];
    }
    return vc;
}
//忘记密码下一步
-(BaseViewController *)forgetNextViewController
{
    ForgetNextViewController *vc = (ForgetNextViewController *)[self popReuseObjectForClass:[ForgetNextViewController class]];
    if (!vc) {
        
        vc = [[ForgetNextViewController alloc] init];
    }
    return vc;
}
//注册界面
-(BaseViewController *)registerViewController
{
    RegisterViewController *vc = (RegisterViewController *)[self popReuseObjectForClass:[RegisterViewController class]];
    if (!vc) {
        
        vc = [[RegisterViewController alloc] init];
    }
    return vc;
}

//注册界面下一步
-(BaseViewController *)registerNextViewController
{
    RegisterNextViewController *vc = (RegisterNextViewController *)[self popReuseObjectForClass:[RegisterNextViewController class]];
    if (!vc) {
        
        vc = [[RegisterNextViewController alloc] init];
    }
    return vc;
}

//等待审核
-(BaseViewController *)waitCheckViewController
{
    WaitCheckViewController *vc = (WaitCheckViewController *)[self popReuseObjectForClass:[WaitCheckViewController class]];
    if (!vc) {
        
        vc = [[WaitCheckViewController alloc] init];
    }
    return vc;
}


//审核成功
-(BaseViewController *)checkSuccessViewController
{
    CheckSuccessViewController *vc = (CheckSuccessViewController *)[self popReuseObjectForClass:[CheckSuccessViewController class]];
    if (!vc) {
        
        vc = [[CheckSuccessViewController alloc] init];
    }
    return vc;
}

//审核失败
-(BaseViewController *)checkDefeatedViewController
{
    CheckDefeatedViewController *vc = (CheckDefeatedViewController *)[self popReuseObjectForClass:[CheckDefeatedViewController class]];
    if (!vc) {
        
        vc = [[CheckDefeatedViewController alloc] init];
    }
    return vc;
}

//个人基本资料
-(BaseViewController *)myselfDetailViewController
{
    MyselfDetailViewController *vc = (MyselfDetailViewController *)[self popReuseObjectForClass:[MyselfDetailViewController class]];
    if (!vc) {
        
        vc = [[MyselfDetailViewController alloc] init];
    }
    return vc;
}
//修改密码 
-(BaseViewController *)restPwdViewController
{
    RestPwdViewController *vc = (RestPwdViewController *)[self popReuseObjectForClass:[RestPwdViewController class]];
    if (!vc) {
        
        vc = [[RestPwdViewController alloc] init];
    }
    return vc;
}

-(BaseViewController *)baseWebViewViewController
{
    
    BaseWebViewViewController *vc = (BaseWebViewViewController *)[self popReuseObjectForClass:[BaseWebViewViewController class]];
    
    if (!vc) {
        
        vc = [[BaseWebViewViewController alloc] init];
    }
    return vc;
}




-(BaseViewController *)baseWkWebViewController
{
    BaseWkWebViewController *vc = (BaseWkWebViewController *)[self popReuseObjectForClass:[BaseWkWebViewController class]];
    
    if (!vc) {
        
        vc = [[BaseWkWebViewController alloc] init];
    }
    return vc;
}

//
-(BaseViewController *)searchWebViewViewController
{
    SearchWebViewViewController *vc = (SearchWebViewViewController *)[self popReuseObjectForClass:[BaseWkWebViewController class]];
    
    if (!vc) {
        
        vc = [[SearchWebViewViewController alloc] init];
    }
    return vc;
}




@end
