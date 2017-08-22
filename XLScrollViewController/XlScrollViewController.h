 

#import "BaseViewController.h"

@interface XlScrollViewController : BaseViewController

@property (nonatomic ) CGFloat animationDuration;
@property (nonatomic ) NSInteger pageNumber;
-(void)updateOfInterface:(id)model;
@end
