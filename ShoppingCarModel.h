//
//  ShoppingCarModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface ShoppingCarModel : BaseModel


@property(nonatomic, strong) NSString *sellerId;

//公司名字
@property(nonatomic, strong) NSString *companName;
//产品数组
@property(nonatomic, strong) NSArray  *goodsArray;


@property(nonatomic, strong) NSArray  *goods;

/**上次是否被选*/
@property (nonatomic, assign) BOOL isSelect;

@end
