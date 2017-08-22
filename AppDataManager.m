//
//  AppDataManager.m
//  BenShiFu
//
//  Created by fyaex001 on 16/8/16.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "AppDataManager.h"


NSString * const appDidLogoutNotification = @"appDidLogoutNotification";
NSString * const appDidLoginNotification =  @"appDidLoginNotification";


static AppDataManager* instance;

@interface AppDataManager()

@property(readonly, nonatomic)NSUserDefaults* userDefaults;
@property(readonly, nonatomic)NSDictionary * userDictionary;

@end

@implementation AppDataManager

+(instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AppDataManager alloc] init];
    });
    
    return instance;
}

-(NSDictionary *)userDictionary
{
    if (![self identifier]) {
        return nil;
    }
    return [self.userDefaults objectForKey:[self identifier]];
}

-(NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

-(void)setIdentifier:(NSString *)identifier {
    if (!identifier) {
        [self.userDefaults removeObjectForKey:@"identifier"];
        [self.userDefaults synchronize];
        return;
    }
    NSString *identifierStr = [NSString stringWithFormat:@"%@",identifier];
    
    [self.userDefaults setObject:identifierStr forKey:@"identifier"];
    NSDictionary* dic = [self.userDefaults objectForKey:identifierStr];
    if (!dic) {
        dic = @{@"isOff":@(1)};
        [self.userDefaults setObject:dic forKey:identifierStr];
    }
    
    [self.userDefaults synchronize];
}

-(NSString *)identifier {
    
    return [self.userDefaults objectForKey:@"identifier"];
}
//账号
-(void)setUseridAccount:(NSString *)useridAccount
{
    if (![self userDictionary]){
        return;
    }
    NSMutableDictionary* dic = [self.userDictionary mutableCopy];
    [dic setObject:useridAccount forKey:@"useridAccount"];
    
    [self.userDefaults setObject:dic forKey:[self identifier]];
    [self.userDefaults synchronize];
}

-(NSString *)useridAccount
{
    return [self.userDictionary objectForKey:@"useridAccount"];
}



//登录账号
-(NSString *)PhoneAccount
{
    return [self.userDefaults objectForKey:@"phoneAccount"];
}

-(void)setPhoneAccount:(NSString *)PhoneAccount
{
  
    [self.userDefaults setObject:PhoneAccount forKey:@"phoneAccount"];
    [self.userDefaults synchronize];
}



//保存登录密码
-(void)setPassWord:(NSString *)passWord
{
    if (![self identifier]) {
        
        return;
    }
    [self.userDefaults setObject:passWord forKey:@"passWord"];
    [self.userDefaults synchronize];
}

-(NSString *)passWord
{
    
    return [self.userDefaults objectForKey:@"passWord"];
}

//支付订单号
-(void)setOrder_id:(NSString *)order_id
{
    if (![self identifier]) {
        
        return;
    }
    [self.userDefaults setObject:order_id forKey:@"order_id"];
    [self.userDefaults synchronize];
}
-(NSString *)order_id
{
    return [self.userDefaults objectForKey:@"order_id"];
}

//支付类型
-(void)setOrder_type:(NSString *)order_type
{
    if (![self identifier]) {
        
        return;
    }
    [self.userDefaults setObject:order_type forKey:@"order_type"];
    [self.userDefaults synchronize];
}

-(NSString *)order_type
{
    return [self.userDefaults objectForKey:@"order_type"];
}


//保存token值
-(void)setToken:(NSString *)token
{
    [self.userDefaults setObject:token forKey:@"token"];
    [self.userDefaults synchronize];
}

-(NSString *)token
{
    return [self.userDefaults objectForKey:@"token"];
}

//保存城市
-(void)setProvinceData:(NSString *)ProvinceData
{
    [self.userDefaults setObject:ProvinceData forKey:@"ProvinceData"];
    [self.userDefaults synchronize];
}

-(NSString *)ProvinceData
{
    return [self.userDefaults objectForKey:@"ProvinceData"];
}

//保持省份Id
-(void)setProvinceId:(NSString *)ProvinceId
{
    [self.userDefaults setObject:ProvinceId forKey:@"ProvinceId"];
    [self.userDefaults synchronize];
    
}
-(NSString *)ProvinceId
{
     return [self.userDefaults objectForKey:@"ProvinceId"];
}

//是否认证成功
-(void)setIsidentification:(NSString *)Isidentification
{
    [self.userDefaults setObject:Isidentification forKey:@"Isidentification"];
    [self.userDefaults synchronize];
}

-(NSString *)Isidentification
{
     return [self.userDefaults objectForKey:@"Isidentification"];
}






//储存广告栏的信息
-(void)setBannerModelArray:(NSArray *)BannerModelArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:BannerModelArray];
    
    [self.userDefaults setObject:data forKey:@"BannerModel"];
    [self.userDefaults synchronize];
    
}

