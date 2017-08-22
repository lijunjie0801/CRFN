//
//  MessageScrollerModel.m
//  ShiTiTong
//
//  Created by fyaex001 on 2016/12/28.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MessageScrollerModel.h"

@implementation MessageScrollerModel
+(NSDictionary *)JSONDictionary
{
    return @{
             @"titId":@"id",
             @"title":@"title"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


+(void)requestMessageScrollerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
//    [RequestManager getRequestWithURLPath:KULMessageNotice withParamer:nil completionHandler:^(id responseObject) {
//        
//        
//        
//        if ([responseObject[@"result"] integerValue] ==1) {
//            
//            NSArray *dataArray = responseObject[@"data"];
//            NSArray *array =[MTLJSONAdapter modelsOfClass:[MessageScrollerModel class] fromJSONArray:dataArray error:nil];
//            
//            // [[AppDataManager defaultManager] setBannerModelArray:array];
//            
//            successHandle(array);
//            
//        }else{
//            
//        }
//        
//        
//        
//    } failureHandler:^(NSError *error, NSUInteger statusCode) {
//        failHandler(error,statusCode);
//    }];
}


@end
