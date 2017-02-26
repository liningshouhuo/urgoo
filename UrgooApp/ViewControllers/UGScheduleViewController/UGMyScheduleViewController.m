//
//  UGMyScheduleViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/30.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyScheduleViewController.h"
#import "UGScheduleTableViewCell.h"
#import "UGScheduleDtlViewController.h"
#import "AdvanceListModel.h"
#import "AdvanceDetailModel.h"
#import "AdanceTimeList.h"
#import "UGMyScheduleCell.h"
@interface UGMyScheduleViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) UIScrollView * scrollView;
@property (strong,nonatomic) UITableView * tableView1;
@property (strong,nonatomic) UITableView * tableView2;
@property (strong,nonatomic) UITableView * tableView3;
@property (strong,nonatomic) NSMutableArray * unconfirmeArray;
@property (strong,nonatomic) NSMutableArray * confirmeArray;
@property (strong,nonatomic) UICollectionView * collectionView;
@property (strong,nonatomic) UIButton * chooseDatebutton;

//@property (strong,nonatomic) NSMutableArray * unconfirmeArray;
@property (strong,nonatomic) AdvanceListModel * advanceListModel;

@property (strong,nonatomic) UIView *redDotView;
@property (strong,nonatomic) UIView *redCloseView;

@end

@implementation UGMyScheduleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self loadUrlAdvanceUnconfirme];
    //[self cleanRedShow];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didselect:) name:@"button_IndexArr" object:nil];
    [self.collectionView reloadData];
    
    [self getNetData_redShowAdvanceConfirm];
    [self getNetData_redShowAdvanceClose];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super  viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"button_IndexArr" object:nil];
   
};
-(void)cleanRedShow {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"token"] = kToken;

    [HttpClientManager postAsyn:UG_cleanRedShow_URL params:params success:^(id json) {
        NSLog(@"%@",json);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
- (void)didselect:(NSNotification *)notification{
    UGScheduleDtlViewController * vc = [[UGScheduleDtlViewController alloc]init];
    vc.advanceId = notification.userInfo[@"advanceId"];
    int index = [notification.userInfo[@"status"] intValue];
    vc.index = index;
    if ([notification.userInfo[@"type"] isEqualToString:@"100"]) {
        
    }else{
       vc.type= notification.userInfo[@"type"];
    }
   
    NSLog(@"%d",vc.index);
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:vc animated:YES];
    
   
    
}
-(void)needBackAction:(BOOL)isNeed{
    
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backToRoot)];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
    
    
    
}
-(void)backToRoot{
    
    if (_isJPush) {
        [[AppDelegate sharedappDelegate] showTabBar];
    }else{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    [self backtoAction];
}
-(void)backtoAction{
    
    [AppDelegate sharedappDelegate].tabbar.selectedIndex = 3 ;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"我的预约"];
    //[self loadUrlAdvanceUnconfirme];
    [self setupUI];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didselect:) name:@"buttonIndexArr" object:nil];
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)setupUI{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    NSArray *titleArr = @[@"待确认",@"已确认",@"已结束"];
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(i*kScreenWidth/3, 0, kScreenWidth/3, 39.5);
        [selectBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [selectBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateSelected];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"a5a5a5"] forState:UIControlStateNormal];
        selectBtn.backgroundColor = [UIColor whiteColor];
        [selectBtn setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#ffffff"]] forState:   UIControlStateSelected ];
    
//        [selectBtn setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#26bdab"]] forState:UIControlStateSelected];
        selectBtn.tag =998+i;
        [selectBtn addTarget:self action:@selector(clickDatebutton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectBtn];
        
        if (selectBtn.tag ==998) {//RGB(37, 175, 153)
            selectBtn.selected = YES;
            
            //selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        
    }
    
    _redDotView = [[UIView alloc] init];
    _redDotView.backgroundColor = [UIColor redColor];
    _redDotView.frame = CGRectMake(kScreenWidth/6*3+25, 7, 6, 6);
    _redDotView.layer.cornerRadius = 3;
    _redDotView.layer.masksToBounds = YES;
    _redDotView.hidden = YES;
    [self.view addSubview:_redDotView];
    
    _redCloseView = [[UIView alloc] init];
    _redCloseView.backgroundColor = [UIColor redColor];
    _redCloseView.frame = CGRectMake(kScreenWidth/6*5+25, 7, 6, 6);
    _redCloseView.layer.cornerRadius = 3;
    _redCloseView.layer.masksToBounds = YES;
    _redCloseView.hidden = YES;
    [self.view addSubview:_redCloseView];
    
    /*
    if (_isRedDot) {
        _redDotView.hidden = NO;
    }*/

    UICollectionViewFlowLayout *  layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth , kScreenHeight - 110);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [_collectionView registerClass:[UGMyScheduleCell class] forCellWithReuseIdentifier:@"MySchedulecolectioncell"];
    _collectionView.dataSource =self;
    _collectionView.delegate=self;
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor redColor];
    _collectionView.frame = CGRectMake(0, 54, kScreenWidth, kScreenHeight -114);
    [self.view addSubview:_collectionView];

    
    
    
    
}
#pragma mark 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"%@",str);
    UGMyScheduleCell *  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MySchedulecolectioncell" forIndexPath:indexPath];
    
       cell.testlable =str;
