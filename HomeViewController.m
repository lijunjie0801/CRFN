//
//  HomeViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HomeViewController.h"
#import "XlScrollViewController.h"
#import "goodCellCollectionViewCell.h"
#import "goodCellCollectionViewCell2.h"
#import "SDCycleScrollView.h"
#import "SDHomeGridView.h"
#import "SDHomeGridItemModel.h"
#import "MessageScrollerView.h"
#import "MessageScrollerModel.h"
#import "BannerModel.h"
#import "HomeModel.h"
#import "NavigationProvinveModel.h"
#import <CoreLocation/CoreLocation.h>
#define headerViewIdentifier  @"hederview"
#import "NGRightTableViewViewController.h"

@interface HomeViewController ()<SDCycleScrollViewDelegate,SDHomeGridViewDeleate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITextFieldDelegate,UISearchBarDelegate,UISearchDisplayDelegate,CLLocationManagerDelegate,PulldownMenuDelegate>
{
    double Locationlatitude;//纬度
    double Locationlongitude;//经度
    NSString *provinceName; //省份
    
}



@property(nonatomic,retain) CLLocationManager *locationManager;


@property(nonatomic, strong) UISearchBar * searchbar ;

@property(nonatomic, strong) NSArray        *bannerList;
@property(nonatomic, strong) UIView         *headerView;
@property(nonatomic, strong) XlScrollViewController *adScrollView;
@property(nonatomic, weak) SDHomeGridView *mainView;
@property(nonatomic, strong) MessageScrollerView *messageViews;

@property(nonatomic,strong)UICollectionView *goodCollectionView;

//火热推荐，限时优惠
@property(nonatomic, strong) NSArray *hotGoodsArray,*timeGoodsArray;

@property(nonatomic,strong)MASConstraint * height;


@property (nonatomic, retain) NGRightTableViewViewController *rtvv;
@property (nonatomic, strong) UIView *bottomShow;

@property (nonatomic, strong) UIButton *leftbtn; //地址


@property(nonatomic, strong) NSArray *provinceArray;//所有省份

@property(nonatomic, strong) UILabel *numberLabel;

@end

@implementation HomeViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"shouye"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"首页";
        self.tabBarItem.title = @"首页";
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
}

-(NSArray *)hotGoodsArray
{
    if (!_hotGoodsArray) {
        
        _hotGoodsArray = [[NSArray alloc] init];
    }
    return _hotGoodsArray;
}

-(NSArray *)timeGoodsArray
{
    if (!_timeGoodsArray) {
        
        _timeGoodsArray = [[NSArray alloc] init];
    }
    return _timeGoodsArray;
}

-(NSArray *)provinceArray
{
    if (!_provinceArray) {
        
        _provinceArray = [[NSArray alloc] init];
    }
    return _provinceArray;
}


#pragma mark --------------定位的代理方法-----------
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currLocation = [locations lastObject];
    // NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    //经度
    Locationlatitude = [[NSString stringWithFormat:@"%f",currLocation.coordinate.latitude] doubleValue];
    //纬度
    Locationlongitude = [[NSString stringWithFormat:@"%f",currLocation.coordinate.longitude] doubleValue];
    
    
    
    
    
    //测试手动设置经纬度
//    float latitude = 38.0370570000;
//    float longitude = 114.4686640000;
//     CLLocationCoordinate2D center = {latitude,longitude};
//    CLLocation *locationCe = [[CLLocation alloc] initWithLatitude:center.latitude longitude:center.longitude];
//
//    //经度
//    Locationlatitude = latitude;
//    //纬度
//    Locationlongitude = longitude;
    
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //反地理编码  (根据经纬度获取地理名称)
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //放错处理
        if (placemarks.count == 0 || error) {
            
            NSLog(@"定位错误");
            return ;
        }
        
        for (CLPlacemark *place in placemarks) {
            
            
            //            NSLog(@"省份：%@", place.administrativeArea);
            //            NSLog(@"城市：%@", place.locality);
            //            NSLog(@"区：%@", place.subLocality);
            
            NSString *provice = place.administrativeArea;
            NSString *city    = place.locality;
//            NSString *qu      = place.subLocality;
            
            if ([place.administrativeArea rangeOfString:@"省"].location == NSNotFound) {
                NSLog(@"string 不存在省");
            } else {
                NSLog(@"string 包含省");
                //去掉最后一个字符串
               provice = [place.administrativeArea substringToIndex:[place.locality length]-1];
               
            }

             provinceName = provice;
            
            [[AppDataManager defaultManager] setProvinceData:provinceName];
            
            [_leftbtn setTitle:provinceName forState:UIControlStateNormal];
            
             NSLog(@"这个方法调用了多少遍啊");
             [self requsetData];
             [_locationManager stopUpdatingLocation];
            
        }
        
        
    }];
    
   
