//
//  UGSearchClientViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSearchClientViewController.h"
#import "UGSearchClientDetailViewController.h"
#import "UGSearchTableViewCell.h"
#import "Masonry.h"
#import "JHRefresh.h"
#import "MJRefresh.h"
#import "CounselorListModel.h"
//#import "UGScreenCounselorView.h"
#import "UGScreenCounselorViewController.h"
#import "UGUnderstandUrgooViewController.h"

@interface UGSearchClientViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView * tableView;
@property (strong,nonatomic) UIView * headView;
@property (strong,nonatomic) NSMutableArray * group;
@property (assign,nonatomic) int number ;
//@property (strong,nonatomic) UGScreenCounselorView * screenView;
@property (strong,nonatomic) NSArray * selectArray;
@property (strong,nonatomic) NSArray * screenArray;
@property (strong,nonatomic) NSMutableDictionary * params;
@end

@implementation UGSearchClientViewController
-(void)loadView{
    
    self.view = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0  blue:247.0/255.0  alpha:1.0];
    
}
-(NSMutableArray *)group{
    
    if (_group == nil) {
        _group = [NSMutableArray array];
    }
    return _group;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 1;
    //[self loadNewData];
    // [self loadfristData];
    //[self.tableView ] 
    [self setCustomTitle:@"找顾问"];
    [self needBackAction:NO];
    [self needRightAction];
    [self initUI];
    [self screenLoadData];
    //[self loadWebViewWithUrlStr:UG_STUDENT_SEARCHCLIENT_URL];
    
    //[self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@",UG_STUDENT_SEARCHCLIENT_URL]];
    //[self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_STUDENT_CLINT_URL,kToken_temp]];
}
-(void)needRightAction{
//    
    
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"Right_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBtn)];
        self.navigationItem.rightBarButtonItem = backItem;
        
        
    

        
    
}
#pragma mark 跳出的筛选按钮
-(void)clickRightBtn{

    UGScreenCounselorViewController * vc = [[UGScreenCounselorViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.arrayM = [NSArray arrayWithArray:_selectArray];
    vc.consultCanArray = [NSArray arrayWithArray:_screenArray];
    [self pushToNextViewController:vc];
   
    __weak typeof (self) weakSelf = self;
   vc.settingBlock= ^(NSArray *array ){
       _selectArray = [NSArray arrayWithArray:array];
       
       NSLog(@"_selectArray =====%@",_selectArray);
       
       
       [weakSelf updateNewdata];
       
       
         };

    
}
#pragma mark 筛选发送网络请求
-(void)screenLoadData{
 // NSString * str =  @"http://139.129.164.163:8081/urgoo/001/001/nosign/searchInfo?termType=2";
    [HttpClientManager getAsyn:UG_nosign_searchInfo_URL params:nil success:^(id json) {
        
        if (json) {
            _screenArray = [NSArray arrayWithArray:json[@"body"][@"lableList"]];
           // NSLog(@"%@",_screenArray);
        }
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"网络发送失败");
    }];

    
}
#pragma mark 筛选之后的 网络请求
-(void)updateNewdata{
      _params = [NSMutableDictionary dictionary];
     NSString * selectPrams =[NSString stringWithFormat:@"%@", _selectArray[0]];
    NSLog(@"%@",selectPrams);
    if ([selectPrams isEqualToString:@"1"] || [selectPrams isEqualToString:@"2"]) {
      _params[@"countryType"] = selectPrams;
    
    }else if ([selectPrams isEqualToString:@"3"] ){
        NSString * str = @"1";
        _params[@"gender"] = str;
    }else if ([selectPrams isEqualToString:@"4"]){
        NSString * str = @"2";
        _params[@"gender"] = str;
    }else if ([selectPrams isEqualToString:@"5"]){
        NSString * str = @"1";
        _params[@"serviceMode"] = str;
    }else if([selectPrams isEqualToString:@"6"] ){
        NSString * str = @"2";
        _params[@"serviceMode"] = str;
    }else if([selectPrams isEqualToString:@"0"]) {
        //什么都没有选择
        [_params removeAllObjects];
    }else{
        _params[@"lableId"] = selectPrams;
        
    }
       [SVProgressHUD show];
    [HttpClientManager getAsyn:UG_nosign_searchCounselorList_URL params:_params success:^(id json) {
        NSLog(@"dsdssd");
        [_group removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        NSArray * arrayM = json[@"body"][@"counselorListInfoList"];
        if (!arrayM || !arrayM.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [self.tableView reloadData];
                
               
            });
            

           
        }else{
            
            _number = 1;
            for (NSDictionary * dict in arrayM) {
                //NSLog(@"111111111111%@",dict);
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                
                [_group addObject:model];
                
                NSLog(@"updateNewdata %@",self.group);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [self.tableView reloadData];
                
                // self.tableView.contentOffset.y = 0;
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                [self.tableView setContentOffset:CGPointMake(0, 0)];
            });
            
        }

    } failure:^(NSError *error) {
         NSLog(@"dsdssd");
          [SVProgressHUD dismiss];
    }];
    
    
    
    
    
    
}
-(void)initUI{
     __weak UGSearchClientViewController *weakSelf = self;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight* 0.18)];
   
        self.headView.backgroundColor = [UIColor greenColor];
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  kScreenWidth, kScreenHeight* 0.18)];
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_headView)];
    [self.headView addGestureRecognizer:recognizer];
    imageview.image =[UIImage imageNamed:@"30urgoo750@2x"];
    [self.headView addSubview:imageview];
    //[self.view addSubview:self.headView];
