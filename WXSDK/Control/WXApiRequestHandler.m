//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 15/7/14.
//
//

#import "WXApi.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"
#import "WXMediaMessage+messageConstruct.h"

@implementation WXApiRequestHandler

#pragma mark - Public Methods
+ (BOOL)sendText:(NSString *)text
         InScene:(enum WXScene)scene {
    SendMessageToWXReq *req = [SendMessageToWXReq requestWithText:text
                                                   OrMediaMessage:nil
                                                            bText:YES
                                                          InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendImageData:(NSData *)imageData
              TagName:(NSString *)tagName
           MessageExt:(NSString *)messageExt
               Action:(NSString *)action
           ThumbImage:(UIImage *)thumbImage
              InScene:(enum WXScene)scene {
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:nil
                                                   Description:nil
                                                        Object:ext
                                                    MessageExt:messageExt
                                                 MessageAction:action
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    
    return [WXApi sendReq:req];
}

+ (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene {
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;

    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendMusicURL:(NSString *)musicURL
             dataURL:(NSString *)dataURL
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXMusicObject *ext = [WXMusicObject object];
    ext.musicUrl = musicURL;
    ext.musicDataUrl = dataURL;

    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:nil];
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    
    return [WXApi sendReq:req];
}

+ (BOOL)sendVideoURL:(NSString *)videoURL
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = videoURL;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendEmotionData:(NSData *)emotionData
             ThumbImage:(UIImage *)thumbImage
                InScene:(enum WXScene)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:thumbImage];
    
    WXEmoticonObject *ext = [WXEmoticonObject object];
    ext.emoticonData = emotionData;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendFileData:(NSData *)fileData
       fileExtension:(NSString *)extension
               Title:(NSString *)title
         Description:(NSString *)description
          ThumbImage:(UIImage *)thumbImage
             InScene:(enum WXScene)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:thumbImage];
    
    WXFileObject *ext = [WXFileObject object];
    ext.fileExtension = @"pdf";
    ext.fileData = fileData;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];
}

+ (BOOL)sendAppContentData:(NSData *)data
                   ExtInfo:(NSString *)info
                    ExtURL:(NSString *)url
                     Title:(NSString *)title
               Description:(NSString *)description
                MessageExt:(NSString *)messageExt
             MessageAction:(NSString *)action
                ThumbImage:(UIImage *)thumbImage
                   InScene:(enum WXScene)scene {
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = info;
    ext.url = url;
    ext.fileData = data;

    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:messageExt
                                                 MessageAction:action
                                                    ThumbImage:thumbImage
                                                      MediaTag:nil];
    
    SendMessageToWXReq* req = [SendMessageToWXReq requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];

}

+ (BOOL)addCardsToCardPackage:(NSArray *)cardItems {
    AddCardToWXCardPackageReq *req = [[[AddCardToWXCardPackageReq alloc] init] autorelease];
    req.cardAry = cardItems;
    return [WXApi sendReq:req];
}

+ (BOOL)sendAuthRequestScope:(NSString *)scope
                       State:(NSString *)state
                      OpenID:(NSString *)openID
            InViewController:(UIViewController *)viewController {
    SendAuthReq* req = [[[SendAuthReq alloc] init] autorelease];
    req.scope = scope; // @"post_timeline,sns"
    req.state = state;
    req.openID = openID;
    
    return [WXApi sendAuthReq:req
               viewController:viewController
                     delegate:[WXApiManager sharedManager]];
}

+ (BOOL)jumpToBizWebviewWithAppID:(NSString *)appID
                      Description:(NSString *)description
                        tousrname:(NSString *)tousrname
                           ExtMsg:(NSString *)extMsg {
    [WXApi registerApp:appID withDescription:description];
    JumpToBizWebviewReq *req = [[[JumpToBizWebviewReq alloc]init]autorelease];
    req.tousrname = tousrname;
    req.extMsg = extMsg;
    req.webType = WXMPWebviewType_Ad;
    return [WXApi sendReq:req];
}


