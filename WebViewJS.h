//
//  WebViewJS.h
//  CRFN
//
//  Created by zlkj on 2017/3/3.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//JS方法
@protocol WebViewJSObjectProtocol <JSExport>


-(void)goLogin;  //到登录界面

-(void)getToken;  //传递token值

//获取省份id
-(void)getProv;

//切换省份Id
-(void)setProv:(NSString *)proId;

//拨打电话
-(void)callphone:(NSString *)phone;


//支付宝支付
-(void)zfb_pay:(NSString *)sign;

//上传单张图片
-(void)get_photo;

//加载中
-(void)loading;

//结束加载
-(void)closeLoading;


//选择物流的方法
-(void)go_NativeSite;

//上传图片
-(void)get_mul_photo:(NSString *)indexPath;

-(void)wx_pay:(NSString *)payStr;



@end



//代理方法
@protocol WebViewJSDelegate <NSObject>

//到登录界面
-(void)goLoginJS;

//传递token值
-(void)getTokenJS;


//获取省份id
-(void)getProvJS;

//切换省份Id
-(void)setProvJS:(NSString *)proId;

//拨打电话
-(void)callphoneJS:(NSString *)phone;

//支付宝支付
-(void)zfb_payJS:(NSString *)sign;


//上传单张图片
-(void)get_photoJS;

//加载中
-(void)loadingJS;

//结束加载
-(void)closeLoadingJS;

//选择物流的方法
-(void)go_NativeSiteJS;

//上传图片
-(void)get_mul_photoJS:(NSString *)indexPath;

-(void)wx_payJS:(NSString *)payStr;



@end

@interface WebViewJS : NSObject<WebViewJSObjectProtocol>

@property(nonatomic, weak) id<WebViewJSDelegate> delegate;


@end
