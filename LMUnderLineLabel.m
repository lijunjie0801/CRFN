//
//  LMUnderLineLabel.m
//  GZB
//
//  Created by fyaex001 on 16/3/14.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "LMUnderLineLabel.h"

@implementation LMUnderLineLabel

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGSize fontSize;
//    CGSize size =CGSizeMake(self.frame.size.width,CGFLOAT_MAX);
//    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
//        fontSize =[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
//    }
//    //    else if (IOS7Below){
//    //        fontSize =[self.text sizeWithFont:self.font
//    //                                 forWidth:self.frame.size.width
//    //                            lineBreakMode:NSLineBreakByTruncatingTail];
//    //    }
//    CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);  // set as the text's color
//    CGContextSetLineWidth(ctx, 1.0f);
//    
//    CGPoint leftPoint = CGPointMake(0,
//                                    self.frame.size.height/2.0 +fontSize.height/2.0);
//    CGPoint rightPoint = CGPointMake(fontSize.width,
//                                     self.frame.size.height/2.0 + fontSize.height/2.0);
//    CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
//    CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
//    CGContextStrokePath(ctx);
}




@end
