

#import "BaseViewController.h"
#import "SwitchViewController.h"
#import "AppAppearance.h"
#define IOS7Below  ([[[UIDevice currentDevice] systemVersion] floatValue] <  7.0)

@interface BaseViewController ()

@end

@implementation BaseViewController


-(instancetype)init
{
    self = [super init];
    if (self) {
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        _svc =[SwitchViewController sharedSVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断导航栏的返回按钮是否退出
    if ([self shouldShowBackItem]) {
        
        [self showBackItem];
    }else {
        self.navigationItem.hidesBackButton = YES;
    }
    
    self.view.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:[self shouldHideNavigationBar] animated:animated];
}

-(BOOL)shouldShowBackItem
{
    return YES;
}

-(BOOL)canBeCached
{
    return NO;
}

-(BOOL)shouldHideNavigationBar
{
    return NO;
}

-(void)blankLeftItems
{
    self.navigationItem.leftBarButtonItems = nil;
}

-(void)blankRightItems
{
    self.navigationItem.rightBarButtonItems = nil;
}
+(UIButton*)buttonWithImage:(UIImage*)image title:(NSString*)title target:(id)target action:(SEL)action {
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        CGFloat hw = image.size.width/2;
        CGFloat hh = image.size.height/2;
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(hh, hw, hh, hw)];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    } else {
        [btn setImage:image forState:UIControlStateNormal];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [btn sizeToFit];
    return btn;
}

-(void)addItemForLeft:(BOOL)left withItem:(UIBarButtonItem*)item spaceWidth:(CGFloat)width {
    //    UIBarButtonItem *space = [[UIBarButtonItem alloc]
    //                              initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
    //                              target:nil action:nil];
    //
    //    if (IOS7Below) width -= 10;
    //    space.width = width;
    //
    //    if (left) {
    //        self.navigationItem.leftBarButtonItems = @[space,item];
    //    } else {
    //        self.navigationItem.rightBarButtonItems = @[space,item];
    //    }
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if (left) {
        
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -10;
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
        }else
            self.navigationItem.leftBarButtonItem = item;
        
    }else{
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -10;
            self.navigationItem.rightBarButtonItems = @[negativeSpacer, item];
        }else
            self.navigationItem.rightBarButtonItem = item;
    }
    
}

-(void)showBackItem
{
    UIButton *btn =[self.class buttonWithImage:[UIImage imageNamed:@"item_back"] title:nil target:self action:@selector(backItemAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:YES withItem:item spaceWidth:0];
}




-(void)backItemAction:(UIButton *)button
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [_svc popViewController];
        }else
        {
           // [_svc dismissTopViewControllerCompletion:NULL];
        }
        
    }else {
        
        //[_svc dismissTopViewControllerCompletion:NULL];
    }
}







//注册按钮
//-(void)showRegistrationItem
//{
//    UIButton *button = [self.class buttonWithImage:nil title:@"注册" target:self action:@selector(registrationlItemAction:)];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
//    [self addItemForLeft:NO withItem:item spaceWidth:0];
//}


-(void)registrationlItemAction:(UIButton *)button
{
    //子类需要重写
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
