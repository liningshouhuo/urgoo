//
//  UGMyreportViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyreportViewController.h"
#import "UGMyreportTableViewCell.h"

@interface UGMyreportViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView * tableview;
@end

@implementation UGMyreportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"我的报告"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self initUI];
   }

-(void)initUI{
    
    
    _tableview = [[UITableView alloc]init];
    _tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _tableview.backgroundColor = [UIColor clearColor];
   // _tableview.separatorStyle =   UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle =   UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[UGMyreportTableViewCell class] forCellReuseIdentifier:@"UG_report"];

    [self.view addSubview:_tableview];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UGMyreportTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UG_report"];
    if (cell ==nil) {
        cell = [[UGMyreportTableViewCell alloc]initWithFrame:CGRectZero];
        
    }
    //(@"%@",self.consultantArray);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 75;
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
