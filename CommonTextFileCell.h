//
//  CommonTextFileCell.h
//  YiYuan
//
//  Created by fyaex001 on 2016/12/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTextFileCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, assign) BOOL isHide;//是否隐藏最后一根线
@property (nonatomic,strong)UITextField *textFile; //显示信息的个数

+(instancetype)commonTextFileCellWithTableView:(UITableView *)tableView;

@end
