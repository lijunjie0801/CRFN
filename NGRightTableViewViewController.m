//
//  NGRightTableViewViewController.m
//  DropDown
//
//  Created by Aaron on 14-9-18.
//  Copyright (c) 2014年 Aaron. All rights reserved.
//

#import "NGRightTableViewViewController.h"
#import "ProvincesModel.h"

@interface NGRightTableViewViewController (){
//    NSMutableArray *array;
   
}

@end

@implementation NGRightTableViewViewController
@synthesize  tableViewArray=_tableViewArray;
@synthesize cellString=_cellString;
@synthesize pulldelegate;
-(void)setTableViewArray:(NSArray *)tableViewArray{
    if (_tableViewArray==nil) {
        _tableViewArray=[[NSArray alloc]init];
    }
    _tableViewArray=tableViewArray;
}

-(NSString *)cellString{
    return self.cellString;
    
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tableViewArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                
                initWithStyle:UITableViewCellStyleDefault
                
                reuseIdentifier:CellIdentifier];
        
    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
//    UIButton *_button = [[UIButton alloc] initWithFrame:CGRectMake(0,5, 80, 20)];
////    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [_button setTitle:@"缓存" forState:UIControlStateNormal];
//    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _button.backgroundColor = [UIColor grayColor];
//    _button.opaque = YES;
//    _button.backgroundColor = [UIColor redColor];
//    [cell.contentView addSubview:_button];
//
    
    ProvincesModel *model = self.tableViewArray[indexPath.row];
    
    [cell.textLabel setText:model.area_name];
    [cell.textLabel setTextAlignment:NSTextAlignmentNatural];
//    [cell.contentView setBackgroundColor:[UIColor blueColor]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    self.cellString=[self.tableViewArray objectAtIndex:indexPath.row];
    [pulldelegate menuItemSelected:indexPath];
//    NSLog(@" .%@..select cell 。。。。。%@",[self.tableViewArray objectAtIndex:indexPath.row],_cellString);
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
