//
//  UGMessagesViewController.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMessagesViewController.h"
#import "UGMessageCell.h"
#import "UGMessageHeadView.h"

#import "UGAssistantViewController.h"


@interface UGMessagesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView; 
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UGMessageHeadView *headView;
@end

@implementation UGMessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"Message"];
    
    [self needBackAction:NO];
    
    [self initUI];

}
#pragma mark - initUI
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.view addSubview:self.tableView];
    
    
    __weak UGMessagesViewController *weakSelf = self;
    _headView =[[UGMessageHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 113)];
    _headView.block = ^(){
        DLog(@"消息页面的头试图被点击了");
        [weakSelf pushToNextViewController:[[UGAssistantViewController alloc] init]];
    };
    self.tableView.tableHeaderView = _headView;

}
#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UGMessageCell *cell  = [UGMessageCell messageTableViewCellWithTableView:tableView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"mine cell selected");
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
