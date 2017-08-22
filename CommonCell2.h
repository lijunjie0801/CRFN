//
//  CommonCell2.h
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCell2 : UITableViewCell



@property(nonatomic, strong) UILabel     *titlelbl;
@property(nonatomic, strong) UILabel     *detaillbl;
@property (nonatomic, strong) UIView *line;


+(instancetype)commonCell2WithTableView:(UITableView *)tableView;
@end
