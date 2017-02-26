//
//  UGMyScheduleCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/6/14.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyScheduleCell.h"
#include "UGScheduleTableViewCell.h"
#import "AdvanceListModel.h"
#import "AdanceTimeList.h"
@interface UGMyScheduleCell()<UITableViewDelegate,UITableViewDataSource>;

@property (strong,nonatomic) NSMutableArray * groupArray;
@property (strong,nonatomic) NSMutableArray * groupArray1;
@property (strong,nonatomic) NSMutableArray * groupArray2;
@property(strong,nonatomic) UITableView * tableview;
@property(strong,nonatomic) NSMutableArray * hightArray;
@end
@implementation UGMyScheduleCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initUI];
    //[self loadURl];
     _groupArray = [NSMutableArray array];
    self.backgroundColor = [UIColor yellowColor];
    return self;
    
}

-(void)setTestlable:(NSString *)testlable{
    [self removeFromSuperview];
    _testlable = testlable;
    NSLog(@"%@",_testlable);
    if ([_testlable isEqualToString:@"0"]) {
          _groupArray = [NSMutableArray array];

        [self loadconfirmURl];
    }
    else if ([_testlable isEqualToString:@"1"]){
         _groupArray1 = [NSMutableArray array];
        [self confirmURl];
    }
    
    else if ([_testlable isEqualToString:@"2"]){
         _groupArray2 = [NSMutableArray array];
        [self loadCloseListUrl];
  
}
}

