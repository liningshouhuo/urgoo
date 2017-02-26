//
//  UGAcountViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAcountViewController.h"
#import "UGAccountCell.h"


@interface UGAcountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)int page;

@end

@implementation UGAcountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initUI];
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

#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.informationModelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UGAccountCell *cell  = [UGAccountCell accountTableViewCellWithTableView:tableView];
//    return cell;
    static NSString *ugaccountcellStr = @"ugaccountcellStr";
    UGAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ugaccountcellStr];
    if (!cell) {
        cell = [[UGAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ugaccountcellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    self.MesgAccountModel = self.informationModelArr[indexPath.row];
    cell.nameLabel.text = self.MesgAccountModel.title;
    cell.dateLabel.text = self.MesgAccountModel.insertDatetime;
    if ([self.MesgAccountModel.unread isEqual:@"1"]) {
        cell.nameLabel.textColor = [UIColor grayColor];
        cell.redImageView.hidden = YES;
    }else{
        cell.nameLabel.textColor = [UIColor blackColor];
        cell.redImageView.hidden = NO;
    }
    return cell;
}
// 消息已读
-(void)getNet_InformationAccountDetail:(MesgAccountModel *)model{//tesk
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"type"] = @"1";
    params[@"termType"] = @"1";
    params[@"unread"] = model.unread;
    params[@"informationId"] = model.informationId;
    
    
    [HttpClientManager postAsyn:UG_informationAccountDetail_URL params:params success:^(id json) {
        if (json) {
            DLog(@"****** Account以阅读成功 ******");
        }
    } failure:^(NSError *error) {
        [self showSVErrorString:@"Network request failed, please try again later"];
    }];
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
    
    [self getNet_InformationAccountDetail:self.informationModelArr[indexPath.row]];
    
    UGAccountCell *cell = (UGAccountCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self updateCellStatus:cell selected:YES];
    
}
-(void)updateCellStatus:(UGAccountCell *)Cell selected:(BOOL)selected{
    Cell.nameLabel.textColor = selected ?[UIColor grayColor]:[UIColor colorWithHexString:@"393939"];
    
}
#pragma mark -刷新数据
-(void)addUpData{//上拉
    __weak UGAcountViewController *weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
       [weakSelf.assistantVC getNet_InformationData_account:0];
        weakSelf.page = 0;
        
    }];
}

-(void)addDownData{//下拉
    __weak UGAcountViewController *weakSelf = self;
    
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        weakSelf.page += 1;
        [weakSelf.assistantVC getNet_InformationData_account:weakSelf.page];
    }];
}


@end
