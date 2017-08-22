//
//  MyinfoModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/24.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyinfoModel.h"

@implementation MyinfoModel



+(NSDictionary *)JSONDictionary
{
    return @{
             @"userName":@"username",
             @"head_imgStr":@"head_img",
             @"credits":@"credits",
             @"userMobile":@"mobile",
             @"addressDetail":@"addr_detail",
             @"companName":@"comp_name",
             @"balance":@"balance",
             @"companTel":@"comp_tel",
             @"provinceName":@"pca"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