//    cell.dateListmodel = [AdvanceDateList mj_objectWithKeyValues:_listArray[indexPath.row]];
//    _advanceDate = cell.dateListmodel.advanceDate;
//    _timerListArrayT = [NSMutableArray arrayWithArray:cell.dateListmodel.timeList];
//    NSLog(@"%@",_timerListArrayT);
//    _indexItem = indexPath;
//    _collectionIndex = [NSString stringWithFormat:@"点击的是第%ld",(long)indexPath.row];
//    
//    // cell.testlable = str ;
    
   //[self.collectionView reloadData]
   
    return cell;
}

#pragma mark 未确认列表
-(void)loadUrlAdvanceUnconfirme{
    
    // 客户端预约列表(待确定)
      [SVProgressHUD show];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
        params[@"token"] = kToken;
    NSLog(@"%@",kToken);
    _unconfirmeArray = [NSMutableArray array];
    __weak UGMyScheduleViewController *weakSelf = self;

    [HttpClientManager postAsyn:advanceUnconfirmeListClient params:params success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        NSLog(@"111111111%@",json);
        NSArray *listArray = [NSArray arrayWithArray: json[@"body"][@"advanceList"]];
       
        for (NSDictionary * dict in listArray) {
            
            AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:dict];
            [_unconfirmeArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self endRefresh];
            
            [weakSelf.tableView1 reloadData];
        });

        NSLog(@"%@",_unconfirmeArray);
        } failure:^(NSError *error) {
            [weakSelf showSVErrorString:@"请确认连接了网络"];
              [SVProgressHUD dismiss];
        }];
    
    
    
    // 客户端预约列表(确定)
    self.confirmeArray = [NSMutableArray array];
  [HttpClientManager getAsyn:advanceConfirmeListClient params:params success:^(id json) {
      NSLog(@"%@",json);
       NSArray *listArray = [NSArray arrayWithArray: json[@"body"][@"advanceList"]];
      NSLog(@"2222222%@",listArray);
      for (NSDictionary * dict in listArray) {
          
          AdvanceListModel * model = [AdvanceListModel mj_objectWithKeyValues:dict];
          [_confirmeArray addObject:model];
      }
      
      NSLog(@"这里  是 11111%@",self.confirmeArray);
      dispatch_async(dispatch_get_main_queue(), ^{
          //[self endRefresh];
          
          [weakSelf.tableView2 reloadData];
      });

  } failure:^(NSError *error) {
    
  }];
