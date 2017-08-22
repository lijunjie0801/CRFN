//
//  CommonCell2.m
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CommonCell2.h"

@implementation CommonCell2



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSubView];
        
    }
    return self;
}


-(void)createSubView
{
    
    _titlelbl      = [[UILabel alloc] init];
    _titlelbl.font = [MyAdapter fontADapter:16];
    _titlelbl.textColor     = [AppAppearance sharedAppearance].titleTextColor;
    [self.contentView addSubview:_titlelbl];
    

    _detaillbl               = [[UILabel alloc] init];
    _detaillbl.textColor     = [AppAppearance sharedAppearance].title2TextColor;
    _detaillbl.font          = [MyAdapter fontADapter:14];
    _detaillbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_detaillbl];
    
    _line                               = [[UIView alloc]initWithFrame:CGRectZero];
    _line.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
    [self.contentView addSubview:_line];
    
    
    CGFloat viewH= self.bounds.size.height;
    

    
    [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(10);
        make.width.offset([MyAdapter aDapter:150]);
        make.height.offset([MyAdapter aDapter:25]);
        make.top.offset((viewH-[MyAdapter aDapter:25])/2);
    }];
    [self.detaillbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.offset([MyAdapter aDapter:25]);
        make.top.offset((viewH-[MyAdapter aDapter:25])/2);
        make.right.equalTo(self.mas_right).offset(-[MyAdapter aDapter:30]);
        make.width.offset([MyAdapter aDapter:140]);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.height.mas_equalTo([MyAdapter aDapter:0.6]);
        make.right.offset(0);
    }];
    
}





//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    CGFloat viewH= self.bounds.size.height;
//
//    CGFloat iconWH = 25;
//
//    _iconImg.frame = CGRectMake(10, (viewH-iconWH)/2, iconWH, iconWH);
//    _titlelbl.frame = CGRectMake(CGRectGetMaxX(_iconImg.frame)+10, (viewH-iconWH)/2, 150, iconWH);
//
//    _detaillbl.frame = CGRectMake(self.bounds.size.width-170, (viewH-iconWH)/2, 140, iconWH);
//
//    _line.frame = CGRectMake(0, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.contentView.bounds), 0.6);
//}



+(instancetype)commonCell2WithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell2";
    
    CommonCell2 *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[CommonCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
