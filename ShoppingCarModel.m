//
//  ShoppingCarModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "ShoppingCarModel.h"
#import "shopCarGoodsModel.h"
#import "MTLJSONAdapter.h"

@implementation ShoppingCarModel



+(NSDictionary *)JSONDictionary
{
    return @{
             @"sellerId":@"seller_id",
             @"companName":@"comp_name",
             @"goodsArray":@"goods"
             };
}





//MJExtension

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"sellerId":@"seller_id",
             @"companName":@"comp_name"
//             @"goods":@"shopCarGoodsModel"
             
             };
}


+ (NSDictionary *)mj_objectClassInArray{
    return @{
              @"goods" : @"shopCarGoodsModel"
              };
}



//+(NSValueTransformer *)JSONTransformerForKey:(NSString *)key
//{
//    NSLog(@"===%@",key);
//    if ([key isEqualToString:@"goodsArray"]) {
//        
//        return [MTLJSONAdapter arrayTransformerWithModelClass:shopCarGoodsModel.class];
//    }
//   
//    return nil;
//}







+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


@end
