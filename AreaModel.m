//
//  AreaModel.m
//  CRFN
//
//  Created by 房建 on 17/2/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"areaid":@"id",
             @"children":@"children",
             @"area_name":@"area_name"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
