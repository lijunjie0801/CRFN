//
//  MyAdapter.m
//  CRFN
//
//  Created by zlkj on 2017/2/9.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyAdapter.h"

@implementation MyAdapter
//4.7inch  375*667
+(float)aDapter:(float)old{
    return WIDTH>375?old*1.2:old;
}

+(float)laDapter:(float)old{
    return WIDTH<375?old/1.2:old;
}

+(float)laDapter360:(float)old{
    return [self laDapter:old*1.15];
}

+(UIFont*)fontADapter:(float)old{
    return [UIFont  systemFontOfSize:WIDTH>375?old*1.2:old];
}
+(float)fontDapter:(float)old{
    return WIDTH>375?old*1.2:old;
}

+(UIFont*)lfontADapter:(float)old{
    return [UIFont  systemFontOfSize:WIDTH<375?old/1.2:old];
}

+(UIFont*)lfontADapter360:(float)old{
    return [self lfontADapter:old*1.15];
}
@end
