//
//  NavigationProvinveModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/22.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "NavigationProvinveModel.h"

@implementation NavigationProvinveModel
+(NSDictionary *)JSONDictionary
{
    return @{
        
             @"proId":@"id",
             @"area_name":@"area_name"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}
@end
