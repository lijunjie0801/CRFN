//
//  ForgetViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/10.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()

@property(nonatomic, strong) UITextField *iphoneField,*codeField;
@property(nonatomic, strong) UIButton *codeBtn,*nextBtn;

@property (nonatomic, strong) UIView *line,*line1;

@property(nonatomic, strong) UILabel *phoneLbl,*callPhongLbl;
@property(nonatomic, strong) NSString *phoneStr;

@end

@implementation ForgetViewController

-(void)requestPhone
{
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLPhone]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            
            self.phoneStr = responseObject[@"phone"];
            self.callPhongLbl.text = self.phoneStr;
            
            
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
    
    self.view.backgroundColor = [AppAppearance sharedAppearance].whiteColor;

    self.title = @"忘记密码";
    [self showLoginItem];
    [self createSubViews];
}

//创建视图
-(void)createSubViews
{
    //请输入接收验证码的手机号码:
    UILabel *recivelbl = [[UILabel alloc] init];
    recivelbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    recivelbl.text = @"请输入接收验证码的手机号码:";
    recivelbl.textAlignment = NSTextAlignmentCenter;
    recivelbl.font = [MyAdapter fontADapter:16];
    [self.view addSubview:recivelbl];
    
    //输入手机号
    _iphoneField                          = [[UITextField alloc]initWithFrame:CGRectZero];
    _iphoneField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _iphoneField.font                     = [UIFont systemFontOfSize:[MyAdapter fontDapter:16]];
    _iphoneField.borderStyle              = UITextBorderStyleNone;
    _iphoneField.returnKeyType            = UIReturnKeyDone;
    _iphoneField.textAlignment            = NSTextAlignmentLeft;
    _iphoneField.backgroundColor          = [UIColor clearColor];
    _iphoneField.keyboardType             = UIKeyboardTypeNumberPad;
    _iphoneField.clearButtonMode          = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_iphoneField];
    
    //分界线
    _line                               = [[UIView alloc]initWithFrame:CGRectZero];
    _line.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
    [self.view addSubview:_line];
    
    
    //验证码
    _codeField                          = [[UITextField alloc]initWithFrame:CGRectZero];
    _codeField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _codeField.font                     = [UIFont systemFontOfSize:[MyAdapter fontDapter:16]];
    _codeField.borderStyle              = UITextBorderStyleNone;
    _codeField.returnKeyType            = UIReturnKeyDone;
    _codeField.textAlignment            = NSTextAlignmentLeft;
    _codeField.backgroundColor          = [UIColor clearColor];
//    _codeField.clearButtonMode          = UITextFieldViewModeWhileEditing;
    _codeField.keyboardType             = UIKeyboardTypeNumberPad;
    _codeField.placeholder = @"验证码:";
    [self.view addSubview:_codeField];
    
    
    
    //点击获取验证码
    _codeBtn = [[UIButton alloc] init];
    _codeBtn.titleLabel.font = [MyAdapter fontADapter:16];
    _codeBtn.layer.cornerRadius = 3.f;
    _codeBtn.clipsToBounds = YES;
    _codeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_codeBtn setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forState:UIControlStateNormal];
    [_codeBtn addTarget:self action:@selector(authBtnForgetClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeBtn];
    
    //分界线
    _line1                               = [[UIView alloc]initWithFrame:CGRectZero];
    _line1.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
    [self.view addSubview:_line1];
    
    //下一步
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextBtn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    _nextBtn.layer.cornerRadius = 10;
    _nextBtn.layer.masksToBounds = YES;
    [_nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextBtn];
    
    
    //设置位置
    [recivelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.offset(0);
        make.top.offset([MyAdapter aDapter:20]);
        make.height.mas_equalTo([MyAdapter aDapter:25]);
    }];
    
    [self.iphoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(recivelbl.mas_bottom).offset(5);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo([MyAdapter aDapter:150]);
        make.height.mas_equalTo([MyAdapter aDapter:30]);
        
        
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.top.equalTo(self.iphoneField.mas_bottom).offset(0);
        make.height.mas_equalTo([MyAdapter aDapter:0.6]);
        make.right.offset(0);
    }];
    
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.line.mas_bottom).offset(10);
        make.left.offset([MyAdapter aDapter:20]);
        make.right.offset([MyAdapter aDapter:-20]);
        make.width.mas_equalTo(WIDTH);
        make.height.mas_equalTo([MyAdapter aDapter:30]);
        
        
    }];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-20);
        make.height.equalTo(self.codeField.mas_height);
        make.top.equalTo(self.line.mas_bottom).offset(10);
        make.width.mas_equalTo([MyAdapter aDapter:85]);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.top.equalTo(self.codeField.mas_bottom).offset(5);
        make.height.mas_equalTo([MyAdapter aDapter:0.6]);
        make.right.offset(0);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.right.offset(-20);
        make.top.equalTo(self.line1.mas_bottom).offset(20);
        make.height.mas_equalTo([MyAdapter aDapter:45]);
        
    }];
    
    
    
    //5.客服电话
    _phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT-200, WIDTH, 30)];
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
    _callPhongLbl.text = self.phoneStr;
    [self.view addSubview:_callPhongLbl];
    UITapGestureRecognizer *tagCall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneClick)];
    [_callPhongLbl addGestureRecognizer:tagCall];
    
    
}


