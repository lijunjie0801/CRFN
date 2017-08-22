//
//  SearchWebViewViewController.m
//  CRFN
//
//  Created by zlkj on 2017/4/7.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "SearchWebViewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "WebViewJS.h"
#import "FeThreeDotGlow.h"
#import "UIWebView+JavaScriptAlert.h"

@interface SearchWebViewViewController ()<UIWebViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>



@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) MBProgressHUD *weakProgressHUD;
@property(nonatomic, strong) NSURL *urls;

@property(nonatomic, strong) NSString *requestType;


@property(nonatomic, strong) NSString *isOpen;

@property(nonatomic, strong) FeThreeDotGlow *threeDot;

@property(nonatomic, strong) UISearchBar * searchbar ;

@property(nonatomic, strong) NSString *navigationStr;



@end

@implementation SearchWebViewViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    _intentDic = intentDic;
    
    _urls  = [NSURL URLWithString:_intentDic[@"urls"]];
    _navigationStr =intentDic[@"navigation"];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showRightItems];
    
    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [MyAdapter laDapter:250], [MyAdapter laDapter:36])];
    //    [titleView setBackgroundColor:COMMON_TITLE_COLOE];
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [MyAdapter laDapter:250], [MyAdapter laDapter:36])];
    _searchbar.delegate = self;
    //    _searchbar.backgroundColor = COMMON_TITLE_COLOE;
    _searchbar.layer.cornerRadius = [MyAdapter laDapter:15];
    _searchbar.layer.masksToBounds = YES;
    [_searchbar.layer setBorderWidth:8];
    [_searchbar.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    if ([_navigationStr isEqualToString:@"搜索订单号或商品名称"]) {
        
        _searchbar.placeholder = @"搜索订单号或商品名称";
    }else{
    
        _searchbar.placeholder = @"商品搜索";
        
    }
    
    
    [titleView addSubview:_searchbar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    
    //对视图进行适配
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    //web网页会根据屏幕大小进行自动缩放
    _webView.scalesPageToFit = NO;
    _webView.dataDetectorTypes = UIDataDetectorTypeNone;
    [self.view addSubview:_webView];
    
    [self createRequest];
    
    _threeDot = [[FeThreeDotGlow alloc] initWithView:self.view blur:NO];
    _threeDot.center = CGPointMake(WIDTH/2, (HEIGHT-64-44)/2);
    _threeDot.hidden = YES;
    [self.view addSubview:_threeDot];
    
}


//webview界面要带的协议头
-(void)createRequest
{
    NSURLRequest *request = [NSURLRequest requestWithURL:_urls];
    
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:_urls cachePolicy:request.cachePolicy timeoutInterval:request.timeoutInterval];
    
    if ([self.requestType isEqualToString:@"POST"]) {
        
        [req setHTTPMethod:@"POST"];
    }else{
        
        [req setHTTPMethod:@"GET"];
    }
    
    
    NSString *body = @"";
    
    body= [NSString stringWithFormat:@"token=%@",[AppDataManager defaultManager].identifier];
   
    
    
    [req setHTTPBody: [body dataUsingEncoding: NSUTF8StringEncoding]];
    
    [req setValue:[AppDataManager defaultManager].identifier forHTTPHeaderField:@"TOKEN"];
    
    
    if ([AppDataManager defaultManager].ProvinceId) {
        
        //把汉字转换成coding类型
        NSString* string2 = [[AppDataManager defaultManager].ProvinceId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [req setValue:string2 forHTTPHeaderField:@"LOCATION"];
        
    }
    
    
    
    [self.webView loadRequest:req];
    
    
}



#pragma mark -WebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    
//    NSLog(@"url===========%@，=========%ld",[request URL].absoluteString,(long)navigationType);
    //
    //    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
    //
    //        NSLog(@"========UIWebViewNavigationTypeLinkClicked");
    //    }
    //    if (navigationType == UIWebViewNavigationTypeFormSubmitted) {
    //
    //        NSLog(@"========UIWebViewNavigationTypeFormSubmitted");
    //    }
    //
    //    if (navigationType == UIWebViewNavigationTypeBackForward) {
    //
    //        NSLog(@"========UIWebViewNavigationTypeBackForward");
    //    }
    //    if (navigationType == UIWebViewNavigationTypeReload) {
    //
    //        NSLog(@"========UIWebViewNavigationTypeReload");
    //    }
    //    if (navigationType == UIWebViewNavigationTypeFormResubmitted) {
    //
    //        NSLog(@"========UIWebViewNavigationTypeFormResubmitted");
    //    }
    //    if (navigationType == UIWebViewNavigationTypeOther) {
    //
    //        NSLog(@"========UIWebViewNavigationTypeOther");
    //    }
    
    
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        
        NSString *url = [request URL].absoluteString;
        
        NSLog(@"=======================走了跳转的方法了UIWebViewNavigationTypeLinkClicked");
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url}];
        
        return NO;
    }
    
    
    NSLog(@"=============%@",self.isOpen);
    //判断是否单击
    if (navigationType == UIWebViewNavigationTypeOther && [_isOpen isEqualToString:@"1"] ) {
        
        NSString *url = [request URL].absoluteString;
        
        NSLog(@"=======================走了跳转的方法了UIWebViewNavigationTypeOther");
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url,@"isOpen":@"0"}];
        
        return NO;
    }
    
    self.isOpen = @"1";
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
    _threeDot.hidden = YES;
    [_threeDot dismiss];
}



-(void)showRightItems
{
    UIButton *btn =[self.class buttonWithImage:nil title:@"搜索" target:self action:@selector(searchAction)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)searchAction
{
    
    
    if (_searchbar.text.length>0) {
        
        //把汉字转换成coding类型
        NSString* string2 = [_searchbar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        
         if ([_navigationStr isEqualToString:@"搜索订单号或商品名称"]) {
             
             NSString *urls = [NSString stringWithFormat:@"%@%@?keywords=%@",KBaseURL,KURLAllDingdanSearch,string2];
             
             NSLog(@"=====%@",urls);
             
             
             [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":urls}];
             
             
         }else{
         
             NSString *urls = [NSString stringWithFormat:@"%@%@?keywords=%@",KBaseURL,KURLSearchDetail,string2];
             
             NSLog(@"=====%@",urls);
             
             
             [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":urls}];
         }
        
        
        
      
        
    }
    
   
    
}




#pragma mark - UISearchBarDelegate

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//    [searchBar setShowsCancelButton:NO animated:NO];
//    [searchBar resignFirstResponder];
//    [self.view endEditing:YES];
//    
//    return YES;
//}
//
//
//
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    
//    return YES;
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    //[[RealtimeSearchUtil currentUtil] realtimeSearchStop];
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
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
