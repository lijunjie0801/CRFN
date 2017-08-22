

#import <UIKit/UIKit.h>

@class SwitchViewController;

@interface BaseViewController : UIViewController
{
    
@protected
    SwitchViewController *_svc;
    NSDictionary *_intentDic;
    
}


/*
 所有继承自BaseViewController的vc,若要正常的用svc，需要init初始化
 */

//此为svc单例
@property(nonatomic ,readonly) SwitchViewController *svc;
@property(nonatomic ,strong) NSDictionary *intentDic;

/*
 自定义message内容，当state为CustomMessage时，会使用这个message种的信息
 */
@property(nonatomic ,strong) NSString *customMessage;


/**
 *  当前ViewController是否可以被缓存
 *
 *  @return 默认为NO
 */
-(BOOL)canBeCached;
/**
 *  是否使导航栏完全透明
 *
 *  @return 默认为NO
 */
-(BOOL)shouldHideNavigationBar;
/**
 *  自定义button
 *
 *  @return 自定义的barButtonItem
 */
+(UIButton*)buttonWithImage:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action;
/**
 *  这个方法解决了需要navigationBar的item靠近边界的问题，使用这个方法添加的item可以更靠近边界
 */
-(void)addItemForLeft:(BOOL)left withItem:(UIBarButtonItem*)item spaceWidth:(CGFloat)width;

/**
 *  控制是否显示后退按钮
 *
 *  @return 默认为YES，子类可以重写此方法
 */
-(BOOL)shouldShowBackItem;
-(void)backItemAction:(UIButton*)button;


//以下所有方法都在NaviBar右侧添加Item


-(void)loginItemAction:(UIButton *)button;


-(void)hideMineItem;
-(void)mineItemAction:(UIButton *)button;

-(void)showMailItem;
-(void)mailItemAction:(UIButton *)button;

-(void)showHelpItem;
-(void)helpItemAction:(UIButton *)button;

-(void)showMoreItem;
-(void)moreItemAction:(UIButton *)button;

-(void)showWithdrawalItem;
-(void)withdrawalItemAction:(UIButton *)button;

-(void)showRegistrationItem;
-(void)registrationlItemAction:(UIButton *)button;

-(void)showMoreRightItem;
-(void)moreRightItemAction:(UIButton *)button;

-(void)showWithDrawButton;
-(void)withDrawButtonAction:(UIButton *)button;


-(void)guideAction:(UIButton *)button;

-(void)showChongzhiItem;
-(void)chongzhiItemAction:(UIButton *)button;


@end
