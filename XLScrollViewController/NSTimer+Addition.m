//
//  NSTimer+Addition.m
//  ADScrollView
//
//  Created by miao on 14-7-7.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)

//时间暂停
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

//继续，开始时间
-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
