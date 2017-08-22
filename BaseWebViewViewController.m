//
//  BaseWebViewViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseWebViewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJS.h"
#import "FeThreeDotGlow.h"
#import "UIWebView+JavaScriptAlert.h"
#import "WXApiRequestHandler.h"
#import "WXApi.h"

@interface BaseWebViewViewController ()<UIWebViewDelegate,WebViewJSDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>


@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;
@property(nonatomic, strong) NSURL *url;

@property(nonatomic, strong) NSString *requestType;

@property(nonatomic, strong) WebViewJS *webviewJs;

@property(nonatomic, strong) NSString *isOpen;

@property(nonatomic, strong) NSString *cids;

@property(nonatomic, strong) NSString *cidType;

@property(nonatomic, strong) FeThreeDotGlow *threeDot;

@property(nonatomic, strong)UIImagePickerController *imagePicker;

@property(nonatomic, strong) NSString *requestUrl;

@property(nonatomic, strong) NSString *indexpath;

@end

@implementation BaseWebViewViewController




-(void)setIntentDic:(NSDictionary *)intentDic
{
    _intentDic = intentDic;
    
    self.url  = [NSURL URLWithString:intentDic[@"url"]];
    _requestUrl=_intentDic[@"url"];
    
    _requestType = _intentDic[@"type"];
    _isOpen = _intentDic[@"isOpen"];
    _cids = _intentDic[@"cids"];
    _cidType = _intentDic[@"cidType"];
    
  
    


}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self showBackItems];
    
    
    
    if ([_intentDic[@"url"] rangeOfString:@"/ucenter/orderlist_view?os="].location != NSNotFound) {
        
        //条件为真
        [self showRightSearchItem];
        
    }
    
    
    
    
    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    
    //对视图进行适配
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //web网页会根据屏幕大小进行自动缩放
    _webView.scalesPageToFit = NO;
//    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:_webView];
    
    _webviewJs = [[WebViewJS alloc] init];
    _webviewJs.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aliPaylNotic:) name:@"Alipay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXPaylNotic) name:@"WXpay" object:nil];

    
    
    
    [self createRequest];
    
    
    _threeDot = [[FeThreeDotGlow alloc] initWithView:self.view blur:NO];
    _threeDot.center = CGPointMake(WIDTH/2, (HEIGHT-64-44)/2);
    _threeDot.hidden = YES;
    [self.view addSubview:_threeDot];
    
}


//webview界面要带的协议头
-(void)createRequest
{
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:_url cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
    
    if ([self.requestType isEqualToString:@"POST"]) {
        
        [req setHTTPMethod:@"POST"];
    }else{
    
        [req setHTTPMethod:@"GET"];
    }


    
    NSString *body = @"";
    
//     body= [NSString stringWithFormat:@"token=%@",[AppDataManager defaultManager].identifier];
    if (self.cids.length>0) {
        
        body= [NSString stringWithFormat:@"carIds=%@",_cids];
        [req setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    }
//    if (self.cidType.length>0) {
//        
//         body= [NSString stringWithFormat:@"token=%@&cid=%@",[AppDataManager defaultManager].identifier,self.cidType];
//    }
//    
//  
//    
   
    

    

    
    
    
    if ([AppDataManager defaultManager].identifier.length>0) {
        
        [req setValue:[AppDataManager defaultManager].identifier forHTTPHeaderField:@"TOKEN"];
        
    }
    

    
    
    
    
    if ([AppDataManager defaultManager].ProvinceId) {
        
        //把汉字转换成coding类型
        NSString* string2 = [[AppDataManager defaultManager].ProvinceId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [req setValue:string2 forHTTPHeaderField:@"LOCATION"];
    
    }
    
    
    
   
    
    [self.webView loadRequest:req];
    
    
}


//微信支付跳转
-(void)WXPaylNotic
{
    NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    if (tempVCA.count!=0 && tempVCA!=nil) {
        
        
        for (int i = (int)tempVCA.count-1; i>0; i--) {
            
            [tempVCA removeObjectAtIndex:i];
        }
        
        self.navigationController.viewControllers = tempVCA;
    }
    
    //全部订单
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAllDingdan],@"type":@"POST"}];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"4"}];
}





