//
//  shopCarGoodsModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "shopCarGoodsModel.h"
#import "shopCarNormsModel.h"

@implementation shopCarGoodsModel


+(NSDictionary *)JSONDictionary
{
    return @{
             @"goodId":@"id",
             @"cid":@"cid",
             @"goodName":@"name",
             @"isShowNums":@"user_nums",
             @"sellerId":@"seller_id",
             @"sellPrice":@"sell_price",
             @"goodImgStr":@"img",
             @"goodNums":@"num",
             @"weight":@"weight",
             @"specStr":@"specStr"
//             @"specArray":@"spec_array"
             };
}




//MJExtension

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"goodId":@"cid",
             @"goodName":@"name",
             @"isShowNums":@"user_nums",
             @"sellerId":@"seller_id",
             @"sellPrice":@"sell_price",
             @"goodImgStr":@"img",
             @"goodNums":@"num"
//             @"spec_array":@"shopCarNormsModel"
             
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"spec_array" : @"shopCarNormsModel"
             };
}


//+(NSValueTransformer *)JSONTransformerForKey:(NSString *)key
//{
//    if ([key isEqualToString:@"specArray"]) {
//        
//          return [MTLJSONAdapter arrayTransformerWithModelClass:shopCarNormsModel.class];
//    }
//    
//    return nil;
//}




+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