//    [_locationManager stopUpdatingLocation];
    
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([AppDataManager defaultManager].ProvinceData.length>0) {
        
        [_leftbtn setTitle:[AppDataManager defaultManager].ProvinceData forState:UIControlStateNormal];
        
    }
    
    //未读消息数目
    [self requsetMessageCount];
    
    [self requsetData];
    
    
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
   

    
    
    
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    
    /** 由于IOS8中定位的授权机制改变 需要进行手动授权
     * 获取授权认证，两个方法：
     * [self.locationManager requestWhenInUseAuthorization];
     * [self.locationManager requestAlwaysAuthorization];
     */
    
    [_locationManager requestWhenInUseAuthorization];
//    [_locationManager requestAlwaysAuthorization];//添加这句
    [_locationManager startUpdatingLocation];
    
    //创建视图
    [self initView];
    
   
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
  
   
}


-(UILabel *)numberLabel
{
    if (!_numberLabel) {

        static CGFloat const kNameLabelWidth = 14;
        static CGFloat const kNameLabelHeight = 14;
        static CGFloat const kNameLabelX = 40; // 父视图宽44，UI说改到这个位置
        static CGFloat const kNameLabelY = 6;

        _numberLabel = [UILabel new];
//        _numberLabel.hidden = YES;
        _numberLabel.frame = CGRectMake(kNameLabelX, kNameLabelY, kNameLabelWidth, kNameLabelHeight);

        _numberLabel.backgroundColor = [AppAppearance sharedAppearance].redColor;
        _numberLabel.textColor = [AppAppearance sharedAppearance].whiteColor;
        _numberLabel.font = [UIFont systemFontOfSize:9];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.layer.cornerRadius = kNameLabelHeight * 0.5;
        _numberLabel.layer.masksToBounds = YES;

//        _numberLabel.text = @"3";

    }
    return _numberLabel;
}


-(void)initView
{
    self.view.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
     self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    //左右导航按钮与searchbar
    _leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftbtn.frame = CGRectMake(0, 0, [MyAdapter aDapter:40], 35);
    [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
//    [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_upArrow"] forState:UIControlStateSelected];
    _leftbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [_leftbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -[MyAdapter aDapter:35], 0, 0)];
    _leftbtn.imageEdgeInsets = UIEdgeInsetsMake(0, [MyAdapter aDapter:32], 0, -[MyAdapter aDapter:10]);
    [_leftbtn setTitle:@"内蒙古" forState:UIControlStateNormal];
    _leftbtn.titleLabel.font = [MyAdapter lfontADapter:18];
    [_leftbtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
     UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:_leftbtn];
    [self.navigationItem setLeftBarButtonItem:leftItem animated:YES];
    
    
//    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"tel"] forState:UIControlStateNormal];
//    rightBtn.frame = (CGRectMake(0, 0, [MyAdapter laDapter:25],[MyAdapter laDapter:25]
//                                 ));
    
    static CGFloat const kButtonWidth = 43.0f;
    static CGFloat const kButtonHeight = 43.0f;
    
    UIImage *cartImage = [[UIImage imageNamed:@"ic_xiaoxi"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0.0f, 0.0f, kButtonWidth, kButtonHeight);
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn setImage:cartImage forState:UIControlStateNormal];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0f,(kButtonHeight- cartImage.size.width), 0.0f, 0.0f)];
    [rightBtn addSubview:self.numberLabel];
     self.numberLabel.hidden = YES;
    
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightItem animated:YES];
    
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [MyAdapter laDapter:250], [MyAdapter laDapter:36])];
//    [titleView setBackgroundColor:COMMON_TITLE_COLOE];
    
    _searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [MyAdapter laDapter:250], [MyAdapter laDapter:36])];
    _searchbar.delegate = self;
