//
//  CheckBoxView.h
//  GZB
//
//  Created by fyaex001 on 16/3/14.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBoxView : UIView

{
    BOOL checked;
    BOOL enabled;
    
    UIImageView *checkBoxImageView;
    UILabel     *textLabel;
    
    SEL stateChangedselector;
    id<NSObject> delegate;
    
    NSString *offImage;
    NSString *onImage;
    
    void(^stateChangedBlock) (CheckBoxView *checkBoxView);
}

@property(nonatomic, readonly) BOOL     checked;
@property(nonatomic, retain)   UIColor *hightlightedTextColor;
@property(nonatomic, retain)   UIColor *textColor;
@property (nonatomic,getter = enabled, setter = setEnabled:) BOOL enabled;
@property(nonatomic, copy) void(^stateChangedBlock)(CheckBoxView *chenckBoxView);

- (id) initWithFrame:(CGRect)frame checked:(BOOL) aChecked;

- (void) setText:(NSString *)text;

- (NSString *) text;

- (void) setFont:(UIFont *)font textColor:(UIColor *)color;

- (void) setChecked:(BOOL) isChecked;


- (void) setStateChangedTarget:(id<NSObject>)target selector:(SEL)selector;

- (void) setCheckBox:(NSString *)_onImage off:(NSString *)_offImage;




@end
