//
//  MyselfDetailViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/23.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "MyselfDetailViewController.h"
#import "commonImgCell.h"
#import "CommonTextFileCell.h"
#import "AddressDetailCell.h"
#import "ActionSheetPicker-3.0/ActionSheetPicker.h"
#import "ProvincesModel.h"
#import "CityModel.h"
#import "AreaModel.h"
#import "TWSelectCityView.h"
#import "MyinfoModel.h"


@interface MyselfDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSString *pId; //省id
    NSString *cId; //市id
    NSString *aId;//区id
    
    NSString *headImgStr; //头像照片

}

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIImageView *headImg; //用户头像

//用户昵称,手机号，性别，企业名称，企业联系方式，企业地址，企业详细地址
@property(nonatomic, strong) UITextField *usernameFile,*userPhoneFile,*sexFile,*companyNameFile,*companyPhoneFile,*provinceFile,*addressFile;

@property(nonatomic, strong)UIImagePickerController *imagePicker;


@property(nonatomic, strong) MyinfoModel *myinfoModel;

@end

@implementation MyselfDetailViewController


-(void)setIntentDic:(NSDictionary *)intentDic
{
    _myinfoModel = (MyinfoModel *)intentDic[@"MyinfoModel"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"基本信息";

    
    [self showRightItem];
     self.tableView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
   
    
}




#pragma mark -UITableViewDelegate-----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 3;
    }else if (section ==1){
    
        return 4;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    CommonTextFileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[CommonTextFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
       
    }
    
    commonImgCell *imgCell = [commonImgCell commonImgCellWithTableView:tableView];
    
    AddressDetailCell *adrCell = [AddressDetailCell addressDetailCellWithTableView:tableView];
    
    cell.selectionStyle    = UITableViewCellSelectionStyleNone;
    imgCell.selectionStyle = UITableViewCellSelectionStyleNone;
    adrCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
            
            if (indexPath.row ==0) {
                //头像
                imgCell.titleLabel.text = @"头像上传";
                NSString *url = [NSString stringWithFormat:@"%@/%@",KBaseURL,_myinfoModel.head_imgStr];
                [imgCell.img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
                _headImg = imgCell.img;
                //设置箭头
                [imgCell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                return imgCell;
                
            }else if(indexPath.row ==1){
            
                //昵称
                cell.titleLabel.text = @"昵称";
                cell.textFile.placeholder = @"请输入昵称";
                if (_myinfoModel.userName.length>0) {
                    
                    cell.textFile.text = _myinfoModel.userName;
                    
                }
            
                _usernameFile = cell.textFile;
                
                //设置箭头
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                return cell;
                
            }else{
            
                //手机号码
                cell.titleLabel.text = @"手机号";
                cell.textFile.enabled = NO;
                _userPhoneFile = cell.textFile;
            
                cell.textFile.text = _myinfoModel.userMobile;
                //设置箭头
//                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                return cell;
                
            }

        case 1:
            

            if (indexPath.row ==0) {
                //企业名称
                cell.titleLabel.text = @"名称";
//                cell.textFile.placeholder = @"请输入昵称";
                _companyNameFile = cell.textFile;
                cell.textFile.enabled = NO;
                
                cell.textFile.text = _myinfoModel.companName;
                //设置箭头
//                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                return cell;
                
            }else if (indexPath.row ==1){
                //联系方式
                cell.titleLabel.text = @"联系方式";
//                cell.textFile.placeholder = @"请输入联系方式";
                cell.textFile.enabled = NO;
                cell.textFile.text = _myinfoModel.companTel;
                _companyPhoneFile = cell.textFile;
                //设置箭头
//                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                return cell;
            
            }else if (indexPath.row ==2){
                //地址
                cell.titleLabel.text = @"地址";
//                cell.textFile.placeholder = @"请选择地址";
                cell.textFile.text = _myinfoModel.provinceName;
                _provinceFile = cell.textFile;
                _provinceFile.enabled = NO;
                //设置箭头
//                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                return cell;
            
            }else{
            
                //详细地址
                adrCell.textFile.placeholder = @"请输入详细地址";
                adrCell.textFile.enabled = NO;
                adrCell.textFile.text = _myinfoModel.addressDetail;
                _addressFile = adrCell.textFile;
                return adrCell;
                
            }
            break;
        case 2:
            
            cell.titleLabel.text = @"修改密码";
            //设置箭头
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            cell.textFile.enabled = NO;
            return cell;
            
            break;
    
            
        default:
            break;
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            _imagePicker = [[UIImagePickerController alloc] init];
            _imagePicker.editing = YES;
            _imagePicker.delegate = self;
            
            _imagePicker.allowsEditing = YES;
            
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"相册", nil];
            sheet.actionSheetStyle = UIActionSheetStyleDefault;
            
            [sheet showInView:self.view];
            
        }
      
 
    }else if(indexPath.section ==2){
    
        [_svc pushViewController:_svc.restPwdViewController];
    }
}





