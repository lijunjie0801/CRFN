//
//  ForgetNextViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/10.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ForgetNextViewController.h"
#import "UserBehaviorCell.h"

@interface ForgetNextViewController ()<UITableViewDelegate,UITableViewDataSource>

{

    NSString *phoneStr;
}

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UITextField *passWord;
@property(nonatomic, strong) UITextField *confirmPwd;

@property(nonatomic, strong) NSString *callphoneStr;
@property(nonatomic, strong) UILabel *callIphonelbl;


@end

@implementation ForgetNextViewController

-(void)setIntentDic:(NSDictionary *)intentDic
{
    phoneStr = intentDic[@"phone"];
}


-(void)requestPhone
{
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLPhone]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            
            self.callphoneStr = responseObject[@"phone"];
            self.callIphonelbl.text = self.callphoneStr;
            
            
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
    [self showLoginItem];
    
    [self requestPhone];
    
    self.title = @"忘记密码";
    
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
    
    _callIphonelbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iphonelbl.frame)+5, WIDTH, 30)];
    _callIphonelbl.textAlignment = NSTextAlignmentCenter;
    _callIphonelbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:[MyAdapter fontDapter:18]];;
    _callIphonelbl.textColor = [AppAppearance sharedAppearance].mainColor;
    _callIphonelbl.userInteractionEnabled = YES;
    _callIphonelbl.text = self.callphoneStr;
    [footerView addSubview:_callIphonelbl];
    UITapGestureRecognizer *tagCall = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callPhoneClick)];
    [_callIphonelbl addGestureRecognizer:tagCall];
    
    
    
    
    
    return footerView;
}

-(void)submitAction
{
 
    if ([self submitCheck]) {
        
        
        [_svc showLoadingWithMessage:@"修改中..." inView:[UIApplication sharedApplication].keyWindow];
        
        
        NSDictionary *param =@{@"password":_passWord.text,@"mobile":phoneStr};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULStringResetPassword]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            
            NSLog(@"%@",responseObject);
            
            
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
                
                if(tempVCA.count!=0 && tempVCA!=nil) {
                    
                    for (int i = (int)tempVCA.count-1; i>=1; i--) {
                        
                        [tempVCA removeObjectAtIndex:i];
                    }
                    
                    self.navigationController.viewControllers = tempVCA;
                    
                }
             
                
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
}

-(BOOL)submitCheck
{
  
    if (!_passWord.text.length) {
        [MessageTool showMessage:@"新密码不能为空" isError:YES];
        return NO;
    }
    if (!_confirmPwd.text.length) {
        [MessageTool showMessage:@"新密码不能为空" isError:YES];
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
            cell.imageView.image        = [UIImage imageNamed:@"register_Input password"];
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder  = @"请输入新密码";
            cell.forgetPass.hidden = YES;
            _passWord                      = cell.textField;
            break;
        case 1:
            cell.imageView.image           = [UIImage imageNamed:@"register_Confirm password"];
            cell.textField.keyboardType    = UIKeyboardTypeDefault;
            cell.textField.secureTextEntry = YES;
            cell.textField.placeholder     = @"请输入新密码";
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




//到登录界面
-(void)showLoginItem
{
    UIButton *btn =[self.class buttonWithImage:nil title:@"登录" target:self action:@selector(loginAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)loginAction:(UIButton *)button
{
    
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
    NSString *phonStr =self.callphoneStr;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:phonStr preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phonStr]]];
        
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