//支付宝支付跳转的界面
-(void)aliPaylNotic:(NSNotification *)notic {
    
    
    
    NSDictionary *nameDictionary = [notic userInfo];
    
    NSString *message = [nameDictionary objectForKey:@"message"];
    

    
        
    [_svc showMessage:message];
    
    
    NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    if (tempVCA.count!=0 && tempVCA!=nil) {
        
        
        for (int i = (int)tempVCA.count-1; i>0; i--) {
            
            [tempVCA removeObjectAtIndex:i];
        }
        
        self.navigationController.viewControllers = tempVCA;
    }
    
    //全部订单
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAllDingdan],@"type":@"POST"}];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"4"}];
    
 
    
    
    

}



#pragma mark -WebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    

//    NSLog(@"url===========%@，=========%ld",[request URL].absoluteString,(long)navigationType);
//
//    
//    
//    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//        
//        NSString *url = [request URL].absoluteString;
//        
//        NSLog(@"=======================走了跳转的方法了UIWebViewNavigationTypeLinkClicked");
//        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url}];
//        
//        return NO;
//    }
//    
//    
//    NSLog(@"=============%@",self.isOpen);
//    //判断是否单击
//    if (navigationType == UIWebViewNavigationTypeOther && [_isOpen isEqualToString:@"1"] ) {
//
//        NSString *url = [request URL].absoluteString;
//        
//         NSLog(@"=======================走了跳转的方法了UIWebViewNavigationTypeOther");
//        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
//        
//        return NO;
//    }
//    
//    self.isOpen = @"1";
    
       NSString *url = [request URL].absoluteString;
    
    
       NSLog(@"url========%@",url);
    
    if ([_isOpen intValue] ==0) {
        
        
        _isOpen = @"1";
        
    }else{
    
    
        if ([url rangeOfString:@"order/paytype_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"order/offline_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"ucenter/order_detail_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"news_detail_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"order/comment_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"goods/intro_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"order/goods-details"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"credits/jifen-sorts"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"credits/jifen-order-list"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"credits/jifen-shop-car"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        
        if ([url rangeOfString:@"credits/jifen-list"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"ucenter/credits_intro_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"credits/goodslist_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"order/order_fromby_view"].location != NSNotFound ) {
            
            
            NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
            
            if (tempVCA.count!=0 && tempVCA!=nil) {
                
                
                for (int i = (int)tempVCA.count-1; i>tempVCA.count-3; i--) {
                    
                    [tempVCA removeObjectAtIndex:i];
                }
                
                
                
                self.navigationController.viewControllers = tempVCA;
            }
            
            
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"ucenter/mycredits_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"ucenter/order_addr_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"credits/credits_orderlist_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"credits/credits_car_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"credits/goodsdetail_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"order/banknote_ok_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"ucenter/orderlist_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"goods/tg_intro_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"order/order_frombytg_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
        if ([url rangeOfString:@"goods/sel_kf_view"].location != NSNotFound ) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
            
            return NO;
        }
    
    }
   
    
    return YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    _weakProgressHUD = [MessageTool showProcessMessage:@"加载中..." view:self.view];
    _threeDot.hidden = NO;
    [_threeDot show];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [_weakProgressHUD hide:YES];
    _threeDot.hidden = YES;
    [_threeDot dismiss];
    
    //获取网页的标题
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //调用js
    context[@"obj"]=self.webviewJs;
    
    
    if ([AppDataManager defaultManager].identifier) {
        
         [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"saveToken('%@');",[AppDataManager defaultManager].identifier]];
    }
    
    if ([AppDataManager defaultManager].ProvinceId) {
        
           [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"receive('%@');",[AppDataManager defaultManager].ProvinceId]];
    }
    
   
    
  
    
    
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [_weakProgressHUD hide:YES];
    
    
    
//    [_svc showMessage:error.domain];
    
    NSLog(@"%@",error);
    _threeDot.hidden = YES;
     [_threeDot dismiss];
    
//    if ([error code] == NSURLErrorCannotParseResponse) {
//        
////        [self createRequest];
//        
//    }
    
    
    
}






#pragma mark  ----WebviewJSDelegate------
-(void)goLoginJS
{
    NSMutableArray *temArr = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    if (temArr!=nil && temArr.count!=0) {
        
        for (int i= (int)temArr.count-1; i>0; i--) {
            
            [temArr removeObjectAtIndex:i];
        }
        self.navigationController.viewControllers = temArr;
    }
    
    [_svc presentViewController:_svc.loginViewController];
  
}


