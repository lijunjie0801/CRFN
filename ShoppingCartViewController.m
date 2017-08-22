//
//  ShoppingCartViewController.m
//  CRFN
//  购物车
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ShoppingCartViewController.h"

#import "bottomPriceView.h"
#import "MJExtension.h"
#import "ShopCartGoodViewCell.h"
#import "ShopCartHeadViewCell.h"
#import "ShoppingCarModel.h"
#import "shopCarGoodsModel.h"
#import "shopCarNormsModel.h"
#import "NoRecodeView.h"


@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,bottomPriceViewDelegate,ShopCartGoodViewCellDelegate,ShopCartHeadViewCellDelegate,UITextFieldDelegate>
{
    BOOL isShowEdit;
}


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) bottomPriceView *bottonView;

/**购物车的所有内容*/
@property (nonatomic, strong) NSMutableDictionary *shopCartDic;
@property (nonatomic, strong) NSMutableArray *shopNameArray;
/**选着的商品*/
@property (nonatomic, strong) NSMutableArray *selectedArray;
/**选中的店铺*/
@property (nonatomic, strong) NSMutableArray *selectedStoreArr;
/**购物车每件商品的模型数组*/
@property (nonatomic, strong) NSMutableArray *modelArr;
/**总价格*/
@property (nonatomic, assign) double allSum;

@property(nonatomic, strong) UILabel *numberLabel;

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong)  UIButton *editBtn;

@property(nonatomic, strong) NoRecodeView *noRecodeView;


@end



@implementation ShoppingCartViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"woyun" image:[UIImage imageNamed:@"gouwuche"] tag:1];
        //self.tabBarItem.selectedImage=[UIImage imageNamed:@"shouye_sel"];
        self.title = @"购物车";
        self.tabBarItem.title = @"购物车";
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
        
        _numberLabel.text = @"3";
        
    }
    return _numberLabel;
}

- (NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [NSMutableArray new];
    }
    return _modelArr;
}
//一个key对应该商店的所有商品
- (NSMutableDictionary *)shopCartDic{
    if (!_shopCartDic) {
        _shopCartDic = [NSMutableDictionary new];
    }
    return _shopCartDic;
}
- (NSMutableArray *)shopNameArray{
    if (!_shopNameArray) {
        _shopNameArray = [NSMutableArray new];
    }
    return _shopNameArray;
}
/**被选中的商品*/
- (NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray new];
    }
    return _selectedArray;
}
/**被选中的店铺*/
- (NSMutableArray *)selectedStoreArr{
    if (!_selectedStoreArr) {
        _selectedStoreArr = [NSMutableArray new];
    }
    return _selectedStoreArr;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showRightItem];
    
    
    
  
    
    
//    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULMessageCount]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
//    }
//    
    
    
    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
//    topView.backgroundColor = [UIColor colorWithRed:156/255.0 green:157/255.0 blue:158/255.0 alpha:1.0];
//    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7.5, 15, 15)];
//    topImg.image = [UIImage imageNamed:@"xianshi"];
//    [topView addSubview:topImg];
//    
//    UILabel *toplbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, WIDTH-30, 30)];
//    toplbl.textColor = [AppAppearance sharedAppearance].whiteColor;
//    toplbl.text = @"请于3个小时内完成付款，超时将自动移出购物车。";
//    toplbl.font = [MyAdapter fontADapter:12];
//    [topView addSubview:toplbl];
//    
//    [self.view addSubview:topView];
    
    
    self.navigationController.navigationBar.barTintColor= [AppAppearance sharedAppearance].tabBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:[MyAdapter fontDapter:20]],
                                                                      NSForegroundColorAttributeName:[AppAppearance sharedAppearance].whiteColor}];
    
