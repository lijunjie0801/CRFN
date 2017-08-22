 

#import <Foundation/Foundation.h>

extern NSString *const KBaseURL;  //服务器地址

//用户行为

extern NSString *const KURLHomeMessage; //首页滚动消息


extern NSString *const KURLStringSendSma;//获取验证码
extern NSString *const KURLStringLogin;//用户登录
extern NSString *const KURLProvince;//获取省事区
extern NSString *const KURLStringRegister;//用户注册
extern NSString *const KURLRegisterInfo;//注册提交企业信息
extern NSString *const KULStringCheckCode;//忘记密码下一步
extern NSString *const KULStringResetPassword;//忘记密码
extern NSString *const KURLLogOut;//用户退出
extern NSString *const KULNaProv;//导航栏获取省份
extern NSString *const KULAdBanner;//首页的数据
extern NSString *const KULSortGoods;//配件中心和冷库机组分类页

extern NSString *const KULShoppingCar;//购物车信息

extern NSString *const KULShoppingCarAdd;//购物车中商品数量增加
extern NSString *const KULShoppingCarDown;//购物车中商品数量减少

extern NSString *const KULDelShoppingCar;//删除购物车数量

extern NSString *const KULPayShoppingCar;//购物车中结算




extern NSString *const KULMessageNotice;//滚动新闻

extern NSString *const KULHomeGoods;//首页商品

extern NSString *const KULMessageCount;//未读消息数目

extern NSString *const KULHomeSearch;//首页刷新

extern NSString *const KULHomeQianDao;//签到

extern NSString *const KULHomeDetail;//首页商品详情

extern NSString *const KULSortList;//分类list
extern NSString *const KULSortDetail;//分类详情

extern NSString *const KULMyAccount;//用户基本信息
extern NSString *const KULMyInfo;//用户个人信息
extern NSString *const KULupd_myInfo;//修改用户信息
extern NSString *const KULResetPwd ;//修改密码


extern NSString *const KULNativePwd;//初始密码
extern NSString *const KULChangePwd;//修改密码
extern NSString *const KULChangeOrder;//更新订单

extern NSString *const KURLPhone;//电话号码



//h5界面

extern NSString *const KURLIos;//ios是否审核

extern NSString *const KURLSearchDetail;//搜索详情
extern NSString *const KURLSearch;//搜索界面
extern NSString *const KURLgoodList;//商品列表页
extern NSString *const KURLMessage;//系统消息

extern NSString *const KURLHomeCollect;//首页我的收藏
extern NSString *const KURLHomeCoupon;//首页优惠券
extern NSString *const KURLHomeIntegration;//首页积分商城
extern NSString *const KURLHomeNewsCenter;//首页新闻中心
extern NSString *const KURLHomeNewsDetail;//滚动新闻详情

extern NSString *const KURLGoodDetail;//商品详情
extern NSString *const KURLTeShuGoodDetail;//特殊的商品详情

extern NSString *const KURLMyKeFu;//客服

extern NSString *const KURLMyIntegration;//我的积分
extern NSString *const KURLSystemMsg;//系统消息
extern NSString *const KURLAboutUs;//关于我们
extern NSString *const KURLProblems;//常见问题

extern NSString *const KURLShoppingCarJieSuan;//购物车结算


extern NSString *const KURLAllDingdanSearch;//全部订单搜索

extern NSString *const KURLAllDingdan;//全部订单
extern NSString *const KURLZhiFu;//待支付
extern NSString *const KURLFahuo;//待发货
extern NSString *const KURLShouHuo;//带收货
extern NSString *const KURLPingJia;//待评价
extern NSString *const KURLTuiHuan;//退换货

extern NSString *const KURLMoneyDetail;//资金明细

extern NSString *const KURLMyselfChange;//我要换货

extern NSString *const KURLYue;//余额明细
extern NSString *const KURLJifen;//积分明细
extern NSString *const KURLAddress;//收货地址
extern NSString *const KURLShare;//分享
extern NSString *const KURLShowShare;//分享
extern NSString *const KURLTuijian;//我的推荐




@interface URLManager : NSObject
+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path;
@end