//获取token值
-(void)getTokenJS
{
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"saveToken('%@');",[AppDataManager defaultManager].identifier]];
}
//获取省份的id
-(void)getProvJS
{
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"receive('%@');",[AppDataManager defaultManager].ProvinceId]];
}


//保持省份id
-(void)setProvJS:(NSString *)proId
{
    [[AppDataManager defaultManager] setProvinceId:proId];
}

//拨打电话
-(void)callphoneJS:(NSString *)phone
{
    NSString *phoneStr = phone;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:phoneStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)get_mul_photoJS:(NSString *)indexPath
{
    self.indexpath = indexPath;
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.editing = YES;
    
    _imagePicker.delegate = self;
    
    _imagePicker.allowsEditing = YES;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"相册", nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    sheet.tag = 200;
    
    [sheet showInView:self.view];
}



//上传图片
-(void)get_photoJS
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.editing = YES;
    
    _imagePicker.delegate = self;
    
    _imagePicker.allowsEditing = YES;
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"相册", nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    sheet.tag = 100;
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag ==100) {
        
        _imagePicker.view.tag = 100;
        if (buttonIndex == 0) {
            
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:_imagePicker animated:YES completion:nil];
            
        }else if (buttonIndex ==1){
            
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_imagePicker animated:YES completion:nil];
        }else{
            
            //取消
        }
        
    }
    
    if (actionSheet.tag == 200) {
        
        _imagePicker.view.tag =200;
        if (buttonIndex == 0) {
            
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_imagePicker animated:YES completion:nil];
            
        }else if (buttonIndex ==1){
            
            _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_imagePicker animated:YES completion:nil];
        }else{
            
            //取消
        }
        
    }
    
   
}


#pragma mark  --UImagePickerControllerDelegate
//选择图片完成后调用的方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    //通过info字典获取选择的照片
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    
    //把一张图片保存到图库中，此时无论是这张照片是照相机拍的还是本身从图库中取出的，都会保存到图库中;
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
//    CGSize imagesize = image.size;
//    imagesize.height =300;
//    imagesize.width =350;
//    //对图片大小进行压缩--
//    image = [self imageWithImage:image scaledToSize:imagesize];
    
    
    //压缩图片，如果图片要上传到服务器或者网络，子需要执行该步骤(压缩),第二个参数是压缩比例，转化为NsData类型
    NSData *fileData = UIImageJPEGRepresentation(image, 0.7);
    
    // 对于base64编码编码
    NSString *headImageString=[fileData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    if (picker.view.tag == 100) {
        
         [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"savePhoto('%@');",headImageString]];
    }
    
    if (picker.view.tag == 200) {
        
         [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@" saveMulPhoto('%@','%@');",headImageString,self.indexpath]];
        
    }
    
   
    
    //关闭一模态形式显示的UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




//加载中
-(void)loadingJS
{
    [_svc showLoadingWithMessage:@"请稍等" inView:[UIApplication sharedApplication].keyWindow];
}


//加载结束
-(void)closeLoadingJS
{
    [_svc hideLoadingView];
}

//选择物流的方法
-(void)go_NativeSiteJS
{
    
}








