//
//  shopCarGoodsModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface shopCarGoodsModel : BaseModel

@property(nonatomic, strong) NSString *goodId; //id
@property(nonatomic, strong) NSString *cid; //id
@property(nonatomic, strong) NSString *sellerId;
@property(nonatomic, strong) NSString *goodName; //商品名字
@property(nonatomic, strong) NSNumber *isShowNums; //是否允许选择数量
@property(nonatomic, strong) NSNumber *goodNums; //商品数量
@property(nonatomic, strong) NSNumber *sellPrice;  //销售价格
@property(nonatomic, strong) NSString *goodImgStr;  //商品图片
//@property(nonatomic, strong) NSArray  *specArray;//规格

@property(nonatomic, strong) NSString *specStr;//规格
@property(nonatomic, strong) NSNumber *weight;

@property(nonatomic, assign) NSInteger indexSe;//secion

@property(nonatomic, strong) NSArray  *spec_array;//规格


/**上次是否被选*/
@property (nonatomic, assign) BOOL isSelect;

@end
