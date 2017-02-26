//
//  MyActivityViewController.m
//  UrgooApp
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "MyActivityViewController.h"

#import "UGLiveVideoCell.h"
#import "UGLiveVideoDetailViewController.h"
#import "LiveVideoModel.h"

@interface MyActivityViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *buttomline;
    NSMutableArray *buttonArr;
    
    UIView *noDataView;
}

@property (nonatomic,strong) UIScrollView *scrollsView;
//未开始
@property (nonatomic,strong) UITableView  *videoListTableView;
//结束
@property (nonatomic,strong) UITableView  *pastVideoTableView;
//进行中
@property (nonatomic,strong) UITableView  *processingVideoTableView;

@property (nonatomic,strong) LiveVideoModel  *liveVideoModel;
@property (nonatomic,strong) NSMutableArray         *liveListArr;
@property (nonatomic,strong) NSMutableArray         *passtListArr;

@property (nonatomic,strong) NSMutableArray        *processingListArr;

@property (nonatomic,strong) NSMutableArray  *timerArray;


@property (assign,nonatomic) NSInteger        numberNew;
@property (assign,nonatomic) NSInteger        numberProcessing;
@property (assign,nonatomic) NSInteger        numberPass;


@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = false;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setCustomTitle:@"我的活动"];
    [self initUI];
    [self getNetNotstartedList:@"0"];
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self deallocNSTimer];
}

-(void)deallocNSTimer{
    
    if (self.timerArray)
    {
        for (NSTimer *subTimer in self.timerArray)
        {
            if (subTimer)
            {
                [subTimer invalidate];
            }
        }
        
        [self.timerArray removeAllObjects];
    }
    
}

-(void)backAction
{
    [User_Default removeObjectForKey:@"activityframe"];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI{
    
    buttonArr     = [NSMutableArray array];
    _timerArray   = [NSMutableArray array];
    _liveListArr  = [NSMutableArray array];
    _passtListArr = [NSMutableArray array];
    _processingListArr = [NSMutableArray array];
    
    _numberNew=0;
    _numberPass=0;
    _numberProcessing=0;

    
    //NSArray *titleArr = @[@"最新动态",@"往期回顾"];
    NSArray *titleArr = @[@"未开始",@"进行中",@"已结束"];
    for (int i = 0; i < 3; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (kScreenWidth/3), 0, kScreenWidth/3, 38);
        button.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100 + i;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:@"007466"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButtons2:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
        }
        [buttonArr addObject:button];
        [self.view addSubview:button];
        
    }
    
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(kScreenWidth/3, 6, 0.6, 25);
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    UIView *line2 = [[UIView alloc] init];
    line2.frame = CGRectMake(2*(kScreenWidth/3), 6, 0.6, 25);
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];
    
    buttomline = [[UIView alloc] init];
    buttomline.frame = CGRectMake(kScreenWidth/4-25, 33, 50, 5);
    buttomline.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomline];
    buttomline.center = CGPointMake(kScreenWidth/6, buttomline.centerY);
    
    _scrollsView = [[UIScrollView alloc] init];
    _scrollsView.frame = CGRectMake(0, 37, kScreenWidth, kScreenHeight-64-38);
    _scrollsView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    _scrollsView.tag = 997;
    _scrollsView.delegate = self;
    _scrollsView.pagingEnabled = YES;
    _scrollsView.showsHorizontalScrollIndicator = NO;
    //_scrollsView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_scrollsView];
    
    _videoListTableView = [[UITableView alloc] init];
    _videoListTableView.frame = CGRectMake(0, 0, kScreenWidth, _scrollsView.height);
    _videoListTableView.backgroundColor = self.view.backgroundColor;
    _videoListTableView.tag = 998;
    _videoListTableView.delegate = self;
    _videoListTableView.dataSource = self;
    _videoListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _videoListTableView.tableFooterView = [[UIView alloc] init];
    [_scrollsView addSubview:_videoListTableView];
    [self addUpData:0];
    [self addDownData:0];
    
    _pastVideoTableView = [[UITableView alloc] init];
    _pastVideoTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollsView.height);
    _pastVideoTableView.backgroundColor = self.view.backgroundColor;
    _pastVideoTableView.tag = 999;
    _pastVideoTableView.delegate = self;
    _pastVideoTableView.dataSource = self;
    _pastVideoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pastVideoTableView.tableFooterView = [[UIView alloc] init];
    [_scrollsView addSubview:_pastVideoTableView];
    [self addUpData:1];
    [self addDownData:1];
    
    
    _processingVideoTableView= [[UITableView alloc] init];
    _processingVideoTableView.frame = CGRectMake(2*kScreenWidth, 0, kScreenWidth, _scrollsView.height);
    _processingVideoTableView.backgroundColor = self.view.backgroundColor;
    _processingVideoTableView.tag = 1000;
    _processingVideoTableView.delegate = self;
    _processingVideoTableView.dataSource = self;
    _processingVideoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _processingVideoTableView.tableFooterView = [[UIView alloc] init];
    [_scrollsView addSubview:_processingVideoTableView];
    [self addUpData:2];
    [self addDownData:2];
    
}

