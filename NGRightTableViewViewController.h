//
//  NGRightTableViewViewController.h
//  DropDown
//
//  Created by Aaron on 14-9-18.
//  Copyright (c) 2014年 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PulldownMenuDelegate
-(void)menuItemSelected:(NSIndexPath *)indexPath;
-(void)pullDownAnimated:(BOOL)open;
@end

@interface NGRightTableViewViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
 id<PulldownMenuDelegate> pulldelegate;

}

@property (nonatomic, retain) id<PulldownMenuDelegate> pulldelegate;
@property (nonatomic,strong) NSArray *tableViewArray;
@property (nonatomic,strong) NSString *cellString;

-(NSString *) cellString;
@end