//支付宝支付
-(void)zfb_payJS:(NSString *)sign
{
    [[AlipaySDK defaultService] payOrder:sign fromScheme:@"CRFNAliPay" callback:^(NSDictionary *resultDic) {
        
         NSLog(@"reslut = %@",resultDic);
        
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
}



//微信支付
-(void)wx_payJS:(NSString *)payStr
{
    NSLog(@"传过来的参数=======%@",payStr);
    
    
    
//    if ([WXApi openWXApp]) {
    
        NSArray *array = [payStr componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
        
        
        
        
        if (array.count>=7) {
            
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = array[0];
            req.partnerId           = array[1];
            /** 预支付订单 */
            req.prepayId= array[2];
            /** 商家根据财付通文档填写的数据和签名 */
            req.package = array[3];
            /** 随机串，防重发 */
            req.nonceStr= array[4];
            /** 时间戳，防重发 */
            req.timeStamp= [array[5] intValue];
            /** 商家根据微信开放平台文档对数据做的签名 */
            req.sign= array[6];
            
            
//            req.openID              = @"wx0727f2b6b7a9e1e1";
//            req.partnerId           = @"1467821102";
//            /** 预支付订单 */
//            req.prepayId= @"wx20170518104435e9a0d163270358315701";
//            /** 商家根据财付通文档填写的数据和签名 */
//            req.package = @"Sign=WXPay";
//            /** 随机串，防重发 */
//            req.nonceStr=@"059fa6212611951a0ac0e9a60d963782";
//            /** 时间戳，防重发 */
//            req.timeStamp= 1495075474;
//            /** 商家根据微信开放平台文档对数据做的签名 */
//            req.sign= @"3AC72B8E8E4B4AE945D6C0F3705690D8";
            
            
            
          BOOL  isOpen = [WXApi sendReq:req];
            
            NSLog(@"返回的结果=====%d",isOpen);
            
            if (!isOpen) {
                
                [_svc showMessage:@"支付失败"];
            }
            
        }else{
            
            [_svc showMessage:@"支付失败"];
        }
        
//    }else{
//    
//        [_svc showMessage:@"没有安装微信"];
//    }
//    

}





-(void)showBackItems
{
    UIButton *btn =[self.class buttonWithImage:[UIImage imageNamed:@"item_back"] title:nil target:self action:@selector(backItemAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:YES withItem:item spaceWidth:0];
}




-(void)backItemAction:(UIButton *)button
{
    
    
//    NSLog(@"=============url  =======%@",_url);
    
    if ([_intentDic[@"url"] rangeOfString:@"/order/paytype_view"].location != NSNotFound) {
        
        //条件为真
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"订单已生成，是否确认取消支付" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
            
            if (tempVCA.count!=0 && tempVCA!=nil) {
                
                
                for (int i = (int)tempVCA.count-1; i>0; i--) {
                    
                    [tempVCA removeObjectAtIndex:i];
                }
                
                self.navigationController.viewControllers = tempVCA;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"4"}];
            
            //全部订单
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAllDingdan],@"type":@"POST"}];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
        
        
        
 
       
        
    }else if ([_intentDic[@"url"] rangeOfString:@"/ucenter/orderlist_view"].location != NSNotFound){
        
        
        
       
        
        NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        
        if (tempVCA.count!=0 && tempVCA!=nil) {
            
            
            for (int i = (int)tempVCA.count-1; i>0; i--) {
                
                [tempVCA removeObjectAtIndex:i];
            }
            
           
            
            self.navigationController.viewControllers = tempVCA;
        }
        
          [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"4"}];
        
    
    }else if ([_intentDic[@"url"] rangeOfString:@"/order/banknote_ok_view"].location != NSNotFound){
        
        
        NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        
        if (tempVCA.count!=0 && tempVCA!=nil) {
            
            
            for (int i = (int)tempVCA.count-1; i>0; i--) {
                
                [tempVCA removeObjectAtIndex:i];
            }
            
            self.navigationController.viewControllers = tempVCA;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"4"}];
        
        //全部订单
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAllDingdan],@"type":@"POST"}];
        
        
    }else if ([_intentDic[@"url"] rangeOfString:@"/rder/exchange_tip_view"].location != NSNotFound){
        
        
        
        NSString *url = [NSString stringWithFormat:@"%@%@",KBaseURL,@"/ucenter/exgoods_view"];
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSURL URLWithString:url]}];
    
    }else if ([_intentDic[@"url"] rangeOfString:@"/ucenter/exgoods_view"].location != NSNotFound){
        
        //返回到我的界面
        
        NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
        
        if (tempVCA.count!=0 && tempVCA!=nil) {
            
            
            for (int i = (int)tempVCA.count-1; i>0; i--) {
                
                [tempVCA removeObjectAtIndex:i];
            }
            
            self.navigationController.viewControllers = tempVCA;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"4"}];
        
      
        
    }else {
    
        if (self.navigationController) {
            if (self.navigationController.viewControllers.count > 1) {
                [_svc popViewController];
            }else
            {
                // [_svc dismissTopViewControllerCompletion:NULL];
            }
            
        }else {
            
            //[_svc dismissTopViewControllerCompletion:NULL];
        }
        
        
        
    }
    
    

}


//显示右侧搜索
-(void)showRightSearchItem
{
    UIButton *btn = [self.class buttonWithImage:[UIImage imageNamed:@"search"] title:nil target:self action:@selector(searchAction)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)searchAction
{
    [_svc pushViewController:_svc.searchWebViewViewController withObjects:@{@"navigation":@"搜索订单号或商品名称"}];
}


-(BOOL)shouldShowBackItem
{
    return NO;;
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
