//
//  AddressDetailCell.h
//  CRFN
//
//  Created by zlkj on 2017/2/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressDetailCell : UITableViewCell

@property (nonatomic, assign) BOOL isHide;//是否隐藏最后一根线
@property (nonatomic,strong)UITextField *textFile; //显示信息的个数

+(instancetype)addressDetailCellWithTableView:(UITableView *)tableView;

@end