//     [self getShopCartData];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64-44-kFit(50)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    self.bottonView = [[bottomPriceView alloc]initWithFrame:CGRectMake(0, SScreen_Height - kFit(50)-64-44, SScreen_Width, kFit(50))];
    self.bottonView.delegate = self;
    self.allSum = 0;
    [self.view addSubview:self.bottonView];
    
    //没有分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    //如果没有数据显示的view
    _noRecodeView = [[NoRecodeView alloc] initWithFrame:self.view.bounds];
    _noRecodeView.hidden = YES;
    [self.view addSubview:_noRecodeView];
    
    
    __weak ShoppingCartViewController *ws = self;
    
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [ws headerRefresh];
    }];
    
}

-(void)headerRefresh
{
    
    [self getShopCartData];
    [self.tableView.mj_header endRefreshing];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getShopCartData];
    
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








//购物车中的信息
-(void)getShopCartData
{
    
    
    
    //先清空选中的
    [self.selectedArray removeAllObjects];
    [self.selectedStoreArr removeAllObjects];
    [self.modelArr removeAllObjects];
    [self.shopNameArray removeAllObjects];
    [self.dataArray removeAllObjects];
    self.bottonView.isSelectBtn = NO;
    
    
    
    [_svc showLoadingWithMessage:@"加载中..." inView:[UIApplication sharedApplication].keyWindow];
    NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULShoppingCar]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
      
            _noRecodeView.hidden = YES;
            
            NSArray *sellerArray =  (NSArray *)responseObject[@"car"];
            
//            self.shopCartDic = (NSDictionary *)responseObject[@"car"];
            
            
//            ShoppingCarModel *Models = [ShoppingCarModel mj_objectArrayWithKeyValuesArray:sellerArray];
            
            
             NSArray *array =[MTLJSONAdapter modelsOfClass:[ShoppingCarModel class] fromJSONArray:sellerArray error:nil];
            
  
         
            for (int i=0; i<array.count; i++) {
                
                ShoppingCarModel *shopCarModel = (ShoppingCarModel *)array[i];
                
                NSArray *goodsArr = [MTLJSONAdapter modelsOfClass:[shopCarGoodsModel class] fromJSONArray:shopCarModel.goodsArray error:nil];
                shopCarModel.goodsArray = goodsArr;
                
                //购物车中所有的商家
                [self.shopNameArray addObject:shopCarModel.sellerId];
                //购物车中所有的商品
                [self.modelArr addObjectsFromArray:goodsArr];
                
//                for (int j=0; j<shopCarModel.goodsArray.count; j++) {
//                    
//                    shopCarGoodsModel *goodsModel = shopCarModel.goodsArray[j];
//                    
//                     NSArray *goodsnormsArr = [MTLJSONAdapter modelsOfClass:[shopCarNormsModel class] fromJSONArray:goodsModel.specArray error:nil];
////                    goodsModel.specArray = goodsnormsArr;
//                    
//                }
                
                
                
            }
            
            NSMutableArray *dicArr = [NSMutableArray arrayWithArray:array];
            self.dataArray = dicArr;
            
            
        }else if ([responseObject[@"status"] intValue] ==-1){
            
            [_svc showMessage:responseObject[@"message"]];
          
            //退出登录
            [self userlogout];
            
            
        }else{
        
            
            _noRecodeView.hidden = NO;
             [_svc showMessage:responseObject[@"message"]];
            
        }
       
        
        [_svc hideLoadingView];
        [self.tableView reloadData];
        
    } progress:^(NSProgress *progress) {
        
//        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
    
    
    
    
}

#pragma mark - tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
//    return self.shopNameArray.count;
    return self.dataArray.count;

   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   

