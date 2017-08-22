//
//  bottomPriceView.m
//  meidianjie
//
//  Created by HYS on 16/1/6.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import "bottomPriceView.h"
#import "Masonry.h"
@implementation bottomPriceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MColor(230, 230, 230);
        //选择商品btn
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setImage:[UIImage imageNamed:@"weixuanzhong42"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"xuanzhong42"] forState:UIControlStateSelected];
        _selectedBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_selectedBtn addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectedBtn.x = 0;
        _selectedBtn.y = 0;
        _selectedBtn.width = 0.2 * frame.size.width;
        _selectedBtn.height = frame.size.height;
        _selectedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [_selectedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectedBtn.titleLabel.font = MFont(kFit(13));
        [_selectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [self addSubview:_selectedBtn];
        
        //结算btn
        _payStr = @"结算";
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        _payBtn.backgroundColor = [AppAppearance sharedAppearance].redColor;
        _payBtn.y = 0;
        _payBtn.height = frame.size.height;
        _payBtn.width = kFit(90);
        _payBtn.x = frame.size.width - kFit(90);
        _payBtn.titleLabel.font = MFont(kFit(13));
        [_payBtn setTitle:_payStr forState:UIControlStateNormal];
        [self addSubview:_payBtn];
        
        //合计label
        _allPriceLabel = [[UILabel alloc]init];
        _allPriceLabel.font = MFont(kFit(14));
        _allPriceLabel.minimumScaleFactor = kFit(11);
        _allPriceLabel.textAlignment = NSTextAlignmentCenter;
        _attAllStr = @"合计:￥0.00";
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:_attAllStr];
        
        //添加属性
        NSRange range = {_attAllStr.length - 3, 3};
        
        NSRange range1 = {3, _attAllStr.length - 3};
        [attStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:kFit(11)] range:range];
        [attStr addAttribute:NSForegroundColorAttributeName value:[AppAppearance sharedAppearance].redColor range:range1];
        _allPriceLabel.attributedText = attStr;
        _allPriceLabel.x = CGRectGetMaxX(_selectedBtn.frame) + kFit(5);
        _allPriceLabel.y = 0;
        _allPriceLabel.width = frame.size.width - _allPriceLabel.x - _payBtn.width;
        _allPriceLabel.height = frame.size.height;
        [self addSubview:_allPriceLabel];
        
        
    }
    return self;
}
- (void)setIsSelectBtn:(BOOL)isSelectBtn{
    _selectedBtn.selected = isSelectBtn;
    if ([self.delegate respondsToSelector:@selector(bottomPriceView:)]) {
        [self.delegate bottomPriceView:self];
    }
}
- (void)selectedClick:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if ([self.delegate respondsToSelector:@selector(bottomPriceView:)]) {
        [self.delegate bottomPriceView:self];
    }
}
- (void)setPayStr:(NSString *)payStr{
//    [_payBtn setTitle:[NSString stringWithFormat:@"结算", payStr] forState:UIControlStateNormal];
    
    _allPriceLabel.text = [NSString stringWithFormat:@"已选:%@",payStr];
    
}

- (void)setAttAllStr:(NSString *)attAllStr{
    _attAllStr = [NSString stringWithFormat:@"合计:￥%@", attAllStr];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:_attAllStr];
    
    //添加属性
    NSRange range = {_attAllStr.length - 3, 3};
    
    NSRange range1 = {3, _attAllStr.length - 3};
    [attStr addAttribute:NSForegroundColorAttributeName value:[AppAppearance sharedAppearance].titleTextColor range:range];
    [attStr addAttribute:NSFontAttributeName value:[MyAdapter fontADapter:14] range:range];
    
    [attStr addAttribute:NSForegroundColorAttributeName value:[AppAppearance sharedAppearance].redColor range:range1];
    [attStr addAttribute:NSFontAttributeName value:[MyAdapter fontADapter:12] range:range];
    _allPriceLabel.attributedText = attStr;
}


//结算点击事件
-(void)payClick
{
    if ([self.delegate respondsToSelector:@selector(bottomPayBtnClick)]) {
        
        [self.delegate bottomPayBtnClick];
    }
}


@end