-(NSArray *)BannerModelArray
{
    NSData *data = [self.userDefaults valueForKey:@"BannerModel"];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}

//免费抢的信息
-(void)setFreeModelArray:(NSArray *)freeModelArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:freeModelArray];
    
    [self.userDefaults setObject:data forKey:@"freeModelArray"];
    [self.userDefaults synchronize];
}

-(NSArray *)freeModelArray
{
    NSData *data = [self.userDefaults valueForKey:@"freeModelArray"];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}


//首页中所有商品集合
-(void)setHomeData:(NSArray *)homeData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:homeData];
    [self.userDefaults setObject:data forKey:@"homeData"];
    [self.userDefaults synchronize];
}

-(NSArray *)homeData
{
    NSData *data = [self.userDefaults valueForKey:@"homeData"];
    NSArray *arr2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr2;
}

//分类中的数据
-(void)setSortDataSource:(NSMutableArray *)sortDataSource
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sortDataSource];
    [self.userDefaults setObject:data forKey:@"sortDataSource"];
    [self.userDefaults synchronize];
}
-(NSMutableArray *)sortDataSource
{
    NSData *data = [self.userDefaults valueForKey:@"sortDataSource"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}

-(void)setSortCollectionDatas:(NSMutableArray *)sortCollectionDatas
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sortCollectionDatas];
    [self.userDefaults setObject:data forKey:@"sortCollectionDatas"];
    [self.userDefaults synchronize];
}
-(NSMutableArray *)sortCollectionDatas
{
    NSData *data = [self.userDefaults valueForKey:@"sortCollectionDatas"];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}


//保存个人信息
-(void)setMyseldModelArray:(NSArray *)MyseldModelArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:MyseldModelArray];
    
    [self.userDefaults setObject:data forKey:@"myselfModel"];
    [self.userDefaults synchronize];
}

-(NSArray *)MyseldModelArray
{
    NSData *data = [self.userDefaults valueForKey:@"myselfModel"];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}

//保存登录密码
//-(void)setPassWord:(NSString *)passWord
//{
//    if (![self identifier]) {
//        return;
//    }
//    [self.userDefaults setObject:passWord forKey:@"passWord"];
//    [self.userDefaults synchronize];
//}
//
//-(NSString *)passWord
//{
//    
//    return [self.userDefaults objectForKey:@"passWord"];
//}

//未读消息数目
-(void)setMessageCount:(NSString *)messageCount
{
 
    [self.userDefaults setObject:messageCount forKey:@"messageCount"];
    [self.userDefaults synchronize];
}

-(NSString *)messageCount
{
    return [self.userDefaults objectForKey:@"messageCount"];
}


-(BOOL)hasLogin
{
    return [self identifier].length ? YES:NO;
}



-(void)logout {


    [[AppDataManager defaultManager] setUseridAccount:@""];
    [[AppDataManager defaultManager] setPhoneAccount:@""];
    [[AppDataManager defaultManager] setPassWord:@""];
    [self setIdentifier:nil];

    
   
}

-(BOOL)isChangeUser
{
    //    if([[UserModel sharedModel].userid isEqualToString:[self identifier]] )
    //    {
    //        return NO;
    //    }
    return YES;
    
}




@end
