//
//  LoginViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "LoginViewController.h"
#import "UserBehaviorCell.h"

@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UITextField *phone;
@property(nonatomic, strong) UITextField *passWord;

@property(nonatomic, strong) NSString *phoneStr;

@property(nonatomic, strong)    UILabel *callIphonelbl;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    
    self.title = @"登录";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableHeaderView = [self headerView];
    _tableView.tableFooterView = [self footViews];
    
    [self requestPhone];
    
    
}

-(void)requestPhone
{
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLPhone]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            
            self.phoneStr = responseObject[@"phone"];
            _callIphonelbl.text = self.phoneStr;
            
            
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


//头部视图
-(UIView *)headerView
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 140);
    
    UIImage *logoImg           = [UIImage imageNamed:@"login_logo"];
    
    UIImageView *imageView     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
    imageView.backgroundColor  = [UIColor clearColor];
    imageView.image            = logoImg;
    
    imageView.contentMode      = UIViewContentModeScaleAspectFit;
    imageView.center           = CGPointMake(headerView.bounds.size.width/2, headerView.bounds.size.height/2+20);
    [headerView addSubview:imageView];
    
    return headerView;
}
//尾部视图
-(UIView *)footViews
{
    UIView *footerView = [[UIView alloc] init];
    
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, 350);
    
    
    
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    button.frame     = CGRectMake(20, 20, _tableView.bounds.size.width-40, [MyAdapter aDapter:45]);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    
    
    UILabel *forgetlbl = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(button.frame)+5, 80, 30)];
    forgetlbl.text = @"忘记密码";
    forgetlbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    forgetlbl.font = [MyAdapter fontADapter:16];
    [footerView addSubview:forgetlbl];
    forgetlbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetClick)];
    [forgetlbl addGestureRecognizer:tag];
    
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 90, CGRectGetMaxY(button.frame)+5, 80, 30)];
    lbl.text = @"免费注册";
    lbl.textAlignment = NSTextAlignmentRight;
    lbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
    lbl.font = [MyAdapter fontADapter:16];
    [footerView addSubview:lbl];
    lbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerClick)];
    [lbl addGestureRecognizer:tag1];
    
    
    UILabel *iphonelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lbl.frame)+50, WIDTH, 30)];
    iphonelbl.textAlignment = NSTextAlignmentCenter;
    iphonelbl.font = [MyAdapter fontADapter:18];
    iphonelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    iphonelbl.text = @"客服电话";
    [footerView addSubview:iphonelbl];
    
    _callIphonelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iphonelbl.frame)+5, WIDTH, 30)];
    _callIphonelbl.textAlignment = NSTextAlignmentCenter;
    _callIphonelbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:[MyAdapter fontDapter:18]];;
    _callIphonelbl.textColor = [AppAppearance sharedAppearance].mainColor;
    _callIphonelbl.userInteractionEnabled = YES;
    _callIphonelbl.text = self.phoneStr;
    [footerView addSubview:_callIphonelbl];
    UITapGestureRecognizer *tagCall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneClick)];
    [_callIphonelbl addGestureRecognizer:tagCall];
    
    return footerView;
}


//用户名和密码的验证
-(BOOL)loginCheck{
    
    [self.view endEditing:YES];
    if(_phone.text.length == 0){
        [_svc showMessage:@"请输入您的账号"];
        return NO;
    }
    if(_passWord.text.length == 0){
        [_svc showMessage:@"请输入您的密码"];
        return NO;
    }
    
    if (_passWord.text.length < 6) {
        [MessageTool showMessage:@"密码长度至少6位" isError:YES];
        return NO;
    }
    if(![Utility checkPhone:_phone.text])
    {
        [_svc showMessage:@"请输入正确的手机号"];
        return NO;
    }
    
    
    return YES;
}


//登录方法
-(void)loginAction
{
    
    if ([self loginCheck]) {
        
        [_svc showLoadingWithMessage:@"登录中..." inView:[UIApplication sharedApplication].keyWindow];
        
        
        NSDictionary *param =@{@"password":_passWord.text,@"mobile":_phone.text};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLStringLogin]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功");
            NSLog(@"%@",responseObject);
            
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                
                [AppDataManager defaultManager].identifier = responseObject[@"token"];
                [[AppDataManager defaultManager] setUseridAccount:responseObject[@"token"]];
                [[AppDataManager defaultManager] setPhoneAccount:_phone.text];
                [[AppDataManager defaultManager] setPassWord:_passWord.text];
                
                if ([responseObject[@"user_status"] intValue] ==0) {
                    
                    [_svc pushViewController:_svc.waitCheckViewController];
                    [[AppDataManager defaultManager] setIsidentification:@"0"];
                    
                }else if ([responseObject[@"user_status"] intValue]==1){
                    
                    //                    [_svc pushViewController:_svc.checkSuccessViewController];
                    [_svc dismissTopViewControllerCompletion:nil];
                    [[AppDataManager defaultManager] setIsidentification:@"1"];
                    
                }else if ([responseObject[@"user_status"] intValue]==2){
                    
                    [_svc pushViewController:_svc.checkDefeatedViewController];
                    [[AppDataManager defaultManager] setIsidentification:@"0"];
                    
                }else if ([responseObject[@"user_status"] intValue] ==3){
                    
                    
                    [_svc pushViewController:_svc.registerNextViewController];
                    [[AppDataManager defaultManager] setIsidentification:@"0"];
                    
                    
                }
                
            }else{
                
                
                [_svc showMessage:responseObject[@"message"]];
                [[AppDataManager defaultManager] setIsidentification:@"0"];
                
                
                
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

//注册方法
-(void)registerClick
{
    [_svc pushViewController:_svc.registerViewController];
}
//忘记密码方法
-(void)forgetClick
{
    [_svc pushViewController:_svc.forgetViewController];
}

//拨打电话
-(void)callPhoneClick
{
    NSString *phoneStr =self.phoneStr;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:phoneStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneStr]]];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -UITableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"loginCell";
    UserBehaviorCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[UserBehaviorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image        = [UIImage imageNamed:@"people"];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.placeholder  = @"请输入账号";
            cell.forgetPass.hidden = YES;
            //            if ([AppDataManager defaultManager].PhoneAccount) {
            //
            //                cell.textField.text = [AppDataManager defaultManager].PhoneAccount;
            //            }
            _phone                      = cell.textField;
            //            _phone.text = @"15345609007";
            break;
        case 1:
            cell.imageView.image           = [UIImage imageNamed:@"mima"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"请输入密码";
            cell.isHide                    = YES;
            //            if ([AppDataManager defaultManager].passWord) {
            //
            //                cell.textField.text = [AppDataManager defaultManager].passWord;
            //            }
            
            _passWord                      = cell.textField;
            //            _passWord.text = @"111111";
            
            cell.accessoryView = cell.forgetPass;
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



-(BOOL)shouldShowBackItem
{
    return NO;
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

