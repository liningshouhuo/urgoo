//
//  UGAssistantsViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAssistantsViewController.h"
#import "UGCustomerServiceView.h"
#import "UGScheduleView.h"
#import "UGOrderView.h"
//客服 计划 订单 三个铺满首页

#import "UGChatViewController.h"
#import "HttpClientManager.h"
#import "ProfileService.h"
#import "AssistantsService.h"

#import "MsgModel.h"
#import "AccountModel.h"
#import "HttpClientManager.h"
#import "AssistantsModel.h"
#import "UGTaskViewController.h"
#import "UGPlanningViewController.h"
#import "AssistantsModel.h"
//
@interface UGAssistantsViewController ()
@property(strong,nonatomic) NSString * str;


@end

@implementation UGAssistantsViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //__weak UrgooTabBarController * weakSelf = self;
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;//gfaPvUV+GxQ=
    //params[@"termType"] =@"2";
    NSLog(@"%@",kToken);
    // MsgModel *msg=[assistantsService getHeaderMsgWithDict:resultData[@"header"]];
    [HttpClientManager getAsyn:UG_USER_SELECT_ORDER_INFO   params:params success:^(id resultData) {
        
        //AssistantsService * assistantsService=[[AssistantsService alloc] init];
        MsgModel *msg=[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]){
            _model = [AssistantsModel mj_objectWithKeyValues:resultData[@"body"]];
            
            [self initUI];
            //[self setupSubviews];
            //[[AppDelegate sharedappDelegate] showTabBar];
            
            
        }else if ([msg.code isEqualToString:@"400"]){
            //[weakSelf showSVString:msg.message];
            //[self setupSubviews];
            
            NSLog(@"11111111---------");
        }
        
        
        
        
    } failure:^(NSError *error) {
        // [weakSelf showSVErrorString:@"Network request failed, please try again later"];
        NSLog(@"没有网络");
        //[self setupSubviews];
        
    }];
    
    
    
}

    
    

- (void)viewDidLoad {
    [super viewDidLoad];
    [self needBackAction:NO];
    [self needRightAction:NO];
    
    [self setCustomTitle:@"优优"];
    
    
    //[self initUI];
}


-(void)initUI{

     __weak UGAssistantsViewController *weakSelf = self;
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"token"] = kToken;
//    [HttpClientManager getAsyn:UG_USER_SELECT_PARENTS_INFO params:params success:^(id resultData) {
//        ProfileService *service=[[ProfileService alloc] init];
//        AccountModel * model = [service getAccountWithDict:resultData[@"body"][@"parentInfo"]];
//        
//        DLog(@"%@",model.nickName);
//        _str = model.nickName;
//        
//        //        if ([msg.code isEqualToString:@"200"]) {
//        //            DLog(@"resultData--->%@",resultData);
//        //        }
//    } failure:^(NSError *error) {
//        
//    }];

    
    CGFloat kHeight=(kScreenHeight - 49-64 -180)/3;
    UGCustomerServiceView *serviceView = [[UGCustomerServiceView  alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHeight)];
    serviceView.nameText = _model.cnName;
    [serviceView initUI];
        //serviceView.detailTextView.text = str;
    serviceView.block = ^(){
        DLog(@"第一个");
        UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
        vc.kHxStr = serviceId;
        [vc setCustomTitle:ServiecName];
        //保存环信ID，获取头像&昵称
        [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    };
    [self.view addSubview:serviceView];
    // 1.拼接请求参数
//    //展示家长信息
//    +(void)selectedParentsInfoWithToken:(NSString *)token
//success:(SuccessBlock)success
//failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"token":token};
//    [[self sharedManager]postDataByUrl:UG_USER_SELECT_PARENTS_INFO byDictionary:params successBlock:success failureBlock:failed];
//}
 //
//    
    
    UGScheduleView *scheduleView = [[UGScheduleView  alloc]initWithFrame:CGRectMake(0, kHeight+40, kScreenWidth, kHeight)];
     scheduleView.titleArrs = _model.taskSituation;
    //scheduleView.titleArrs = @[@"3232323232",@"33333"];
    [scheduleView initUI];
    scheduleView.block = ^(){
        DLog(@"第二个");
        //任务情况
        //任务情况-
        UGTaskViewController *vc  =[[UGTaskViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf pushToNextViewController:vc];
        
        
    };
    [self.view addSubview:scheduleView];
    
    UGOrderView *orderView = [[UGOrderView  alloc]initWithFrame:CGRectMake(0, kHeight*2+80, kScreenWidth, kHeight)];
    orderView.titleArrs = _model.planSituation;
    
    [orderView initUI];
    orderView.block = ^(){
        DLog(@"第三个");
        NSLog(@"留学规划");
        UGPlanningViewController * vc = [[UGPlanningViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf pushToNextViewController:vc];
    };
    [self.view addSubview:orderView];
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
