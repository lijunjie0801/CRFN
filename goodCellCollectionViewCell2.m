//
//  goodCellCollectionViewCell2.m
//  CRFN
//
//  Created by zlkj on 2017/2/22.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "goodCellCollectionViewCell2.h"
#import "HomeModel.h"


@interface goodCellCollectionViewCell2()

@property(nonatomic, strong) UIImageView *goodImg;
@property(nonatomic, strong) UILabel *nameLbl,*priceLbl;
@property(nonatomic, strong) UIButton *buyBtn;

@property(nonatomic, strong) UIView *line1,*line2,*line3,*line4,*ling5;

@end

@implementation goodCellCollectionViewCell2

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [self addSubview:_line1];
        
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [self addSubview:_line2];
        
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [self addSubview:_line3];
        
        _line4 = [[UIView alloc] init];
        _line4.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [self addSubview:_line4];
        
        _ling5 = [[UIView alloc] init];
        _ling5.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
        [self addSubview:_ling5];
        
        _line1.frame = CGRectMake(0, 0, self.frame.size.width, 2);
        _line2.frame = CGRectMake(0, 0, 2, self.frame.size.height);
        _line3.frame = CGRectMake(self.frame.size.width-2, 0, 2, self.frame.size.height);
        _line4.frame = CGRectMake(0, self.frame.size.height-2, self.frame.size.width, 2);
        
        
        if (!_goodImg) {
            
            _goodImg = [[UIImageView alloc] init];
            _goodImg.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_goodImg];
            [_goodImg mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.offset(5);
                make.left.right.offset(0);
                make.bottom.offset(-[MyAdapter laDapter:80]);
            }];
            
        }
        
        
        [self.ling5 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset(0);
            make.width.offset(self.frame.size.width);
            make.height.offset(2);
            make.top.equalTo(_goodImg.mas_bottom).offset(2);
        }];
        
        
        if (!_nameLbl) {
            _nameLbl = [[UILabel alloc] init];
            _nameLbl.font = [MyAdapter fontADapter:14];
            _nameLbl.numberOfLines =1;
            _nameLbl.textAlignment = NSTextAlignmentCenter;
            _nameLbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
            [self addSubview:_nameLbl];
            [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(2);
                make.right.offset(0);
                make.top.equalTo(_ling5.mas_bottom).offset(5);
                make.height.offset([MyAdapter laDapter:30]);
            }];
        }
        
   
        
        if (!_buyBtn) {
            _buyBtn = [[UIButton alloc] init];
            _buyBtn.titleLabel.font = [MyAdapter fontADapter:14];
            [_buyBtn setBackgroundImage:[UIImage buildImageWithColor:[AppAppearance sharedAppearance].redColor] forState:UIControlStateNormal];
            [_buyBtn setTitleColor:[AppAppearance sharedAppearance].whiteColor forState:UIControlStateNormal];
            _buyBtn.layer.cornerRadius = 3.0f;
            _buyBtn.layer.masksToBounds = YES;
            [self addSubview:_buyBtn];
            [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
            
            CGFloat w = [@"立即购买" boundingRectWithSize:CGSizeMake(MAXFLOAT, [MyAdapter aDapter:21]) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[MyAdapter fontADapter:14]} context:nil].size.width;
            
            [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.offset(-5);
                make.top.equalTo(_nameLbl.mas_bottom).offset([MyAdapter laDapter:0]);
                make.height.offset([MyAdapter aDapter:21]);
                make.width.offset(w+5);
            }];
            
            
        }
        
        
        if (!_priceLbl) {
            
            _priceLbl = [[UILabel alloc] init];
            _priceLbl.font =[MyAdapter fontADapter:14];
            [self addSubview:_priceLbl];
            _priceLbl.textColor = [AppAppearance sharedAppearance].title2TextColor;
            [_priceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.offset(2);
                make.top.equalTo(_nameLbl.mas_bottom).offset([MyAdapter laDapter:2]);
                make.height.offset([MyAdapter laDapter:21]);
                make.right.equalTo(_buyBtn.mas_left).offset(0);
                
            }];
        }
        
//        _goodImg.image = [UIImage imageNamed:@"login_logo"];
//        _nameLbl.text = @"天佑牌空调支架";
//        _priceLbl.text = @"￥220";
        
        
        
        
        
    }
    
    return self;
}


-(void)setHomeModel:(HomeModel *)homeModel
{
    _homeModel = homeModel;
    _nameLbl.text =  homeModel.goodName;
    NSString *url = [NSString stringWithFormat:@"%@/%@",KBaseURL,homeModel.goodImg];
    [_goodImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
   
    NSString *priceTitle = [NSString stringWithFormat:@"%@元",homeModel.goodSellPrice];
    _priceLbl.text = priceTitle;
 
}




@end
