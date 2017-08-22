//
//  WebViewJS.m
//  CRFN
//
//  Created by zlkj on 2017/3/3.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "WebViewJS.h"

@implementation WebViewJS

//到登录界面
-(void)goLogin
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(goLoginJS)]) {
            
            [self.delegate goLoginJS];
        }
        
    });
}

//获取token值
-(void)getToken
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(getTokenJS)]) {
            
            [self.delegate getTokenJS];
        }
        
    });
}


//获取省份id
-(void)getProv
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(getProvJS)]) {
            
            [self.delegate getProvJS];
        }
        
    });
}

//切换省份Id
-(void)setProv:(NSString *)proId
{
    dispatch_async(dispatch_get_main_queue(), ^{
    
        if ([self.delegate respondsToSelector:@selector(setProvJS:)]) {
            
            [self.delegate setProvJS:proId];
        }
        
    });
}

//拨打电话
-(void)callphone:(NSString *)phone
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(callphoneJS:)]) {
            
            [self.delegate callphoneJS:phone];
        }
        
    });
}

//支付宝支付
-(void)zfb_pay:(NSString *)sign
{
    dispatch_async(dispatch_get_main_queue(), ^{
    
        if ([self.delegate respondsToSelector:@selector(zfb_payJS:)]) {
            
            [self.delegate zfb_payJS:sign];
        }
        
        
    });
}


//上传单张图片
-(void)get_photo
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(get_photoJS)]) {
            
            [self.delegate get_photoJS];
        }
        
    });
}


//加载中
-(void)loading;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(loadingJS)]) {
            
            [self.delegate loadingJS];
        }
        
    });
}

//结束加载
-(void)closeLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(closeLoadingJS)]) {
            
            [self.delegate closeLoadingJS];
        }
        
    });
}

//选择物流的方法
-(void)go_NativeSite
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(go_NativeSiteJS)]) {
            
            [self.delegate go_NativeSiteJS];
        }
        
    });
}

//上传图片
-(void)get_mul_photo:(NSString *)indexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([self.delegate respondsToSelector:@selector(get_mul_photoJS:)]) {
            
            [self.delegate get_mul_photoJS:indexPath];
        }
        
    });
}

-(void)wx_pay:(NSString *)payStr
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.delegate respondsToSelector:@selector(wx_payJS:)]) {
            
            [self.delegate wx_payJS:payStr];
        }
        
    });
}




@end
