//
//  goodCellCollectionViewCell.h
//  CRFN
//
//  Created by zlkj on 2017/2/13.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import <UIKit/UIKit.h>


#define gCellIdentifier_good @"gCellIdentifier_good"

@class HomeModel;
@interface goodCellCollectionViewCell : UICollectionViewCell


@property(nonatomic, strong) HomeModel *homeModel;

@end
