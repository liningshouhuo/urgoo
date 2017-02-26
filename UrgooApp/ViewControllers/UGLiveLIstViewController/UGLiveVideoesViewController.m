//
//  UGLiveVideoesViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveVideoesViewController.h"
#import "UGLiveVideoCell.h"
#import "UGLiveVideoDetailViewController.h"
#import "LiveVideoModel.h"

@interface UGLiveVideoesViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIView *buttomline;
    NSMutableArray *buttonArr;
    UIView *noDataView;
}

@property (nonatomic,strong) UIScrollView *scrollsView;
@property (nonatomic,strong) UITableView  *videoListTableView;
@property (nonatomic,strong) UITableView  *pastVideoTableView;
@property (nonatomic,strong) LiveVideoModel  *liveVideoModel;
@property (nonatomic,strong) NSMutableArray  *liveListArr;
@property (nonatomic,strong) NSMutableArray  *passtListArr;
@property (nonatomic,strong) NSMutableArray  *timerArray;
@property (assign,nonatomic) NSInteger        numberNew;
@property (assign,nonatomic) NSInteger        numberPass;


@end

@implementation UGLiveVideoesViewController

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self deallocNSTimer];
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    [self setCustomTitle:@"优顾直播"];
    [self needBackAction:NO];
    
    [self initUI];
    
    [self getNetDataZoomLiveNewestListPage:@"0"];
    
}

-(void)initUI{
    
    buttonArr     = [NSMutableArray array];
    _timerArray   = [NSMutableArray array];
    _liveListArr  = [NSMutableArray array];
    _passtListArr = [NSMutableArray array];
    _numberNew  = 0;
    _numberPass = 0;

    NSArray *titleArr = @[@"最新动态",@"往期回顾"];
    for (int i = 0; i < 2; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * (kScreenWidth/2), 0, kScreenWidth/2, 38);
        if ([User_Default objectForKey:@"activityframe"]) {
            button.frame = CGRectMake(i * (kScreenWidth/2), 0, kScreenWidth/2, 38);
        }
        button.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100 + i;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:@"007466"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButtons:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
        }
        [buttonArr addObject:button];
        [self.view addSubview:button];
        
    }
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(kScreenWidth/2, 6 , 0.6, 25);
    line.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line];
    
    buttomline = [[UIView alloc] init];
    buttomline.frame = CGRectMake(kScreenWidth/4-25, 33, 50, 5);
    buttomline.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomline];
    buttomline.center = CGPointMake(kScreenWidth/4, buttomline.centerY);
    
    _scrollsView = [[UIScrollView alloc] init];
    _scrollsView.frame = CGRectMake(0, 37 , kScreenWidth, kScreenHeight-64-38-44);
    _scrollsView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    _scrollsView.tag = 997;
    _scrollsView.delegate = self;
    _scrollsView.pagingEnabled = YES;
    _scrollsView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollsView];
    
    if ([User_Default objectForKey:@"activityframe"]) {
        line.frame = CGRectMake(kScreenWidth/2, 6 , 0.6, 25);
        buttomline.frame = CGRectMake(kScreenWidth/4-25, 33, 50, 5);
        _scrollsView.frame = CGRectMake(0, 37, kScreenWidth, kScreenHeight-38);
    }
    
    _videoListTableView = [[UITableView alloc] init];
    _videoListTableView.frame = CGRectMake(0, 0, kScreenWidth, _scrollsView.height);
    _videoListTableView.backgroundColor = self.view.backgroundColor;
    _videoListTableView.tag = 998;
    _videoListTableView.delegate = self;
    _videoListTableView.dataSource = self;
    _videoListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _videoListTableView.tableFooterView = [[UIView alloc] init];
    [_scrollsView addSubview:_videoListTableView];
    [self addUpData:YES];
    [self addDownData:YES];
    
    _pastVideoTableView = [[UITableView alloc] init];
    _pastVideoTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, _scrollsView.height);
    _pastVideoTableView.backgroundColor = self.view.backgroundColor;
    _pastVideoTableView.tag = 999;
    _pastVideoTableView.delegate = self;
    _pastVideoTableView.dataSource = self;
    _pastVideoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pastVideoTableView.tableFooterView = [[UIView alloc] init];
    [_scrollsView addSubview:_pastVideoTableView];
    [self addUpData:NO];
    [self addDownData:NO];
    
    if (_isPassList) {
        
        _isPassList = NO;
        [self getNetDataZoomLivePassedListPage:@"0"];
        
        UIButton *passButn = buttonArr[1];
        passButn.selected = YES;
        
        buttomline.center = CGPointMake(kScreenWidth/4*3, buttomline.centerY);
        
        CGPoint p = CGPointMake(kScreenWidth, 0);
        [_scrollsView setContentOffset:p animated:YES];
    }
}

#pragma mark -刷新数据
-(void)addUpData:(BOOL)isVideoList
{   //上拉
    typeof(self) weakSelf = self;
    if (isVideoList) {
        [self.videoListTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberNew = 0;
            [weakSelf getNetDataZoomLiveNewestListPage:@"0"];
        }];
    }else{
        [self.pastVideoTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberPass = 0;
            [weakSelf getNetDataZoomLivePassedListPage:@"0"];
        }];
    }
}

