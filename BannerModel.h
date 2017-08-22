//
//  BannerModel.h
//  CRFN
//
//  Created by zlkj on 2017/2/14.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "BaseModel.h"

@interface BannerModel : BaseModel

@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSString *imgUrl;
@property(nonatomic, strong) NSString *intro;




+(void)requestBannerModelOfCompletionHandler:(SuccessHandle)successHandle failHandler:(FailedCompletionHander)failHandler;

@end