//    _confirmeArray = [NSMutableArray array];
//    [HttpClientManager postAsyn:advanceConfirmeListClient params:params success:^(id json) {
////        NSLog(@"%@",json);
////        NSArray *listArray1 = [NSArray arrayWithArray: json[@"body"][@"advanceList"]];
////        NSLog(@"++++++%@",listArray1);
////        for (NSDictionary * dict in listArray1) {
//////            
//////            AdanceTimeList * model = [AdanceTimeList mj_objectWithKeyValues:dict];
//////            [_confirmeArray addObject:model];
////        }
////        dispatch_async(dispatch_get_main_queue(), ^{
////            //[self endRefresh];
////            
//////            [weakSelf.tableView2 reloadData];
////        });
////        
////        NSLog(@"%@",_confirmeArray);
//    } failure:^(NSError *error) {
//        [weakSelf showSVErrorString:@"请确认连接了网络"];
//    }];

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    NSArray *titleArr = @[@"待确认",@"已确认",@"已结束"];
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(i*kScreenWidth/3, 0, kScreenWidth/3, 39.5);
        [selectBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [selectBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateSelected];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"a5a5a5"] forState:UIControlStateNormal];
        selectBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        selectBtn.tag =i+10;
        [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectBtn];
        
//        if (i==0) {//RGB(37, 175, 153)
//            [selectBtn setTitleColor:RGB(38, 189, 171) forState:UIControlStateNormal];
//            //selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        }
//        
    }
