//
//  BasicInfomationViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BasicInfomationViewController.h"
#import "UrgooTabBarController.h"
#import "UGBasicInfomationHeadView.h"
#import "CityViewController.h"


#import "UGPickerView.h"
#import "UGTextField.h"

#import "ProfileService.h"
#import "AccountModel.h"
#import "MsgModel.h";
#import "HttpClientManager.h"



//显示阴影
typedef void(^ShowShadowBlock)();
//隐藏阴影
typedef void(^HideShadowBlock)();




@interface BasicInfomationViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,cityDelegate>
//,EditTextVCDelegate>
@property (nonatomic,copy) ShowShadowBlock showShadowBlock;
@property (nonatomic,copy) HideShadowBlock hideShadowBlock;

@property (strong, nonatomic)UITableView *tableView; //个人信息表格
@property (strong, nonatomic)NSMutableArray *dataArr;//个人信息数据源
@property (strong, nonatomic)UGBasicInfomationHeadView *headView; //头视图

@property (strong, nonatomic) UGTextField *nameField; //名字
@property (strong, nonatomic) UGTextField *genderField; //性别
@property (strong, nonatomic) UGTextField *experienceField; //年级
@property (strong, nonatomic) UGTextField *cityField; //城市
@property (strong, nonatomic) UGTextField *countriesField; //目标留学国


@property (nonatomic,copy) NSString *cityID;
@property (strong, nonatomic) UGTextField *flagField; //标记编辑框

@property(strong,nonatomic)UGPickerView *pickerView;
@property (strong, nonatomic) UIView *accessoryView;

@property(strong,nonatomic)UIButton *saveBtn;//保存按钮



@end

@implementation BasicInfomationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self tapAction];
    
//    [self loadRequest];

}


