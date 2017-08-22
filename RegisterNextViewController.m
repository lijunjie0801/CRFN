//
//  RegisterNextViewController.m
//  CRFN
//
//  Created by zlkj on 2017/2/10.
//  Copyright © 2017年 zlkj. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "CommonTextFileCell.h"
#import "TWSelectCityView.h"
#import "ProvincesModel.h"
#import "CityModel.h"
#import "AreaModel.h"

@interface RegisterNextViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

{
    NSString *pId; //省id
    NSString *cId; //市id
    NSString *aId;//区id
    
    NSString *identityCarFrontStr; //身份证正面
    NSString *identityCarVersoStr; //身份证反正
    NSString *businesslicenseStr;//企业营业执照
    NSString *doorHeadImg1Str; //门头照1
    NSString *doorHeadImg2Str; //门头照2
}

@property(nonatomic, strong)UIImagePickerController *imagePicker;
@property(nonatomic, strong) UIPickerView *pickerView;


@property(nonatomic, strong) UITableView *tableView;

//身份证正面照，身份证反面照，营业执照，门头照，门头照
@property(nonatomic, strong) UIImageView *identityCarFront,*identityCarVerso,*businesslicense,*doorHeadImg1,*doorHeadImg2;

@property(nonatomic, strong) UITextField *companyNameField,*linkmanField,*phoneField,*addressField;
@property(nonatomic, strong) UITextField *provinceText;//省市区
@property(nonatomic, strong) NSArray   *provincesArray;

@end

@implementation RegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"企业认证";
    [self showLoginItem];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.tableFooterView = [self footerViews];
    
    
    [self requestProvince];
    
    
}

-(NSArray *)provincesArray
{
    if (!_provincesArray) {
        
        _provincesArray = [[NSArray alloc] init];
    }
    return _provincesArray;
}

-(void)requestProvince
{
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLProvince]).RequestType(Get).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(nil) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        
        if ([responseObject[@"status"] integerValue]==1) {

            NSArray *dataArray = (NSArray *)responseObject[@"areas_list"];

            NSArray *array =[MTLJSONAdapter modelsOfClass:[ProvincesModel class] fromJSONArray:dataArray error:nil];
            
            _provincesArray = array;

            
        }
        
        
        NSLog(@"safdfdsf");
        
        
    } progress:^(NSProgress *progress) {
        
        NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
}


-(UIView *)footerViews
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, WIDTH,[MyAdapter aDapter:100]*5+[MyAdapter aDapter:45]+30+60)];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    lbl.font = [MyAdapter fontADapter:16];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [AppAppearance sharedAppearance].mainColor;
    lbl.text = @"上传证件";
    [footerView addSubview:lbl];
    
    //身份证正面
    _identityCarFront = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lbl.frame)+10, WIDTH-40, [MyAdapter aDapter:100])];
    _identityCarFront.image = [UIImage imageNamed:@"register_Company-documents01"];
    _identityCarFront.contentMode = UIViewContentModeScaleAspectFit;
    _identityCarFront.tag =100;
    _identityCarFront.userInteractionEnabled = YES;
    [footerView addSubview:_identityCarFront];
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setoneImg:)];
    tag.view.tag = 100;
    [_identityCarFront addGestureRecognizer:tag];
    
    
    
    //身份证反面
    _identityCarVerso = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_identityCarFront.frame)+10, WIDTH-40, [MyAdapter aDapter:100])];
    _identityCarVerso.image = [UIImage imageNamed:@"register_Company-documents02"];
    _identityCarVerso.contentMode = UIViewContentModeScaleAspectFit;
    _identityCarVerso.tag = 200;
    _identityCarVerso.userInteractionEnabled = YES;
    [footerView addSubview:_identityCarVerso];
    UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setoneImg:)];
    tag1.view.tag = 200;
    [_identityCarVerso addGestureRecognizer:tag1];
    
    //营业执照
    _businesslicense = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_identityCarVerso.frame)+10, WIDTH-40, [MyAdapter aDapter:100])];
    _businesslicense.image = [UIImage imageNamed:@"register_Company-documents03"];
    _businesslicense.contentMode = UIViewContentModeScaleAspectFit;
    _businesslicense.tag = 300;
    _businesslicense.userInteractionEnabled = YES;
    [footerView addSubview:_businesslicense];
    UITapGestureRecognizer *tag2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setoneImg:)];
    tag2.view.tag = 300;
    [_businesslicense addGestureRecognizer:tag2];
    
    //门头照1
    _doorHeadImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_businesslicense.frame)+10, WIDTH-40, [MyAdapter aDapter:100])];
    _doorHeadImg1.image = [UIImage imageNamed:@"register_Company-documents04"];
    _doorHeadImg1.contentMode = UIViewContentModeScaleAspectFit;
    _doorHeadImg1.tag = 400;
    _doorHeadImg1.userInteractionEnabled = YES;
    [footerView addSubview:_doorHeadImg1];
    UITapGestureRecognizer *tag3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setoneImg:)];
    tag3.view.tag = 400;
    [_doorHeadImg1 addGestureRecognizer:tag3];
    
    //门头照2
    _doorHeadImg2 = [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_doorHeadImg1.frame)+10, WIDTH-40, [MyAdapter aDapter:100])];
    _doorHeadImg2.image = [UIImage imageNamed:@"register_Company-documents04"];
    _doorHeadImg2.contentMode = UIViewContentModeScaleAspectFit;
    _doorHeadImg2.tag = 500;
    _doorHeadImg2.userInteractionEnabled = YES;
    [footerView addSubview:_doorHeadImg2];
    UITapGestureRecognizer *tag4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setoneImg:)];
    tag4.view.tag = 500;
    [_doorHeadImg2 addGestureRecognizer:tag4];
    
    
    UIButton *submitBtn = [[UIButton alloc] init];
    submitBtn.frame = CGRectMake(10, CGRectGetMaxY(_doorHeadImg2.frame)+10, WIDTH-20, [MyAdapter aDapter:45]);
    submitBtn.backgroundColor    = [AppAppearance sharedAppearance].mainColor;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [MyAdapter fontADapter:16];
    submitBtn.layer.cornerRadius = 10;
    submitBtn.layer.masksToBounds      = YES;
    [submitBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitBtn];
    
    
    
    
    return footerView;
}

