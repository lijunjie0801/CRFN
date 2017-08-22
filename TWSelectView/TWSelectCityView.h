//
//  TWSelectCityView.h
//  TWCitySelectView
//
//  Created by TreeWriteMac on 16/6/30.
//  Copyright © 2016年 Raykin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProvincesModel;
@class CityModel;
@class AreaModel;

@interface TWSelectCityView : UIView

-(instancetype)initWithTWFrame:(CGRect)rect TWselectCityTitle:(NSString*)title andArray:(NSArray *)Parray;

/**
 *  显示
 */
-(void)showCityView:(void(^)(ProvincesModel *proviceModel,CityModel *cityModel,AreaModel *areaModel))selectStr;


@end
