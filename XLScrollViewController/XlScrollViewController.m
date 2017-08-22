 

#import "XlScrollViewController.h"
#import "XLScrollView.h"
#import "BannerModel.h"

@interface XlScrollViewController ()<XLScrollViewDelegate>

@property (nonatomic,strong)XLScrollView *xlScrollView;
@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation XlScrollViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(starTimer)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopTimer)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [_xlScrollView starTimer];
}

-(void)setAnimationDuration:(CGFloat)animationDuration
{
    _xlScrollView.animationDuration = animationDuration;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _xlScrollView = [[XLScrollView alloc] initWithFrame:self.view.bounds];
    _xlScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _xlScrollView.currentPageIndex = _pageNumber;
    _xlScrollView.delegate = self;

    [self.view addSubview:_xlScrollView];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self removeNotificationCenter];
    [_xlScrollView stopTimer];
}

-(void)removeNotificationCenter
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)updateOfInterface:(id)model;
{
    NSArray *arry = model;
    if(arry.count >0){
        _dataArray = arry;
        [_xlScrollView updateOfInterface];
    }
}
-(void)starTimer
{
    if(_dataArray.count >0){
        [_xlScrollView starTimer];
    }
}

-(void)stopTimer
{
    [_xlScrollView stopTimer];
}

#pragma mark - XlScrollViewControllerDelegate

-(NSInteger)totalPagesCountInXlScrollView:(XLScrollView *)scrollView
{
    return _dataArray.count;
}

-(UIView *)XLscrollView:(XLScrollView *)scrollView imageAtIndex:(NSInteger)pageIndex
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _xlScrollView.frame.size.width,_xlScrollView.frame.size.height)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    BannerModel *bannerModel = [_dataArray objectAtIndex:pageIndex];
    
    NSString *imgString =[NSString stringWithFormat:@"%@/%@",KBaseURL,bannerModel.imgUrl];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:imgString] placeholderImage:[UIImage imageNamed:@"default"]];
   // [imageView setImageWithURL:bannerModel.imgUrl placeholderImage:nil];
    
    
    return imageView;
}

-(NSString *)XLscrollView:(XLScrollView *)scrollView labelTextAtIndex:(NSInteger)pageIndex
{
    BannerModel *bannerModel = [_dataArray objectAtIndex:pageIndex];
    return bannerModel.intro;
}

//图片轮播器中每张图片的点击事件
-(void)XLscrollView:(XLScrollView *)scrollView contentViewTapAction:(NSInteger)pageIndex
{
    BannerModel *bannerModel = [_dataArray objectAtIndex:pageIndex];
    if (bannerModel.url.length)
    {
//        if ([bannerModel.intro isEqualToString:@"收益增益计划"]) {
//            [_svc presentViewController:_svc.webViewController withObjects:@{@"url":bannerModel.url,@"title":bannerModel.intro}];
//        }else {
//            [_svc presentViewController:_svc.webViewController withObjects:@{@"url":bannerModel.url,@"title":bannerModel.intro}];
//        }
       // [_svc presentViewController:_svc.baseWebViewViewController withObjects:@{@"url":bannerModel.url}];
      
        
      //  [_svc presentViewController:_svc.webViewController withObjects:@{@"url":bannerModel.url,@"title":@"工资宝"}];
        
//        [_svc pushViewController:_svc.baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@",KBaseURL,bannerModel.url]}];
    }
}


@end
