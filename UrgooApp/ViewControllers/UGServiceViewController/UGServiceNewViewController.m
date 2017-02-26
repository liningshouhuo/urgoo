//
//  UGServiceNewViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGServiceNewViewController.h"
#import "UGNewTimePlanViewController.h"
#import "SeaveNewHeadView.h"
#import "SeaveNewCell.h"
#import "PlanDataModel.h"
#import "PlanTasksModel.h"
#import "NewtaskDetialsViewController.h"
#import "NewReportViewController.h"

@interface UGServiceNewViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SeaveNewHeadView *seaveNewHeadView;
@property (nonatomic, strong) PlanDataModel    *planDataModel;
@property (nonatomic, strong) NSArray          *taskArr;
@property (nonatomic, strong) PlanTasksModel   *planTasksModel;

@end

@implementation UGServiceNewViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getNetData_taskTypeList];
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self needBackAction:NO];
    [self setCustomTitle:@"规划模板"];
    
    [self initUI];
}
-(void)backAction
{
    UGNewTimePlanViewController *newTimePlanVC = [[UGNewTimePlanViewController alloc] init];
    newTimePlanVC.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:newTimePlanVC];
}

-(void)initUI
{
    _taskArr = [NSArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-64)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _seaveNewHeadView = [[SeaveNewHeadView alloc] init];
    _seaveNewHeadView.frame = CGRectMake(0, 0, kScreenWidth, 176);
    _tableView.tableHeaderView = _seaveNewHeadView;
    
    typeof(self) weakSelf = self;
    _seaveNewHeadView.reportBlock = ^(NSString *reportId){
        NewReportViewController *reportVC = [[NewReportViewController alloc] init];
        reportVC.hidesBottomBarWhenPushed = YES;
        [weakSelf pushToNextViewController:reportVC];
    };
    
    _seaveNewHeadView.typeBlock = ^(NSString *type,NSString *title){
        
        UGNewTimePlanViewController *newTimePlanVC = [[UGNewTimePlanViewController alloc] init];
        newTimePlanVC.type = type;
        newTimePlanVC.titleName = title;
        newTimePlanVC.hidesBottomBarWhenPushed = YES;
        [weakSelf pushToNextViewController:newTimePlanVC];
    };
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _taskArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeaveNewCell *cell = (SeaveNewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cell";
    SeaveNewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[SeaveNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    if (_taskArr) {
        _planTasksModel = _taskArr[indexPath.row];
        [cell initUI:_planTasksModel];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _planTasksModel = _taskArr[indexPath.row];
    NewtaskDetialsViewController *taskDetialsVC = [[NewtaskDetialsViewController alloc] init];
    taskDetialsVC.taskId = _planTasksModel.taskId;
    taskDetialsVC.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:taskDetialsVC];
}



#pragma mark - 获取网络数据
-(void)getNetData_taskTypeList
{
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    
    [HttpClientManager postAsyn:UG_tasknewTaskList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            [PlanDataModel mj_setupObjectClassInArray:^NSDictionary *{
                
                return @{
                         @"listTask":@"PlanTasksModel",
                         @"listType":@"PlanHeaderModel"
                         };
            }];
            
            _planDataModel = [PlanDataModel mj_objectWithKeyValues:json[@"body"]];
            
            if (_planDataModel) {
                
                for (UIView *subView in _seaveNewHeadView.subviews) {
                    [subView removeFromSuperview];
                }
                [_seaveNewHeadView initUI:_planDataModel];
                _taskArr = _planDataModel.listTask;
                [_tableView reloadData];
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