//提交方法
-(void)registerBtnClick
{
    
    if ([self RegisterCheckInput]) {
        
        
        [_svc showLoadingWithMessage:@"注册中..." inView:[UIApplication sharedApplication].keyWindow];
        
        
        NSDictionary *params = @{@"hand_idcard_img":identityCarFrontStr,@"front_img":identityCarVersoStr,@"licence_img":businesslicenseStr};
        
        
        NSDictionary *param =@{@"token":[AppDataManager defaultManager].identifier,@"comp_name":_companyNameField.text,@"comp_contact":_linkmanField.text,@"comp_tel":_phoneField.text,@"province":pId,@"city":cId,@"area":aId,@"addr_detail":self.addressField.text,@"rack_img1":doorHeadImg1Str,@"rack_img2":doorHeadImg2Str};
        
        [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:KURLRegisterInfo]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"成功");
            NSLog(@"%@",responseObject);
            
            
            
            if ([responseObject[@"status"] intValue] ==1) {
                
                //跳转到待审核界面
//                [_svc pushViewController:_svc.waitCheckViewController];
                [self sendNextImgData];
               
                
            }else{
                
                [_svc showMessage:responseObject[@"message"]];
            }
            
//            [_svc hideLoadingView];
            
        } progress:^(NSProgress *progress) {
            
//            NSLog(@"1111");
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            [_svc hideLoadingView];
            
            [_svc showMessage:error.domain];
        }];
        
        
        
        
    }
    
}


-(void)sendNextImgData
{
    
    
    NSDictionary *param = @{@"token":[AppDataManager defaultManager].identifier,@"hand_idcard_img":identityCarFrontStr,@"front_img":identityCarVersoStr,@"licence_img":businesslicenseStr};
    
    
    [[AFNetAPIClient sharedJsonClient].setRequest([URLManager requestURLGenetatedWithURL:@"/login/submitImg"]).RequestType(Post).Cachetype(WYQHTTPClientReloadIgnoringLocalCacheData).time(60).Parameters(param) startRequestWithSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"成功");
        NSLog(@"%@",responseObject);
        
        
        
        if ([responseObject[@"status"] intValue] ==1) {
            
            //跳转到待审核界面
            [_svc pushViewController:_svc.waitCheckViewController];
            
            
        }else{
            
            [_svc showMessage:responseObject[@"message"]];
        }
        
        [_svc hideLoadingView];
        
    } progress:^(NSProgress *progress) {
        
        //            NSLog(@"1111");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [_svc hideLoadingView];
        
        [_svc showMessage:error.domain];
    }];
    
}













//检验输入的正确性
-(BOOL)RegisterCheckInput
{
    if (self.companyNameField.text.length== 0 ) {
        [MessageTool showMessage:@"企业名称不能为空" isError:YES];
        return NO;
    }
    if (self.linkmanField.text.length == 0) {
        
        [MessageTool showMessage:@"联系人不能为空" isError:YES];
        return NO;
    }
    if(self.phoneField.text.length == 0)
    {
        [_svc showMessage:@"联系方式不能为空"];
        return NO;
    }
    
    
    if (self.addressField.text.length == 0) {
        
        [MessageTool showMessage:@"详细地址不能为空" isError:YES];
        return NO;
    }
    if (pId.length == 0 || cId.length == 0 || aId.length ==0) {
        [MessageTool showMessage:@"企业地址不能为空" isError:YES];
        return NO;
    }

    if (identityCarFrontStr.length == 0) {
        [MessageTool showMessage:@"请上传身份证正面照" isError:YES];
        return NO;
    }
    if (identityCarVersoStr.length == 0) {
        [MessageTool showMessage:@"请上传身份证正面照" isError:YES];
        return NO;
    }

    if (businesslicenseStr.length == 0) {
        [MessageTool showMessage:@"请上传企业营业执照" isError:YES];
        return NO;
    }

    if (doorHeadImg1Str.length == 0) {
        [MessageTool showMessage:@"请上传门头照/货架照" isError:YES];
        return NO;
    }

    if (doorHeadImg2Str.length == 0) {
        [MessageTool showMessage:@"请上传门头照/货架照" isError:YES];
        return NO;
    }

 
    
    return YES;
}