//    _searchbar.backgroundColor = COMMON_TITLE_COLOE;
    _searchbar.layer.cornerRadius = [MyAdapter laDapter:15];
    _searchbar.layer.masksToBounds = YES;
    [_searchbar.layer setBorderWidth:8];
    [_searchbar.layer setBorderColor:[UIColor whiteColor].CGColor];
    _searchbar.placeholder = @"商品搜索";
    [titleView addSubview:_searchbar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
    
    //UICollectionView
    self.automaticallyAdjustsScrollViewInsets=NO;
    UICollectionViewFlowLayout * layout1 = [[UICollectionViewFlowLayout alloc]init];
    //滚动的方向
    [layout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    _goodCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout1];
    //注册头视图
     [_goodCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
//    [_goodCollectionView registerClass:[goodCellCollectionViewCell class] forCellWithReuseIdentifier:gCellIdentifier_good];
    _goodCollectionView.backgroundColor = [UIColor whiteColor];
    _goodCollectionView.showsHorizontalScrollIndicator = NO;
    _goodCollectionView.showsVerticalScrollIndicator = NO;
    _goodCollectionView.dataSource=self;
    _goodCollectionView.delegate=self;
    [self.view addSubview:_goodCollectionView];
    [_goodCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.width.offset(WIDTH);
//        self.height = make.height.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    [self createRefresh];
//    [self requsetData];
    
    
}


-(void)leftBtnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_upArrow"] forState:UIControlStateNormal];
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULNaProv]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功");
            NSLog(@"%@",responseObject);
            
            
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                NSArray *dataArray = responseObject[@"areas"];
                self.provinceArray =[MTLJSONAdapter modelsOfClass:[NavigationProvinveModel class] fromJSONArray:dataArray error:nil];
                
                
                if (_rtvv==nil) {
                    _rtvv=[[NGRightTableViewViewController alloc] init];
                    _rtvv.view.frame=CGRectMake(0, 0, WIDTH, 200);
//                    _rtvv.view.frame=CGRectMake(150, 64, 165, 120);
                    [self addChildViewController:_rtvv];
                    [self.view addSubview:_rtvv.view];
                    _rtvv.pulldelegate=self;
                    [_rtvv.view setHidden:YES];
                    
                    
                }
                
                if (_bottomShow == nil) {
                    
                    _bottomShow = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_rtvv.view.frame), WIDTH, HEIGHT-200)];
                    _bottomShow.backgroundColor = [UIColor blackColor];
                    _bottomShow.alpha = 0.3;
                    [self.view addSubview:_bottomShow];
                    [_bottomShow setHidden:YES];
                    _bottomShow.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomShowClick)];
                    [_bottomShow addGestureRecognizer:tag];
                }
                
                _rtvv.tableViewArray=self.provinceArray;
                 [_rtvv.view setHidden:NO];
                [_bottomShow setHidden:NO];
                
                
            }else{
                
                if ([responseObject[@"status"] intValue] ==-1) {
                    
                    //退出登录
//                    [self userlogout];
                }
                
                
                [_svc showMessage:responseObject[@"message"]];
                
            }
            
            [_svc hideLoadingView];
            
        } progress:^(NSProgress *progress) {
            
            NSLog(@"1111");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [_svc hideLoadingView];
            
//            [_svc showMessage:error.domain];
        }];
        

        
    }else{
    
         [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
        
        [_rtvv.view setHidden:YES];
        [_bottomShow setHidden:YES];
    }
    
    
    
    
   
}

//消息
-(void)rightBtnClick
{
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMessage]}];
}


