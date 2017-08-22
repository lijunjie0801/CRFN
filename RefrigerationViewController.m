//
//  RefrigerationViewController.m
//  CRFN
//  冷库机组
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "RefrigerationViewController.h"
#import "CollectionViewHeaderView.h"
#import "CollectionViewCell.h"
#import "CollectionCategoryModel.h"
#import "LJCollectionViewFlowLayout.h"
#import "NSObject+Property.h"
#import "UIViewController+Dealloc.h"
#import "LeftTableViewCell.h"
#import "NGRightTableViewViewController.h"
#import "NavigationProvinveModel.h"

@interface RefrigerationViewController ()<UITextFieldDelegate,UITextFieldDelegate,UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,PulldownMenuDelegate,UICollectionViewDataSource>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, retain) NGRightTableViewViewController *rtvv;
@property (nonatomic, strong) UIView *bottomShow;

@property (nonatomic, strong) UIButton *leftbtn; //地址


@property(nonatomic, strong) NSArray *provinceArray;//所有省份

@property(nonatomic, strong) UILabel *numberLabel;

@property(nonatomic, strong) UISearchBar * searchbar ;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *collectionDatas;



@end

@implementation RefrigerationViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"lengkujizu"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
//        self.title = @"首页";
        self.tabBarItem.title = @"冷库机组";
        //调整tabbaritem中文字的位置
        self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    }
    return self;
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([AppDataManager defaultManager].ProvinceData.length>0) {
        
        [_leftbtn setTitle:[AppDataManager defaultManager].ProvinceData forState:UIControlStateNormal];
        
    }
    
    [self requsetMessageCount];
    

    
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
                
                if ([responseObject[@"status"] intValue] ==-1) {
                    
                    //退出登录
                    [self userlogout];
                }
                
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
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    
    [self requestData];
}

//获取数据
-(void)requestData
{
    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    
    
    NSDictionary *param =@{@"cid":@"143",@"province":[AppDataManager defaultManager].ProvinceId
                           };
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULSortGoods]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
//            [self.dataSource removeAllObjects];
//            [self.collectionDatas removeAllObjects];
            
            NSArray *categories = responseObject[@"list"];
            
            for (NSDictionary *dict in categories)
            {
                CollectionCategoryModel *model =
                [CollectionCategoryModel objectWithDictionary:dict];
                [self.dataSource addObject:model];
                
                NSMutableArray *datas = [NSMutableArray array];
                for (SubCategoryModel *sModel in model.children)
                {
                    [datas addObject:sModel];
                }
                [self.collectionDatas addObject:datas];
            }
            
            
            
            [self.tableView reloadData];
            [self.collectionView reloadData];
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            
            
        }else{
            if ([responseObject[@"status"] intValue] ==-1) {
                
                //退出登录
                [self userlogout];
            }
            
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
                
                [_svc showMessage:responseObject[@"message"]];
                
            }
            
            [_svc hideLoadingView];
            
        } progress:^(NSProgress *progress) {
            
            NSLog(@"1111");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [_svc hideLoadingView];
            
            [_svc showMessage:error.domain];
        }];
        
        
        
    }else{
        
        [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
        
        [_rtvv.view setHidden:YES];
        [_bottomShow setHidden:YES];
    }
    
    
    
    
    
}

-(void)rightBtnClick
{
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMessage]}];
}


-(void) menuItemSelected:(NSIndexPath *)indexPath
{
    //    NSLog(@"选择id=%d,.....%@",indexPath.item,[_provinceArray objectAtIndex:indexPath.item]);
    NavigationProvinveModel *model =  _provinceArray[indexPath.item];
    [_leftbtn setTitle:model.area_name forState:UIControlStateNormal];
    [_leftbtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    [_rtvv.view setHidden:YES];
    [_bottomShow setHidden:YES];
    [[AppDataManager defaultManager] setProvinceId:model.proId];
    [[AppDataManager defaultManager] setProvinceData:model.area_name];
    
     [self requestData];
    
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
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLSearch]}];
}

#pragma mark - Getters

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)collectionDatas
{
    if (!_collectionDatas)
    {
        _collectionDatas = [NSMutableArray array];
    }
    return _collectionDatas;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 80, HEIGHT-64-44)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[LeftTableViewCell class]
           forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        LJCollectionViewFlowLayout *flowlayout = [[LJCollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 2;
        //上下间距
        flowlayout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 + 80,0, WIDTH - 80 - 4, HEIGHT - 64 - 44) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
        //        //注册分区头标题
        //        [self.collectionView registerClass:[CollectionViewHeaderView class]
        //                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
        //                       withReuseIdentifier:@"CollectionViewHeaderView"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - UITableView DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    CollectionCategoryModel *model = self.dataSource[indexPath.row];
    cell.name.text = model.cate_name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    
    NSArray *array = self.collectionDatas[_selectIndex];
    
    if(array.count>0){
    
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        
    }
    
    
}

#pragma mark - UICollectionView DataSource Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CollectionCategoryModel *model = self.dataSource[section];
    return model.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubCategoryModel *model = self.collectionDatas[indexPath.section][indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLgoodList,model.id];
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":url}];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WIDTH - 80 - 4 - 4) / 3,
                      (WIDTH - 80 - 4 - 4) / 3 + 30);
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
//           viewForSupplementaryElementOfKind:(NSString *)kind
//                                 atIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *reuseIdentifier;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    { // header
//        reuseIdentifier = @"CollectionViewHeaderView";
//    }
//    CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                        withReuseIdentifier:reuseIdentifier
//                                                                               forIndexPath:indexPath];
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        CollectionCategoryModel *model = self.dataSource[indexPath.section];
//        view.title.text = model.name;
//    }
//    return view;
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(WIDTH, 30);
//}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath
{
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && collectionView.dragging)
    {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}

// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static float lastOffsetY = 0;
    
    if (self.collectionView == scrollView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
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
