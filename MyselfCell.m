//
//  MyselfCell.m
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyselfCell.h"


@interface MyselfCell()

@property(nonatomic, strong) UILabel *daifukuanLbl;//待支付

@property(nonatomic, strong) UILabel *daifahuoLbl;//待发货

@property(nonatomic, strong) UILabel *daishouhuoLbl;//待收货

@property(nonatomic, strong) UILabel *daipingjiaLbl;//待评价

@property(nonatomic, strong) UILabel *daituihuanLbl;//退换货

@end

@implementation MyselfCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubviews];
    }
    return self;
}


-(void)createSubviews
{
    int totalCol = 5;
    
    NSArray *titleArray= @[@"待支付",@"待发货",@"待收货",@"待评价",@"换货"];
    NSArray *iconArray= @[@"wo_daizhifu",@"wo_daifahuo",@"wo_daishouhuo",@"wo_daipingjia",@"wo_tuihuo"];
    
    
    CGFloat marginTop = 10;
    CGFloat widthHeight = 25;
    
    for (int i = 0; i<titleArray.count; i++) {
        
        CGFloat marginX=((WIDTH -30- totalCol*widthHeight))/(totalCol-1);
        // CGFloat marginY=widthHeight-15;
        CGFloat x=15+(widthHeight+marginX)*(i%totalCol);
        //CGFloat y=marginTop+marginY+(widthHeight+marginY)*(i/totalCol);
        
        UIButton *button = [[UIButton alloc] init];
        
        
        button.frame = CGRectMake(x, marginTop, widthHeight, widthHeight);
        
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -15, -60, -15);
        button.titleLabel.font = [MyAdapter fontADapter:12];
        [button setBackgroundImage:[UIImage imageNamed:iconArray[i]] forState:UIControlStateNormal];
        button.tag = 100+i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        
        if (i == 0) {
            //待付款
            self.daifukuanLbl.frame = CGRectMake(CGRectGetMaxX(button.frame)-2, CGRectGetMinY(button.frame)-5, 16, 16);
            self.daifukuanLbl.hidden = YES;
            
            
            
        }else if (i==1){
            
            //待发货
            self.daifahuoLbl.frame = CGRectMake(CGRectGetMaxX(button.frame)-2, CGRectGetMinY(button.frame)-5, 16, 16);
            self.daifahuoLbl.hidden = YES;
            
            self.daifahuoLbl.layer.cornerRadius = 8;
//            self.daifahuoLbl.layer.borderWidth = 1.0;
            self.daifahuoLbl.backgroundColor = [AppAppearance sharedAppearance].redColor;
            self.daifahuoLbl.textAlignment = NSTextAlignmentCenter;
//            self.daifahuoLbl.layer.borderColor = [[UIColor redColor] CGColor];
            self.daifahuoLbl.clipsToBounds = YES;
            self.daifahuoLbl.font = [UIFont systemFontOfSize:10];
            self.daifahuoLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
            
        }else if (i ==2){
            //待收货
            self.daishouhuoLbl.frame = CGRectMake(CGRectGetMaxX(button.frame)-2, CGRectGetMinY(button.frame)-5, 16, 16);
            self.daishouhuoLbl.hidden = YES;
            
            self.daishouhuoLbl.layer.cornerRadius = 8;
            self.daishouhuoLbl.backgroundColor = [AppAppearance sharedAppearance].redColor;
//            self.daishouhuoLbl.layer.borderWidth = 1.0;
            self.daishouhuoLbl.textAlignment = NSTextAlignmentCenter;
//            self.daishouhuoLbl.layer.borderColor = [[UIColor redColor] CGColor];
            self.daishouhuoLbl.clipsToBounds = YES;
            self.daishouhuoLbl.font = [UIFont systemFontOfSize:10];
            self.daishouhuoLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
            
        }else if (i ==3){
            //待评价
            self.daipingjiaLbl.frame = CGRectMake(CGRectGetMaxX(button.frame)-2, CGRectGetMinY(button.frame)-5, 16, 16);
            self.daipingjiaLbl.hidden = YES;
            
            self.daipingjiaLbl.layer.cornerRadius = 8;
            self.daipingjiaLbl.backgroundColor = [AppAppearance sharedAppearance].redColor;
//            self.daipingjiaLbl.layer.borderWidth = 1.0;
            self.daipingjiaLbl.textAlignment = NSTextAlignmentCenter;
//            self.daipingjiaLbl.layer.borderColor = [[UIColor redColor] CGColor];
            self.daipingjiaLbl.clipsToBounds = YES;
            self.daipingjiaLbl.font = [UIFont systemFontOfSize:10];
            self.daipingjiaLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
            
        }else{
            
          //  退换货
             self.daituihuanLbl.frame = CGRectMake(CGRectGetMaxX(button.frame)-2, CGRectGetMinY(button.frame)-5, 16, 16);
             self.daituihuanLbl.hidden = YES;

            self.daituihuanLbl.backgroundColor = [AppAppearance sharedAppearance].redColor;
             self.daituihuanLbl.layer.cornerRadius = 8;
//             self.daituihuanLbl.layer.borderWidth = 1.0;
             self.daituihuanLbl.textAlignment = NSTextAlignmentCenter;
//             self.daituihuanLbl.layer.borderColor = [[UIColor redColor] CGColor];
             self.daituihuanLbl.clipsToBounds = YES;
             self.daituihuanLbl.font = [UIFont systemFontOfSize:10];
             self.daituihuanLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
            
        }
        
        
        
        
        
    }
    
}