//    NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[section]];
    ShoppingCarModel *model = self.dataArray[section];
    
    return model.goodsArray.count+1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//        NSMutableArray *array = [self.shopCartDic objectForKey:self.shopNameArray[indexPath.section]];
        if (indexPath.row == 0) {//商店头
            static NSString *ID = @"shopCartHeadCell";
            ShopCartHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[ShopCartHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            
            cell.shopCarModel = self.dataArray[indexPath.section];

            if ([self.selectedStoreArr containsObject:cell.shopCarModel.sellerId]) {
                
//                cell.selectedBtn.selected = YES;
                cell.isCheck = @"1";
                
            }else{
                
//                cell.selectedBtn.selected = NO;
                cell.isCheck = @"0";
            }
            
            return cell;
        }else{//商品
            static NSString *ID = @"shopCartGoodCell";
            ShopCartGoodViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            if (!cell) {
                cell = [[ShopCartGoodViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
                cell.countTextField.delegate = self;
            }
            
           ShoppingCarModel *shopCarModel = self.dataArray[indexPath.section];
//            cell.model = array[indexPath.row-1];
            shopCarGoodsModel *goodModel = shopCarModel.goodsArray[indexPath.row-1];
//            goodModel.indexSe = indexPath.section;
            [goodModel setIndexSe:indexPath.section];
            cell.goodsModel = goodModel;
            cell.shopModel = shopCarModel;
            return cell;
        }
            

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击进去详情
    //    GoodsDetailsController *goodsC = [[GoodsDetailsController alloc]init];
    //    [self.navigationController pushViewController:goodsC animated:YES];
    
    
    
    if(indexPath.row!=0){
    
        ShoppingCarModel *shopCarModel = self.dataArray[indexPath.section];
        shopCarGoodsModel *model = shopCarModel.goodsArray[indexPath.row-1];
        
        if ([model.isShowNums intValue]==0) {
            
            
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLTeShuGoodDetail,model.goodId]}];
            
        }else{
            
            [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLGoodDetail,model.goodId]}];
        }

        
        
    }
    
   
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.shopNameArray.count == 0) {
        if (section == 0) {
            return kFit(5);
        }else{
            return kFit(38);
        }
    }else{
        if (section == self.shopNameArray.count) {
            return kFit(38);
        }else{
            return kFit(5);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFit(1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.shopNameArray.count == 0) {
        if (indexPath.section == 0) {
            return kFit(200);
        }else{
            return YouLikeCellH + YouLikeInset;
        }
    }else{
        if (indexPath.section != self.shopNameArray.count) {
            if (indexPath.row == 0) {
                return kFit(40);
            }else{
                return kFit(100);
            }
        }else{
            return YouLikeCellH + YouLikeInset;
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 0) {
        return YES;
    }else{
        return NO;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row != 0) {
        
        
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            
            ShoppingCarModel *shopCarModel = self.dataArray[indexPath.section];
            //1.取出对应商店的所有商品数组
            NSMutableArray *array = [NSMutableArray arrayWithArray:shopCarModel.goodsArray];
            //2.0删除对应的商品
            shopCarGoodsModel *goodModel = shopCarModel.goodsArray[indexPath.row-1];
        
            
            NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"cid":goodModel.cid};
            
            [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULDelShoppingCar]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
                
                if ([responseObject[@"status"] intValue] ==1) {
                    
                    [array removeObjectAtIndex:(indexPath.row-1)];
                    //删除已选中的商品
                    //2.1删除已选中商品
                    if ([self.selectedArray containsObject:goodModel]) {
                        [self.selectedArray removeObject:goodModel];
                    }
                    
                    shopCarModel.goodsArray = array;
                    [self.modelArr removeObject:goodModel];
                    
                    if ([self.selectedStoreArr containsObject:goodModel.sellerId]) {
                        
                        [self.selectedStoreArr removeObject:goodModel.sellerId];
                        
                    }
                    
                    if (!(shopCarModel.goodsArray.count>0)) {
                        
                        [self.shopNameArray removeObject:goodModel.sellerId];
                        [self.dataArray removeObjectAtIndex:indexPath.section];
                        
                        
                        
                        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
                        [self.tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                        
                     
                        
                    }else{
                    
                           [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                      
                    }
                    
            
                    
                    
               
                    
                }
                
                
                [_svc showMessage:responseObject[@"message"]];
                [_svc hideLoadingView];
                [tableView reloadData];
                
            } progress:^(NSProgress *progress) {
                
                //                NSLog(@"1111");
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                
                [_svc hideLoadingView];
                
                [_svc showMessage:error.domain];
            }];
            
            
            
            
            
            
        }
        
        
    }

    
}
#pragma mark - ShopCartGoodViewCellDelegate
//购物车数量加
- (void)shopCartGoodViewCellChangeAdd:(ShopCartGoodViewCell *)cell{
    _allSum = 0;
    
    NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"cid":cell.goodsModel.goodId};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULShoppingCarAdd]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
