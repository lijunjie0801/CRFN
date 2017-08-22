//
//  RootViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "FittingsCenterViewController.h"
#import "RefrigerationViewController.h"
#import "ShoppingCartViewController.h"
#import "MySelfViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarControllerSelectedIndex:) name:@"TabBarControllerSelectedIndex" object:nil];
}


-(NSArray *)viewControllers
{
    return @[[HomeViewController new],[FittingsCenterViewController new],[RefrigerationViewController new],[ShoppingCartViewController new],[MySelfViewController new]];
    return nil;
    
}


-(void)tabBarControllerSelectedIndex:(NSNotification *)notification
{
    NSInteger index = [notification.userInfo[@"index"] integerValue];
    
    self.selectedIndex = index;
}


-(BOOL)shouldSelectIndex:(NSInteger)index viewController:(UIViewController *)viewController
{
    
    if(index == 4 || index ==3){
        
        if(![AppDataManager defaultManager].hasLogin){
            
            
            
            
           
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录提醒" message:@"你尚未登录，请登录" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                
                 [_svc presentViewController:_svc.loginViewController];

            }];

            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

            [alertController addAction:okAction];
            [alertController addAction:cancelAction];

            [self.navigationController presentViewController:alertController animated:YES completion:nil];
            
            
            return NO;
            
        }
        
        
    }
    
    return YES;
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