#pragma mark - 请求数据
-(void)loadRequest
{
    __weak BasicInfomationViewController *weakSelf = self;
    
    
    
    
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"termType"] = @"2";
    
    
    [HttpClientManager getAsyn:UG_USER_SELECT_PARENTS_INFO params:params success:^(id resultData) {
        
        ProfileService *service=[[ProfileService alloc] init];
        MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
        NSString *code=msg.code;
        
        if ([code isEqualToString:@"200"]) {
            
            AccountModel *amodel=[service getAccountWithDict:resultData[@"body"][@"parentInfo"]];
            
            //头像
            NSString *headImgStr=[NSString stringWithFormat:@"%@%@",UG_HOST,amodel.userIcon];
            
            [weakSelf.headView.iconIv sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"photo-g"]];
            //nickName
            weakSelf.nameField.text = amodel.nickName;
            
            //weakSelf.experienceField.text =resultData[@"body"][@"parentInfo"][@"experience"];
            
            //性别
            NSString *genderNum = [NSString stringWithFormat:@"%@",amodel.gender];
            weakSelf.genderField.text =[StringHelper genderStrByNumStr:genderNum];
            
            //年级
            weakSelf.experienceField.text = [NSString stringWithFormat:@"%@",amodel.grade];
            
            //城市
            NSString *cityName = amodel.cityName;
            if (cityName.length == 0) {
                weakSelf.cityField.text = @"请选择";
            }else{
                weakSelf.cityField.text =[NSString stringWithFormat:@"%@",amodel.cityName];
            }
            
            
            [weakSelf.tableView reloadData];
            
            
        }else if ([code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求失败，请稍后重试"];
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"完善信息"];
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
    
    [self loadRequest];
    
    [self initUI];
    
    [self registerKeyboardNotification];
    
    [self createCustomInputView];
    
    
    //手势添加到tableView上会遮盖住tableView的didSelect方法
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

#pragma mark - 构建自定义键盘
- (void)createCustomInputView {
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    topView.backgroundColor =[UIColor colorWithHexString:@"7089b4"];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(0, 10, 50, 20);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hiddenInputView) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:cancleBtn];
    
    UIButton *suerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    suerBtn.frame = CGRectMake(kScreenWidth-50, 10, 50, 20);
    [suerBtn addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [suerBtn setTitle:@"确定" forState:UIControlStateNormal];
    suerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [suerBtn setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    [topView addSubview:suerBtn];
    
    _accessoryView = topView;
    _pickerView = [[UGPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 140) andTitleArr:nil];
}
#pragma mark - 取消&确定
-(void)hiddenInputView
{
    [_flagField resignFirstResponder];
    //隐藏阴影
    if (self.hideShadowBlock) {
        self.hideShadowBlock();
    }
}
//确定按钮触发事件
- (void)sureButtonClick {

    NSInteger row = [_pickerView.pv selectedRowInComponent:0];
    _flagField.text = _pickerView.titleArray[row];

    [_flagField resignFirstResponder];
    //隐藏阴影
    if (self.hideShadowBlock) {
        self.hideShadowBlock();
    }
}

#pragma mark - 注册通知
- (void)registerKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowInView:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideInView:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - 键盘升起
- (void)keyboardWillShowInView:(NSNotification *)noti {
    DLog(@"键盘升起......");
    NSDictionary *userInfo = noti.userInfo;
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *interval = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]; //0.25
    CGFloat orignY = value.CGRectValue.origin.y - 40; //447
    //根据父视图的显示位置
    CGFloat fieldY = _flagField.indexPath.row * 44 + 95;
    CGFloat offSet = fieldY - orignY;

    DLog(@" offset--%f",fieldY);
    
    
    if (offSet > 0) {
        [UIView animateWithDuration:[interval doubleValue] animations:^{
            CGPoint point = _tableView.contentOffset;
            _tableView.contentOffset = CGPointMake(0, point.y + offSet);
        }];
    }
}
#pragma mark - 键盘隐藏
- (void)keyboardWillHideInView:(NSNotification *)noti {
    DLog(@"键盘落下.....");
    NSDictionary *userInfo = noti.userInfo;
    NSNumber *interval = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [UIView animateWithDuration:[interval doubleValue] animations:^{
        _tableView.contentOffset = CGPointMake(0,0);
    }];
}


#pragma mark - initUI
-(void)initUI
{
    //skip
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.frame = CGRectMake(kScreenWidth-30, 20, 30, 30);
    [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:skipBtn];
    
    
    if (_fromType ==666) {
    }else{
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    }
    
    
//    _dataArr = [NSMutableArray arrayWithArray:@[@"昵称:",@"性别:",@"年级:",@"城市:",@"目标留学国:"]];
    _dataArr = [NSMutableArray arrayWithArray:@[@"昵称:",@"性别:",@"城市:",@"目标留学国:"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    self.tableView.tableFooterView  = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    
    _headView  = [[UGBasicInfomationHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 95)];
    self.tableView.tableHeaderView = _headView;
    __weak BasicInfomationViewController *weakSelf = self;
    _headView.changeblock = ^(){
        DLog(@"点击了头像图片");
        
        [weakSelf tapAction];
        
        
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"照片",nil];
        actionSheet.tag =168;
        [actionSheet showInView:weakSelf.view];
    };
    

    
}



#pragma mark - skip
-(void)skipAction
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    //判断是否登陆了
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginState"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//
//    
//    //如果登陆的话
//    [[AppDelegate sharedappDelegate] showTabBar];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self tapAction];
}

#pragma mark - tapAction
-(void)tapAction
{
    [_nameField resignFirstResponder];
    [_genderField resignFirstResponder];
    [_experienceField resignFirstResponder];
    [_countriesField resignFirstResponder];
}
#pragma mark - 修改头像
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag ==168) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        switch (buttonIndex) {
            case 0:
                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                break;
            case 1:
               
                //picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //picker.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
                picker.navigationBar.tintColor = [UIColor whiteColor];
                //picker.navigationBar.titleTextAttributes = [UIColor whiteColor];
                
                //[[UINavigationBar appearance] setBarTintColor:[UIColor greenColor]];
                //setBackgroundColor:RGB(24, 152, 130)
                
                [self.navigationController.navigationBar setBackgroundColor:RGB(24, 152, 130)];
                
                [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
                break;
            default:
                return;
                break;
        }
        [self presentViewController:picker animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
        
    _headView.iconIv.image = [info objectForKey:UIImagePickerControllerEditedImage];
    //方法
    //    NSData * data = UIImagePNGRepresentation(_headView.iconIv.image);
    NSData *data = UIImageJPEGRepresentation(_headView.iconIv.image, 0.3);
    //post头像
    __weak BasicInfomationViewController *weakSelf = self;
    
    if ([CustomHelper isNetWorking]) {
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = kToken;
        [HttpClientManager uploadFilesAsy:UG_USER_UPDATE_USER_ICON fileData:data params:params success:^(id resultData)
         {
             
             ProfileService *service=[[ProfileService alloc] init];
             MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
             
             if ([msg.code isEqualToString:@"400"]) {
                 [weakSelf showSVString:msg.message];
             }
             else if ([msg.code isEqualToString:@"200"]) {
                 [weakSelf showSVSuccessWithStatus:@"Avatar changed success"];
                 //杨德成  2016-4-9 头像刷新
                 NSString *headImgStr=[NSString stringWithFormat:@"%@%@",UG_HOST,resultData[@"body"][@"userIcon"]];
                 
                 [weakSelf.headView.iconIv sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"photo-g"]];
             }
             
         }failure:^(NSError *error) {
             [weakSelf showSVErrorString:@"请求网络失败，请稍后重试"];
         }];
        
        /**[RequestManager updateUserIconWithToken:kToken userIconFile:data success:^(id resultData) {
            
            if ([resultData[@"header"][@"code"] isEqualToString:@"400"]) {
                [weakSelf showSVString:resultData[@"header"][@"message"]];
            }
            else if ([resultData[@"header"][@"code"] isEqualToString:@"200"]) {
                //杨德成  2016-4-9 头像刷新
                NSString *headImgStr=[NSString stringWithFormat:@"%@%@",UG_HOST,resultData[@"body"][@"userIcon"]];
                
                [weakSelf.headView.iconIv sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"photo-g"]];
                
                [weakSelf showSVSuccessWithStatus:@"修改成功"];
            }
        } failed:^(NSError *error) {
            //        DLog(@"error--->%@",error.description);
            [weakSelf showSVErrorString:error.description];
            
        }];**/
        
    }else{
        [weakSelf showSVErrorString:@"请确认连接了网络"];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //隐藏控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 5;
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
            
        UGTextField *textField = [[UGTextField alloc] initWithFrame:CGRectMake(110, 0, kScreenWidth-110, 44)];
        textField.tag = 10000;
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:15.0f];
        textField.borderStyle = UITextBorderStyleNone;
        textField.textColor = [UIColor colorWithHexString:@"4c4c4c"];
        [cell.contentView addSubview:textField];
        cell.textLabel.text = self.dataArr[indexPath.row];

        }

    
    UGTextField *field = (UGTextField *)[cell.contentView viewWithTag:10000];
    field.indexPath = indexPath;
