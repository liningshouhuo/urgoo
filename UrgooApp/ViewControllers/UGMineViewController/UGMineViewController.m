//
//  UGMineViewController.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMineViewController.h"

#import "UGMineHeadView.h"
#import "UGTableViewCell.h"

#import "BasicInfomationViewController.h"
#import "UGSettingViewController.h"
#import "UGProfileViewController.h"
//#import "UGClientViewController.h"
#import "UGFollowViewController.h"


#import "UGMyContractViewController.h"

#import "MyConsultantViewController.h"

#import "UGMineCell.h"

#import "Masonry.h"
#import "HttpClientManager.h"

#import "ProfileService.h"
#import "AccountModel.h"
#import "MsgModel.h"
#import "ClientChangePasswordViewController.h"
#import "UGAboutUrgooViewController.h"
#import "UGMyOrderViewController.h"
#import "UGAccountViewController.h"
#import "UGHelpViewController.h"
#import "UGChatViewController.h"
#import "UGMyScheduleViewController.h"
#import "UGPayViewController.h"
#import "MyActivityViewController.h"
#import "UGNewServiceViewController.h"

#import "UGShareTofirViewController.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

#import "MyGuanZhuViewController.h"
#import "UGServeDtlViewController.h"
#import "UGAssistantViewController.h"

@interface UGMineViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic)NSArray *dataArr;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UGMineHeadView *headView;
@property (strong, nonatomic)UISwitch * mainSwitch;
@property (assign, nonatomic)BOOL * youbao;
@property (strong, nonatomic)NSString * isShow;
@property (strong, nonatomic)UIImageView *redImageView;//小圆点
@property (assign, nonatomic)BOOL isRedShow;

@end

@implementation UGMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self needBackAction:NO];
    [self needRightAction:NO];
    [self initUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(is_Information_advanceShowRed) name:@"UpDataMainUIRedDotByJPushNotification" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    DLog(@"kToken---%@",kToken);
    
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:animated];
    //[self isShowRedView];
    [self loadRequest];
    [self is_Information_advanceShowRed];
    
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];

}

#pragma mark -消息&预约-red的判断
-(void)is_Information_advanceShowRed{
    
    __weak UGMineViewController *weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"termType"] = @"2";
    
    [HttpClientManager postAsyn:UG_informationCount_URL params:params success:^(id json) {
        if (json) {
            DLog(@"是否有‘消息&预约’数据:%@",json);
            AssistantsService *service=[[AssistantsService alloc] init];
            MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
            
            if ([msg.code isEqualToString:@"200"]) {
                
                //消息
                id obj = [NSString stringWithFormat:@"%@",json[@"body"][@"count"]];
                if (![obj isEqual:@"0"]) {
                    _isRedShow = YES;
                }else{
                    _isRedShow = NO;
                }
                
                //预约
                _isShow = [NSString stringWithFormat:@"%@",json[@"body"][@"advanceCount"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
                
                //Tabbar
                NSString *allCount = [NSString stringWithFormat:@"%@",json[@"body"][@"allCount"]];
                if (![allCount isEqualToString:@"0"]) {
                    [self.tabBarController.tabBar showTabBarRedDotOnItemIndex:3.0];
                }else{
                    [self.tabBarController.tabBar hideTabBarRedDotOnItemIndex:3.0];
                }
                
            }else if ([msg.code isEqualToString:@"400"]) {
                [weakSelf showSVErrorString:msg.message];
            }
        }
    } failure:^(NSError *error) {
        DLog(@"出错：%@",error);
    }];
}

#pragma mark - 判断是否有预约
-(void)isShowRedView{
    
     __weak UGMineViewController *weakSelf = self;
   
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    [HttpClientManager getAsyn:UG_isScheduleRedShow_URL params: params success:^(id json) {

        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            _isShow = json[@"body"][@"showRed"][@"isShow"];
            NSLog(@"%@",_isShow);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.tableView reloadData];
            });
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 请求数据
-(void)loadRequest
{
    __weak UGMineViewController *weakSelf = self;
    
    NSString *tokenStr = [NSString stringWithFormat:@"%@",kToken];
    
    
    if ([CustomHelper isNetWorking]) {
  
        if (tokenStr.length>0) {
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = kToken;
            params[@"termType"] = @"2";
            
            [HttpClientManager getAsyn:UG_USER_SELECT_PARENTS_INFO params:params success:^(id resultData) {
                NSLog(@"%@",resultData);
               // ProfileService *service=[[ProfileService alloc] init];
                MsgModel *msg=[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
                NSString *code=msg.code;
                
                if ([code isEqualToString:@"200"]) {
                    
                    AccountModel *amodel=[AccountModel mj_objectWithKeyValues:resultData[@"body"][@"parentInfo"]];
                    //头像
                    
                    
                    
                 NSString *headImgStr=resultData[@"body"][@"parentInfo"][@"userIcon"];
                    
                     if ([headImgStr containsString:@"qingdao"]) {
                        NSLog(@"str 包含 qingdao");
                         [weakSelf.headView.avatorImageView sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"photo-g"] ];
                    } else {
                        NSLog(@"str 不存在 qingdao");
                        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,headImgStr];
                        
                        [weakSelf.headView.avatorImageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"photo-g"]  ];
                    }

                    
                    //家长名字
                    NSString *parentName = amodel.nickName;
                    if (parentName.length == 0) {
                        weakSelf.headView.parentNameLabel.text = @"";
                    }else{
                        weakSelf.headView.parentNameLabel.text =parentName;
                    }
                    
                    //学生名字
                    NSString *studentName = amodel.cnName;
                    if (studentName.length == 0) {
                        weakSelf.headView.nameLabel.text = @"";
                    }else{
                        weakSelf.headView.nameLabel.text = studentName;
                    }
                    
                    
                    //就读年级
                    NSString *grade=amodel.grade;
                    if(grade==nil){
                        weakSelf.headView.experienceLabel.text = [NSString stringWithFormat:@"就读年级:%@",@""];
                    }else{
                        weakSelf.headView.experienceLabel.text = [NSString stringWithFormat:@"就读年级:%@",grade];
                        
                    }
                    
                    //留学目标
                    NSString *countryName=amodel.countryName;
                    if(countryName==nil){
                        weakSelf.headView.localLabel.text=[NSString stringWithFormat:@"留学目标国:%@",@""];
                    }else{
                        weakSelf.headView.localLabel.text=[NSString stringWithFormat:@"留学目标国:%@",countryName];
                    }
                    
                    
                    
                    [weakSelf.tableView reloadData];
                    
                }else if ([code isEqualToString:@"400"]) {
                    [weakSelf showSVErrorString:msg.message];
                }
                
                
            } failure:^(NSError *error) {
                [weakSelf showSVErrorString:@"网络请求失败，请稍后重试"];
                
            }];
            
        }
            
    }else{
        [weakSelf showSVErrorString:@"请确认连接了网络"];
    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.headView updateHeaderImageViewFrameWithOffsetY:offsetY];
}

