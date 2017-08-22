//
//  shopCarNormsModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/28.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface shopCarNormsModel : BaseModel

@property(nonatomic, strong) NSString *typeId;//商品id
@property(nonatomic, strong) NSNumber *typeNo;//类型编号
@property(nonatomic, strong) NSString *normsValue;//类型名字
@property(nonatomic, strong) NSString *normsName;//尺寸，或者颜色，或者省份

@end
