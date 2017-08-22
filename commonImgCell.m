//
//  commonImgCell.m
//  YiYuan
//
//  Created by fyaex001 on 2016/12/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "commonImgCell.h"

@interface commonImgCell()

@property(nonatomic, strong) UIView *line;

@end


@implementation commonImgCell

- (id )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [AppAppearance sharedAppearance].title2TextColor;
        [self.contentView addSubview:_titleLabel];
        
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [self.contentView addSubview:_line];
        
        
        _img = [[UIImageView alloc] init];
        _img.image = [UIImage imageNamed:@"default"];
        [self.contentView addSubview:_img];
  
        
    }
    return self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat offset = 20;
    _titleLabel.frame = CGRectMake(20, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    _titleLabel.font = [MyAdapter fontADapter:16];
    _line.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.bounds), 0.6);
    _line.hidden = _isHide;
    
    _img.frame = CGRectMake(WIDTH-self.contentView.bounds.size.height-20, 5, self.contentView.bounds.size.height-10, self.contentView.bounds.size.height-10);
    [self.img.layer setCornerRadius:CGRectGetHeight([self.img bounds]) /2];
    self.img.layer.masksToBounds = YES;
    //可以根据需求设置边框宽度,颜色
    self.img.layer.borderWidth = 2;
    self.img.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    
}


+(instancetype)commonImgCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    commonImgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[commonImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
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
