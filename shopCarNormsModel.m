//
//  shopCarNormsModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "shopCarNormsModel.h"

@implementation shopCarNormsModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"typeId":@"id",
             @"typeNo":@"type",
             @"normsValue":@"value",
             @"normsName":@"name"
             };
}



//MJExtension
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"typeId":@"id",
             @"typeNo":@"type",
             @"normsValue":@"value",
             @"normsName":@"name"
             };
}





+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end
