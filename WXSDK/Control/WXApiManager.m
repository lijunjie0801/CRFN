//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvMessageResponse:)]) {
            SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
            [_delegate managerDidRecvMessageResponse:messageResp];
        }
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAuthResponse:)]) {
            SendAuthResp *authResp = (SendAuthResp *)resp;
            [_delegate managerDidRecvAuthResponse:authResp];
        }
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvAddCardResponse:)]) {
            AddCardToWXCardPackageResp *addCardResp = (AddCardToWXCardPackageResp *)resp;
            [_delegate managerDidRecvAddCardResponse:addCardResp];
        }
    }else if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        /*
         按照微信SDKSample，在类实现onResp函数，支付完成后，微信APP会返回到商户APP并回调onResp函数，开发者需要在该函数中接收通知，判断返回错
         误码，如果支付成功则去后台查询支付结果再展示用户实际支付结果。注意
         一定不能以客户端返回作为用户支付的结果，应以服务器端的接收的支付通知或查询API返回的结果为准。
         */
        
//        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
//                strMsg = @"支付结果：成功!";
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[SwitchViewController sharedSVC] showMessage:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpay" object:nil];
                
                break;
        case WXErrCodeUserCancel:
                
                 [[SwitchViewController sharedSVC] showMessage:@"取消支付"];
//                 [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpay" object:nil];
                break;
                
            default:
                 [[SwitchViewController sharedSVC] showMessage:@"支付失败"];
//                 [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpay" object:nil];
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                strMsg = @"支付结果：失败!";
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//        [alert show];
//        [alert release];
    }

}

- (void)onReq:(BaseReq *)req {
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvGetMessageReq:)]) {
            GetMessageFromWXReq *getMessageReq = (GetMessageFromWXReq *)req;
            [_delegate managerDidRecvGetMessageReq:getMessageReq];
        }
    } else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvShowMessageReq:)]) {
            ShowMessageFromWXReq *showMessageReq = (ShowMessageFromWXReq *)req;
            [_delegate managerDidRecvShowMessageReq:showMessageReq];
        }
    } else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
        if (_delegate
            && [_delegate respondsToSelector:@selector(managerDidRecvLaunchFromWXReq:)]) {
            LaunchFromWXReq *launchReq = (LaunchFromWXReq *)req;
            [_delegate managerDidRecvLaunchFromWXReq:launchReq];
        }
    }
}

@end