-(void)setoneImg:(UITapGestureRecognizer *)tag
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.editing = YES;
    _imagePicker.view.tag = tag.view.tag;
    _imagePicker.delegate = self;
    
    _imagePicker.allowsEditing = YES;
   
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"相册", nil];
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    sheet.tag = 100;
    
    [sheet showInView:self.view];
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
    
    
    //把一张图片保存到图库中，此时无论是这张照片是照相机拍的还是本身从图库中取出的，都会保存到图库中;
    //UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    //压缩图片，如果图片要上传到服务器或者网络，子需要执行该步骤(压缩),第二个参数是压缩比例，转化为NsData类型
    NSData *fileData = UIImageJPEGRepresentation(image, 0.5);
    
    // 对于base64编码编码
    NSString *headImageString=[fileData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    
    if (picker.view.tag == 100) {
        
        _identityCarFront.image = image;
        identityCarFrontStr = headImageString;
        
    }else if (picker.view.tag == 200){
        
        _identityCarVerso.image = image;
        identityCarVersoStr = headImageString;
    
    }else if (picker.view.tag == 300){
    
        _businesslicense.image = image;
        businesslicenseStr = headImageString;
        
    }else if (picker.view.tag == 400){
    
        _doorHeadImg1.image = image;
        doorHeadImg1Str = headImageString;
    }else{
    
        _doorHeadImg2.image = image;
        doorHeadImg2Str = headImageString;
        
    }
 
    
    
    
    //关闭一模态形式显示的UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
    
}





#pragma mark -UITableViewDelegate-----
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellId";
    CommonTextFileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[CommonTextFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //cell.textField.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
          
            cell.titleLabel.text = @"企业名称";
            cell.textFile.placeholder = @"请输入企业名称";
            _companyNameField = cell.textFile;
            break;
        case 1:
        
            cell.titleLabel.text = @"联系人";
            cell.textFile.placeholder = @"请输入联系人";
            _linkmanField = cell.textFile;
            break;
        case 2:
      
            cell.titleLabel.text = @"联系方式";
            cell.textFile.placeholder = @"请输入联系方式";
            _phoneField = cell.textFile;
            cell.textFile.keyboardType = UIKeyboardTypeNumberPad;
            
            break;
        case 3:
            
            cell.titleLabel.text = @"企业地址";
            cell.textFile.placeholder = @"请选择企业地址";
            _provinceText = cell.textFile;
            _provinceText.enabled = NO;
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            
            break;
        case 4:
            cell.titleLabel.text = @"详细地址";
            cell.textFile.placeholder = @"请输入详细地址";
            _addressField = cell.textFile;
            break;
            
        default:
            break;
    }
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        
        NSLog(@"选择了企业地址选择");
        
        TWSelectCityView *city = [[TWSelectCityView alloc] initWithTWFrame:CGRectMake(0, 0, WIDTH, HEIGHT) TWselectCityTitle:@"选择地区" andArray:self.provincesArray];
        
        [city showCityView:^(ProvincesModel *proviceModel, CityModel *cityModel, AreaModel *areaModel) {
            
            NSLog(@"===%@==%@===%@",proviceModel.area_name,cityModel.area_name,areaModel.area_name);
            pId = proviceModel.sid;
            cId = cityModel.cid;
            aId = areaModel.areaid;
            _provinceText.text = [NSString stringWithFormat:@"%@%@%@",proviceModel.area_name,cityModel.area_name,areaModel.area_name];
        }];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MyAdapter aDapter:44];
}

//到登录界面
-(void)showLoginItem
{
    UIButton *btn =[self.class buttonWithImage:nil title:@"已有账号" target:self action:@selector(loginAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self addItemForLeft:NO withItem:item spaceWidth:0];
}

-(void)loginAction:(UIButton *)button
{
    
    NSMutableArray *tempVCA = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    
    if(tempVCA.count!=0 && tempVCA!=nil) {
        
        for (int i = (int)tempVCA.count-1; i>=1; i--) {
            
            [tempVCA removeObjectAtIndex:i];
        }
        
        self.navigationController.viewControllers = tempVCA;
        
    }
    
    
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