-(void) menuItemSelected:(NSIndexPath *)indexPath
{
//    NSLog(@"选择id=%d,.....%@",indexPath.item,[_provinceArray objectAtIndex:indexPath.item]);
    NavigationProvinveModel *model =  _provinceArray[indexPath.item];
    provinceName = model.area_name;
    [[AppDataManager defaultManager] setProvinceId:model.proId];
    
    [_leftbtn setTitle:provinceName forState:UIControlStateNormal];
    [self requsetData];
     [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    [_rtvv.view setHidden:YES];
    [_bottomShow setHidden:YES];
    
}

//地址选择按钮下面的阴影部分
-(void)bottomShowClick
{
    
     [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    [_rtvv.view setHidden:YES];
    [_bottomShow setHidden:YES];
}



//搜索
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{

    [_svc pushViewController:_svc.searchWebViewViewController withObjects:@{@"urls":[URLManager requestURLGenetatedWithURL:KURLSearch]}];
   
}



//未读消息数目
-(void)requsetMessageCount
{
    
    if ([AppDataManager defaultManager].identifier) {
        
        
        NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULMessageCount]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                
                NSString *msgCount = [NSString stringWithFormat:@"%@",responseObject[@"count"]];
                
                if ([msgCount isEqualToString:@"0"]) {
                    
                    _numberLabel.hidden = YES;
                }else{
                    
                    _numberLabel.hidden = NO;
                    _numberLabel.text = msgCount;
                }
                
                
            }else{
                
                 [_svc showMessage:responseObject[@"message"]];
                
                if ([responseObject[@"status"] intValue] ==-1) {
                    
                    //退出登录
//                    [self userlogout];
                }
                
               
            }
            
            [_svc hideLoadingView];
            
        } progress:^(NSProgress *progress) {
            
            //        NSLog(@"1111");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [_svc hideLoadingView];
            
//            [_svc showMessage:error.domain];
        }];

        
        
    }
   
}







#pragma mark - SDHomeGridViewDeleate
-(void)homeGrideView:(SDHomeGridView *)gridView selectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击的是==%ld",(long)index);
    if (index == 0) {
        //空调支架
        
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@146",KBaseURL,KURLgoodList]}];
        
//         [_svc pushViewController:_svc.baseWkWebViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@146",KBaseURL,KURLgoodList]}];
        
        
    }else if (index ==1){
    
        //钢管
       [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@15",KBaseURL,KURLgoodList]}];
    }else if (index ==2){
        
        //氟利昂
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@139",KBaseURL,KURLgoodList]}];
    
    }else if (index ==3){
        
        //压缩机
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@147",KBaseURL,KURLgoodList]}];
    
    }else if (index ==4){
     
        //我的收藏
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLHomeCollect]}];
    
    }else if (index ==5){
        //优惠券
        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLHomeCoupon]}];
    
    }else if (index ==6){
        //积分商城
         [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLHomeIntegration]}];
    
    }else if (index ==7){
    
        //新闻中心
         [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLHomeNewsCenter]}];
    }
}


//刷新
-(void)createRefresh
{
    WS(weakSelf);
    self.goodCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf headerRefresh];
        
    }];
    self.goodCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf footerRefresh];
    }];
}

//下拉刷新
-(void)headerRefresh
{
    
    [self requsetData];
    
    [self.goodCollectionView.mj_header endRefreshing];
}

//获取首页的收据
-(void)requsetData
{
    
    
//    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];

    
    NSLog(@"选择的城市====%@",provinceName);
    
    
   
    
    if ([AppDataManager defaultManager].ProvinceData.length>0) {
        
        provinceName = [AppDataManager defaultManager].ProvinceData;
    }
    
    
    
    if (provinceName.length == 0) {
        
        provinceName = @"安徽";
    }else{
    
        if ([provinceName rangeOfString:@"省"].location == NSNotFound) {
            NSLog(@"string 不存在省");
        } else {
            NSLog(@"string 包含省");
            //去掉最后一个字符串
            provinceName = [provinceName substringToIndex:provinceName.length-1];
            
        }
    }
    
    [[AppDataManager defaultManager] setProvinceData:provinceName];
    
    NSDictionary *param =@{@"prov":provinceName};
    
    
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULAdBanner]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSLog(@"%@",responseObject);

        if ([responseObject[@"status"] intValue] ==1) {
            
            
            
            
            //图片轮播器中的数据
            NSArray *AdArray = (NSArray *)responseObject[@"adv"];
            NSArray *array =[MTLJSONAdapter modelsOfClass:[BannerModel class] fromJSONArray:AdArray error:nil];
            [_adScrollView updateOfInterface:array];
            
            
            
            
            //轮播消息
            
            NSArray *messageArray = responseObject[@"news"];
            NSArray *Mesarray =[MTLJSONAdapter modelsOfClass:[MessageScrollerModel class] fromJSONArray:messageArray error:nil];
            
//            NSMutableArray *mesArray = [NSMutableArray array];
//            for (int i=0; i<1; i++) {
//                
//                MessageScrollerModel *model = [MessageScrollerModel new];
//                model.titId = @"12";
//                model.title = [NSString stringWithFormat:@"%d:年后大幅度解放军看电视剧",i];
//                [mesArray addObject:model];
//            }
            
            [_messageViews setDataMessageArray:Mesarray];
            
            
            //UICollectionView中的数据
            //限时优惠
            NSArray *timeArray = (NSArray *)responseObject[@"time_goods"];
            self.timeGoodsArray =[MTLJSONAdapter modelsOfClass:[HomeModel class] fromJSONArray:timeArray error:nil];
            //火热推荐
            NSArray *hotArray = (NSArray *)responseObject[@"hot_goods"];
            self.hotGoodsArray =[MTLJSONAdapter modelsOfClass:[HomeModel class] fromJSONArray:hotArray error:nil];
            
            
            
        
            
            
            
            [[AppDataManager defaultManager] setProvinceId:responseObject[@"provId"]];
            
            [_goodCollectionView reloadData];
         
            
        }else{
        
            if ([responseObject[@"status"] intValue] ==-1) {
                
                //退出登录
//                [self userlogout];
            }
            
            
//             [_svc showMessage:responseObject[@"message"]];
            
        }
       
        [_svc hideLoadingView];
        
    } progress:^(NSProgress *progress) {
        
//        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
//        [_svc showMessage:error.domain];
    }];
}