//            [self getShopCartData];
            
            for (shopCarGoodsModel *model in self.selectedArray) {
                
                if ([model.isShowNums intValue] == 0) {
                    
                    self.allSum += [model.sellPrice floatValue] * [model.weight floatValue] ;
                }else{
                
                    self.allSum += [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
                    
                }
                
            
                
            }
            _bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
            
            
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
//购物车中商品数量减
-(void)shopCartGoodViewCellChangeDown:(ShopCartGoodViewCell *)cell
{
    _allSum = 0;
    NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"cid":cell.goodsModel.cid};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULShoppingCarDown]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            
            //            [self getShopCartData];
            
            for (shopCarGoodsModel *model in self.selectedArray) {
                if ([model.isShowNums intValue] == 0) {
                    
                    self.allSum += [model.sellPrice floatValue] * [model.weight floatValue] ;
                }else{
                    
                    self.allSum += [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
                    
                }
            }
            _bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];

            
            
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

#pragma  ---------选择商品点击事件-----------

- (void)shopCartGoodViewCell:(ShopCartGoodViewCell *)cell withSelectedModel:(shopCarGoodsModel *)model andShopModel:(ShoppingCarModel *)shopModel{
    
    
    
   
    
    
    if ([self.selectedArray containsObject:model]) {
        [self.selectedArray removeObject:model];
        //每当删除商品
        self.bottonView.selectedBtn.selected = NO;
        
        
        NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:model.indexSe];
        ShopCartHeadViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.shopCarModel.isSelect = NO;
//        cell.isCheck = @"0";
        
        model.isSelect = NO;
        
        if ([model.isShowNums intValue] == 0) {
            
            self.allSum -= [model.sellPrice floatValue] * [model.weight floatValue] ;
        }else{
            
            self.allSum -= [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
            
        }
        
    }else{
        
        [self.selectedArray addObject:model];
        model.isSelect = YES;
        NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:model.indexSe];
        ShopCartHeadViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.shopCarModel.isSelect = YES;

        
        if ([model.isShowNums intValue] == 0) {
            
            self.allSum += [model.sellPrice floatValue] * [model.weight floatValue] ;
        }else{
            
            self.allSum += [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
            
        }
        

    }

    
    
    BOOL isExist = YES;
    //被选中的商品商店
    for (ShoppingCarModel *model in shopModel.goodsArray) {
        
        if (![self.selectedArray containsObject:model]) {
            isExist = NO;
            break;
        }
    }
    

    NSString *num = model.sellerId;
    
    if (isExist && (![self.selectedStoreArr containsObject:num])) {
        
        NSLog(@"增加商家======%@",num);
        
        [self.selectedStoreArr addObject:model.sellerId ];
    }
    if (!isExist && ([self.selectedStoreArr containsObject:num])) {
        
        NSLog(@"减少商家========%@",num);
        
        [self.selectedStoreArr removeObject:model.sellerId ];
    }
    if (self.selectedStoreArr.count == self.shopNameArray.count) {
        //全部店铺添加
        self.bottonView.selectedBtn.selected = YES;
    }
    
    
    
    
    
      NSLog(@"=====商品是====%lu个，======商家有%lu个",(unsigned long)self.selectedArray.count,(unsigned long)self.selectedStoreArr.count);
    
    if (isShowEdit) {
        
        self.bottonView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
        
    }else{
        
        self.bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
        
    }
    
    [self.tableView reloadData];
}


