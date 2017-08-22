//
//  MySelfViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MySelfViewController.h"
#import "CommonCell.h"
#import "CommonCell2.h"
#import "MyselfCell.h"
#import "MyselfHeaderView.h"
#import "MJRefresh.h"
#import "MyinfoModel.h"

@interface MySelfViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //待支付，待发货，待收货，待评价
    NSNumber *waitPay,*waitSend,*waitReceive,*waitComment;
}

@property(nonatomic, strong) MyselfHeaderView *headerView;

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray *itemsArray;
@property(nonatomic, strong) NSArray *itemsIcons;

@property(nonatomic, strong) MyinfoModel *myinfoModel;

@end

@implementation MySelfViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"gerenzhongxin"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"个人中心";
        self.tabBarItem.title = @"我的";
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-44) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView =[self headerView];
    _tableView.tableFooterView = [self footerView];
    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.itemsArray = @[@[@"全部订单",@""],@[@"优惠券",@"资金明细",@"我要换货",@"我的积分",@"系统消息",@"关于我们",@"常见问题",@"联系客服"]];
    self.itemsIcons = @[@[@"",@""],@[@"wo_youhuiquan",@"zijinmingxi",@"woyaohuanhuo",@"wo_jifeng",@"wo_xitongxiaoxi",@"wo_guanyuwomen",@"wo_changjianwenti",@"wo_zixunkefu"]];
    
    
    __weak MySelfViewController *ws = self;
    
    
    
   _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [ws headerRefresh];
    }];
    
   
   
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [self requestData];
}


-(void)headerRefresh
{
    
    [self requestData];
    [self.tableView.mj_header endRefreshing];
}

//获取数据
-(void)requestData
{
    

    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULMyInfo]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            NSDictionary *userDic = responseObject[@"user_info"];
            
            
            self.myinfoModel = [MTLJSONAdapter modelOfClass:[MyinfoModel class] fromJSONDictionary:userDic error:nil];
             waitPay = responseObject[@"unpay"];
             waitSend = responseObject[@"undelivery"];
             waitReceive = responseObject[@"untake over"];
             waitComment = responseObject[@"uncomment"];
            
            [_headerView setMyinfoModel:self.myinfoModel];
            [self.tableView reloadData];
            
            
            
        }else if ([responseObject[@"status"] intValue] ==-1){
        
            [_svc showMessage:responseObject[@"message"]];
          
            //退出登录
            [self userlogout];
           
            
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



-(UIView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[MyselfHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, _tableView.bounds.size.height/4)];
        _headerView.backgroundColor = [AppAppearance sharedAppearance].mainColor;
        //_headerView.delegate = self;
        
        _headerView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewClick)];
        [_headerView addGestureRecognizer:tag];
        
        
        
    }
    return _headerView;
}

//到个人基本信息界面
-(void)headerViewClick
{
    
    [_svc pushViewController:_svc.myselfDetailViewController withObjects:@{@"MyinfoModel":_myinfoModel}];
}




-(UIView *)footerView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 70)];
    
    UIButton *exitBtn = [[UIButton alloc] init];
    
    [exitBtn setBackgroundColor:[AppAppearance sharedAppearance].mainColor];
    [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
    exitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    exitBtn.layer.cornerRadius = 10;
    exitBtn.layer.masksToBounds = YES;
    
    exitBtn.frame = CGRectMake(20, 10, self.view.frame.size.width-40, [MyAdapter aDapter:45]);
    [exitBtn addTarget:self action:@selector(exitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:exitBtn];
    
    return footerView;
}

//退出登陆
-(void)exitButtonAction:(UIButton *)button
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确认退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        [_svc showLoadingWithMessage:@"退出中..." inView:[UIApplication sharedApplication].keyWindow];
        
        
        NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLLogOut]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {

            NSLog(@"%@",responseObject);

            if ([responseObject[@"status"] intValue] ==1) {
                
                
                [[AppDataManager defaultManager] logout];
                
                //清除cookies
                NSHTTPCookie *cookie;
                NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                for (cookie in [storage cookies])
                {
                    [storage deleteCookie:cookie];
                }
                //清除UIWebView的缓存
                [[NSURLCache sharedURLCache] removeAllCachedResponses];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
                [_svc presentViewController:_svc.loginViewController];
                
                
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
        
        
        
        
        
        
        

        
    
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
    
    
}



#pragma mark  ---------UITableViewdelegate----------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.itemsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.itemsArray[section];
    return arr.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonCell *cell = [CommonCell commonCellWithTableView:tableView];
    CommonCell2 *cell2 = [CommonCell2 commonCell2WithTableView:tableView];
    MyselfCell *myCell = [MyselfCell myselfCellWithTableView:tableView];
   
    
    if (indexPath.section ==0) {
        
        if (indexPath.row ==0) {
            
            cell2.titlelbl.text = self.itemsArray[indexPath.section][indexPath.row];
            cell2.detaillbl.text = @"查看全部订单";
            
            // 设置箭头
            [cell2 setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            return cell2;
        }else{
        
            
            myCell.daifukuanNum  = [NSString stringWithFormat:@"%@",waitPay];
            myCell.daifahuoNum   = [NSString stringWithFormat:@"%@",waitSend];
            myCell.daishouhuoNum = [NSString stringWithFormat:@"%@",waitReceive];
            myCell.daipingjiaNum = [NSString stringWithFormat:@"%@",waitComment];
//            myCell.daituihuanNum = [NSString stringWithFormat:@"%@",@2];
            return myCell;
        }
        
 
    }else{
    
        
        cell.iconImg.image = [UIImage imageNamed:self.itemsIcons[indexPath.section][indexPath.row]];
        cell.titlelbl.text = self.itemsArray[indexPath.section][indexPath.row];
        
        // 设置箭头
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        
        
        return cell;
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row ==0) {
            
            //全部订单
             [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAllDingdan],@"type":@"POST"}];
            
        }
        
    }else{
    
        if (indexPath.row ==0) {
            
            //优惠券
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLHomeCoupon],@"type":@"POST"}];
        }else if (indexPath.row ==1){
            
            //资金明细
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMoneyDetail],@"type":@"POST"}];
            
        }else if (indexPath.row ==2){
        
            //我的换货
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMyselfChange],@"type":@"POST"}];
        }else if (indexPath.row ==3){
            
            //我的积分
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMyIntegration],@"type":@"POST"}];
            
            
        }else if (indexPath.row ==4){
        
            //系统消息
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLSystemMsg],@"type":@"POST"}];
            
        }else if (indexPath.row ==5){
        
            //关于我们
//            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAboutUs]}];
             [_svc pushViewController:_svc.baseWkWebViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLAboutUs],@"type":@"POST"}];
            
        }else if(indexPath.row ==6){
        
            //常见问题
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLProblems],@"type":@"POST"}];
            
   
        }else{
        
            //联系客服
             [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMyKeFu],@"type":@"POST"}];
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 &&indexPath.row ==1) {
        
        return [MyAdapter aDapter:70];
    }
    return [MyAdapter aDapter:44];
}




//用户退出登录
-(void)userlogout
{
    NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLLogOut]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            [[AppDataManager defaultManager] logout];
            
            //清除cookies
            NSHTTPCookie *cookie;
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (cookie in [storage cookies])
            {
                [storage deleteCookie:cookie];
            }
            //清除UIWebView的缓存
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TabBarControllerSelectedIndex" object:nil userInfo:@{@"index":@"0"}];
            [_svc presentViewController:_svc.loginViewController];
            
            
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
