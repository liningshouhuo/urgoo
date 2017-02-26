//
//  UGServiceViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGServiceViewController.h"
#import "UGServiceHeadView.h"
#import "UGTableViewCell.h"


#import "UGSearchClientViewController.h"
//#import "UGScheduleViewController.h"
#import "UGMyOrderViewController.h"
#import "UGAccountViewController.h"
#import "UGTaskViewController.h"
#import "UGChatLogViewController.h"
#import "UGFollowViewController.h"
#import "UGTermPaperViewController.h"
#import "UGSubscribeViewController.h"
#import "UGPlanningViewController.h"
#import "UGChatViewController.h"
#import "MyScheduleViewController.h"
#import "UGHelpViewController.h"
#import "MyConsultantViewController.h"

#import "UGServiceArgreementViewController.h"
@interface UGServiceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSArray *dataArr;
@property (strong, nonatomic)NSArray *imageArr;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UGServiceHeadView *headView;
@end

@implementation UGServiceViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self needBackAction:NO];
    [self needRightAction:NO];
    
    [self setCustomTitle:@"规划"];
    
    [self initUI];
}
#pragma mark - initUI
-(void)initUI
{

    
    
//    self.dataArr =@[@"帮助",@"客服介入"];
    self.dataArr =@[@"任务情况",@"学期报告",@"留学规划"];
    self.imageArr =@[@"service_icon_tasks",@"report_change",@"planning_change"];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-64) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    
    
    __weak UGServiceViewController *weakSelf = self;
//    _headView =[[UGServiceHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200+kScreenWidth/4)];//375 *450   2*kScreenWidth/3
     _headView =[[UGServiceHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.22)];
    _headView.underBlock = ^(NSInteger buttonTag){
        DLog(@"---buttonTag--%d",(int)buttonTag);
        
        /**if (buttonTag ==100) {//找顾问-
            UGSearchClientViewController *vc  =[[UGSearchClientViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }
        else if (buttonTag ==101){//我的关注-
            UGFollowViewController *vc  =[[UGFollowViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }
        else if (buttonTag ==102){//预约安排-
            MyScheduleViewController *vc  =[[MyScheduleViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }
        else if (buttonTag ==103){//我的订单-
            UGMyOrderViewController *vc  =[[UGMyOrderViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }
        else if (buttonTag ==104){//账户-
            UGAccountViewController *vc  =[[UGAccountViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }else if (buttonTag ==105){//留学规划
            UGPlanningViewController *vc  =[[UGPlanningViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }else if (buttonTag ==106){//任务情况-
            UGTaskViewController *vc  =[[UGTaskViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }else if (buttonTag ==107){//学期报告-
            UGTermPaperViewController *vc  =[[UGTermPaperViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }**/
        
        
        
        //杨德成 2016-4-9 屏蔽预约安排
        if (buttonTag ==100) {
            //任务情况-
            UGTaskViewController *vc  =[[UGTaskViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
            
//            //找顾问-
//            UGSearchClientViewController *vc  =[[UGSearchClientViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [weakSelf pushToNextViewController:vc];
        }
        else if (buttonTag ==101){
            //学期报告-
            UGTermPaperViewController *vc  =[[UGTermPaperViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
            
//            //我的关注-
//            UGFollowViewController *vc  =[[UGFollowViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [weakSelf pushToNextViewController:vc];
        }
        
        else if (buttonTag ==102){
            
            NSLog(@"留学规划");
            UGPlanningViewController * vc = [[UGPlanningViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
//            //我的订单-
//            UGMyOrderViewController *vc  =[[UGMyOrderViewController alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [weakSelf pushToNextViewController:vc];
        }
        else if (buttonTag ==103){//账户-
            UGAccountViewController *vc  =[[UGAccountViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }else if (buttonTag ==104){//任务情况-
            UGTaskViewController *vc  =[[UGTaskViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }else if (buttonTag ==105){//学期报告-
            UGTermPaperViewController *vc  =[[UGTermPaperViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf pushToNextViewController:vc];
        }
        
    };
    
    self.tableView.tableHeaderView = _headView;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    // if(section == 0){
//    return 3;
//}
//    
    return _dataArr.count;
    //return 3;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    UGTableViewCell *cell  = [UGTableViewCell ugTableViewCellWithTableView:tableView];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"434343"];
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.imageArr[indexPath.row]]];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    imageView.layer.cornerRadius = 10;
    UIImage *icon = [UIImage imageNamed:self.imageArr[indexPath.row] ];
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [icon drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //[cell.contentView addSubview:imageView];
    //cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    imageView.image = [UIImage imageNamed:self.imageArr[indexPath.row]];

    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
    

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        //任务情况-
        UGTaskViewController *vc  =[[UGTaskViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:vc];
        
    }else if(indexPath.row==1){
         
         //学期报告-
         UGTermPaperViewController *vc  =[[UGTermPaperViewController alloc]init];
         vc.hidesBottomBarWhenPushed = YES;
         [self pushToNextViewController:vc];

        
    }else if (indexPath.row==2) {
        
        NSLog(@"留学规划");
        UGPlanningViewController * vc = [[UGPlanningViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:vc];
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
