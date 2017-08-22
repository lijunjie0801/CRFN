//
//  BaseModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MTLModel.h"
#import "Mantle.h"

typedef void (^SuccessHandle)(id object);
typedef void (^FailedCompletionHander)(NSError *error,NSUInteger statusCode);
@interface BaseModel : MTLModel<MTLJSONSerializing>

/**
 *  返回解析完成的字典(子类需重写)
 *
 *  @return 解析完成的字典
 */

+ (NSDictionary *)JSONDictionary;

@end