-(void)buttonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:{
            
            [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLZhiFu],@"type":@"POST"} ];
            
            break;
        }
        case 101:{
            
            [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLFahuo],@"type":@"POST"} ];
            
            break;
        }
        case 102:{
            
            [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLShouHuo],@"type":@"POST"} ];
            
            break;
        }
        case 103:{
            
            [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLPingJia],@"type":@"POST"} ];
            
            
            break;
        }
        case 104:{
            
            [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":[URLManager requestURLGenetatedWithURL:KURLTuiHuan]} ];
            
            break;
        }
            
            
        default:
            break;
    }
}



+(instancetype)myselfCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"MyselfCell";
    
    MyselfCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell=[[MyselfCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


//待付款
-(UILabel *)daifukuanLbl
{
    if (!_daifukuanLbl) {
        
        _daifukuanLbl = [[UILabel alloc] init];
        [self addSubview:_daifukuanLbl];
    }
    
    return _daifukuanLbl;
    
}

//待发货
-(UILabel *)daifahuoLbl
{
    if (!_daifahuoLbl) {
        
        _daifahuoLbl = [[UILabel alloc] init];
        [self addSubview:_daifahuoLbl];
        
    }
    return _daifahuoLbl;
}


//待收货
-(UILabel *)daishouhuoLbl
{
    if (!_daishouhuoLbl) {
        
        _daishouhuoLbl = [[UILabel alloc] init];
        [self addSubview:_daishouhuoLbl];
        
    }
    return _daishouhuoLbl;
}

//待评价
-(UILabel *)daipingjiaLbl
{
    if (!_daipingjiaLbl) {
        
        _daipingjiaLbl = [[UILabel alloc] init];
        [self addSubview:_daipingjiaLbl];
        
    }
    return _daipingjiaLbl;
}

//退换货
-(UILabel *)daituihuanLbl
{
    if (!_daituihuanLbl) {

        _daituihuanLbl = [[UILabel alloc] init];
        [self addSubview:_daituihuanLbl];
        
    }
    return _daituihuanLbl;
}


//待付款
-(void)setDaifukuanNum:(NSString *)daifukuanNum
{
    if ([daifukuanNum isEqualToString:@"0"]) {
        
        _daifukuanLbl.hidden = YES;
    }else{
        
        self.daifukuanLbl.layer.cornerRadius = 8;
//        self.daifukuanLbl.layer.borderWidth = 1.0;
        self.daifukuanLbl.backgroundColor = [AppAppearance sharedAppearance].redColor;
        self.daifukuanLbl.textAlignment = NSTextAlignmentCenter;
//        self.daifukuanLbl.layer.borderColor = [[UIColor redColor] CGColor];
        self.daifukuanLbl.clipsToBounds = YES;
        self.daifukuanLbl.font = [UIFont systemFontOfSize:10];
        self.daifukuanLbl.textColor = [AppAppearance sharedAppearance].whiteColor;
        
        _daifukuanLbl.hidden = NO;
        _daifukuanLbl.text = daifukuanNum;
    }
}

//待发货
-(void)setDaifahuoNum:(NSString *)daifahuoNum
{
    if ([daifahuoNum isEqualToString:@"0"]) {
        
        _daifahuoLbl.hidden = YES;
    }else{
        
        _daifahuoLbl.hidden = NO;
        _daifahuoLbl.text = daifahuoNum;
    }
}

//待收货
-(void)setDaishouhuoNum:(NSString *)daishouhuoNum
{
    if ([daishouhuoNum isEqualToString:@"0"]) {
        
        _daishouhuoLbl.hidden = YES;
    }else{
        
        _daishouhuoLbl.hidden = NO;
        _daishouhuoLbl.text = daishouhuoNum;
    }
}
//待评价
-(void)setDaipingjiaNum:(NSString *)daipingjiaNum
{
    if ([daipingjiaNum isEqualToString:@"0"]) {
        
        _daipingjiaLbl.hidden = YES;
    }else{
        
        _daipingjiaLbl.hidden = NO;
        _daipingjiaLbl.text = daipingjiaNum;
    }
}

//退换货
-(void)setDaituihuanNum:(NSString *)daituihuanNum
{
    if ([daituihuanNum isEqualToString:@"0"]) {

        _daituihuanLbl.hidden = YES;
    }else{

        _daituihuanLbl.hidden = NO;
        _daituihuanLbl.text = daituihuanNum;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
