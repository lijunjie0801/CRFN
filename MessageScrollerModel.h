//
//  MessageScrollerModel.h
//  ShiTiTong
//
//  Created by fyaex001 on 2016/12/28.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "BaseModel.h"

@interface MessageScrollerModel : BaseModel

@property(nonatomic, strong) NSString *titId;
@property(nonatomic, strong) NSString *title;



+(void)requestMessageScrollerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;


@end