#pragma mark - initUI
-(void)initUI
{
    //message红点
    _redImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-40, 18, 7, 7)];
    _redImageView.image = [UIImage imageNamed:@"message_new_info"];
    _redImageView.layer.masksToBounds = YES;
    _redImageView.layer.cornerRadius = 3.5;
    _redImageView.hidden = NO;
    
//    self.dataArr =@[@[@"绑定ID",@"我的合同"],@[@"签约流程",@"服务协议"]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

    __weak UGMineViewController *weakSelf = self;
    _headView =[[UGMineHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];//375 *450   2*kScreenWidth/3

    
    
    _headView.settingBlock = ^(){
        DLog(@"设置");
        UGSettingViewController *setting = [[UGSettingViewController alloc]init];
        setting.hidesBottomBarWhenPushed = YES;
        [weakSelf pushToNextViewController:setting];
    };
    
    _headView.headBlock = ^(){
        DLog(@"头像被点击了");
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:weakSelf cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"照片",nil];
        actionSheet.tag =168;
        [actionSheet showInView:weakSelf.view];
//         BasicInfomationViewController *basicInfoVC = [[BasicInfomationViewController alloc]init];
//        basicInfoVC.fromType = 667;
//        basicInfoVC.hidesBottomBarWhenPushed = YES;
//        [weakSelf pushToNextViewController:basicInfoVC];
    };
    
    self.tableView.tableHeaderView = _headView;
}
//#pragma 修改头像
//-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//    
//    NSLog(@"dsdcs");
//}
#pragma mark - settingAction
-(void)settingAction
{
    UGSettingViewController *setting = [[UGSettingViewController alloc]init];
    [self pushToNextViewController:setting];
}
#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 6;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        UGMineCell *cell = [UGMineCell mineTableViewCellWithTableView:tableView];
        
        
        cell._isShow = _isShow;
        __weak UGMineViewController *weakSelf = self;
        
        cell.underBlock = ^(NSInteger buttonTag){
            
            
            DLog(@"%ld个被点击了",(long)buttonTag);
            //我的顾问跳转页
            if (buttonTag ==0) {
                
                
                
                //  关注的顾问
                
                
                MyGuanZhuViewController *vc  =[[MyGuanZhuViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self pushToNextViewController:vc];
                
                
                //NSLog(@"我的顾问");
                //MyConsultantViewController *vc  =[[MyConsultantViewController alloc]init];
                //MyConsultantViewController *vc  =[[MyConsultantViewController alloc]init];
                //vc.hidesBottomBarWhenPushed = YES;
                //[weakSelf pushToNextViewController:vc];
            }
            /*
            else if (buttonTag ==1){
                UGClientViewController *vc  =[[UGClientViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf pushToNextViewController:vc];
                        }
             */
            else if (buttonTag ==1){
                
                //  预约
                UGMyScheduleViewController * vc = [[UGMyScheduleViewController alloc]init];
                
                vc.hidesBottomBarWhenPushed = YES;
                [self pushToNextViewController:vc];
                
                /*
                 UGProfileViewController *vc  =[[UGProfileViewController alloc]init];
                 vc.hidesBottomBarWhenPushed = YES;
                 [weakSelf pushToNextViewController:vc];
                 */
            }else{
                
                
                NSLog(@"订单");
                //我的订单-
                UGMyOrderViewController *vc  =[[UGMyOrderViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [weakSelf pushToNextViewController:vc];

                
                //NSLog(@"账户");
                //账户-
                //UGAccountViewController *vc  =[[UGAccountViewController alloc]init];
                //vc.hidesBottomBarWhenPushed = YES;
                //[weakSelf pushToNextViewController:vc];
            }
        };
        
        return cell;
        
    }else {
        UGTableViewCell *cell  = [UGTableViewCell ugTableViewCellWithTableView:tableView];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        NSArray * cellStrArr= @[@"消息中心",@"报名的活动",@"我的二维码",@"我的资料",@"帮助",@"退出登录"];
        /*
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }*/
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#434343"];
        
        if (indexPath.section == 1){
            cell.textLabel.text = cellStrArr[indexPath.row];
        }
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            [self isMessageNote:self.isRedShow cell:cell];
        }
        
        return cell;
   }
    return nil;
}

