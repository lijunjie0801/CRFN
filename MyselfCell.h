//
//  MyselfCell.h
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyselfCell : UITableViewCell

@property(nonatomic, strong) NSString *daifukuanNum;//待支付

@property(nonatomic, strong) NSString *daifahuoNum;//待发货

@property(nonatomic, strong) NSString *daishouhuoNum;//待收货

@property(nonatomic, strong) NSString *daipingjiaNum;//待评价

@property(nonatomic, strong) NSString *daituihuanNum;//退换货


+(instancetype)myselfCellWithTableView:(UITableView *)tableView;

@end