//发送验证按钮的点击事件
-(void)authBtnForgetClick:(UIButton *)button
{
    if (_iphoneField.text.length == 0) {
        
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return;
    }
    
    if (_iphoneField.text.length < 11) {
        
        [MessageTool showMessage:@"手机号格式不正确" isError:YES];
        return;
    }
    if(![Utility checkPhone:_iphoneField.text])
    {
        [_svc showMessage:@"请输入正确的手机号"];
        return;
    }
    
    [_svc showLoadingWithMessage:@"发送中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    NSDictionary *param =@{@"user_type":@"1",@"validate":@"zgzlw",@"type":@"2",@"mobile":_iphoneField.text};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLStringSendSma]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
     
        
        
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            [self countDownTime:@(60)];
            
        }
        [_svc showMessage:responseObject[@"message"]];
        [_svc hideLoadingView];
        
    } progress:^(NSProgress *progress) {
        
//        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
    
    
}


//倒计时函数
-(void)countDownTime:(NSNumber *)sourceDate
{
    __block int timeout = sourceDate.intValue;  //倒计时间
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatchQueue);
    dispatch_source_set_timer(_time, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_time, ^{
        
        if (timeout <= 1) {
            dispatch_source_cancel(_time);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _codeBtn.enabled = YES;
            });
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *numStr = [NSString stringWithFormat:@"%d",timeout];
                NSString *strTime = [NSString stringWithFormat:@"%@秒",numStr];
                _codeBtn.enabled = NO;
                _codeBtn.titleLabel.text = strTime;
            });
            
            timeout--;
        }
        
    });
    dispatch_resume(_time);
}


//下一步
-(void)nextAction
{
    
    
    
    if (_iphoneField.text.length == 0) {
        
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return;
    }
    
    if (_iphoneField.text.length < 11) {
        
        [MessageTool showMessage:@"手机号格式不正确" isError:YES];
        return;
    }
    if(![Utility checkPhone:_iphoneField.text])
    {
        [_svc showMessage:@"请输入正确的手机号"];
        return;
    }
    
    if (_codeField.text.length == 0) {
        
        [_svc showMessage:@"验证码不能为空"];
        return;
    }
    
    
    [_svc showLoadingWithMessage:@"验证中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    NSDictionary *param =@{@"code":_codeField.text,@"mobile":_iphoneField.text};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULStringCheckCode]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            [_svc pushViewController:_svc.forgetNextViewController withObjects:@{@"phone":_iphoneField.text}];
            
        }else{
        
             [_svc showMessage:responseObject[@"message"]];
            
        }
       
        [_svc hideLoadingView];
        
    } progress:^(NSProgress *progress) {
        
        //        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
    
    
    
    
   
}

//到登录界面
-(void)showLoginItem
{
    UIButton *btn =[self.class buttonWithImage:nil title:@"登录" target:self action:@selector(loginAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)loginAction:(UIButton *)button
{
    
//    [_svc dismissTopViewControllerCompletion:nil];
    [_svc popViewController];
    
    
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
