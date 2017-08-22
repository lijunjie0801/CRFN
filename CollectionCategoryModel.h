//
//  CategoryModel.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CollectionCategoryModel : BaseModel

@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSArray *children;

@end

@interface SubCategoryModel : BaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *goodid;
@property (nonatomic, copy) NSString *cate_img;
@property (nonatomic, copy) NSString *cate_name;
@property (nonatomic, copy) NSString *pid;

@end