-(void)KaddNoDataView:(NSString *)state
{
    noDataView = [[UIView alloc] init];
    noDataView.frame = CGRectMake(0, 10, kScreenWidth, kScreenHeight-120);
    noDataView.backgroundColor = [UIColor clearColor];
    if ([state isEqualToString:@"0"]) {
        [_scrollsView insertSubview:noDataView aboveSubview:self.videoListTableView];
    }else if ([state isEqualToString:@"1"]){
        noDataView.frame = CGRectMake(kScreenWidth, 10, kScreenWidth, kScreenHeight-120);
        [_scrollsView insertSubview:noDataView aboveSubview:self.pastVideoTableView];
    }else if ([state isEqualToString:@"2"]){
        noDataView.frame = CGRectMake(kScreenWidth*2, 10, kScreenWidth, kScreenHeight-120);
        [_scrollsView insertSubview:noDataView aboveSubview:self.processingVideoTableView];
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(50, noDataView.height/4, kScreenWidth/3, kScreenWidth/3);
    imageView.center = CGPointMake(kScreenWidth/2, imageView.centerY);
    imageView.image = [UIImage imageNamed:@"NoData_icon_image"];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [noDataView addSubview:imageView];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(0, 300, noDataView.width, 20);
    lable.center = CGPointMake(kScreenWidth/2, imageView.bottom+10);
    lable.font = [UIFont systemFontOfSize:13];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"还没有报名的活动哦";
    [noDataView addSubview:lable];

}



#pragma mark - UIScrollViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 998) {
        return _liveListArr.count;
    }else if (tableView.tag == 999){
        return _passtListArr.count;
    }else if(tableView.tag == 1000){
        return _processingListArr.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cell";
    
    if (tableView.tag == 998) {
        UGLiveVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            cell = [[UGLiveVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        }
        
        [cell.timer invalidate];
        cell.timer = nil;
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        _liveVideoModel = _liveListArr[indexPath.row];
        
        [cell initUI:_liveVideoModel];
        
        if (cell.timer) {
            [_timerArray addObject:cell.timer];
        }
        
        return  cell;
        
    }else if (tableView.tag == 999){
        UGLiveVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            cell = [[UGLiveVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        }
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        _liveVideoModel = _passtListArr[indexPath.row];
        
        [cell initUI:_liveVideoModel];
        
        return  cell;
    }else if (tableView.tag == 1000){
        UGLiveVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
        if (cell == nil) {
            cell = [[UGLiveVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
        }
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        _liveVideoModel = _processingListArr[indexPath.row];
        
        [cell initUI:_liveVideoModel];
        
        return  cell;
    }
    
    UITableViewCell *cell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [User_Default setObject:@"frame" forKey:@"activityframe"];
    [User_Default synchronize];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 998) {
        
        _liveVideoModel = _liveListArr[indexPath.row];
        UGLiveVideoDetailViewController *liveVideoDetailVC = [[UGLiveVideoDetailViewController alloc] init];
        liveVideoDetailVC.isSignSuccess = YES;
        liveVideoDetailVC.liveId = _liveVideoModel.liveId;
        [self pushToNextViewController:liveVideoDetailVC];
        
    }else if (tableView.tag == 999){
        
        _liveVideoModel = _passtListArr[indexPath.row];
        UGLiveVideoDetailViewController *liveVideoDetailVC = [[UGLiveVideoDetailViewController alloc] init];
        liveVideoDetailVC.isSignSuccess = YES;
        liveVideoDetailVC.liveId = _liveVideoModel.liveId;
        [self pushToNextViewController:liveVideoDetailVC];
        
    }else if (tableView.tag == 1000){
        
        _liveVideoModel = _processingListArr[indexPath.row];
        UGLiveVideoDetailViewController *liveVideoDetailVC = [[UGLiveVideoDetailViewController alloc] init];
        liveVideoDetailVC.isSignSuccess = YES;
        liveVideoDetailVC.liveId = _liveVideoModel.liveId;
        [self pushToNextViewController:liveVideoDetailVC];
        
    }
    
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [noDataView removeFromSuperview];
    _numberNew = 0;
    _numberPass = 0;
    _numberProcessing = 0;
    
    if (scrollView.tag == 997) {
        
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        
        [UIView animateWithDuration:0.2 animations:^{
            if (index == 0) {
                buttomline.center = CGPointMake(kScreenWidth/6, buttomline.centerY);
            }else if(index==1){
                 buttomline.center = CGPointMake(kScreenWidth/6+(kScreenWidth/3)*index, buttomline.centerY);
            }else{
                 buttomline.center = CGPointMake(kScreenWidth/6+(kScreenWidth/3)*index, buttomline.centerY);
            }
            
        }];
        
        for (UIButton *button in buttonArr) {
            button.selected = NO;
            UIButton *butn = (UIButton *)[self.view viewWithTag:index+100];
            if (button.tag == index + 100) {
                butn.selected = YES;
            }
        }
        
        if (index == 1) {
            [self getNetDataprocessingActivityList:@"0"];
        }
        if (index == 2) {
            [self getNetDataEndActivityList:@"0"];
        }
        if (index == 0) {
            [self getNetNotstartedList:@"0"];
        }
        
    }
    
}


-(void)clickButtons2:(UIButton *)button
{
    [noDataView removeFromSuperview];
    _numberNew = 0;
    _numberPass = 0;
    _numberProcessing = 0;
    
    NSInteger index = button.tag - 100;
    for (int i = 0; i < 3; i ++) {
        UIButton *temButn = (UIButton *)[self.view viewWithTag:100 +i];
        temButn.selected = NO;
    }
    button.selected = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        if (index == 0) {
            buttomline.center = CGPointMake(kScreenWidth/6, buttomline.centerY);
            [self getNetNotstartedList:@"0"];
        }else if(index==1) {
            buttomline.center = CGPointMake(kScreenWidth/6+(kScreenWidth/3)*index, buttomline.centerY);
            [self getNetDataprocessingActivityList:@"0"];
        }else{
            buttomline.center = CGPointMake(kScreenWidth/6+(kScreenWidth/3)*index, buttomline.centerY);
            [self getNetDataEndActivityList:@"0"];
        }
    }];
    
    CGFloat x = index * kScreenWidth;
    CGPoint p = CGPointMake(x, 0);
    [_scrollsView setContentOffset:p animated:YES];
}


#pragma mark -刷新数据
-(void)addUpData:(NSInteger)tabletype
{   //上拉
    typeof(self) weakSelf = self;
    if (tabletype==0) {
        [self.videoListTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberNew = 0;
            [weakSelf getNetNotstartedList:@"0"];
        }];
    }else if(tabletype==1){
        [self.pastVideoTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberPass = 0;
            [weakSelf getNetNotstartedList:@"0"];
        }];
    }else if(tabletype==2){
        [self.processingVideoTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberProcessing = 0;
            [weakSelf getNetDataprocessingActivityList:@"0"];
        }];
    }
}

