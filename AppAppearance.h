
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AppAppearance : NSObject

+(instancetype)sharedAppearance;
/**
 *  主色调，主要用于导航栏背景
 */

@property(readonly, nonatomic) UIColor* mainColor;
/**
 *  较亮的主色调，主要用于view中，靠近主色调）的字体颜色
 */
@property(readonly, nonatomic) UIColor* mainColorLight;
@property(readonly, nonatomic) UIColor* whiteColor;
@property(readonly, nonatomic) UIColor* tabBarColor;
@property(readonly, nonatomic) UIColor* pageBackgroundColor;
@property(readonly, nonatomic) UIColor* blackColor;

@property(readonly, nonatomic) UIColor* yellowColor;
@property(readonly, nonatomic) UIColor* bluewColor;
@property(readonly, nonatomic) UIColor* greeColor;

@property(readonly, nonatomic) UIColor* lightRedColor;
@property(readonly, nonatomic) UIColor* lightGreenColor;
@property(readonly, nonatomic) UIColor* redColor;
@property(readonly, nonatomic) UIColor* grayColor;
@property(readonly, nonatomic) UIColor* cellLineColor;

@property(readonly, nonatomic) UIColor* titleTextColor;
@property(readonly, nonatomic) UIColor* title2TextColor;
@property(readonly, nonatomic) UIColor* buttonColor;
@property(readonly, nonatomic) UIColor* placeholderColor;
@property(readonly, nonatomic) UIColor* segementBootomLineColor;
@property(readonly, nonatomic) UIImage* defaultImage;
@property(readonly, nonatomic) UIImage* defaultAvatarImage;

-(UIFont *)fontWithSize:(CGFloat)size;
-(UIButton *)buttonWithTitle:(NSString *)title;
@end
