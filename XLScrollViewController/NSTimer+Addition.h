//
//  NSTimer+Addition.h
//  ADScrollView
//
//  Created by miao on 14-7-7.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)


- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
