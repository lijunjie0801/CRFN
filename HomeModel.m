//
//  HomeModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/22.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"goodId":@"id",
             @"goodImg":@"img",
             @"goodMarketPrice":@"market_price",
             @"goodName":@"name",
             @"user_nums":@"user_nums",
             @"goodSellPrice":@"sell_price"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end
