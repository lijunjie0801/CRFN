//
//  AddressDetailCell.m
//  CRFN
//
//  Created by zlkj on 2017/2/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "AddressDetailCell.h"


@interface AddressDetailCell()

@property(nonatomic, strong) UIView *line;

@end

@implementation AddressDetailCell



- (id )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
        
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [AppAppearance sharedAppearance].cellLineColor;
        [self.contentView addSubview:_line];
        
        
        
        _textFile = [[UITextField alloc] init];
//        _textFile.textAlignment = NSTextAlignmentRight;
        _textFile.font = [MyAdapter fontADapter:14];
        [self.contentView addSubview:_textFile];
        
        
    }
    return self;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat offset = 20;

    
    _line.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.bounds), 0.6);
    _line.hidden = _isHide;
    
    _textFile.frame = CGRectMake(20, 5, WIDTH-40, self.contentView.bounds.size.height-10);
    
    
    
}













+(instancetype)addressDetailCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"addresscell";
    AddressDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[AddressDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
