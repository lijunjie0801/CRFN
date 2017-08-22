//
//  BaseModel.m
//  CRFN
//
//  Created by zlkj on 2017/2/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel





+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [self JSONDictionary];
}

+ (NSDictionary *)JSONDictionary
{
    //NSLog(@"子类需要重写%s",__FUNCTION__);
    return nil;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"没有发现这个字段%@",key);
}


@end
