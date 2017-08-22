//
//  MyselfHeaderView.h
//  CRFN
//
//  Created by zlkj on 2017/2/16.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyinfoModel;
@interface MyselfHeaderView : UIView

@property(nonatomic, strong) MyinfoModel *myinfoModel;

//头像
@property(nonatomic, strong) UIImageView *HeadImg;
//名字  积分
@property(nonatomic, strong) UILabel *titleLbl,*integrationLbl,*mybalancelbl;


@end
