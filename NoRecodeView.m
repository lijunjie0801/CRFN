//
//  NoRecodeView.m
//  CRFN
//
//  Created by zlkj on 2017/4/12.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "NoRecodeView.h"

@interface NoRecodeView()

@property(nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic, strong) UIView *Centerview;

@end


@implementation NoRecodeView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        _Centerview = [[UIView alloc] init];
        [self addSubview:_Centerview];
        
        _iconImageView = [[UIImageView alloc] init];
        [_Centerview addSubview:_iconImageView];
        
        
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    _Centerview.frame = CGRectMake(0, 0, WIDTH, 300);
    _Centerview.center = CGPointMake(self.center.x, self.center.y-20);
    
    
    UIImage *icon = [UIImage imageNamed:@"gwc_empty"];
    
    _iconImageView.frame = CGRectMake((WIDTH-200)/2, 0, 200, 200);
    
    _iconImageView.image = icon;
    

    
}




@end
