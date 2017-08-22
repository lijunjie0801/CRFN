//
//  RegisterViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/10.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserBehaviorCell.h"
#import "CheckBoxView.h"
#import "LMUnderLineLabel.h"


@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UITextField *phone;  //电话号码
@property(nonatomic, strong) UITextField *verify; //验证码
@property(nonatomic, strong) UITextField *password; //密码
@property(nonatomic, strong) UITextField *confirmPwd;  //确认密码
@property(nonatomic, strong) UIButton    *authBtn;   //发送验证码
@property(nonatomic, strong) UIButton    *submitBtn;  //提交

//@property(nonatomic, strong) CheckBoxView *checkBoxView;

@property(nonatomic, strong) UIView *buyView,*sellView;
@property(nonatomic, strong) UIButton *buyBtn,*sellBtn;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    [self showLoginItem];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView = [self headerViews];
    _tableView.tableFooterView = [self footerViews];
}


-(UIView *)headerViews
{
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, 50)];
    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, WIDTH, 100)];
    
//    _buyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
//    [headerView addSubview:_buyView];
//    
//    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _buyBtn.frame=CGRectMake((WIDTH-200)/2, 0, 200, 30);
//   
//    _buyBtn.backgroundColor = [UIColor clearColor];
//    //设置button正常状态下的图片
//    [_buyBtn setImage:[UIImage imageNamed:@"register_Radio02"] forState:UIControlStateNormal];
//
//    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
//    _buyBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    _buyBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [_buyBtn setTitle:@"我要买货，用户注册" forState:UIControlStateNormal];
//    //button标题的偏移量，这个偏移量是相对于图片的
//    _buyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    //设置button正常状态下的标题颜色
//    [_buyBtn setTitleColor:[AppAppearance sharedAppearance].redColor forState:UIControlStateNormal];
//    _buyBtn.titleLabel.font = [MyAdapter fontADapter:16];
//    [_buyBtn addTarget:self action:@selector(buyClick) forControlEvents:UIControlEventTouchUpInside];
//    [_buyView addSubview:_buyBtn];
//    
//    
//    
//    
//    _sellView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_buyView.frame)+10, WIDTH, 30)];
//    [headerView addSubview:_sellView];
//    
//    _sellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _sellBtn.frame=CGRectMake((WIDTH-200)/2, 0, 200, 30);
//    
//    _sellBtn.backgroundColor = [UIColor clearColor];
//    //设置button正常状态下的图片
//    [_sellBtn setImage:[UIImage imageNamed:@"register_Radio01"] forState:UIControlStateNormal];
//    
//    //button图片的偏移量，距上左下右分别(10, 10, 10, 60)像素点
//    _sellBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    _sellBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [_sellBtn setTitle:@"我要卖货，商家入驻" forState:UIControlStateNormal];
//    //button标题的偏移量，这个偏移量是相对于图片的
//    _sellBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    //设置button正常状态下的标题颜色
//    [_sellBtn setTitleColor:[AppAppearance sharedAppearance].title2TextColor forState:UIControlStateNormal];
//    _sellBtn.titleLabel.font = [MyAdapter fontADapter:16];
//    [_sellBtn addTarget:self action:@selector(sellClick) forControlEvents:UIControlEventTouchUpInside];
//    [_sellView addSubview:_sellBtn];
//    
//    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_sellView.frame)+15, WIDTH-20, 1)];
//    line.image = [UIImage imageNamed:@"register_Dividing-line"];
//    [headerView addSubview:line];
    
    return headerView;
}

//买家注册
-(void)buyClick
{
    
        
    [_buyBtn setImage:[UIImage imageNamed:@"register_Radio02"] forState:UIControlStateNormal];
    [_buyBtn setTitleColor:[AppAppearance sharedAppearance].redColor forState:UIControlStateNormal];
    
    [_sellBtn setImage:[UIImage imageNamed:@"register_Radio01"] forState:UIControlStateNormal];
    [_sellBtn setTitleColor:[AppAppearance sharedAppearance].title2TextColor forState:UIControlStateNormal];
        
   
    
    
        
    
}