//加上tableView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight-64-50)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    [self.view addSubview:_scrollView];
    //待确认的tableView
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight-64-50)];
    _tableView1.backgroundColor = [UIColor whiteColor];
    _tableView1.dataSource = self;
    _tableView1.delegate =self;
   _tableView1.separatorStyle =   UITableViewCellSeparatorStyleNone;

    [_tableView1 registerClass:[UGScheduleTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_scrollView addSubview:_tableView1];
    //已确认的tableView
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 64-50)];
    //_tableView2.backgroundColor = [UIColor yellowColor];
    _tableView2.dataSource =self;
    _tableView2.delegate = self;
    _tableView2.separatorStyle =   UITableViewCellSeparatorStyleNone;
    [_tableView2 registerClass:[UGScheduleTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_scrollView addSubview:_tableView2];
    //已结束的tableView
    _tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - 64 -50)];
    //_tableView3.backgroundColor = [UIColor greenColor];
    _tableView3.dataSource =self;
    _tableView3.delegate = self;
    _tableView3.separatorStyle =   UITableViewCellSeparatorStyleNone;

    [_tableView3 registerClass:[UGScheduleTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_scrollView addSubview:_tableView3];
    
}
#pragma mark 上下联动
-(void)clickDatebutton:(UIButton *)sender{
    for (NSInteger i=998; i<1001; i++) {
        UIButton *tmpBtn = (UIButton *)[self.view viewWithTag: i];
        //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        tmpBtn.selected = NO;
    }
    sender.selected = YES;
    [sender setTintColor:[UIColor whiteColor]];
    NSInteger select =sender.tag -998;
    [_collectionView setContentOffset:CGPointMake(select*kScreenWidth, 0) animated:YES];
    
    if (select == 1) {
        [self getNetData_cleanRedShowAdvanceType:@"confirm"];
    }else if (select == 2){
        [self getNetData_cleanRedShowAdvanceType:@"close"];
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
  
    
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    for (NSInteger i =998; i<1001; i++) {
        UIButton *tmpBtn  = (UIButton *)[self.view viewWithTag:i];
        tmpBtn.selected = NO;
        //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        //_chooseDatebutton = tmpBtn;
    }
    _chooseDatebutton = (UIButton *)[self.view viewWithTag:998+index];
    _chooseDatebutton.selected = YES;
    //selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //[_collectionView setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
    
    
    if (index == 1) {
        [self getNetData_cleanRedShowAdvanceType:@"confirm"];
    }else if (index == 2){
        [self getNetData_cleanRedShowAdvanceType:@"close"];
    }
    
}

-(void)selectAction:(UIButton *) sender{
    
   
    for (NSInteger i=10; i<13; i++) {
        UIButton *tmpBtn = (UIButton *)[self.view viewWithTag:10 + i];
        //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        tmpBtn.selected = NO;
         _chooseDatebutton = tmpBtn;
    }
    sender.selected = YES;
    NSInteger select =sender.tag -10;
    [_scrollView setContentOffset:CGPointMake(select*kScreenWidth, 0) animated:YES];
}
#pragma mark 数据源 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual: _tableView1]) {
        return self.unconfirmeArray.count;
    }
    else if ([tableView isEqual: _tableView2]){
//        return self.confirmeArray.count;
        return self.confirmeArray.count;
    }
    else if ([tableView isEqual: _tableView3]){
        return 10;
    }
    return 0;

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView1) {
        
        UGScheduleTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UGScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSLog(@"%lu",(unsigned long)_unconfirmeArray.count);
        cell.advanceListModel = self.unconfirmeArray[indexPath.row];
        return cell;
    }else{
        UGScheduleTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell == nil) {
            cell = [[UGScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
                   }
        cell.confirmeDetailModel = self.confirmeArray[indexPath.row];

        return cell;

    }
//    if (tableView == _tableView1){
//        UGScheduleTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
//        if (cell == nil) {
//            cell = [[UGScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//            cell.backgroundColor = [UIColor redColor];
//            
//            return cell;
//        }
//    }else if (tableView == _tableView2){
//        UGScheduleTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell1"];
//        if (cell == nil) {
//            cell = [[UGScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
//            
//           
//            return cell;
//        }
//    }else if (tableView == _tableView3){
//        UGScheduleTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell2"];
//        if (cell == nil) {
//            cell = [[UGScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
//            
//           
//            return cell;
//        }
//    }
//
      return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView2) {
        return 86;
    }
    
    
    
    return 102;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UGScheduleDtlViewController * vc = [[UGScheduleDtlViewController alloc]init];
    vc.index = (int)indexPath.row + 1;
    vc.hidesBottomBarWhenPushed = YES;
   
    if (tableView == _tableView1) {
        
        _advanceListModel = _unconfirmeArray[indexPath.row];
        vc.advanceId = _advanceListModel.advanceId;
      [self.navigationController  pushViewController:vc animated:YES];
        
        
    }else if (tableView == _tableView2){
         [self.navigationController  pushViewController:vc animated:YES];
        
    }else if (tableView == _tableView3){
        
          [self.navigationController  pushViewController:vc animated:YES];
        
    }
}


#pragma mark - 预约关系变化-红点
-(void)getNetData_redShowAdvanceConfirm{
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"flag"] = @"confirm";
    
    [HttpClientManager postAsyn:UG_redShowAdvance_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSString *isShow = [NSString stringWithFormat:@"%@",json[@"body"][@"showRed"][@"isShow"]] ;
            if ([isShow isEqualToString:@"1"]) {
                _redDotView.hidden = NO;
            }else{
                _redDotView.hidden = YES;
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

-(void)getNetData_redShowAdvanceClose{
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"flag"] = @"close";
    
    [HttpClientManager postAsyn:UG_redShowAdvance_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSString *isShow = [NSString stringWithFormat:@"%@",json[@"body"][@"showRed"][@"isShow"]] ;
            if ([isShow isEqualToString:@"1"]) {
                _redCloseView.hidden = NO;
            }else{
                _redCloseView.hidden = YES;
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

-(void)getNetData_cleanRedShowAdvanceType:(NSString *)type
{
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"flag"] = type;
    
    [HttpClientManager postAsyn:UG_cleanRedShowAdvance_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            if ([type isEqualToString:@"confirm"]) {
                _redDotView.hidden = YES;
            }else if ([type isEqualToString:@"close"]){
                _redCloseView.hidden = YES;
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

@end
