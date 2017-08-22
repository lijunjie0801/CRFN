

#import "CommonCell.h"


@interface CommonCell()



@end

@implementation CommonCell




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
    _titlelbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    [self.contentView addSubview:_titlelbl];
    
    _iconImg = [[UIImageView alloc] init];
    _iconImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImg];
    
    _detaillbl               = [[UILabel alloc] init];
    _detaillbl.textColor     = [AppAppearance sharedAppearance].title2TextColor;
    _detaillbl.font          = [MyAdapter fontADapter:14];
    _detaillbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_detaillbl];
    
    _line                               = [[UIView alloc]initWithFrame:CGRectZero];
    _line.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
    [self.contentView addSubview:_line];
    
    
    CGFloat viewH= self.bounds.size.height;
    
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(10);
        make.width.height.offset([MyAdapter aDapter:25]);
        make.top.offset((viewH-[MyAdapter aDapter:25])/2);
    }];
    
    [self.titlelbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.iconImg.mas_right).offset(10);
        make.width.offset([MyAdapter aDapter:150]);
        make.height.offset([MyAdapter aDapter:25]);
         make.top.offset((viewH-[MyAdapter aDapter:25])/2);
    }];
    [self.detaillbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.offset([MyAdapter aDapter:25]);
        make.top.offset((viewH-[MyAdapter aDapter:25])/2);
        make.right.equalTo(self.mas_right).offset(-[MyAdapter aDapter:170]);
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



+(instancetype)commonCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    
    CommonCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
