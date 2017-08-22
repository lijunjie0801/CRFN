//
//  ProvincesModel.m
//  CRFN
//
//  Created by 房建 on 17/2/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ProvincesModel.h"

@implementation ProvincesModel



+(NSDictionary *)JSONDictionary
{
    return @{
             @"sid":@"id",
             @"area_name":@"area_name",
             @"cityArray":@"children"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+(void)requestProvincesModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
    
}


@end