//    field.text = _dataArr[indexPath.row];
    
    
    switch (indexPath.row) {
        case 0:
        {
            _nameField = field;
        }
            break;
        case 1:{
            _genderField = field;
            _genderField.inputAccessoryView = _accessoryView;
            _genderField.inputView = _pickerView;
        }
            break;
//        case 2:{
//            _experienceField = field;
//            _experienceField.inputAccessoryView = _accessoryView;
//            _experienceField.inputView = _pickerView;
//        }
//            break;
        case 2:{
            _cityField = field;
            _cityField.enabled = NO;
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//            _cityField.inputAccessoryView = _accessoryView;
//            _cityField.inputView = _pickerView;
        }
            break;
//        case 4:{
//            _countriesField = field;
//            _countriesField.inputAccessoryView = _accessoryView;
//            _countriesField.inputView = _pickerView;
//        }
        default:
            break;
    }
    
    
    return cell;
}

#pragma mark -textFieldDelegate
//点击return 隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
// 设定自定义的键盘
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _flagField = (UGTextField *)textField;

    if ([textField isEqual:_genderField]) {
        [self reloadPickerViewWithData:@[@"男",@"女"]];
//    } else if ([textField isEqual:_experienceField]) {
//        [self reloadPickerViewWithData:@[@"9年级",@"10年级",@"11年级",@"12年级"]];
//    } else if ([textField isEqual:_cityField]) {
//        [self reloadPickerViewWithData:@[@"北京",@"上海",@"广州",@"深圳",@"其他"]];
//    }else if ([textField isEqual:_countriesField]) {
//        [self reloadPickerViewWithData:@[@"USA",@"UK",@"Japan",@"Others"]];
    }else if ([textField isEqual:_nameField]) {
        //显示阴影
        if (self.showShadowBlock) {
            self.showShadowBlock();
        }
    }
