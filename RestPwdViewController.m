//
//  RestPwdViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "RestPwdViewController.h"
#import "UserBehaviorCell.h"

@interface RestPwdViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITextField *oldPwd;
@property(nonatomic, strong) UITextField *passWord;
@property(nonatomic, strong) UITextField *confirmPwd;

@end

@implementation RestPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableFooterView = [self footerViews];
}


-(UIView *)footerViews
{
    UIView *footerView = [[UIView alloc] init];
    
    footerView.backgroundColor = [UIColor clearColor];
    footerView.frame           = CGRectMake(0, 0, _tableView.bounds.size.width, HEIGHT - [MyAdapter aDapter:44]*2);
    
    //忘记密码提交
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    button.frame     = CGRectMake(20, 20, _tableView.bounds.size.width-40, [MyAdapter aDapter:45]);
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    
    
    
    UILabel *iphonelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT - 280, WIDTH, 30)];
    iphonelbl.textAlignment = NSTextAlignmentCenter;
    iphonelbl.font = [MyAdapter fontADapter:18];
    iphonelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    iphonelbl.text = @"客服电话";
    [footerView addSubview:iphonelbl];
    
    UILabel *callIphonelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iphonelbl.frame)+5, WIDTH, 30)];
    callIphonelbl.textAlignment = NSTextAlignmentCenter;
    callIphonelbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:[MyAdapter fontDapter:18]];;
    callIphonelbl.textColor = [AppAppearance sharedAppearance].mainColor;
    callIphonelbl.userInteractionEnabled = YES;
    callIphonelbl.text = @"400-400-4000";
    [footerView addSubview:callIphonelbl];
    UITapGestureRecognizer *tagCall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneClick)];
    [callIphonelbl addGestureRecognizer:tagCall];
    
    
    
    
    
    return footerView;
}

-(void)submitAction
{
    
    if ([self submitCheck]) {

        [_svc showLoadingWithMessage:@"修改中..." inView:[UIApplication sharedApplication].keyWindow];
        
        
        NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"oldpwd":_oldPwd.text,@"newpwd":_passWord.text,@"newrepwd":_confirmPwd.text};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULResetPwd]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功");
            NSLog(@"%@",responseObject);
            
            
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                
                [_svc popViewController];
                
            }
            [_svc showMessage:responseObject[@"message"]];
            [_svc hideLoadingView];
            
        } progress:^(NSProgress *progress) {
            
//            NSLog(@"1111");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [_svc hideLoadingView];
            
            [_svc showMessage:error.domain];
        }];
    }
}

-(BOOL)submitCheck
{
    if (!_oldPwd.text.length) {
        [MessageTool showMessage:@"原始密码不能为空" isError:YES];
        return NO;
    }
    
    if (!_passWord.text.length) {
        [MessageTool showMessage:@"新密码不能为空" isError:YES];
        return NO;
    }
    if (!_confirmPwd.text.length) {
        [MessageTool showMessage:@"确认密码不能为空" isError:YES];
        return NO;
    }
    
    if (_passWord.text.length < 6) {
        [MessageTool showMessage:@"密码长度至少6位" isError:YES];
        return NO;
    }
    
    if (![_passWord.text isEqualToString:_confirmPwd.text]) {
        [MessageTool showMessage:@"新密码输入的不一致" isError:YES];
        return NO;
    }
    
    
    return YES;
    
}





#pragma mark -UITableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
            cell.imageView.image        = [UIImage imageNamed:@"register_Input password"];
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder  = @"请输入原密码";
            cell.forgetPass.hidden = YES;
            _oldPwd                      = cell.textField;
            break;
        case 1:
            cell.imageView.image        = [UIImage imageNamed:@"register_Input password"];
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder  = @"请输入新密码";
            cell.forgetPass.hidden = YES;
            _passWord                      = cell.textField;
            break;
        case 2:
            cell.imageView.image           = [UIImage imageNamed:@"register_Confirm password"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"请确认新密码";
            cell.isHide                    = YES;
            _confirmPwd                      = cell.textField;
            
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



//拨打电话
-(void)callPhoneClick
{
    NSString *phoneStr = @"400-400-4000";
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
