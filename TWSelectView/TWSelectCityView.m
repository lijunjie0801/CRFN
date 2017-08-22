//
//  TWSelectCityView.m
//  TWCitySelectView
//
//  Created by TreeWriteMac on 16/6/30.
//  Copyright © 2016年 Raykin. All rights reserved.
//

#import "TWSelectCityView.h"
#import "ProvincesModel.h"
#import "CityModel.h"
#import "AreaModel.h"

#define TWW self.frame.size.width
#define TWH self.frame.size.height

#define TWRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define BtnW 60
#define toolH 40
#define BJH 260

@interface TWSelectCityView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIView *_BJView;                //一个view，工具栏和pickview都是添加到上面，便于管理
    
    NSArray *_AllARY;          //取出所有数据(json类型，在pilst里面)
    NSMutableArray *_ProvinceAry;          //只装省份的数组
    NSMutableArray *_CityAry;              //只装城市的数组
    NSMutableArray *_DistrictAry;          //只装区的数组（还有县）
    UIPickerView *_pickView;        //最主要的选择器
    
    NSInteger _proIndex;            //用于记录选中哪个省的索引
    NSInteger _cityIndex;           //用于记录选中哪个市的索引
    NSInteger _districtIndex;       //用于记录选中哪个区的索引
}

@property (copy, nonatomic) void (^sele)(ProvincesModel *proviceModel,CityModel *cityModel,AreaModel *areaModel);

@end

@implementation TWSelectCityView


-(instancetype)initWithTWFrame:(CGRect)rect TWselectCityTitle:(NSString *)title andArray:(NSArray *)Parray{
    if (self = [super initWithFrame:rect]) {
        
        _ProvinceAry = [NSMutableArray array];
        _CityAry = [NSMutableArray array];
        _DistrictAry = [NSMutableArray array];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }];
        
        
        _AllARY = Parray;
        for (ProvincesModel *dci in _AllARY) {
            
//            [_ProvinceAry addObject:[[dci allKeys] firstObject]];
            [_ProvinceAry addObject:dci];
            
        }
   
        if (!_ProvinceAry.count) {
            NSLog(@"卧槽，你连数据都没有，你也敢来调用");
        }
        
        //显示pickview和按钮最底下的view
        _BJView = [[UIView alloc] initWithFrame:CGRectMake(0, TWH, TWW, BJH)];
        [self addSubview:_BJView];
        
        UIView *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, TWW, toolH)];
        tool.backgroundColor = TWRGB(237, 236, 234);
        [_BJView addSubview:tool];
        
        /**
         按钮+中间可以显示标题的UILabel
         */
        UIButton *left = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        left.frame = CGRectMake(0, 0, BtnW, toolH);
        [left setTitle:@"取消" forState:UIControlStateNormal];
        [left addTarget:self action:@selector(leftBTN) forControlEvents:UIControlEventTouchUpInside];
        [tool addSubview:left];
        
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(left.frame.size.width, 0, TWW-(left.frame.size.width*2), toolH)];
        titleLB.text = title;
        titleLB.textAlignment = NSTextAlignmentCenter;
        [tool addSubview:titleLB];
        
        UIButton *right = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        right.frame = CGRectMake(TWW-BtnW ,0,BtnW, toolH);
        [right setTitle:@"确定" forState:UIControlStateNormal];
        [right addTarget:self action:@selector(rightBTN) forControlEvents:UIControlEventTouchUpInside];
        [tool addSubview:right];


        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,toolH, TWW, _BJView.frame.size.height-toolH)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = TWRGB(237, 237, 237);
        [_BJView addSubview:_pickView];
        
        
        for (NSDictionary *dci in _AllARY) {
            
            if (_AllARY.count-1>=_proIndex) {
            
                ProvincesModel *provinceModel = _ProvinceAry[_proIndex];
//                _CityAry = [NSMutableArray arrayWithArray:[[dci objectForKey:_ProvinceAry[_proIndex]] allKeys]];
                
                NSArray *array =[MTLJSONAdapter modelsOfClass:[CityModel class] fromJSONArray:provinceModel.cityArray error:nil];
                _CityAry = [NSMutableArray arrayWithArray:array];
                
                [_pickView reloadComponent:1];
                [_pickView selectRow:0 inComponent:1 animated:YES];
                
//                NSLog(@"%@",[[dci objectForKey:_ProvinceAry[_proIndex]] objectForKey:_CityAry[0]]);
                
              
//                _DistrictAry = [NSMutableArray arrayWithArray:[[dci objectForKey:_ProvinceAry[_proIndex]] objectForKey:_CityAry[0]]];
                
                CityModel *cityModel = _CityAry[0];
                NSArray *array1 =[MTLJSONAdapter modelsOfClass:[AreaModel class] fromJSONArray:cityModel.areaArray error:nil];
                _DistrictAry = [NSMutableArray arrayWithArray:array1];
                
                [_pickView reloadComponent:2];
                [_pickView selectRow:0 inComponent:2 animated:YES];
                
                
            }
        }
       
    }
    return self;
    
}

//自定义每个pickview的label
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = [UILabel new];
    pickerLabel.numberOfLines = 0;
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    [pickerLabel setFont:[UIFont boldSystemFontOfSize:12]];
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