//上啦刷新
-(void)footerRefresh
{
    [self.goodCollectionView.mj_footer endRefreshing];
}


#pragma mark -----UICollectionDelegate-----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    if (section == 0) {
        
        return self.timeGoodsArray.count;
    }
    return self.hotGoodsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        static BOOL nibri =NO;
        if(!nibri){
            
            [_goodCollectionView registerClass:[goodCellCollectionViewCell class] forCellWithReuseIdentifier:gCellIdentifier_good];
            nibri =YES;
        }
        
        goodCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gCellIdentifier_good forIndexPath:indexPath];
        
        HomeModel *model = self.timeGoodsArray[indexPath.row];
        cell.homeModel = model;
        
        
        
        nibri=NO;
        return cell;
        
    }else{
    
        
        static BOOL nibri =NO;
        if(!nibri){
            
            [_goodCollectionView registerClass:[goodCellCollectionViewCell2 class] forCellWithReuseIdentifier:gCellIdentifier_good2];
            nibri =YES;
        }
        
        goodCellCollectionViewCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:gCellIdentifier_good2 forIndexPath:indexPath];
        
        HomeModel *model = self.hotGoodsArray[indexPath.row];
        cell.homeModel = model;
        
        
        
        nibri=NO;
        return cell;
        
        
    }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        HomeModel *model = self.timeGoodsArray[indexPath.row];
        
        if ([model.user_nums isEqualToString:@"0"]) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLTeShuGoodDetail,model.goodId];
            
             [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLTeShuGoodDetail,model.goodId]}];
            
        }else{
        
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLGoodDetail,model.goodId]}];
        }
     
        
    }else{
    
         HomeModel *model = self.hotGoodsArray[indexPath.row];
        if ([model.user_nums isEqualToString:@"0"]) {
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLTeShuGoodDetail,model.goodId]}];
            
        }else{
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLGoodDetail,model.goodId]}];
        }
    }
}



//定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH-[MyAdapter laDapter:30])/2,[MyAdapter laDapter:170]);
}

//定义每个UICollectionView 的间距  //
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake([MyAdapter laDapter:10],[MyAdapter laDapter:10],[MyAdapter laDapter:10],[MyAdapter laDapter:10]);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [MyAdapter laDapter:10];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//section的高度
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return CGSizeMake(WIDTH, 250*WIDTH/640+[MyAdapter laDapter:190]+ [MyAdapter aDapter:42]+10 +[MyAdapter aDapter:20]+10);
    }else{
    
         return CGSizeMake(WIDTH,[MyAdapter aDapter:20]+10);
        
    }
   
}


