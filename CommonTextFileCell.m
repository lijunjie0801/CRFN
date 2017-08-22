//
//  CommonTextFileCell.m
//  YiYuan
//
//  Created by fyaex001 on 2016/12/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "CommonTextFileCell.h"

@interface CommonTextFileCell()


@property(nonatomic, strong) UIView *line;
@end

@implementation CommonTextFileCell

- (id )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textColor = [AppAppearance sharedAppearance].title2TextColor;
        _titleLabel.font = [MyAdapter fontADapter:16];
        [self.contentView addSubview:_titleLabel];
        
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [self.contentView addSubview:_line];
        
        
     
        _textFile = [[UITextField alloc] init];
        _textFile.textAlignment = NSTextAlignmentRight;
        _textFile.font = [MyAdapter fontADapter:14];
        [self.contentView addSubview:_textFile];
        
        
    }
    return self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat offset = 20;
    _titleLabel.frame = CGRectMake(20, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    
    _line.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.bounds), 0.6);
    _line.hidden = _isHide;
    
    _textFile.frame = CGRectMake(WIDTH-180, 5, 150, self.contentView.bounds.size.height-10);

    
    
}


+(instancetype)commonTextFileCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    CommonTextFileCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[CommonTextFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