/**
 *  下面几个委托方法相信大家都知道，我就不一一说了😄😄😄😄😄😄
 *
 */

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        _proIndex = row;
        _cityIndex = 0;
        _districtIndex = 0;
        
        for (NSDictionary *dci in _AllARY) {
            
            if (_AllARY.count-1>=_proIndex) {
            
            
            ProvincesModel *provinceModel = _ProvinceAry[_proIndex];

            
            NSArray *array =[MTLJSONAdapter modelsOfClass:[CityModel class] fromJSONArray:provinceModel.cityArray error:nil];
            _CityAry = [NSMutableArray arrayWithArray:array];
            
            
//                _CityAry = [NSMutableArray arrayWithArray:[[dci objectForKey:_ProvinceAry[_proIndex]] allKeys]];
            
                [_pickView reloadComponent:1];
                [_pickView selectRow:0 inComponent:1 animated:YES];
                
//                _DistrictAry = [NSMutableArray arrayWithArray:[[dci objectForKey:_ProvinceAry[_proIndex]] objectForKey:_CityAry[0]]];
            
            CityModel *cityModel = _CityAry[0];
            NSArray *array1 =[MTLJSONAdapter modelsOfClass:[AreaModel class] fromJSONArray:cityModel.areaArray error:nil];
            _DistrictAry = [NSMutableArray arrayWithArray:array1];
            
            
                [_pickView reloadComponent:2];
                [_pickView selectRow:0 inComponent:2 animated:YES];

            }
        }
        
    }
    
    if (component == 1) {
        _cityIndex = row;
        _districtIndex = 0;

        for (NSDictionary *dcis in _AllARY) {
            
            if (_AllARY.count-1>=_proIndex) {
            
            
            ProvincesModel *provinceModel = _ProvinceAry[_proIndex];
            
            
            NSArray *cityArray =[MTLJSONAdapter modelsOfClass:[CityModel class] fromJSONArray:provinceModel.cityArray error:nil];
            _CityAry = [NSMutableArray arrayWithArray:cityArray];
            
            if (provinceModel.cityArray.count-1>=_cityIndex) {
                    
//                CityModel *cityModel = provinceModel.cityArray[_cityIndex];
                
                CityModel *cityModel = [MTLJSONAdapter modelOfClass:[CityModel class] fromJSONDictionary:provinceModel.cityArray[_cityIndex] error:nil];
                
                NSArray *areaArray = [MTLJSONAdapter modelsOfClass:[AreaModel class] fromJSONArray:cityModel.areaArray error:nil];
        
                
                _DistrictAry = [NSMutableArray arrayWithArray:areaArray];
                
                [_pickView reloadComponent:2];
                [_pickView selectRow:0 inComponent:2 animated:YES];
                        
                        
                    
             
                }


            }
        }
        
    }
    
    if (component == 2) {
        _districtIndex = row;
    }
    
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        ProvincesModel *model = _ProvinceAry[row];
//        return [_ProvinceAry objectAtIndex:row];
        return model.area_name;
    }else if (component == 1){
//        return [_CityAry objectAtIndex:row];
        CityModel *model = _CityAry[row];
        return model.area_name;
    }else if (component == 2){
//        return [_DistrictAry objectAtIndex:row];
        AreaModel *model = _DistrictAry[row];
        return model.area_name;
    }
    
    return nil;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return _ProvinceAry.count;
    }else if (component == 1){
        return _CityAry.count;
    }else if (component == 2){
        return _DistrictAry.count;
    }
    
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

/**
 *  左边的取消按钮
 */
-(void)leftBTN{
    __weak typeof(UIView*)blockview = _BJView;
    __weak typeof(self)blockself = self;
    __block int blockH = TWH;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        bjf.origin.y = blockH;
        blockview.frame = bjf;
        blockself.alpha = 0.1;
    } completion:^(BOOL finished) {
        [blockself removeFromSuperview];
    }];
    
}

/**
 *  右边的确认按钮
 */
-(void)rightBTN{
    __weak typeof(UIView*)blockview = _BJView;
    __weak typeof(self)blockself = self;
    __block int blockH = TWH;
    
    if (self.sele) {
        
        ProvincesModel *provinceModel = _ProvinceAry[_proIndex];
        CityModel *cityModel = _CityAry[_cityIndex];
        AreaModel *areaModel = _DistrictAry[_districtIndex];
        
//        self.sele(provinceModel.sid,cityModel.cid,areaModel.areaid);
        self.sele(provinceModel,cityModel,areaModel);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        bjf.origin.y = blockH;
        blockview.frame = bjf;
        blockself.alpha = 0.1;
    } completion:^(BOOL finished) {
        [blockself removeFromSuperview];
    }];
}


//-(void)showCityView:(void (^)(NSString *, NSString *, NSString *))selectStr{
//    
//    self.sele = selectStr;
//    
//    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
//    
//    __weak typeof(UIView*)blockview = _BJView;
//    __block int blockH = TWH;
//    __block int bjH = BJH;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect bjf = blockview.frame;
//        bjf.origin.y = blockH-bjH;
//        blockview.frame = bjf;
//    }];
//    
//}


-(void)showCityView:(void (^)(ProvincesModel *, CityModel *, AreaModel *))selectStr
{
        self.sele = selectStr;
    
        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
        __weak typeof(UIView*)blockview = _BJView;
        __block int blockH = TWH;
        __block int bjH = BJH;
    
        [UIView animateWithDuration:0.3 animations:^{
            CGRect bjf = blockview.frame;
            bjf.origin.y = blockH-bjH;
            blockview.frame = bjf;
        }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_BJView.frame, point)) {
        [self leftBTN];
    }

}

@end