#pragma mark - ShopCartHeadViewCellDelegate
- (void)shopCartHeadViewCell:(ShopCartHeadViewCell *)cell withSelectedStore:(NSString *)storeId{
    
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:cell.shopCarModel.goodsArray];
    
    if ([self.selectedStoreArr containsObject:storeId]) {
        NSLog(@"删除商家======%@",storeId);
        [self.selectedStoreArr removeObject:storeId];
        
        for (shopCarGoodsModel *model in array) {
            
            
            [self.selectedArray removeObject:model];
            //每当删除商品
            self.bottonView.selectedBtn.selected = NO;
            model.isSelect = NO;
            cell.shopCarModel.isSelect = NO;
            
            if ([model.isShowNums intValue] == 0) {
                
                self.allSum -= [model.sellPrice floatValue] * [model.weight floatValue] ;
            }else{
                
                self.allSum -= [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
                
            }
            

        }
    }else{
        [self.selectedStoreArr addObject:storeId];
        
        NSLog(@"增加商家======%@",storeId);
        
        for (shopCarGoodsModel *model in array) {
            
            if (![self.selectedArray containsObject:model]) {
                [self.selectedArray addObject:model];
                model.isSelect = YES;
                cell.shopCarModel.isSelect = YES;
//                self.allSum += [model.sellPrice floatValue] * [model.goodNums integerValue]*[model.weight intValue];
                if ([model.isShowNums intValue] == 0) {
                    
                    self.allSum += [model.sellPrice floatValue] * [model.weight floatValue] ;
                }else{
                    
                    self.allSum += [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
                    
                }
            }
        }
    }
    
    NSLog(@"选择的商品是====%lu个，选择的商家有%lu个",(unsigned long)self.selectedArray.count,(unsigned long)self.selectedStoreArr.count);
    
    if (self.selectedStoreArr.count == self.shopNameArray.count) {
        //全部店铺添加
        self.bottonView.selectedBtn.selected = YES;
    }else{
    
        self.bottonView.selectedBtn.selected = NO;
    }
    
    
    if (isShowEdit) {
        
         self.bottonView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
        
    }else{
        
         self.bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
        
    }
    
    
    [self.tableView reloadData];
}

#pragma mark - bottomPriceViewDelegate
- (void)bottomPriceView:(bottomPriceView *)bottonView{
    if (bottonView.selectedBtn.selected) {
        [self.selectedArray removeAllObjects];
        
        [self.selectedArray addObjectsFromArray:self.modelArr];

        for (shopCarGoodsModel *model in self.modelArr) {
            model.isSelect = YES;
//            ShopCartModel *shopModel = self.dataArray[model.indexSe];
//            shopModel.isSelect = YES;
        }
        [self.selectedStoreArr removeAllObjects];
        [self.selectedStoreArr addObjectsFromArray:self.shopNameArray];
        self.allSum = 0.0;
        //计算总价格
        for (shopCarGoodsModel *model in self.selectedArray) {
//            self.allSum += [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight intValue];
            
            if ([model.isShowNums intValue] == 0) {
                
                self.allSum += [model.sellPrice floatValue] * [model.weight floatValue] ;
            }else{
                
                self.allSum += [model.sellPrice floatValue] * [model.goodNums intValue] *[model.weight floatValue] ;
                
            }
            
        }
        
        
        
    }else{
        [self.selectedArray removeAllObjects];
        [self.selectedStoreArr removeAllObjects];
        
        for (shopCarGoodsModel *model in self.modelArr) {
            model.isSelect = NO;
            
        }
        self.allSum = 0.0;
    }
    
    if (isShowEdit) {
        
        
        bottonView.payStr = [NSString stringWithFormat:@"%lu", self.selectedArray.count];
        
       
        
    }else{
    
         bottonView.attAllStr = [NSString stringWithFormat:@"%.2f", self.allSum];
        
    }
    
    
    
    [self.tableView reloadData];
    
}

//结算或者删除
-(void)bottomPayBtnClick
{
    NSMutableString *str = [[NSMutableString alloc]init];
    
    for (shopCarGoodsModel *model in self.selectedArray) {
        
        [str appendString:[NSString stringWithFormat:@"%@,",model.cid]];
    }
    

  
    
    if (isShowEdit) {
        
        if (str.length>1) {
            
            NSString *cidStr = [str substringToIndex:str.length-1];
            
            //删除
            [self delegateShopCarGoods:cidStr];
            
        }
     
        
    }else{
    
        //结算
        if (str.length>1) {
            
            
            BOOL isok = true;
            for (int i=1; i<self.selectedArray.count; i++) {
                
                shopCarGoodsModel *model = self.selectedArray[i-1];
                shopCarGoodsModel *model1 = self.selectedArray[i];
                if (![model.sellerId isEqualToString:model1.sellerId]) {
                    
                    isok = false;
                    break;
                }
            }
            
//            BOOL isShow = true;
//            for (int i=1; i<self.selectedArray.count; i++) {
//                
//                shopCarGoodsModel *model = self.selectedArray[i-1];
//                shopCarGoodsModel *model1 = self.selectedArray[i];
//                if ([model.isShowNums intValue] != [model1.isShowNums intValue]) {
//                    
//                    isShow = false;
//                    break;
//                }
//            }

            if (isok) {
                
//                NSLog(@"单个商家可以去支付");
                NSString *cidStr = [str substringToIndex:str.length-1];
                
                [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@",KBaseURL,KURLShoppingCarJieSuan],@"type":@"POST",@"cids":cidStr}];
//                if (isShow) {
//                    
//                    NSLog(@"数量类型一样可以去支付");
//                    
//                     NSString *cidStr = [str substringToIndex:str.length-1];
//                    
//                    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@",KBaseURL,KURLShoppingCarJieSuan],@"type":@"POST",@"cids":cidStr}];
//                    
//                    
//                    
//                }else{
//                
//                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"可选择数量和不可选择数量的商品不能一起结算" preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    
//                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
//                    
//                    [alertController addAction:okAction];
//                    
//                    
//                    [self.navigationController presentViewController:alertController animated:YES completion:nil];
//                    
//                }
                
                
                
            }else{
            
//                NSLog(@"多个商家不可以去支付");
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"多个商家不可以支付" preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
                
                [alertController addAction:okAction];
              
                
                [self.navigationController presentViewController:alertController animated:YES completion:nil];
                
                
            }
            
        }
      
        
        
    }
}



//编辑按钮
-(void)editClick:(UIButton *)btn
{
    NSLog(@"编辑商品");
     btn.selected = !btn.selected;
    if (btn.selected) {
        
        [_editBtn setTitle:@"完成" forState:UIControlStateNormal];
        isShowEdit = YES;
        [_bottonView.payBtn setTitle:@"删除" forState:UIControlStateNormal];
//        _bottonView.payStr = [NSString stringWithFormat:@"%d",self.selectedArray.count];
        
    }else{
    
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_bottonView.payBtn setTitle:@"结算" forState:UIControlStateNormal];
//        _bottonView.attAllStr = @"200.00";
        
        
        isShowEdit = NO;
    }
    
    [self bottomPriceView:_bottonView];
    
}





-(void)showRightItem
{
    
    _editBtn=[self.class buttonWithImage:nil title:@"编辑" target:self action:@selector(editClick:)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_editBtn];
    
    
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
    
  self.navigationItem.rightBarButtonItems=@[rightItem,item];
}

//消息按钮
-(void)rightBtnClick
{
   
 
    [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLMessage]}];
}



//删除购物车
-(void)delegateShopCarGoods:(NSString *)cidStr
{
    NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"cid":cidStr};
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULDelShoppingCar]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
 
        if ([responseObject[@"status"] intValue] ==1) {
            
            
            [self getShopCartData];
            
            
        }
        
        
        
        [_svc showMessage:responseObject[@"message"]];
        //
        //                [_svc hideLoadingView];
        //                [tableView reloadData];
        
    } progress:^(NSProgress *progress) {
        
        //                NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
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