//卖家注册
-(void)sellClick
{
    [_sellBtn setImage:[UIImage imageNamed:@"register_Radio02"] forState:UIControlStateNormal];
    [_sellBtn setTitleColor:[AppAppearance sharedAppearance].redColor forState:UIControlStateNormal];
    
    [_buyBtn setImage:[UIImage imageNamed:@"register_Radio01"] forState:UIControlStateNormal];
    [_buyBtn setTitleColor:[AppAppearance sharedAppearance].title2TextColor forState:UIControlStateNormal];
}



-(UIView *)footerViews
{
    UIView *footerView = [[UIView alloc] init];
    
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 162);
    
    
    
//    self.checkBoxView.frame = CGRectMake(15, 10, 130, 30);
//    [footerView addSubview:self.checkBoxView];
    
    
    //协议
//    LMUnderLineLabel *lineLabel   = [[LMUnderLineLabel alloc] initWithFrame:CGRectMake(self.checkBoxView.frame.origin.x + CGRectGetWidth(self.checkBoxView.bounds) - 15, self.checkBoxView.frame.origin.y + 8, 100, 18)];
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookProtocolView)];
//    lineLabel.userInteractionEnabled   = YES;
//    [lineLabel addGestureRecognizer:tapGesture];
//    lineLabel.text                     = @"《商家合约》";
//    lineLabel.backgroundColor          = [UIColor clearColor];
//    [lineLabel setFont:[UIFont systemFontOfSize:12.5f]];
//    [lineLabel setTextColor:[AppAppearance sharedAppearance].mainColor];
//    [footerView addSubview:lineLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.layer.cornerRadius = 6;
    button.layer.masksToBounds = YES;
    [button setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    button.frame   = CGRectMake(20, footerView.bounds.size.height - 100, footerView.bounds.size.width-40, [MyAdapter aDapter:45]);
    [button addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    return footerView;
}
//- (CheckBoxView *)checkBoxView
//{
//    if (!_checkBoxView) {
//        _checkBoxView = [[CheckBoxView alloc] initWithFrame:CGRectMake(7, 12, 60, 30) checked:YES];
//        _checkBoxView.backgroundColor = [UIColor clearColor];
//        [_checkBoxView setText:@"我已阅读并接受"];
//        [_checkBoxView setFont:[UIFont systemFontOfSize:13] textColor:[AppAppearance sharedAppearance].titleTextColor];
//    }
//    return _checkBoxView;
//}

//商家协议
//-(void)lookProtocolView
//{
//    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":@"https://www.baidu.com"}];
//}
//注册下一步
-(void)registerAction
{
    
    
       if ([self checkInput]) {
        
        [_svc showLoadingWithMessage:@"注册中..." inView:self.view];
        
        NSDictionary *param =@{@"user_type":@"1",@"code":_verify.text,@"password":_password.text,@"mobile":_phone.text};
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLStringRegister]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"%@",responseObject);
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                
                [AppDataManager defaultManager].identifier = responseObject[@"message"];
                [[AppDataManager defaultManager] setUseridAccount:responseObject[@"message"]];
                [[AppDataManager defaultManager] setPhoneAccount:_phone.text];
                [[AppDataManager defaultManager] setPassWord:_password.text];
                
                [_svc pushViewController:_svc.registerNextViewController];
                
                
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
    
    

    
    
    
}


