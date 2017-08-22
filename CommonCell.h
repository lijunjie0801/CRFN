//
//  CommonCell.h
//  GZB
//
//  Created by fyaex001 on 16/4/5.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCell : UITableViewCell


@property(nonatomic, strong) UILabel     *titlelbl;
@property(nonatomic, strong) UIImageView *iconImg;
@property(nonatomic, strong) UILabel     *detaillbl;
@property (nonatomic, strong) UIView *line;


+(instancetype)commonCellWithTableView:(UITableView *)tableView;

@end