//    UIView * view1 = [[UIView alloc]init];
//    view1.backgroundColor = [UIColor whiteColor];
//    [self.headView addSubview:view1];
//    
//    UILabel * lable =[[UILabel alloc]init];
//    lable.text = @"为您推荐";
//    [view1 addSubview:lable];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.top.mas_equalTo(self.contentView.mas_top).offset(10);
//        make.bottom.mas_equalTo(self.headView.mas_bottom);
//        make.left.mas_equalTo(self.headView.mas_left);
//        make.right.mas_equalTo(self.headView.mas_right);
//        make.height.mas_equalTo(20);
//    }];
//   [lable mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.left.mas_equalTo(view1.mas_left);
//       make.centerY.mas_equalTo(view1.mas_centerY);
//   }];
//    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.headView);
//        make.right.mas_equalTo(self.headView);
//        make.top.mas_equalTo(self.headView);
//        make.bottom.mas_equalTo(self.headView);
//    }];
   
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 -64)];
    //self.tableView.tableHeaderView = self.headView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle =   UITableViewCellSeparatorStyleNone;
    //self.tableView.
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:_tableView];
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [weakSelf loadDateJhrefresh];
        [weakSelf.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    }];
  [self.tableView headerStartRefresh];//进入消息界面就刷新
//    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
//        [weakSelf loadDateJhrefreshFoot];
//        
//        //事情做完了别忘了结束刷新动画~~~
//        [weakSelf.tableView footerEndRefreshing];
//        
//    }];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
    
}
-(void)click_headView{
    NSLog(@"点击了headview");
    //    UIScrollView * scollView = [[UIScrollView alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, kScreenHeight-40)];
    //    UIImageView * imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scollView.size.width, scollView.size.width * 5)];
    //    imageVIew.image = [UIImage imageNamed:@"30s_understand"];
    //    [scollView addSubview:imageVIew];
    //    imageVIew.backgroundColor = [UIColor blueColor];
    //    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_headView)];
    //    [scollView addGestureRecognizer:recognizer];
    //    scollView.backgroundColor = [UIColor redColor];
    //    scollView.contentSize = CGSizeMake(0, imageVIew.size.height);
    //    [self.view addSubview:scollView];
    UGUnderstandUrgooViewController * vc = [[UGUnderstandUrgooViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc  animated:YES];
    
}

#pragma mark 上拉刷新 下拉刷新， 自动刷新
//启动自动 加载最新
-(void)loadfristData{
       // NSString * urlStr =  @"http://139.129.164.163:8081/urgoo/001/001/nosign/searchCounselorList?page=0";
        //     NSString * urlStr = @"http://139.129.164.163:8080/urgoo/001/001/nosign/searchCounselorList?page=1";
    NSString * urlStr = [NSString stringWithFormat:@"%@page=0",UG_searchCounselorList_URL];
        NSLog(@"%@",urlStr);
    [HttpClientManager getAsyn:urlStr params:_params success:^(id json) {
        //_group = [NSMutableArray array];
        NSLog(@"%@",json);
        [_group removeAllObjects];
        NSLog(@"%lu",(unsigned long)_group.count);
        NSArray * arrayM = json[@"body"][@"counselorListInfoList"];
        NSLog(@"%lu",(unsigned long)arrayM.count);
        for (NSDictionary * dict in arrayM) {
            NSLog(@"%lu",(unsigned long)_group.count);
            NSLog(@"%@",arrayM[0]);

            CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
            
            [self.group addObject:model];
            
            NSLog(@" tableView.mj_header %@",self.group);
        }
        NSLog(@"%lu",(unsigned long)_group.count);
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSLog(@"%lu",(unsigned long)_group.count);
            [self.tableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"shibai ");
    }];
    

    
    
}
//  jhrefresh  上啦刷新
-(void)loadDateJhrefresh{
    _number =1;
    NSLog(@"%lu",(unsigned long)_group.count);
    //NSString * urlStr =  @"http://139.129.164.163:8081/urgoo/001/001/nosign/searchCounselorList?page=0";
    NSString * urlStr = [NSString stringWithFormat:@"%@page=0",UG_searchCounselorList_URL];
    //     NSString * urlStr = @"http://139.129.164.163:8080/urgoo/001/001/nosign/searchCounselorList?page=1";
    NSLog(@"%@",urlStr);
    [HttpClientManager getAsyn:urlStr params:_params success:^(id json) {
        //_group = [NSMutableArray array];
        
        [self.group removeAllObjects];
        NSLog(@"%lu",(unsigned long)_group.count);
        NSArray * arrayM = json[@"body"][@"counselorListInfoList"];
        NSLog(@"%lu",(unsigned long)arrayM.count);
        for (NSDictionary * dict in arrayM) {
            NSLog(@"%lu",(unsigned long)_group.count);
            
            CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
            NSLog(@"%@",model.description);
            [self.group addObject:model];
            
            NSLog(@" tableView.mj_header %@",self.group);
        }
        NSLog(@"%lu",(unsigned long)_group.count);
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSLog(@"%lu",(unsigned long)_group.count);
            [self.tableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"shibai ");
    }];

}
-(void)loadDateJhrefreshFoot{
    
    
    NSLog(@"--------------%d",_number);
    // NSString * urlStr = [NSString stringWithFormat: @"http://139.129.164.163:8081/urgoo/001/001/nosign/searchCounselorList?page=%d",_number ];
    NSString * urlStr = [NSString stringWithFormat:@"%@page=%d",UG_searchCounselorList_URL,_number];
    //     NSString * urlStr = @"http://139.129.164.163:8080/urgoo/001/001/nosign/searchCounselorList?page=1";
    NSLog(@"%@",urlStr);
    [HttpClientManager getAsyn:urlStr params:_params success:^(id json) {
        //_group = [NSMutableArray array];
        _number+=1;
        NSArray * arrayM = json[@"body"][@"counselorListInfoList"];
        for (NSDictionary * dict in arrayM) {
            
            CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
            
            [self.group addObject:model];
            NSLog(@" ableView.mj_footer%@",self.group);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            NSLog(@" dispatch_async foot %@",self.group);
            
            [self.tableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"shibai ");
    }];
    





}
-(void)loadNewData{

    if (self.tableView.mj_header.isRefreshing) {
       
        _number =1;
         NSLog(@"%lu",(unsigned long)_group.count);
        //NSString * urlStr =  @"http://139.129.164.163:8081/urgoo/001/001/nosign/searchCounselorList?page=0";
        NSString * urlStr = [NSString stringWithFormat:@"%@page=0",UG_searchCounselorList_URL];
        //     NSString * urlStr = @"http://139.129.164.163:8080/urgoo/001/001/nosign/searchCounselorList?page=1";
        NSLog(@"%@",urlStr);
        [HttpClientManager getAsyn:urlStr params:_params success:^(id json) {
            //_group = [NSMutableArray array];
         
             [_group removeAllObjects];
             NSLog(@"%lu",(unsigned long)_group.count);
            NSArray * arrayM = json[@"body"][@"counselorListInfoList"];
            NSLog(@"%lu",(unsigned long)arrayM.count);
            for (NSDictionary * dict in arrayM) {
               NSLog(@"%lu",(unsigned long)_group.count);
               
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                
                [_group addObject:model];
                
                NSLog(@" tableView.mj_header %@",self.group);
            }
             NSLog(@"%lu",(unsigned long)_group.count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self endRefresh];
                NSLog(@"%lu",(unsigned long)_group.count);
                [self.tableView reloadData];
            });
            
            
        } failure:^(NSError *error) {
            NSLog(@"shibai ");
        }];
        

    }else if (self.tableView.mj_footer.isRefreshing){
        
        NSLog(@"--------------%d",_number);
        // NSString * urlStr = [NSString stringWithFormat: @"http://139.129.164.163:8081/urgoo/001/001/nosign/searchCounselorList?page=%d",_number ];
        NSString * urlStr = [NSString stringWithFormat:@"%@page=%d",UG_searchCounselorList_URL,_number];
        //     NSString * urlStr = @"http://139.129.164.163:8080/urgoo/001/001/nosign/searchCounselorList?page=1";
        NSLog(@"%@",urlStr);
        [HttpClientManager getAsyn:urlStr params:_params success:^(id json) {
            //_group = [NSMutableArray array];
            _number+=1;
            NSArray * arrayM = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in arrayM) {
              
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                
                [self.group addObject:model];
                 NSLog(@" ableView.mj_footer%@",self.group);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self endRefresh];
                NSLog(@" dispatch_async foot %@",self.group);

                [self.tableView reloadData];
            });
            
            
        } failure:^(NSError *error) {
            NSLog(@"shibai ");
        }];
        
    }
   
    
    

}
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark tableview 代理关系

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _group.count;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //UGSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    UGSearchTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[UGSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    //...其他代码

   // UGSearchTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.counselorModel = _group[indexPath.row];
