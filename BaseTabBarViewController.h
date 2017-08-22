

#import "BaseViewController.h"

@interface BaseTabBarViewController : BaseViewController<UITabBarControllerDelegate>

@property(nonatomic ,readwrite) NSInteger selectedIndex;

-(NSUInteger)defaultSelectedIndex;
-(NSArray *)viewControllers;



/*
 是否可以选择当前某页面
 页面所在 index
 默认为  yes
 */


-(BOOL)shouldSelectIndex:(NSInteger )index viewController:(UIViewController *)viewController;

@end
