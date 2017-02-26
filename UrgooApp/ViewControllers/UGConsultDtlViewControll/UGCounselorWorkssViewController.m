//
//  UGCounselorWorkssViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/27.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGCounselorWorkssViewController.h"
#import "UGWorkssDetailViewController.h"
#import "UGAbount_workssCell.h"
#import "WorkssModel.h"

@interface UGCounselorWorkssViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WorkssModel *workssModel;
@property (nonatomic, strong) NSArray     *subListArr;

@end

@implementation UGCounselorWorkssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self setCustomTitle:@"顾问作品"];
    
    [self getNetDataCounselorWorksList];
    [self.view addSubview:self.tableView];
}

#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _subListArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UGAbount_workssCell *cell = (UGAbount_workssCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *counselorCell = @"counselorCell";
    
    UGAbount_workssCell *cell = [tableView dequeueReusableCellWithIdentifier:counselorCell];
    if (cell == nil) {
        cell = [[UGAbount_workssCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:counselorCell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *subViews = cell.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    
    if (_subListArr) {
        _workssModel = _subListArr[indexPath.row];
        [cell initUI:_workssModel];
    }
    
    return  cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _workssModel = _subListArr[indexPath.row];
    UGWorkssDetailViewController *workssDetailVC = [[UGWorkssDetailViewController alloc] init];
    workssDetailVC.workId = _workssModel.workId;
    [self pushToNextViewController:workssDetailVC];
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    }
    return _tableView;
}


#pragma mark - 网络请求 详情的工作列表
-(void)getNetDataCounselorWorksList{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_CounselorWorksList_URL,kToken,_counselorId);//selectCounselorWorksListByToken
    
    [HttpClientManager postAsyn:UG_CounselorWorksList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        _subListArr = [NSArray array];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            _subListArr = [WorkssModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"counselorWorks"]];
            
            if (_subListArr) {
                [self.tableView reloadData];
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
