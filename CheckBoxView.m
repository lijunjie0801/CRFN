//
//  CheckBoxView.m
//  GZB
//
//  Created by fyaex001 on 16/3/14.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "CheckBoxView.h"
#import <objc/message.h>

#define RgbHex2UIColor(r, g, b) [UIColor colorWithRed:((r) / 256.0) green:((g) / 256.0) blue:((b) / 256.0) alpha:1.0]

static const CGFloat kHeight = 36.0f;

@interface CheckBoxView(Private)

- (UIImage *) checkBoxImageForChecked:(BOOL) isChecked;

- (CGRect) imageviewFrameForCheckBoxImage:(UIImage *) image;

- (void) updateCheckBoxImage;

@end

@implementation CheckBoxView

@synthesize checked,enabled;
@synthesize stateChangedBlock,textColor,hightlightedTextColor;



-(id) initWithFrame:(CGRect)frame checked:(BOOL)aChecked

{
    frame.size.height = kHeight;
    if (self = [super initWithFrame:frame]) {
        
        stateChangedselector = nil;
        self.stateChangedBlock = nil;
        delegate = nil;
        checked = aChecked;
        
        self.enabled = YES;
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        CGRect labelFrame = CGRectMake(20.0f, 7.0f, self.frame.size.width - 30.0f, 20.0f);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = [UIColor redColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:label];
        
        textLabel = label;
        
        UIImage *image = [self checkBoxImageForChecked:checked];
        CGRect imageViewFrame = [self imageviewFrameForCheckBoxImage:image];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        imageView.image = image;
        [self addSubview:imageView];
        
        checkBoxImageView = imageView;
        
        if (checked) {
//            hightlightedTextColor = UIColorFromRGB(0x747474);
            textLabel.textColor = hightlightedTextColor;
        }
    }
    
    return self;
}


- (void) setEnabled:(BOOL)isEabled
{
    textLabel.enabled = isEabled;
    enabled = isEabled;
    checkBoxImageView.alpha = isEabled ? 1.0f : 0.6f;
}

- (BOOL) enabled
{
    return enabled;
}

- (void) setText:(NSString *)text
{
    [textLabel setText:text];
}

- (void) setFont:(UIFont *)font textColor:(UIColor *)color
{
    textLabel.font = font;
    textColor = color;
    hightlightedTextColor = color;
    textLabel.textColor = textColor;
}

- (void) setChecked:(BOOL)isChecked
{
    checked = isChecked;
    [self updateCheckBoxImage];
}


- (void) setStateChangedTarget:(id<NSObject>)target selector:(SEL)selector
{
    delegate = target;
    stateChangedselector = selector;
}


#pragma mark  ---Touch Methods

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!enabled) {
        return;
    }
    self.alpha = 0.8f;
    [super touchesBegan:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!enabled) {
        return;
    }
    self.alpha = 1.0f;
    [super touchesCancelled:touches withEvent:event];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!enabled) {
        return;
    }
    
    self.alpha = 1.0f;
    
    if ([self superview]) {
        UITouch *touch = [touches anyObject];
        
        CGPoint point = [touch locationInView:[self superview]];
        CGRect validTouchArea = CGRectMake(self.frame.origin.x - 5, self.frame.origin.y - 10, self.frame.size.width + 5, self.frame.size.height + 10);
        if (CGRectContainsPoint(validTouchArea, point)) {
            
            checked = !checked;
            [self updateCheckBoxImage];
            if (delegate && stateChangedselector) {
                
                [delegate performSelector:stateChangedselector withObject:self];
            }else if (stateChangedBlock) {
            
                stateChangedBlock(self);
            }
        }
    }
    [super touchesEnded:touches withEvent:event];
}

-(BOOL) canBecomeFirstResponder
{
    return YES;
}

- (void) setCheckBox:(NSString *)_onImage off:(NSString *)_offImage
{
    offImage = _offImage;
    onImage = _onImage;
    UIImage *image = [self checkBoxImageForChecked:checked];
    checkBoxImageView.frame = [self imageviewFrameForCheckBoxImage:image];
    checkBoxImageView.image = image;
}

- (NSString *)text
{
    return textLabel.text;
}


-(UIImage *) checkBoxImageForChecked:(BOOL)isChecked
{
    NSString *suffix = isChecked ? @"on" : @"off";
    NSString *imageName = @"check_";
    imageName = [NSString stringWithFormat:@"%@%@",imageName,suffix];
    
    if (isChecked) {
        
        if (onImage.length  >0) {
            imageName = onImage;
        }
    }else {
        if (offImage.length >0) {
            imageName = offImage;
        }
    }
    return [UIImage imageNamed:imageName];
}


- (CGRect) imageviewFrameForCheckBoxImage:(UIImage *)image
{
    CGFloat y = floorf((kHeight - image.size.height) / 2.0f);
    return CGRectMake(1.0f, y, image.size.width, image.size.height);
}

- (void) updateCheckBoxImage
{
    checkBoxImageView.image = [self checkBoxImageForChecked:checked];
    UIColor *color;
    if (checked) {
        color = hightlightedTextColor;
    }else {
    
        color = textColor;
    }
    textLabel.textColor = color;
}



@end
