
#import <Foundation/Foundation.h>

@interface AppDataManager : NSObject


+(instancetype)defaultManager;

@property (nonatomic,strong) NSString            * identifier;
/**
 *  和identifier相同
 */
@property (readwrite,nonatomic,strong ) NSString            *useridAccount;//用户的id

@property (readwrite, nonatomic,strong) NSString            * passWord;//登录密码

@property (readwrite, nonatomic,strong) NSString            *PhoneAccount;//登录账号

@property (readwrite, nonatomic,strong) NSString            *Isidentification;//是否认证成功


@property(readwrite,nonatomic, strong) NSString             *ProvinceData;//城市
@property(readwrite,nonatomic, strong) NSString             *ProvinceId;//城市

@property(readwrite,nonatomic, strong) NSMutableArray       *friendArray;//好友列表

@property(nonatomic, strong, readwrite) NSArray *BannerModelArray; //广告栏的信息
@property(nonatomic, strong, readwrite) NSArray *freeModelArray; //免费抢的信息

@property(nonatomic, strong, readwrite) NSArray *homeData;//首页中所有商品集合

//分类界面中的数据
@property(nonatomic, strong, readwrite) NSMutableArray *sortDataSource;//UITableView中的数据
@property(nonatomic, strong, readwrite) NSMutableArray *sortCollectionDatas;//collection中的数据


@property(nonatomic, strong, readwrite) NSArray *MyseldModelArray; //个人信息

@property (readwrite,nonatomic,strong ) NSString            *messageCount;//未读消息数目

@property(readwrite,nonatomic, strong) NSString             *order_id;//支付订单号
@property(readwrite,nonatomic, strong) NSString             *order_type;//支付订单类型





-(BOOL)hasLogin;

-(void)logout;

-(BOOL)isChangeUser;

-(void)loginWithIdentifier:(NSString *)identifier;


@end