-(void)addDownData:(NSInteger)tabletype
{
    //下拉
    typeof(self) weakSelf = self;
    if (tabletype==0) {
        [self.videoListTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberNew += 1;
            [weakSelf getNetNotstartedList:[NSString stringWithFormat:@"%ld",weakSelf.numberNew]];
        }];
    }else if(tabletype==1){
        [self.pastVideoTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberPass += 1;
        [weakSelf getNetDataprocessingActivityList:[NSString stringWithFormat:@"%ld",weakSelf.numberPass]];
            DLog(@"$$$$$$$self.pastVideoTableView:%ld",weakSelf.numberProcessing);
        }];
    }else if(tabletype==2){
        [self.processingVideoTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberProcessing += 1;
            [weakSelf getNetDataEndActivityList:[NSString stringWithFormat:@"%ld",weakSelf.numberPass]];
            DLog(@"$$$$$$$self.pastVideoTableView:%ld",weakSelf.numberPass);
        }];
    }
}


#pragma mark - 网络请求 获取未开始活动列表
-(void)getNetNotstartedList:(NSString *) page{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    //params[@"token"] = @"ENW2behsR+g=";
    params[@"page"] = page;
    
    
    DLog(@"%@?token=%@&page=0",UG_ZoomLiveNewestList_URL,kToken);
    
    [HttpClientManager postAsyn:UG_MyNotstartedActivityList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
          NSArray *ListArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if(ListArr){
                if([page isEqualToString:@"0"]){
                    if (ListArr.count == 0) {
                        [self KaddNoDataView:@"0"];
                    }
                    [_liveListArr removeAllObjects];
                    [_liveListArr addObjectsFromArray:ListArr];
                    [self.videoListTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                }else{
                    [_liveListArr addObjectsFromArray:ListArr];
                    [self.videoListTableView footerEndRefreshing];
                }
                
                [self deallocNSTimer];
                [self.videoListTableView reloadData];
            }
        
            
           
            
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}


#pragma mark - 网络请求 我的进行中的活动
-(void)getNetDataprocessingActivityList:(NSString *)page{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;//ENW2behsR+g=
    //params[@"token"] = @"ENW2behsR+g=";
    params[@"page"] = page;
    params[@"status"]=@"1";
    
    DLog(@"%@?token=%@&page=0",UG_ZoomLivePassedList_URL,kToken);
    
    [HttpClientManager postAsyn:UG_MyOtherActivityList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
           /** _passtListArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if (_passtListArr.count > 0) {
                [self.pastVideoTableView reloadData];
            }**/
            
            
            NSArray *ListArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if(ListArr){
                if([page isEqualToString:@"0"]){
                    if (ListArr.count == 0) {
                         [self KaddNoDataView:@"1"];
                    }
                    [_passtListArr removeAllObjects];
                    [_passtListArr addObjectsFromArray:ListArr];
                    [self.pastVideoTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                }else{
                    [_passtListArr addObjectsFromArray:ListArr];
                    [self.pastVideoTableView footerEndRefreshing];
                }
                
                [self deallocNSTimer];
                [self.pastVideoTableView reloadData];
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}


#pragma mark - 网络请求 我的的结束的活动
-(void)getNetDataEndActivityList:(NSString *)page{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;//ENW2behsR+g=
    //params[@"token"] = @"ENW2behsR+g=";
    params[@"page"] = page;
    params[@"status"]=@"2";
    
    DLog(@"%@?token=%@&page=0",UG_ZoomLivePassedList_URL,kToken);
    
    [HttpClientManager postAsyn:UG_MyOtherActivityList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
           /** _processingListArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if (_processingListArr.count > 0) {
                [self.processingVideoTableView reloadData];
            }**/
            
            
            NSArray *ListArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if(ListArr){
                if([page isEqualToString:@"0"]){
                    if (ListArr.count == 0) {
                        [self KaddNoDataView:@"2"];
                    }
                    [_processingListArr removeAllObjects];
                    [_processingListArr addObjectsFromArray:ListArr];
                    [self.processingVideoTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                }else{
                    [_processingListArr addObjectsFromArray:ListArr];
                    [self.processingVideoTableView footerEndRefreshing];
                }
                
                [self deallocNSTimer];
                [self.processingVideoTableView reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