-(void)addDownData:(BOOL)isVideoList
{
    //下拉
    typeof(self) weakSelf = self;
    if (isVideoList) {
        [self.videoListTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberNew += 1;
            [weakSelf getNetDataZoomLiveNewestListPage:[NSString stringWithFormat:@"%ld",weakSelf.numberNew]];
        }];
    }else{
        [self.pastVideoTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.numberPass += 1;
            [weakSelf getNetDataZoomLivePassedListPage:[NSString stringWithFormat:@"%ld",weakSelf.numberPass]];
            DLog(@"$$$$$$$self.pastVideoTableView:%ld",weakSelf.numberPass);
        }];
    }
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 998) {
        return _liveListArr.count;
    }else if (tableView.tag == 999){
        return _passtListArr.count;
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
    }

    UITableViewCell *cell;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 998) {
        
        _liveVideoModel = _liveListArr[indexPath.row];
        UGLiveVideoDetailViewController *liveVideoDetailVC = [[UGLiveVideoDetailViewController alloc] init];
        liveVideoDetailVC.liveId = _liveVideoModel.liveId;
        liveVideoDetailVC.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:liveVideoDetailVC];
        
    }else if (tableView.tag == 999){
        
        _liveVideoModel = _passtListArr[indexPath.row];
        UGLiveVideoDetailViewController *liveVideoDetailVC = [[UGLiveVideoDetailViewController alloc] init];
        liveVideoDetailVC.liveId = _liveVideoModel.liveId;
        liveVideoDetailVC.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:liveVideoDetailVC];
        
    }
    
}


-(void)KaddNoDataView:(BOOL)isNewLiveVideo
{
    noDataView = [[UIView alloc] init];
    noDataView.frame = CGRectMake(0, 10, kScreenWidth, kScreenHeight-120);
    noDataView.backgroundColor = [UIColor clearColor];
    if (isNewLiveVideo) {
        [_scrollsView insertSubview:noDataView aboveSubview:self.videoListTableView];
    }else{
        noDataView.frame = CGRectMake(kScreenWidth, 10, kScreenWidth, kScreenHeight-120);
        [_scrollsView insertSubview:noDataView aboveSubview:self.pastVideoTableView];
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
    if (isNewLiveVideo) {
        lable.text = @"还没有最新直播哦，去往期直播看看吧";
    }else{
        lable.text = @"还没有直播哦";
    }
    [noDataView addSubview:lable];
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [noDataView removeFromSuperview];
    
    if (scrollView.tag == 997) {
        
        NSInteger index = scrollView.contentOffset.x/scrollView.frame.size.width;
        
        [UIView animateWithDuration:0.2 animations:^{
            if (index == 0) {
                buttomline.center = CGPointMake(kScreenWidth/4, buttomline.centerY);
            }else
                buttomline.center = CGPointMake(kScreenWidth/4*(index*3), buttomline.centerY);
        }];
        
        for (UIButton *button in buttonArr) {
            button.selected = NO;
            UIButton *butn = (UIButton *)[self.view viewWithTag:index+100];
            if (button.tag == index + 100) {
                butn.selected = YES;
            }
        }
        
        _numberNew = 0;
        _numberPass = 0;
        if (index == 1) {
            [self getNetDataZoomLivePassedListPage:@"0"];
        }else{
            [self getNetDataZoomLiveNewestListPage:@"0"];
        }
        
    }

}


-(void)clickButtons:(UIButton *)button
{
    [noDataView removeFromSuperview];
    _numberNew = 0;
    _numberPass = 0;
    
    NSInteger index = button.tag - 100;
    for (int i = 0; i < 2; i ++) {
        UIButton *temButn = (UIButton *)[self.view viewWithTag:100 +i];
        temButn.selected = NO;
    }
    button.selected = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
        if (index == 0) {
            buttomline.center = CGPointMake(kScreenWidth/4, buttomline.centerY);
            [self getNetDataZoomLiveNewestListPage:@"0"];
        }else {
            buttomline.center = CGPointMake(kScreenWidth/4*(index*3), buttomline.centerY);
            [self getNetDataZoomLivePassedListPage:@"0"];
        }
    }];
    
    CGFloat x = index * kScreenWidth;
    CGPoint p = CGPointMake(x, 0);
    [_scrollsView setContentOffset:p animated:YES];
}


#pragma mark - 网络请求 直播最新动态列表
-(void)getNetDataZoomLiveNewestListPage:(NSString *)page
{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"page"] = page;
    
    DLog(@"%@?token=%@&page=%@",UG_ZoomLiveNewestList_URL,kToken,page);
    
    [HttpClientManager postAsyn:UG_ZoomLiveNewestList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSArray *liveListArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if (liveListArr) {
                
                if ([page isEqualToString:@"0"]) {
                    if (liveListArr.count == 0) {
                        [self KaddNoDataView:YES];
                    }
                    [_liveListArr removeAllObjects];
                    [_liveListArr addObjectsFromArray:liveListArr];
                    [self.videoListTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                }else{
                    [_liveListArr addObjectsFromArray:liveListArr];
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


#pragma mark - 网络请求 直播详情的往期回顾
-(void)getNetDataZoomLivePassedListPage:(NSString *)page
{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"page"] = page;
    
    DLog(@"%@?token=%@&page=%@",UG_ZoomLivePassedList_URL,kToken,page);
    
    [HttpClientManager postAsyn:UG_ZoomLivePassedList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSArray *passArr  = [LiveVideoModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"liveList"]];
            
            if (passArr) {
                
                if ([page isEqualToString:@"0"]) {
                    if (passArr.count == 0) {
                        [self KaddNoDataView:NO];
                    }
                    [_passtListArr removeAllObjects];
                    [_passtListArr addObjectsFromArray:passArr];
                    [self.pastVideoTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                }else{
                    [_passtListArr addObjectsFromArray:passArr];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