//
    NSLog(@"%@",cell.counselorModel.counselorId) ;
   cell.contentView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CounselorListModel * model = _group[indexPath.row];
    NSString* str = [NSString stringWithFormat:@"%@termType=2&counselorId=%@",UG_clientProfile_URL,model.counselorId];
    NSLog(@"%@",str);
    if ([kToken isEqualToString:@""] || !kToken) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed = YES;
        UGNavigationController *loginNav = [[UGNavigationController alloc] initWithRootViewController:loginVC];
        [self.navigationController presentViewController:loginNav animated:YES completion:nil];

    }else{
        
        NSLog(@"%@",kToken);
        CounselorListModel * model = _group[indexPath.row];
        NSString* str = [NSString stringWithFormat:@"%@termType=2&counselorId=%@",UG_clientProfile_URL,model.counselorId];
        //NSString * str = [NSString stringWithFormat:@"http://139.129.164.163:8081/urgoo/001/001/client/counselorInfoContract?termType=2&counselorId=%@",model.counselorId];
        NSLog(@"44444444444444444%@",str);
        UGSearchClientDetailViewController * vc = [[UGSearchClientDetailViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.urlStr = str;
        [self.navigationController pushViewController:vc animated:YES];
            }
   
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    
//    double offSet = _tableView.contentOffset.y;
//    NSLog(@"%f",offSet);
//    if (offSet == 0) {
//         self.headView.frame = CGRectMake(0, 0 , kScreenWidth,kScreenHeight * 0.18  );
//        self.tableView.frame = CGRectMake(0, kScreenHeight * 0.18  , kScreenWidth, kScreenHeight - 64 -44);
//        NSLog(@"dsdsdsdsdsds");
//    }
//    if (0 < offSet && offSet < kScreenHeight * 0.18) {
//        self.headView.frame = CGRectMake(0, 0 - offSet, kScreenWidth,kScreenHeight * 0.18  );
//        self.tableView.frame = CGRectMake(0, self.headView.origin.y +kScreenHeight * 0.18 , kScreenWidth, kScreenHeight - 64 -44);
//    }else if (offSet > kScreenHeight * 0.18){
//        self.headView.frame = CGRectMake(0, 0 -kScreenHeight* 0.18, kScreenWidth,kScreenHeight * 0.18  );
//        self.tableView.frame = CGRectMake(0, self.headView.origin.y +kScreenHeight * 0.18, kScreenWidth, kScreenHeight - 64 -44);
//    }else if ( offSet<0){
//        self.headView.frame = CGRectMake(0, 0 , kScreenWidth,kScreenHeight * 0.18  );
//        
//
//    }
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//{
//    
//    double offSet = _tableView.contentOffset.y;
//    if ( offSet==0){
//        self.headView.frame = CGRectMake(0, 0 , kScreenWidth,kScreenHeight * 0.18  );
//        //self.tableView.frame = CGRectMake(0, kScreenHeight * 0.18 -10 , kScreenWidth, kScreenHeight - 64 -44);
//        
//    }
//
//}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
//{
//     double offSet = _tableView.contentOffset.y;
//    if (0 < offSet && offSet < kScreenHeight * 0.18) {
//        self.headView.frame = CGRectMake(0, 0 - offSet, kScreenWidth,kScreenHeight * 0.18  );
//        self.tableView.frame = CGRectMake(0, self.headView.origin.y +kScreenHeight * 0.18 , kScreenWidth, kScreenHeight - 64 -44);
//    }else if (offSet > kScreenHeight * 0.18){
//        self.headView.frame = CGRectMake(0, 0 -kScreenHeight* 0.18, kScreenWidth,kScreenHeight * 0.18  );
//        self.tableView.frame = CGRectMake(0, self.headView.origin.y +kScreenHeight * 0.18, kScreenWidth, kScreenHeight - 64 -44);
//    }else if ( offSet<0){
//        self.headView.frame = CGRectMake(0, 0 , kScreenWidth,kScreenHeight * 0.18  );
//        self.tableView.frame = CGRectMake(0, kScreenHeight * 0.18 -10 , kScreenWidth, kScreenHeight - 64 -44);
//        
//    }
//
//}
//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
//{
//    double offSet = _tableView.contentOffset.y;
//    if ( offSet==0){
//        self.headView.frame = CGRectMake(0, 0 , kScreenWidth,kScreenHeight * 0.18  );
//        //self.tableView.frame = CGRectMake(0, kScreenHeight * 0.18 -10 , kScreenWidth, kScreenHeight - 64 -44);
//        
//    }
//
//}
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
