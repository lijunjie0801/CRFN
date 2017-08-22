//
//  BaseTabBarViewController.m
//  GZB
//
//  Created by fyaex001 on 16/3/8.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "AppAppearance.h"
#import "SwitchViewController.h"

@interface BaseTabBarViewController ()

@property(nonatomic ,strong)UITabBarController *tabBarController;


@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tabBarController = [[UITabBarController alloc] init];
    
    [_tabBarController willMoveToParentViewController:self];
    [self addChildViewController:_tabBarController];
    [_tabBarController didMoveToParentViewController:self];
    //[_tabBarController.tabBar setBackgroundColor:[UIColor redColor]];
    
    //改变tabbar的背景颜色
    //[_tabBarController.tabBar setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].mainColor]];
    
    //去掉tabBar顶部线条
//    CGRect rect = CGRectMake(0, 0,WIDTH, HEIGHT);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [_tabBarController.tabBar setBackgroundImage:img];
//    [_tabBarController.tabBar setShadowImage:img];
    
    
//    [_tabBarController.tabBar setBackgroundImage:[UIImage buildImageWithColor:[UIColor whiteColor]]];
   
    
    _tabBarController.delegate = self;
    //当tabbarItem选中时候的颜色
    _tabBarController.tabBar.tintColor=[AppAppearance sharedAppearance].tabBarColor;
    [_tabBarController setViewControllers:[self viewControllers] animated:NO];
    [_tabBarController setSelectedIndex:[self defaultSelectedIndex]];
    [self.view addSubview:_tabBarController.view];
    
    [self tabBarController:_tabBarController didSelectViewController:_tabBarController.selectedViewController];
}




-(NSUInteger)defaultSelectedIndex
{
    return 0;
}

-(NSArray *)viewControllers
{
    return nil;
}

-(BOOL)shouldSelectIndex:(NSInteger)index viewController:(UIViewController *)viewController
{
    
    
    return YES;
}

-(void)updateNavigationBar
{
    UIViewController *selectedVC = [_tabBarController selectedViewController];
    self.navigationItem.leftBarButtonItems = selectedVC.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItems = selectedVC.navigationItem.rightBarButtonItems;
    self.navigationItem.backBarButtonItem = selectedVC.navigationItem.backBarButtonItem;
    self.navigationItem.titleView = selectedVC.navigationItem.titleView;
    self.navigationItem.title = selectedVC.navigationItem.title;
    self.title = selectedVC.title;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
   
    [_tabBarController setSelectedIndex:selectedIndex];
    [self updateNavigationBar];
}


-(NSInteger)selectedIndex
{
    return [_tabBarController selectedIndex];
}

#pragma mark  --tabbarController delegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0);
{
    return [self shouldSelectIndex:[tabBarController.viewControllers indexOfObject:viewController] viewController:viewController];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self updateNavigationBar];
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) {
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    
}


- (NSUInteger)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) {
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) {
    return UIInterfaceOrientationPortrait;
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
