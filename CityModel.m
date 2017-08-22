//
//  CityModel.m
//  CRFN
//
//  Created by 房建 on 17/2/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"cid":@"id",
             @"area_name":@"area_name",
             @"areaArray":@"children"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end
