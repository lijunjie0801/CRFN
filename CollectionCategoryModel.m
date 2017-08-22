//
//  CategoryModel.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import "CollectionCategoryModel.h"

@implementation CollectionCategoryModel

+ (NSDictionary *)objectClassInArray
{
    return @{ @"children": @"SubCategoryModel"};
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    NSLog(@"没有发现这个字段%@",key);
}



@end

@implementation SubCategoryModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if([key isEqualToString:@"id"])
    {
        self.goodid = value;
    }
    
    
    NSLog(@"没有发现这个字段%@",key);
}


@end
