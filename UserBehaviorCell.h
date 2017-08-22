//
//  UserBehaviorCell.h
//  GZB
//
//  Created by fyaex001 on 16/3/12.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserBehaviorCellDelegate <NSObject>

@optional
- (void)didSelectTextField:(id)object;
- (void)didEndEditing;
-(void)didForgetPassAction;

@end



@interface UserBehaviorCell : UITableViewCell


@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong)UIButton *forgetPass;
@property (nonatomic, assign) BOOL isHide;//是否隐藏最后一根线
@property (nonatomic, assign) id<UserBehaviorCellDelegate>delegate;


@end
