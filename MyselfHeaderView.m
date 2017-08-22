//
//  MyselfHeaderView.m
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyselfHeaderView.h"
#import "MyinfoModel.h"

@interface MyselfHeaderView()

@property(nonatomic, strong) UIView *centerView;

@property(nonatomic, strong) UIImageView *rightImg;

@end

@implementation MyselfHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews
{
    _centerView = [[UIView alloc] init];
    _centerView.backgroundColor = [UIColor colorWithRed:87/255.0 green:186/255.0 blue:220/255.0 alpha:1.0];
    [self addSubview:_centerView];
    
    _HeadImg = [[UIImageView alloc] init];
    [self addSubview:_HeadImg];
    

    
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
    _titleLbl.font = [MyAdapter fontADapter:16];
    [self.centerView addSubview:_titleLbl];
    
    _integrationLbl = [[UILabel alloc] init];
    _integrationLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
    _integrationLbl.font = [MyAdapter fontADapter:14];
    [self.centerView addSubview:_integrationLbl];
    
    _mybalancelbl = [[UILabel alloc] init];
    _mybalancelbl.textColor = [AppAppearance sharedAppearance].whiteColor;
    _mybalancelbl.font = [MyAdapter fontADapter:14];
    [self.centerView addSubview:_mybalancelbl];
    
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"gerenzhongxin_you"];
    [self.centerView addSubview:_rightImg];
    
    CGFloat VHeigth = self.frame.size.height;
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset((VHeigth-VHeigth/1.5)/2);
        make.left.offset([MyAdapter aDapter:10]+VHeigth/4);
        make.right.offset(0);
        make.height.offset(VHeigth/1.5);
    }];
    
    [self.HeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset((VHeigth-VHeigth/1.5)/2);
        make.left.offset([MyAdapter aDapter:10]);
        make.height.width.equalTo(self.centerView.mas_height);
        
   
        
    }];
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.HeadImg.mas_right).offset(10);
        make.top.offset(10);
        make.height.offset([MyAdapter aDapter:21]);
        make.width.offset([MyAdapter aDapter:150]);
        
      
        
    }];
    
    [self.integrationLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.HeadImg.mas_right).offset(10);
        make.top.mas_equalTo(self.titleLbl.mas_bottom).offset(0);
        make.height.offset([MyAdapter aDapter:21]);
        make.width.offset([MyAdapter aDapter:150]);
    }];
    
    
    [self.mybalancelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.HeadImg.mas_right).offset(10);
        make.top.mas_equalTo(self.integrationLbl.mas_bottom).offset(0);
        make.height.offset([MyAdapter aDapter:21]);
        make.width.offset([MyAdapter aDapter:150]);
    }];
    
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(0);
        make.height.offset([MyAdapter aDapter:30]);
        make.top.offset((VHeigth/1.5-[MyAdapter aDapter:30])/2);
        make.width.offset([MyAdapter aDapter:50]);
    }];
    
  
    
    [self.HeadImg.layer setCornerRadius:VHeigth/1.5/2];
    self.HeadImg.layer.masksToBounds = YES;
    //可以根据需求设置边框宽度,颜色
    self.HeadImg.layer.borderWidth = 2;
    self.HeadImg.layer.borderColor = [[UIColor whiteColor] CGColor];
    
//    self.titleLbl.text = @"传说中的张三";
//    self.integrationLbl.text = @"我的积分:2380";
//    self.HeadImg.image = [UIImage imageNamed:@"login_logo"];
    
}


-(void)setMyinfoModel:(MyinfoModel *)myinfoModel
{
    _myinfoModel = myinfoModel;
    self.titleLbl.text = myinfoModel.userName;
    self.integrationLbl.text = [NSString stringWithFormat:@"我的积分：%@",myinfoModel.credits];
    self.mybalancelbl.text   = [NSString stringWithFormat:@"我的余额：%@",myinfoModel.balance];
    NSString *url = [NSString stringWithFormat:@"%@/%@",KBaseURL,myinfoModel.head_imgStr];
    [self.HeadImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
