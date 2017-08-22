//
//  WaitCheckViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "WaitCheckViewController.h"

@interface WaitCheckViewController ()

@property(nonatomic, strong) UIImageView *headimg;
@property(nonatomic, strong) UILabel *titLbl,*detailLbl,*phoneLbl,*callPhongLbl;
@property(nonatomic,strong) UIButton *backBtn;

@property(nonatomic, strong) NSString *phoneStr;

@end

@implementation WaitCheckViewController


-(void)requestPhone
{
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLPhone]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            
            self.phoneStr = responseObject[@"phone"];
            _callPhongLbl.text = self.phoneStr;
            
            
        }else{
            
            
            [_svc showMessage:responseObject[@"message"]];
            
            
            
            
        }
        
        
        [_svc hideLoadingView];
        
    } progress:^(NSProgress *progress) {
        
        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestPhone];
    self.title = @"审核状态";
    self.view.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    //1.返回
   _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [_backBtn setTitle:@"退出" forState:UIControlStateNormal];
    _backBtn.frame = CGRectMake(15, 100, WIDTH-30, [MyAdapter aDapter:45]);
    _backBtn.center = CGPointMake(self.view.center.x, self.view.center.y);
    [_backBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _backBtn.layer.cornerRadius = 10;
    _backBtn.layer.masksToBounds = YES;
    [self.view addSubview:_backBtn];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    //2.detailes说明
    _detailLbl =  [[UILabel alloc] init];
    _detailLbl.text = @"我们将在3个工作日内完成审核,感谢您的配合,如果长时间未通过审核,请致电400-400-4000";
    _detailLbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    _detailLbl.numberOfLines = 0;
    _detailLbl.font = [MyAdapter fontADapter:14];
    _detailLbl.frame = CGRectMake(15, CGRectGetMinY(_backBtn.frame)-80, WIDTH-30, [MyAdapter aDapter:60]);
    [self.view addSubview:_detailLbl];
    
    //3.title文字
    _titLbl =  [[UILabel alloc] init];
    _titLbl.text = @"您的信息已经提交成功,请等待审核！";
    _titLbl.textColor = [AppAppearance sharedAppearance].mainColor;
    _titLbl.numberOfLines = 0;
    _titLbl.font =[UIFont fontWithName:@"Helvetica" size:[MyAdapter fontDapter:18]];
    _titLbl.textAlignment = NSTextAlignmentCenter;
    _titLbl.frame = CGRectMake(10, CGRectGetMinY(_detailLbl.frame)-50, WIDTH-20, [MyAdapter aDapter:50]);
    [self.view addSubview:_titLbl];
    
    //4.图片
    _headimg = [[UIImageView alloc] initWithFrame:CGRectMake(30, CGRectGetMinY(_titLbl.frame)-30, WIDTH-60, 20)];
    _headimg.image = [UIImage imageNamed:@"shenhe_shenhezhong"];
    [self.view addSubview:_headimg];
    
    
    //5.客服电话
    _phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT-150, WIDTH, 30)];
    _phoneLbl.textAlignment = NSTextAlignmentCenter;
    _phoneLbl.font = [MyAdapter fontADapter:18];
    _phoneLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    _phoneLbl.text = @"客服电话";
    [self.view addSubview:_phoneLbl];
    
   _callPhongLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_phoneLbl.frame)+5, WIDTH, 30)];
    _callPhongLbl.textAlignment = NSTextAlignmentCenter;
    _callPhongLbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:[MyAdapter fontDapter:18]];;
    _callPhongLbl.textColor = [AppAppearance sharedAppearance].mainColor;
    _callPhongLbl.userInteractionEnabled = YES;
    _callPhongLbl.text = @"400-400-4000";
    [self.view addSubview:_callPhongLbl];
    UITapGestureRecognizer *tagCall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneClick)];
    [_callPhongLbl addGestureRecognizer:tagCall];
    
    
    
}


//退出
-(void)backAction
{
//    [_svc popViewController];
    NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    if(tempVCA.count!=0 && tempVCA!=nil) {
        
        for (int i = (int)tempVCA.count-1; i>=1; i--) {
            
            [tempVCA removeObjectAtIndex:i];
        }
        
        self.navigationController.viewControllers = tempVCA;
        
    }
}


//拨打电话
-(void)callPhoneClick
{
    NSString *phoneStr = self.phoneStr;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:phoneStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
