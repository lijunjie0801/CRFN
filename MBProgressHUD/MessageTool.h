//
//  MessageTool.h
//  Deeper
//
//  Created by junhai yang on 12-3-24.
//  Copyright (c) 2012年 mRocker Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface MessageTool : NSObject<MBProgressHUDDelegate>{
    MBProgressHUD *showMessage;
}
@property (nonatomic,strong)  MBProgressHUD *showMessage;

@property (nonatomic,strong) MBProgressHUD *hub;

+ (void)showMessage:(NSString *)message isError:(BOOL)yesOrNo;
+ (void)showMessage:(NSString *)message view:(UIView*)view isError:(BOOL)yesOrNo;
+ (MBProgressHUD *)showProcessMessage:(NSString *)message;
+ (MBProgressHUD *)showProcessMessage:(NSString *)message view:(UIView*)view;

+ (void)showMessage:(NSString *)message;//应付加的

@end