-(void)loadconfirmURl{
       // 客户端预约列表(待确定)
     [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"token"] =kToken;
    NSLog(@"%@",kToken);
    _hightArray = [NSMutableArray array];
   
   // __weak UGMyScheduleCell *weakSelf = self;
    [self.tableview reloadData];
    [HttpClientManager postAsyn:advanceUnconfirmeListClient params:params success:^(id json) {
        NSLog(@"%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
       NSArray *listArray = [NSArray arrayWithArray: json[@"body"][@"advanceList"]];
        NSLog(@"--------%@",listArray);
        for (NSDictionary * dict in listArray) {
            
            AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:dict];
            [self.groupArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self endRefresh];
            
            [self.tableview reloadData];
        });
        

 NSLog(@"--------%@",self.groupArray);
    } failure:^(NSError *error) {
          NSLog(@"%@",kToken);
          [SVProgressHUD dismiss];
    }];

    
    
    
    
}
-(void)confirmURl{
    // 客户端预约列表(确定)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"token"] = kToken;
    NSLog(@"%@",kToken);
    
    [SVProgressHUD show];

    // __weak UGMyScheduleCell *weakSelf = self;
     [self.tableview reloadData];
    [HttpClientManager postAsyn:advanceConfirmeListClient params:params success:^(id json) {
        NSLog(@"%@",json);
        NSArray *listArray = [NSArray arrayWithArray: json[@"body"][@"advanceList"]];
        NSLog(@"--------%@",listArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        for (NSDictionary * dict in listArray) {
            
            AdanceTimeList * model = [AdanceTimeList mj_objectWithKeyValues:dict];
            [self.groupArray1 addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self endRefresh];
            
            [self.tableview reloadData];
        });
        
        
        NSLog(@"--------%@",self.groupArray);
    } failure:^(NSError *error) {
        NSLog(@"%@",kToken);
          [SVProgressHUD dismiss];
    }];
    
    
    
    
    
}
// 客户端预约列表(结束)
-(void)loadCloseListUrl{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"token"] = kToken;
    NSLog(@"%@",kToken);
    
      [SVProgressHUD show];
    // __weak UGMyScheduleCell *weakSelf = self;
    [self.tableview reloadData];
    [HttpClientManager postAsyn:advanceCloseListClient params:params success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        NSLog(@"%@",json);
        NSArray *listArray = [NSArray arrayWithArray: json[@"body"][@"advanceList"]];
        NSLog(@"--------%@",listArray);
        for (NSDictionary * dict in listArray) {
            
            AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:dict];
            [self.groupArray2 addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self endRefresh];
            
            [self.tableview reloadData];
        });
        
        
        NSLog(@"--------%@",self.groupArray);
    } failure:^(NSError *error) {
        NSLog(@"%@",kToken);
          [SVProgressHUD dismiss];
    }];
    
    
    

    
    
    
    
    
    
}
-(void)initUI{
    
   self.backgroundColor = [UIColor yellowColor];
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.frame.size.height)];
   
    self.tableview.separatorStyle =   UITableViewCellSeparatorStyleNone;
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.contentView addSubview: _tableview];
    [self.tableview setContentOffset:CGPointMake(0, 0)];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_testlable isEqualToString:@"0"]) {
       
        return self.groupArray.count;
    }
    else if ([_testlable isEqualToString:@"1"]){
          return self.groupArray1.count;
    }
    
    else if ([_testlable isEqualToString:@"2"]){
         return self.groupArray2.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UGScheduleTableViewCell * cell =[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UGScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSLog(@"self.testlable-%@",self.testlable);
    if ([self.testlable isEqualToString:@"1"]) {
        
        
        NSLog(@"000000000000%@", self.groupArray1[indexPath.row]);
        cell.confirmeDetailModel = self.groupArray1[indexPath.row];
    }else if([self.testlable isEqualToString:@"0"]){
        cell.advanceListModel = self.groupArray[indexPath.row];
    }else if ([self.testlable isEqualToString:@"2"]){
         cell.advanceListModel = self.groupArray2[indexPath.row];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.testlable isEqualToString:@"0"]) {
        
        AdvanceListModel * hightModel =  self.groupArray[indexPath.row];
        NSLog(@"%@",hightModel.status);
        if ([hightModel.status isEqualToString:@"2"]) {
            return 86;
        }else{
            if(hightModel.advanceDetailList.count >0){
                if (hightModel.advanceDetailList.count == 1) {
                    return 86;
                }else if (hightModel.advanceDetailList.count == 2){
                    return 102;
                }else if (hightModel.advanceDetailList.count == 3){
                    return 130;
                }
            }
        }
    }else if ([self.testlable isEqualToString:@"2"]){
        AdvanceListModel * hightModel =  self.groupArray2[indexPath.row];
        NSLog(@"%@",hightModel.status);
        if ([hightModel.status isEqualToString:@"2"]) {
            return 86;
        }else{
            if(hightModel.advanceDetailList.count >0){
                if (hightModel.advanceDetailList.count == 1) {
                    return 86;
                }else if (hightModel.advanceDetailList.count == 2){
                    return 102;
                }else if (hightModel.advanceDetailList.count == 3){
                    return 130;
                }
            }
        }

    }
       return 86;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * advanceId = [NSString alloc];
    NSString * status = [NSString alloc];
    NSString * type = @"100";
    if ([self.testlable isEqualToString:@"0"]) {
        
        AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:_groupArray[indexPath.row]];
        AdanceTimeList * timeModel = [AdanceTimeList mj_objectWithKeyValues:_groupArray[indexPath.row]];
        NSLog(@"%@",model.advanceId);
        NSLog(@"%@",timeModel.status);
        
        advanceId = [NSString stringWithFormat:@"%@",model.advanceId];
        status = [NSString stringWithFormat:@"%@",timeModel.status];
        type =[NSString stringWithFormat:@"%@",model.type];
        

    }else if ([self.testlable isEqualToString:@"1"]){
        AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:_groupArray1[indexPath.row]];
        AdanceTimeList * timeModel = [AdanceTimeList mj_objectWithKeyValues:_groupArray1[indexPath.row]];
        NSLog(@"%@",model.advanceId);
        NSLog(@"%@",timeModel.status);
        advanceId = [NSString stringWithFormat:@"%@",model.advanceId];
        status = [NSString stringWithFormat:@"%@",timeModel.status];
        
        if (_advanceTypeBlock) {
            _advanceTypeBlock(@"1");
        }
       
    }else if ([self.testlable isEqualToString:@"2"]){
        AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:_groupArray2[indexPath.row]];
        AdanceTimeList * timeModel = [AdanceTimeList mj_objectWithKeyValues:_groupArray2[indexPath.row]];
        NSLog(@"%@",model.advanceId);
        NSLog(@"%@",timeModel.status);
        
        advanceId = [NSString stringWithFormat:@"%@",model.advanceId];
        status = [NSString stringWithFormat:@"%@",timeModel.status];
        
        if (_advanceTypeBlock) {
            _advanceTypeBlock(@"2");
        }
        
    }
    NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:advanceId,@"advanceId",type,@"type",status,@"status", nil];
    
    NSNotification * notice = [NSNotification notificationWithName:@"button_IndexArr" object:self userInfo:dict];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

@end
