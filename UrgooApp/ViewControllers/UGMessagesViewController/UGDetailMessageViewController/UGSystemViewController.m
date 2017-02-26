//
//  UGSystemViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSystemViewController.h"
#import "UGSystemCell.h"

@interface UGSystemViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;

@end

@implementation UGSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initUI];
    self.page = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-40-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.view addSubview:self.tableView];
    
    [self addUpData];//上拉更新
    [self addDownData];//下拉加载
    
}
#pragma mark - initUI
-(void)initUI:(NSArray *)arr andPage:(int)page
{
    if (page == 0) {
        self.informationModelArr = [NSMutableArray arrayWithArray:arr];
    }else{
        [self.informationModelArr addObjectsFromArray:arr];
    }
    [self.tableView reloadData];
    [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];//上拉结束
    [self.tableView footerEndRefreshing];//下拉结束

}
// 消息已读
-(void)getNet_InformationSystemDetail:(InformationModel *)model{//tesk
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"type"] = @"1";
    params[@"termType"] = @"1";
    params[@"unread"] = model.unread;
    params[@"informationId"] = model.informationId;
    
    
    [HttpClientManager postAsyn:UG_informationSystemDetail_URL params:params success:^(id json) {
        if (json) {
            DLog(@"****** System阅读成功 ******");
        }
    } failure:^(NSError *error) {
        [self showSVErrorString:@"Network request failed, please try again later"];
    }];
}
#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _informationModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UGSystemCell *cell  = [UGSystemCell systemTableViewCellWithTableView:tableView];
//    return cell;
    static NSString *ugsystemcellStr = @"ugsystemcellStr";
    UGSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:ugsystemcellStr];
    if (!cell) {
        cell = [[UGSystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugsystemcellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    self.informationModel = self.informationModelArr[indexPath.row];
    cell.nameLabel.text = self.informationModel.titleCn;
    cell.detailLable.text = self.informationModel.contentCn;
    cell.dateLabel.text = self.informationModel.insertDatetime;
    if ([self.informationModel.unread isEqual:@"1"]) {
        cell.nameLabel.textColor = [UIColor grayColor];
        cell.redImageView.hidden= YES;
    }else{
        cell.nameLabel.textColor = [UIColor blackColor];
        cell.redImageView.hidden = NO;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.modelBlock) {
        self.modelBlock(self.informationModelArr[indexPath.row]);
    }
    
    [self getNet_InformationSystemDetail:self.informationModelArr[indexPath.row]];
    
    UGSystemCell *cell = (UGSystemCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self updateCellStatus:cell selected:YES];
    
}
-(void)updateCellStatus:(UGSystemCell *)Cell selected:(BOOL)selected{
    Cell.nameLabel.textColor = selected ?[UIColor grayColor]:[UIColor colorWithHexString:@"393939"];
    Cell.redImageView.hidden = YES;
}

#pragma mark -刷新数据
-(void)addUpData{//下拉
    __weak UGSystemViewController *weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        [weakSelf.assistantVC getNet_InformationData_system:0];
        weakSelf.page = 0;

    }];
    //[self.tableView headerStartRefresh];//进入消息界面就刷新
}

-(void)addDownData{//上拉
    __weak UGSystemViewController *weakSelf = self;
    
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        weakSelf.page += 1;
        [weakSelf.assistantVC getNet_InformationData_system:weakSelf.page];
        
    }];
}






@end