//        else if ([textField isEqual:_cityField]){
//
//    }
}
- (void)reloadPickerViewWithData:(NSArray *)array {
    //显示阴影
    if (self.showShadowBlock) {
        self.showShadowBlock();
    }
    
    _pickerView.titleArray = array;
    [_pickerView reloadData];
}

//textField编辑完将数据更新到数据源
- (void)textFieldDidEndEditing:(UITextField *)textField {
    //保存到数据源
    UGTextField *tmpField = (UGTextField *)textField;
    [_dataArr replaceObjectAtIndex:tmpField.indexPath.row withObject:tmpField.text];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"=index-row==%d",(int)indexPath.row);
    if (indexPath.row == 2) {
        [self.view endEditing:YES];
        CityViewController *CityVC = [[CityViewController alloc] init];
        CityVC.cityDeledate = self;
        [self.navigationController pushViewController:CityVC animated:YES];
    }
}

//回传值代理的实现
-(void)seleCity:(UGCityModel *)cityModel{
    _cityField.text = cityModel.CityName;
    _cityID = [NSString stringWithFormat:@"%@",cityModel.CityID];
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *saveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(30, 20, kScreenWidth-60, 40);
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 5;
    [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:RGB(37, 175, 153)];
    [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [saveView addSubview:_saveBtn];
    
    return saveView;
}


-(void)saveAction
{
    DLog(@"saveAction");
    
    __weak BasicInfomationViewController *weakSelf = self;

    
    
    //性别
    NSString *genderNum = [StringHelper genderNumByGenderStr:_genderField.text];
    //国家
//    NSString *countryNum = [StringHelper countryNumByCountryStr:_countriesField.text];
    if (_cityID.length == 0) {
      _cityID = @"1";
    }
    
    if ([CustomHelper isNetWorking]) {
 
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = kToken;
        params[@"nickName"] = _nameField.text;
        params[@"gender"] = genderNum;
        params[@"cityId"] = self.cityID ;
        
        [HttpClientManager postAsyn:UG_USER_PREFECT_INFOMATION params:params success:^(id resultData) {
            ProfileService *service=[[ProfileService alloc] init];
            MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
            NSString *code=msg.code;
            
            
            if ([code isEqualToString:@"400"]) {
                [weakSelf showSVString:resultData[@"header"][@"message"]];
            }
            else if ([code isEqualToString:@"200"]) {
                [weakSelf showSVSuccessWithStatus:@"修改成功"];
                
                CATransition *animation = [CATransition animation];
                [animation setDuration:0.8];
                [animation setType: @"cube"];
                
                [animation setSubtype: kCATransitionFromLeft];
                [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                
                [self.navigationController.view.layer addAnimation:animation forKey:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            
            [weakSelf showSVErrorString:@"操作失败，请稍后重试"];

        }];
    
    }else{
        [weakSelf showSVErrorString:@"请确认连接了网络"];
    }
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

@end
