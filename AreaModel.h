//
//  AreaModel.h
//  CRFN
//
//  Created by 房建 on 17/2/17.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface AreaModel : BaseModel

@property(nonatomic, strong) NSString *areaid;
@property(nonatomic, strong) NSString *area_name;
@property(nonatomic, strong) NSArray *children;


@end