//检验输入的正确性
-(BOOL)checkInput
{
    if (!_phone.text.length) {
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return NO;
    }
    if (_phone.text.length < 11) {
        
        [MessageTool showMessage:@"手机号格式不正确" isError:YES];
        return NO;
    }
    if(![Utility checkPhone:_phone.text])
    {
        [_svc showMessage:@"请输入正确的手机号"];
        return NO;
    }
    
    
    if (!_verify.text.length) {
        
        [MessageTool showMessage:@"验证码不能为空" isError:YES];
        return NO;
    }
    if (!_password.text.length) {
        [MessageTool showMessage:@"新密码不能为空" isError:YES];
        return NO;
    }
    if (![_confirmPwd.text isEqualToString:_password.text]) {
        [MessageTool showMessage:@"新密码输入的不一致" isError:YES];
        return NO;
    }
    
    if (_password.text.length < 6) {
        [MessageTool showMessage:@"密码长度至少6位" isError:YES];
        return NO;
    }
//    if (!_checkBoxView.checked) {
//        [_svc showMessage:@"请同意商家合约"];
//        return NO;
//    }
    
    return YES;
}







#pragma mark -UITableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    UserBehaviorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[UserBehaviorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //cell.textField.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image        = [UIImage imageNamed:@"register_Cell-phone number"];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.placeholder  = @"手机号";
            _phone = cell.textField;
            break;
        case 1:
            cell.imageView.image           = [UIImage imageNamed:@"register_Verification Code"];
            cell.textField.keyboardType    = UIKeyboardTypeNumberPad;
            cell.textField.secureTextEntry = NO;
            cell.textField.placeholder     = @"短信验证码";
            cell.textField.clearButtonMode = UITextFieldViewModeNever;
            _verify                        = cell.textField;
            [cell addSubview:[self verifyButton]];
            break;
        case 2:
            cell.imageView.image           = [UIImage imageNamed:@"register_Input password"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"登录密码";
            _password                       = cell.textField;
            
            break;
        case 3:
            cell.imageView.image           = [UIImage imageNamed:@"register_Confirm password"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"确认密码";
            cell.isHide                    = YES;
            _confirmPwd                      = cell.textField;
            break;
     
        default:
            break;
    }
   
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:44];
}


//发送验证码按钮
-(UIButton *)verifyButton
{
    if (!_authBtn) {
        
        _authBtn    = [UIButton buttonWithType:UIButtonTypeCustom];
        _authBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds) - 100, 5, 86, 30);
        _authBtn.layer.cornerRadius = 3.f;
        _authBtn.clipsToBounds = YES;
        _authBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_authBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_authBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_authBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_authBtn setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor] forState:UIControlStateNormal];
        [_authBtn addTarget:self action:@selector(authBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _authBtn;
}

//发送验证按钮的点击事件
-(void)authBtnClick:(UIButton *)button
{
    if (_phone.text.length == 0) {
        
        [MessageTool showMessage:@"手机号不能为空" isError:YES];
        return;
    }
    
    if (_phone.text.length < 11) {
        
        [MessageTool showMessage:@"手机号格式不正确" isError:YES];
        return;
    }
    if(![Utility checkPhone:_phone.text])
    {
        [_svc showMessage:@"请输入正确的手机号"];
        return;
    }

    [_svc showLoadingWithMessage:@"发送中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    NSDictionary *param =@{@"user_type":@"1",@"validate":@"zgzlw",@"type":@"1",@"mobile":_phone.text};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLStringSendSma]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {


            [self countDownTime:@(60)];

        }
        [_svc showMessage:responseObject[@"message"]];
        [_svc hideLoadingView];
        
    } progress:^(NSProgress *progress) {
        
        NSLog(@"1111");
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
                
                [_authBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                _authBtn.enabled = YES;
            });
        }else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *numStr = [NSString stringWithFormat:@"%d",timeout];
                NSString *strTime = [NSString stringWithFormat:@"%@秒",numStr];
                _authBtn.enabled = NO;
                _authBtn.titleLabel.text = strTime;
            });
            
            timeout--;
        }
        
    });
    dispatch_resume(_time);
}




//到登录界面
-(void)showLoginItem
{
    UIButton *btn =[self.class buttonWithImage:nil title:@"已有账号" target:self action:@selector(loginAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)loginAction:(UIButton *)button
{
    
    //    [_svc dismissTopViewControllerCompletion:nil];
    [_svc popViewController];
    
    
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
