
#import "AppAppearance.h"
//#import "UIImage+ImageFromColor.h"

#define UIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

@implementation AppAppearance

+(instancetype)sharedAppearance
{
    static AppAppearance* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
        _mainColor               = [UIColor colorWithRed:4/255.0 green:158/255.0 blue:207/255.0 alpha:1];
        _tabBarColor             = _mainColor;
        
        _yellowColor             = [UIColor colorWithRed:243/255.0 green:187/255.0 blue:12/255.0 alpha:1];
        _bluewColor             = [UIColor colorWithRed:79/255.0 green:157/255.0 blue:248/255.0 alpha:1];
         _greeColor             = [UIColor colorWithRed:120/255.0 green:208/255.0 blue:183/255.0 alpha:1];
        _blackColor              = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.000];
        _grayColor               = UIColorFromRGB(0xe0e0e0);
        _whiteColor              = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.000];
        _pageBackgroundColor     = UIColorFromRGB(0xededf3);
        _buttonColor             = [UIColor colorWithRed:9/255.0 green:90/255.0 blue:159/255.0 alpha:1];
        _placeholderColor        = [UIColor grayColor];
        _redColor                = [UIColor colorWithRed:228/255.0 green:57/255.0 blue:60/255.0 alpha:1.000];
        _lightRedColor           = UIColorFromRGB(0xe04c4c);
        _lightGreenColor         = UIColorFromRGB(0x0de53f);
        
         _cellLineColor           = UIColorFromRGB(0xe7e7e7);
        _segementBootomLineColor = [UIColor colorWithRed:0.682 green:0.678 blue:0.678 alpha:1.000];
        
        _titleTextColor          = [UIColor colorWithRed:68/255.0 green:68/255.0 blue:68/255.0 alpha:1.000];
        _title2TextColor          = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.000];
        //_defaultAvatarImage = [UIImage imageNamed:@"user"];
    }
    return self;
}

-(UIFont *)fontWithSize:(CGFloat)size {
    //    return [UIFont fontWithName:@"Heiti TC" size:size];
    return [UIFont systemFontOfSize:size];
}

//-(UIButton *)buttonWithTitle:(NSString *)title {
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage buildImageWithColor:_buttonColor] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage buildImageWithColor:[_buttonColor colorWithAlphaComponent:.5]] forState:UIControlStateHighlighted];
//    button.layer.cornerRadius = 3;
//    button.clipsToBounds = YES;
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:_mainColorLight forState:UIControlStateNormal];
//    return button;
//}

@end
