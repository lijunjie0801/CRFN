//
//  ShopCartHeadViewCell.h
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ShopCartModel.h"
@class ShopCartHeadViewCell;
@class ShoppingCarModel;
@protocol ShopCartHeadViewCellDelegate <NSObject>

- (void)shopCartHeadViewCell:(ShopCartHeadViewCell *)cell withSelectedStore:(NSString *) storeId;

@end


@interface ShopCartHeadViewCell : UITableViewCell
/**店铺全选btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**店铺小图标*/
@property (nonatomic, strong) UIImageView *shopIcon;
/**店铺名称*/
@property (nonatomic, strong) UILabel *shopNameLabel;
/**更多*/
@property (nonatomic, strong) UIImageView *moreImage;
@property (nonatomic, assign) BOOL isSelect;
//@property (nonatomic, strong) ShopCartModel *model;

@property (nonatomic, strong) ShoppingCarModel *shopCarModel;



@property (weak, nonatomic) id<ShopCartHeadViewCellDelegate> delegate;

@property(nonatomic, strong) NSString *isCheck;

@end