+ (NSString *)jumpToBizPay {

    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
   
    
//    - (IBAction)weChatPayButtonAction:(id)sender
//    {
//        PayReq *request = [[PayReq alloc] init];
//        /** 商家向财付通申请的商家id */
//        request.partnerId = @"1220277201";
//        /** 预支付订单 */
//        request.prepayId= @"82010380001603250865be9c4c063c30";
//        /** 商家根据财付通文档填写的数据和签名 */
//        request.package = @"Sign=WXPay";
//        /** 随机串，防重发 */
//        request.nonceStr= @"lUu5qloVJV7rrJlr";
//        /** 时间戳，防重发 */
//        request.timeStamp= 1458893985;
//        /** 商家根据微信开放平台文档对数据做的签名 */
//        request.sign= @"b640c1a4565b476db096f4d34b8a9e71960b0123";
//        /*! @brief 发送请求到微信，等待微信返回onResp
//         *
//         * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
//         * SendAuthReq、SendMessageToWXReq、PayReq等。
//         * @param req 具体的发送请求，在调用函数后，请自己释放。
//         * @return 成功返回YES，失败返回NO。
//         */  
//        [WXApi sendReq: request];  
////    }
    
    
    //调起微信支付
//    PayReq* req             = [[[PayReq alloc] init]autorelease];
//    req.openID              = WXAppId;
//    req.partnerId           = WXPartnerId;
//    //                    req.prepayId            = [dict objectForKey:@"prepayid"];
//    //                    req.nonceStr            = [dict objectForKey:@"noncestr"];
//    //                    req.timeStamp           = stamp.intValue;
//    //                    req.package             = [dict objectForKey:@"package"];
//    //                    req.sign                = [dict objectForKey:@"sign"];
//    
//    /** 预支付订单 */
//    req.prepayId= @"82010380001603250865be9c4c063c30";
//    /** 商家根据财付通文档填写的数据和签名 */
//    req.package = @"Sign=WXPay";
//    /** 随机串，防重发 */
//    req.nonceStr= @"lUu5qloVJV7rrJlr";
//    /** 时间戳，防重发 */
//    req.timeStamp= 1458893985;
//    /** 商家根据微信开放平台文档对数据做的签名 */
//    req.sign= @"b640c1a4565b476db096f4d34b8a9e71960b0123";
//    
//    [WXApi sendReq:req];
    
    return nil;
    
//    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
//        //解析服务端返回json数据
//        NSError *error;
//        //加载一个NSURL对象
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//        //将请求的url数据放到NSData对象中
//        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
////        if ( response != nil) {
//            NSMutableDictionary *dict = NULL;
//            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
////            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//    
//            NSLog(@"url:%@",urlString);
//            if(dict != nil){
//                NSMutableString *retcode = [dict objectForKey:@"retcode"];
//                if (retcode.intValue == 0){
////                    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                    
//                    //调起微信支付
//                    PayReq* req             = [[[PayReq alloc] init]autorelease];
//                    req.openID              = WXAppId;
//                    req.partnerId           = WXPartnerId;
////                    req.prepayId            = [dict objectForKey:@"prepayid"];
////                    req.nonceStr            = [dict objectForKey:@"noncestr"];
////                    req.timeStamp           = stamp.intValue;
////                    req.package             = [dict objectForKey:@"package"];
////                    req.sign                = [dict objectForKey:@"sign"];
//                    
//                    /** 预支付订单 */
//                    req.prepayId= @"82010380001603250865be9c4c063c30";
//                    /** 商家根据财付通文档填写的数据和签名 */
//                    req.package = @"Sign=WXPay";
//                    /** 随机串，防重发 */
//                    req.nonceStr= @"lUu5qloVJV7rrJlr";
//                    /** 时间戳，防重发 */
//                    req.timeStamp= 1458893985;
//                    /** 商家根据微信开放平台文档对数据做的签名 */
//                    req.sign= @"b640c1a4565b476db096f4d34b8a9e71960b0123";
//                    
//                    [WXApi sendReq:req];
//                    //日志输出
////                    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//                    return @"";
//                }else{
//                    return [dict objectForKey:@"retmsg"];
//                }
////            }else{
////                return @"服务器返回错误，未获取到json对象";
////            }
////        }else{
////            return @"服务器返回错误";
////        }
}
@end
