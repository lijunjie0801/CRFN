//
//  HomeModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/22.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

//商品的id,商品的图片，商品的售价，商品的名称,商品的真实售价，
@property(nonatomic, strong) NSString *goodId,*goodImg,*goodMarketPrice,*goodName,*goodSellPrice,*user_nums;


@end
