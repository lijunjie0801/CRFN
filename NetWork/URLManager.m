 

#import "URLManager.h"

////////////////////////////////////正式环境/////////////////////////////////////

//#if DEBUG
//NSString *const KBaseURL                     = @"http://yyq.jiaozujin.com/html";
//#else
//NSString *const KBaseURL                     = @"http://yyq.jiaozujin.com/html";
//#endif

////////////////////////////////////测试/////////////////////////////////////
#if DEBUG
NSString *const KBaseURL                     = @"http://zgzlw1.zilankeji.com";
#else
NSString *const KBaseURL                     = @"http://zgzlw1.zilankeji.com";
#endif

//用户行为
NSString *const KURLStringSendSma            = @"/login/sendcode";//获取验证码

NSString *const KURLStringLogin              = @"/login/getlogin";//用户登录
NSString *const KURLStringRegister           = @"/login/getsign";//用户注册

NSString *const KULStringCheckCode           = @"/login/verify_code";//忘记密码下一步

NSString *const KULStringResetPassword       = @"/login/change_pwd";//忘记密码，重置密码

NSString *const KURLProvince                 = @"/login/getareas";//获取省事区

NSString *const KURLRegisterInfo             = @"/login/submitInfo";//注册提交企业信息

NSString *const KURLLogOut                   = @"/login/logout";//用户退出


NSString *const KULNaProv                    = @"/login/getprov";//导航栏获取省份
NSString *const KULAdBanner                  = @"/sindex/index";//首页的数据

NSString *const KULMessageCount              = @"/ucenter/get_unread_sysmsg";//未读消息数目


NSString *const KULSortGoods                  = @"/sindex/goods_cate_list";//配件中心和冷库机组分类页


NSString *const KULShoppingCar               = @"/car/index";//购物车信息


NSString *const KULShoppingCarAdd            = @"/car/up";//购物车中商品数量增加
NSString *const KULShoppingCarDown           = @"/car/down";//购物车中商品数量减少

NSString *const KULDelShoppingCar            = @"/car/delcar";//删除购物车数量

NSString *const KULPayShoppingCar            = @"/index.php/Mobile/ApiUser/jieSuan";//购物车中结算


NSString *const KULHomeGoods               = @"/index.php/Mobile/ApiCommon/getGoodsList";//首页商品

NSString *const KULHomeDetail               = @"/index.php/Mobile/Goods/goodsinfo/id/";//首页商品详情

NSString *const KULHomeSearch               = @"/index.php/Mobile/Index/search";//首页刷新

NSString *const KULHomeQianDao               = @"/index.php/Mobile/ApiUser/sign";//签到

NSString *const KULSortList                = @"/index.php/Mobile/ApiCommon/getCategoryList";//分类List

NSString *const KULSortDetail              = @"/index.php/Mobile/Goods/goodsList/cate/";//分类详情



NSString *const KULMyInfo                      = @"/ucenter/index";//用户个人信息


NSString *const KULupd_myInfo                  = @"/ucenter/upd_userinfo";//修改个人信息

NSString *const KULResetPwd                    = @"/ucenter/reset_pwd";//修改密码


NSString *const KULNativePwd                  = @"/index.php/Mobile/ApiUser/getPassword";//初始密码
NSString *const KULChangePwd                  = @"/index.php/Mobile/ApiUser/updPassword";//修改密码

NSString *const KULChangeOrder                 = @"/index.php/Mobile/ApiUser/updOrder";//更新订单



//h5界面

NSString *const KURLIos                    = @"/sindex/ios";//ios是否审核

NSString *const KURLSearch                 = @"/sindex/search_goods";//搜索

NSString *const KURLSearchDetail           = @"/goods/search_re_view";//搜索详情

NSString *const KURLgoodList               = @"/goods/goods_view?cid=";//商品列表页
NSString *const KURLMessage                = @"/ucenter/sysmsg_view";//系统消息

NSString *const KURLHomeCollect            = @"/ucenter/favorite_view";//首页我的收藏
NSString *const KURLHomeCoupon             = @"/ucenter/mycoupon_view";//首页优惠券
NSString *const KURLHomeIntegration        = @"/credits/index";//首页积分商城
NSString *const KURLHomeNewsCenter         = @"/news/index";//首页新闻中心

NSString *const KURLHomeNewsDetail         = @"/news/news_detail_view?nid=";//滚动新闻详情

NSString *const KURLGoodDetail             = @"/goods/intro_view?gid=";//商品详情
NSString *const KURLTeShuGoodDetail        = @"/goods/tg_intro_view?gid=";//特殊的商品详情

NSString *const KURLMyIntegration          = @"/ucenter/mycredits_view";//我的积分
NSString *const KURLSystemMsg              = @"/ucenter/sysmsg_view";//系统消息
NSString *const KURLAboutUs                = @"/ucenter/aboutus_view";//关于我们
NSString *const KURLProblems               = @"/ucenter/problems_view";//常见问题

NSString *const KURLShoppingCarJieSuan     = @"/order/order_fromcar_view";//购物车结算


NSString *const KURLAllDingdanSearch       = @"/ucenter/search_re_view";//全部订单搜索

NSString *const KURLAllDingdan             = @"/ucenter/orderlist_view?os=999";//全部订单
NSString *const KURLZhiFu                  = @"/ucenter/orderlist_view?os=1";//待支付
NSString *const KURLFahuo                  = @"/ucenter/orderlist_view?os=2";//待发货
NSString *const KURLShouHuo                = @"/ucenter/orderlist_view?os=3";//带收货
NSString *const KURLPingJia                = @"/ucenter/orderlist_view?os=4";//待评价

NSString *const KURLTuiHuan                = @"/ucenter/exgoods_view";//退换货

NSString *const KURLYue                    = @"/index.php/Mobile/User/userMoneyList";//余额明细

NSString *const KURLMoneyDetail            = @"/ucenter/money_log_view";//资金明细

NSString *const KURLMyKeFu                 = @"/goods/sel_kf_view";//客服

NSString *const KURLJifen                  = @"/index.php/Mobile/User/pointList";//积分明细
NSString *const KURLAddress                = @"/index.php/Mobile/User/addressList";//收货地址

NSString *const KURLShare                  = @"/index.php/Mobile/User/enjoy";//分享
NSString *const KURLShowShare              = @"/index.php/Mobile/Index/enjoy";//分享

NSString *const KURLTuijian                = @"/index.php/Mobile/User/myInvited";//我的推荐

NSString *const KURLMyselfChange           = @"/ucenter/myexgoods_view";//我要换货

NSString *const KURLPhone                  = @"/login/get_kefu_phone";//电话号码

@implementation URLManager

+ (NSString *)requestURLGenetatedWithURL:(NSString *const) path
{
 
    return [KBaseURL stringByAppendingString:path];
}
@end