-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePicker animated:YES completion:nil];
        
    }else if (buttonIndex ==1){
        
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    }else{
        
        //取消
    }
}



#pragma mark  --UImagePickerControllerDelegate
//选择图片完成后调用的方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    //通过info字典获取选择的照片
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    
    _headImg.image = image;
    
    //把一张图片保存到图库中，此时无论是这张照片是照相机拍的还是本身从图库中取出的，都会保存到图库中;
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    //压缩图片，如果图片要上传到服务器或者网络，子需要执行该步骤(压缩),第二个参数是压缩比例，转化为NsData类型
    NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
    
    // 对于base64编码编码
    headImgStr=[fileData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    //关闭一模态形式显示的UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row ==0) {
  
        return [MyAdapter aDapter:60];
    }
    return [MyAdapter aDapter:44];
}

//让UITableView的section header view不悬停的方法
-(UITableViewStyle)tableViewStyle
{
    return UITableViewStyleGrouped;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==2) {
        
        return 0;
    }
    return 35;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 35)];
    
    view.backgroundColor = [AppAppearance sharedAppearance].whiteColor;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WIDTH, 30)];
    lbl.textColor = [AppAppearance sharedAppearance].titleTextColor;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 32, WIDTH, 3)];
    backView.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    [view addSubview:backView];
    
    [view addSubview:lbl];
    
    if (section == 0) {
        
        lbl.text = @"个人信息";
        
    }else if(section ==1){
        
        lbl.text = @"企业信息";
    }
    lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:[MyAdapter fontDapter:16]];
    return view;
}



//section头部间距
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 10;
//    }
//    return 5;//section头部高度
//}
////section头部视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 5)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 3)];
    view.backgroundColor = [AppAppearance sharedAppearance].pageBackgroundColor;
    return view;
}



-(void)showRightItem
{
    UIButton *button = [self.class buttonWithImage:nil title:@"完成" target:self action:@selector(saveClick)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)saveClick
{
    if ([self checkSubmit]) {
        NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"head_img":headImgStr,@"username":_usernameFile.text};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KULupd_myInfo]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功");
            NSLog(@"%@",responseObject);
            
            
            
       
            [_svc showMessage:responseObject[@"message"]];
            [_svc hideLoadingView];
            
        } progress:^(NSProgress *progress) {
            
            NSLog(@"1111");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [_svc hideLoadingView];
            
            [_svc showMessage:error.domain];
        }];
        
    }
}

-(BOOL)checkSubmit
{
    if (headImgStr.length == 0) {
        [_svc showMessage:@"请上传头像"];
        return NO;
    }
    if (_usernameFile.text.length == 0) {
        [_svc showMessage:@"请输入昵称"];
        return NO;
    }
//    if (_sexFile.text.length == 0) {
//        [_svc showMessage:@"请选择性别"];
//        return NO;
//    }
//    if (_companyNameFile.text.length == 0) {
//        [_svc showMessage:@"请输入企业名称"];
//        return NO;
//    }
//    if (_companyPhoneFile.text.length == 0) {
//        [_svc showMessage:@"请输入联系方式"];
//        return NO;
//    }
//    if (_provinceFile.text.length == 0) {
//        [_svc showMessage:@"请选择地址"];
//        return NO;
//    }
//    if (_addressFile.text.length == 0) {
//        [_svc showMessage:@"请输入详细地址"];
//        return NO;
//    }
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