//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        
        
        for (UIView *view in header.subviews) {
            
            [view removeFromSuperview];
        }
        
        if (indexPath.section ==0) {
            
            //添加头视图的内容
            [self addContent];
            
            header.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
            //头视图添加view
            [header addSubview:_headerView];
            return header;
            
        }else {
            
            
//            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 5, WIDTH, 10)];
//            line.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
//            [header addSubview:line];
            
            UIImageView *secionImg = [[UIImageView alloc] initWithFrame:CGRectMake(10,0, [MyAdapter aDapter:20], [MyAdapter aDapter:20])];
            secionImg.image = [UIImage imageNamed:@"10"];
            [header addSubview:secionImg];
            UILabel *sectionlbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secionImg.frame)+5, 0, WIDTH-10-5-[MyAdapter aDapter:25], [MyAdapter aDapter:25])];
            sectionlbl.text = @"火热推荐";
            sectionlbl.font = [MyAdapter fontADapter:14];
            sectionlbl.textColor = [AppAppearance sharedAppearance].redColor;
            [header addSubview:sectionlbl];
            
            return header;
            
        }
        
        
    }
    
    
    return nil;

    
}

-(void)addContent
{
    
    if (!_headerView) {
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 250*WIDTH/640+[MyAdapter laDapter:190]+ [MyAdapter aDapter:42]+10)];
        _headerView.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        //广告栏
        float bannerHeight=250*WIDTH/640;
        _adScrollView = [[XlScrollViewController alloc] init];
        _adScrollView.view.frame = CGRectMake(0, 0, WIDTH, bannerHeight);
        _adScrollView.animationDuration = 3.f;
        _adScrollView.pageNumber = 0;
        _adScrollView.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_headerView addSubview:_adScrollView.view];
        
        SDHomeGridView *mainView = [[SDHomeGridView alloc] initWithFrame:CGRectMake(0, bannerHeight, _headerView.frame.size.width, [MyAdapter laDapter:190])];   //工作台
        mainView.gridViewDelegate = self;
        mainView.showsVerticalScrollIndicator = NO;
        
        NSMutableArray *array = [NSMutableArray array];
        NSArray *itemTitleArray = @[@"空调支架",@"铜管",@"氟利昂",@"压缩机",@"我的收藏",@"优惠券",@"积分商城",@"新闻中心"];
        NSArray *iconArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08"];
        for (int i=0; i<8; i++) {
            
            SDHomeGridItemModel *model = [[SDHomeGridItemModel alloc] init];
            model.imageResString =iconArray[i];
            model.title = itemTitleArray[i];
            [array addObject:model];
        }
        //    [self setupDataArray];
        mainView.gridModelsArray = array;
        [_headerView addSubview:mainView];
        _mainView = mainView;
        [_headerView bringSubviewToFront:_mainView];
        
        UIImageView *mesImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.mainView.frame), [MyAdapter aDapter:70], [MyAdapter aDapter:42])];
//        mesImg.contentMode = UIViewContentModeScaleAspectFit;
        mesImg.image = [UIImage imageNamed:@"09"];
        [_headerView addSubview:mesImg];
        
        _messageViews = [[MessageScrollerView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(mesImg.frame)+10, CGRectGetMaxY(self.mainView.frame), WIDTH-[MyAdapter aDapter:70]-20, [MyAdapter aDapter:42])];
        [_headerView addSubview:_messageViews];
        
//        NSMutableArray *mesArray = [NSMutableArray array];
//        for (int i =0; i<=10; i++) {
//            
//            MessageScrollerModel *model = [[MessageScrollerModel alloc] init];
//            model.title = @"探索制冷配件行业新的经营模式111";
//            model.title1 = @"探索制冷配件行业新的经营模式222";
//            [mesArray addObject:model];
//            
//        }
//        [_messageViews setDataMessageArray:mesArray];
        
        
        UIImageView *secionImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_messageViews.frame)+10, [MyAdapter aDapter:20], [MyAdapter aDapter:20])];
        secionImg.image = [UIImage imageNamed:@"11"];
        [_headerView addSubview:secionImg];
        UILabel *sectionlbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(secionImg.frame)+5, CGRectGetMaxY(_messageViews.frame)+10, WIDTH-10-5-[MyAdapter aDapter:25], [MyAdapter aDapter:25])];
        sectionlbl.text = @"限时优惠";
        sectionlbl.font = [MyAdapter fontADapter:14];
        sectionlbl.textColor = [AppAppearance sharedAppearance].redColor;
        [_headerView addSubview:sectionlbl];
        
        
    }
    
   
   
}


#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:NO];
    [searchBar resignFirstResponder];
    [self.view endEditing:YES];
    
    return YES;
}



- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
