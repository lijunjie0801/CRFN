

#import "UserBehaviorCell.h"
#import "AppAppearance.h"


@interface UserBehaviorCell()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *line;

@end

@implementation UserBehaviorCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
        
        _textField                          = [[UITextField alloc]initWithFrame:CGRectZero];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.font                     = [UIFont systemFontOfSize:[MyAdapter fontDapter:16]];
        _textField.borderStyle              = UITextBorderStyleNone;
        _textField.returnKeyType            = UIReturnKeyDone;
        _textField.textAlignment            = NSTextAlignmentLeft;
        _textField.backgroundColor          = [UIColor clearColor];
        _textField.clearButtonMode          = UITextFieldViewModeWhileEditing;
        _textField.delegate                 = self;
        [self.contentView addSubview:_textField];
        
        _line                               = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor               = [AppAppearance sharedAppearance].cellLineColor;
        [self.contentView addSubview:_line];
        
//        _forgetPass                         = [UIButton buttonWithType:UIButtonTypeCustom];
//        _forgetPass.titleLabel.font         = [UIFont systemFontOfSize:14];
//        [_forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
//        [_forgetPass setTitleColor:[AppAppearance sharedAppearance].mainColor forState:UIControlStateNormal];
//        [_forgetPass addTarget:self action:@selector(forgetPassAction:) forControlEvents:UIControlEventTouchUpInside];
        //[self.contentView addSubview:_forgetPass];
        
        [self.imageView sizeToFit];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset([MyAdapter aDapter:20]);
            make.top.offset([MyAdapter aDapter:10]);
            make.width.height.mas_equalTo([MyAdapter aDapter:25]);
            
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset([MyAdapter aDapter:50]);
            make.top.offset([MyAdapter aDapter:10]);
            make.height.mas_equalTo([MyAdapter aDapter:25]);
            make.right.offset(0);
        }];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.offset([MyAdapter aDapter:50]);
            make.top.equalTo(self.imageView.mas_bottom).offset(5);
            make.height.mas_equalTo([MyAdapter aDapter:0.6]);
            make.right.offset(0);
        }];
    }
    return self;
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    CGFloat offset = 50;
//    //    if (self.accessoryView) {
//    //        _textField.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 46, CGRectGetWidth(self.contentView.bounds)- offset - 30 + 35, 46);
//    //    }else{
//    //        _textField.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 46, CGRectGetWidth(self.contentView.bounds) - offset - 30 - 39, 46);
//    //    }
// 
//   
//    
//    
//    
////    _textField.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 46, CGRectGetWidth(self.contentView.bounds)- offset, 46);
////    self.imageView.frame = CGRectMake(12, 10, CGRectGetWidth(self.imageView.bounds), CGRectGetHeight(self.imageView.bounds));
//    
////    _line.frame = CGRectMake(offset, CGRectGetHeight(self.contentView.bounds) - 0.6f, CGRectGetWidth(self.contentView.bounds), 0.6);
////    _line.hidden = _isHide;
//    
//    //_forgetPass.frame = CGRectMake(CGRectGetWidth(self.bounds) - 65, 0, 60, 46);//
//    
//}

#pragma mark -
#pragma mark -- UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(didSelectTextField:)]){
        [self.delegate didSelectTextField:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        if([_delegate respondsToSelector:@selector(didEndEditing)]){
            [self.delegate didEndEditing];
        }
        
        return NO;
    }
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
//-(void)forgetPassAction:(UIButton *)btn
//{
//    if([self.delegate respondsToSelector:@selector(didForgetPassAction)])
//    {
//        [self.delegate didForgetPassAction];
//    }
//    
//}


@end
