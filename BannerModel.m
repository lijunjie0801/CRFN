//
//  BannerModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

+(NSDictionary *)JSONDictionary
{
    return @{
            
             @"imgUrl":@"img"
             };
}


+(NSValueTransformer *)imgUrlJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


+(void)requestBannerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler
{
//    [RequestManager getRequestWithURLPath:KULAdBanner withParamer:nil completionHandler:^(id responseObject) {
//        
//        
//        if ([responseObject[@"result"] integerValue]==1) {
//            
//            NSArray *dataArray = (NSArray *)responseObject[@"data"];
//            
//            NSArray *array =[MTLJSONAdapter modelsOfClass:[BannerModel class] fromJSONArray:dataArray error:nil];
//            
////            [[AppDataManager defaultManager] setBannerModelArray:array];
//            
//            successHandle(array);
//            
//        }
//        
//        
//    } failureHandler:^(NSError *error, NSUInteger statusCode) {
//        failHandler(error,statusCode);
//    }];
}



@end