#pragma mark - message提示（红点）
-(void)isMessageNote:(BOOL)isNote cell:(UGTableViewCell *)cell{
    
    if (!isNote) {
        _redImageView.hidden = YES;
    }else{
        _redImageView.hidden = NO;
        [cell.contentView addSubview:_redImageView];
    }
    
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
                
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                picker.navigationBar.tintColor = [UIColor whiteColor];
                
                
                [self.navigationController.navigationBar setBackgroundColor:RGB(24, 152, 130)];
                
                [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
                break;
            default:
                return;
                break;
        }
        [self presentViewController:picker animated:YES completion:nil];
    }else if (actionSheet.tag == 998){
        switch (buttonIndex) {
            case 0:
                [self loginOutAction];
                break;
                
            default:
                break;
        }
        NSLog(@"点击了 、、、、、、");
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
   _headView.avatorImageView.image = [info objectForKey:UIImagePickerControllerEditedImage];
    //方法
    NSData *data = UIImageJPEGRepresentation(_headView.avatorImageView.image, 0.7);
    //post头像
    __weak UGMineViewController *weakSelf = self;
    
    if ([CustomHelper isNetWorking]) {
        
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = kToken;
        [HttpClientManager uploadFilesAsy:UG_editUserIcon_URL fileData:data params:params success:^(id resultData)
         {
             NSLog(@"%@",resultData);
             //ProfileService *service=[[ProfileService alloc] init];
             MsgModel *msg=[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
             
             if ([msg.code isEqualToString:@"400"]) {
                 [weakSelf showSVString:msg.message];
             }
             else if ([msg.code isEqualToString:@"200"]) {
                 [weakSelf showSVSuccessWithStatus:@"头像添加成功"];
                 //杨德成  2016-4-9 头像刷新
                 NSString * str = resultData[@"body"][@"userIcon"];
                 NSLog(@"%@",str);
                [weakSelf.headView.avatorImageView sd_setImageWithURL:[NSURL URLWithString:resultData[@"body"][@"userIcon"]]  placeholderImage:[UIImage imageNamed:@"photo-g"]  ];

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


#pragma mark -tableView 代理数据源
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        //return kScreenWidth/4;
        return  64;
    }
      return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }
    return 11.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section==2&&indexPath.row==0){
//        NSLog(@"dianji 预约 ");
//        UGMyScheduleViewController * vc = [[UGMyScheduleViewController alloc]init];
//        
//        vc.hidesBottomBarWhenPushed = YES;
//        [self pushToNextViewController:vc];
//        
//    }else if (indexPath.section==3&&indexPath.row==0){
//        //NSLog(@"个人资料");
//        UGProfileViewController *vc  =[[UGProfileViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self pushToNextViewController:vc];
//        
//    }else if (indexPath.section ==4){
//        if (indexPath.row == 0) {
//            NSLog(@"帮助");
//            UGHelpViewController *vc  =[[UGHelpViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self pushToNextViewController:vc];
//            
//        }else if (indexPath.row == 1) {
//            NSLog(@"在线优宝");
//            UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
//            vc.kHxStr = serviceId;
//            //保存环信ID，获取头像&昵称
//            [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//            
//            
//            }
//        
//        
//    }else if (indexPath.section==5){
//        
//        if (indexPath.row ==0){
//            //修改密码
//            ClientChangePasswordViewController *vc = [[ClientChangePasswordViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self pushToNextViewController:vc];
//        }else if(indexPath.row == 1) {
//            
//            NSLog(@"关于我们");
//            UGAboutUrgooViewController *vc = [[UGAboutUrgooViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self pushToNextViewController:vc];
//        }        
//    }else if (indexPath.section == 6 && indexPath.row == 0) {
//        
//        
//        NSLog(@"退出登录");
//        //退出登录
//        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"确定要退出登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
//        actionSheet.tag =998;
//        [actionSheet showInView:self.view];
//        
//    }else if (indexPath.section == 1  ){
//        
//        if (indexPath.row ==0) {
//            
//            NSLog(@"我关注的列表");
//            MyGuanZhuViewController *vc  =[[MyGuanZhuViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self pushToNextViewController:vc];
//            
//            
//        }else if (indexPath.row == 1){
//            DLog(@"我报名的活动");
//            MyActivityViewController *vc  =[[MyActivityViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self pushToNextViewController:vc];
//
//            
//        }
//    }
    if (indexPath.section == 1  ){
        
        if (indexPath.row == 0) {
            //消息
            UGAssistantViewController *vc =[[UGAssistantViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
        }else if (indexPath.row == 1){
            
            //我报名的活动
            MyActivityViewController *vc  =[[MyActivityViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
        }else if (indexPath.row == 2){
            
            // 二维码
            UGShareTofirViewController * vc = [[UGShareTofirViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
            
        }else if (indexPath.row == 4){
            
            //帮助
            UGHelpViewController *vc  =[[UGHelpViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
        }else if (indexPath.row == 3){
            
            //个人资料
            UGProfileViewController *vc  =[[UGProfileViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
        }
            //else if (indexPath.row == 5){
//            
//            //修改密码
//            ClientChangePasswordViewController *vc = [[ClientChangePasswordViewController alloc] init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self pushToNextViewController:vc];
//            
//        }
            else if (indexPath.row == 5){
            
            //退出登录
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"确定要退出登录" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定",nil];
            actionSheet.tag =998;
            [actionSheet showInView:self.view];

        }
        
    }
    
}

-(void)loginOutAction
{
    
    DLog(@"loginout");
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                DLog(@"退出成功");
                
                //退出登录后清除token
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //退出登录后清除订单信息
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //退出登录后 去除 极光推送
                [JPUSHService setAlias:@"" callbackSelector:nil object:self];
                DLog(@"清除token--%@",kToken);
                
                //推出登陆，切换到登录页面
                //[[AppDelegate sharedappDelegate] showLogin];
                [[AppDelegate sharedappDelegate] showNewLong];
                //[AppDelegate sharedappDelegate].tabbar.selectedIndex=0;
                
            }
            else{
                DLog(@"退出登陆的error%@",error.errorDescription);
                //退出登录后清除token
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //退出登录后清除订单信息
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
                //退出登录后 去除 极光推送
                [JPUSHService setAlias:@"" callbackSelector:nil object:self];

                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        });
    });
    
}



/*
if (indexPath.section==0) {
    ClientChangePasswordViewController *vc = [[ClientChangePasswordViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:vc];
    //    }else if (indexPath.section==2&&indexPath.row==0){
    //        EditTextViewController *vc = [[EditTextViewController alloc] init];
    //        vc.fromType = 100;
    //        vc.hidesBottomBarWhenPushed = YES;
    //        [self pushToNextViewController:vc];
    //    }else if (indexPath.section==2&&indexPath.row==1){
}else if (indexPath.section==1){
    
    UGAboutUrgooViewController *vc = [[UGAboutUrgooViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:vc];
}
*/

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
