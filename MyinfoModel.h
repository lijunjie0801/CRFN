//
//  MyinfoModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/24.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface MyinfoModel : BaseModel

@property(nonatomic, strong) NSString *userName;//用户名
@property(nonatomic, strong) NSString *head_imgStr;//头像
@property(nonatomic, strong) NSString *credits;//积分
@property(nonatomic, strong) NSString *userMobile;//用户手机号
@property(nonatomic, strong) NSString *addressDetail;//企业详细地址
@property(nonatomic, strong) NSString *companName;//企业名称
@property(nonatomic, strong) NSString *companTel;//企业联系方式
@property(nonatomic, strong) NSString *provinceName;//省市区
@property(nonatomic, strong) NSString *balance;//我的余额


@end
