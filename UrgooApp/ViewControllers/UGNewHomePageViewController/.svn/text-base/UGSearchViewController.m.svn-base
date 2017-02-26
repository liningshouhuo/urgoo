//
//  UGSearchViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/20.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSearchViewController.h"
#import "SKTagView.h"
#import "SearchLIstModel.h"
#import "SearchNameModel.h"
#import "UGNewPageConTableViewCell.h"
#import "CounselorListModel.h"
#import "JHRefresh.h"
#import "MJRefresh.h"
#import "UGCounselorDetailNewViewController.h"

@interface UGSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate>
{
   // UISearchDisplayController *searchDisplayController;
    UISearchController * searchController;
    NSMutableArray * array;
    CGFloat tagHeight;
   
}

@property (strong,nonatomic)UITableView * historytableview;
@property (nonatomic,strong) SKTagView *tagView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *groupArray;
@property (nonatomic,strong) SearchLIstModel * HotListModel;
@property (nonatomic,strong) UITableView * searchListTableView;
@property (nonatomic,strong) NSMutableArray * seaListArray;
@property (nonatomic,strong) UIView * clearView;
@property (nonatomic,strong)  UILabel * historylable;
@property (nonatomic,strong) UIScrollView * BGscrollView;
@property (nonatomic,strong) UIView * no_dataView;
@property (nonatomic,strong) NSMutableDictionary * searchPramas;
@property (assign,nonatomic) int pageInt;
@end

@implementation UGSearchViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    [self.navigationController.navigationBar setTranslucent:YES];
    
    
}
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithArray:self.groupArray];
//        _dataSource = [[NSMutableArray alloc] initWithArray:@[@"余罪",@"恐怖游轮",@"放牛班的春天",@"当幸福来敲门",@"哈利波特",@"死亡密码",@"源代码",@"盗梦空间",@"疯狂动物城",@"X战警",@"西游降魔篇",]];
    }
    return _dataSource;
}
-(NSMutableDictionary * )searchPramas{
    
    if (_searchPramas == nil) {
        _searchPramas = [NSMutableDictionary dictionary];
    }
    
    return _searchPramas;
    
}
-(NSMutableArray *)seaListArray{
    if (_seaListArray == nil) {
        _seaListArray = [NSMutableArray array];
        
    }
    return _seaListArray;
    
    
}
-(NSMutableArray *)groupArray{
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}
-(UITableView *)searchListTableView{
    if (_searchListTableView == nil) {
        _searchListTableView = [[UITableView alloc]init];
        _searchListTableView.frame = CGRectMake(0, 69, kScreenWidth, kScreenHeight - 69);
         _searchListTableView.separatorStyle =   UITableViewCellSeparatorStyleNone;
        _searchListTableView.delegate = self;
        _searchListTableView.dataSource = self;
        _searchListTableView.estimatedRowHeight = 340.0f;
        _searchListTableView.rowHeight = UITableViewAutomaticDimension;
        _searchListTableView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        [_searchListTableView registerClass:[UGNewPageConTableViewCell class] forCellReuseIdentifier:@"search_cell"];
        _searchListTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadNewData];
        }];
        

        _searchListTableView.hidden = YES;
        
        
        
        
        
        
        
        
        [self.view addSubview:_searchListTableView];
    }
    return _searchListTableView;
    
    
    
}
-(UIView *)no_dataView{
    if (_no_dataView == nil) {
        _no_dataView = [[UIView alloc]init];
        _no_dataView.frame = CGRectMake(0, 69, kScreenWidth, kScreenHeight - 69);
        
        _no_dataView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no_data"]];
//        imageview.centerX = kScreenWidth/2;
//        imageview.centerY = (kScreenHeight)/2;
//        imageview.size = CGSizeMake(150, 150);
        imageview.frame = CGRectMake((kScreenWidth - 150)/2,( kScreenHeight -150 -69)/2 - 50,  150, 150);
        [_no_dataView addSubview:imageview];
        UILabel * lable = [[UILabel alloc]init];
        lable.text = @"没有找到该顾问,请确认输入姓名是否正确";
        lable.frame = CGRectMake(0, imageview.origin.y + imageview.size.width +10, kScreenWidth, 16);
        lable.font = [UIFont systemFontOfSize:15];
        lable.textAlignment = NSTextAlignmentCenter;
        
        [_no_dataView addSubview:lable];
        
        
        
        _no_dataView.hidden = YES;
        [self.view addSubview:_no_dataView];

    }
    
    
    
    return _no_dataView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRequest];
    array = [NSMutableArray array];
    [array addObjectsFromArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"history_array"]];
    [self needBackAction:false];
    self.view.backgroundColor = [UIColor whiteColor];
    _pageInt = 0;
    
   searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
   searchController.searchBar.frame = CGRectMake(0, 0, 200, 44);
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.showsCancelButton = YES;
    searchController.searchBar.backgroundColor = [UIColor clearColor];
    searchController.searchBar.placeholder =@"请输入顾问的姓名";
    searchController.searchBar.delegate =self;
    //searchController.searchResultsUpdater = self;
    self.navigationItem.titleView = searchController.searchBar;
    UIButton *canceLBtn = [searchController.searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    //canceLBtn.size = CGSizeMake(100, 50);
    canceLBtn.backgroundColor = [UIColor clearColor];
    [canceLBtn addTarget:self action:@selector(click_cancleBtn) forControlEvents:UIControlEventTouchUpInside];
    [canceLBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    _historytableview = [[UITableView alloc]init];
    _BGscrollView = [[UIScrollView alloc]init];
    _BGscrollView.alwaysBounceHorizontal = YES;
    //_BGscrollView.backgroundColor = [UIColor redColor];
   // _BGscrollView.contentSize = CGSizeMake (0, 800);
    _BGscrollView.bounces = NO;
    _BGscrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight );
    [self.view addSubview:_BGscrollView];
    
    
}
-(void)loadRequest{
   // UG_nosign_findInfo_URL
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    //params[@"token"]= kToken;
    [SVProgressHUD show];
    [HttpClientManager postAsyn:UG_nosign_findInfo_URL params:params success:^(id json) {
        
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        _HotListModel = [SearchLIstModel mj_objectWithKeyValues:json[@"body"]];
        for (NSDictionary * dict in _HotListModel.countryTypeList) {
            SearchNameModel * model1 = [SearchNameModel mj_objectWithKeyValues:dict];
            if (model1.countryName.length >0) {
                
                [self.groupArray addObject:model1.countryName];
            }
        }
            for (NSDictionary * dict in _HotListModel.genderList) {
                SearchNameModel * model1 = [SearchNameModel mj_objectWithKeyValues:dict];
                [self.groupArray addObject:model1.genderName];
                
            }
            
       
        NSLog(@"%@",self.groupArray);
        [self sethotSearchUI];
        [self setHistorUI];
        [self setbottomBtn];
        
    } failure:^(NSError *error) {
         [SVProgressHUD dismiss];
        [self showSVErrorString:@"网络错误请重试"];
    }];
    

    
}
-(void)sethotSearchUI{
    
    UILabel * hotlable = [[UILabel alloc]init];
    
    hotlable.text = @"热门搜索";
    hotlable.font = [UIFont systemFontOfSize:15];
    
    hotlable.frame = CGRectMake(20, 30 +69, 70, 16);
    [_BGscrollView addSubview:hotlable];
    
    [self.tagView removeAllTags];
    self.tagView = [[SKTagView alloc] init];
    // 整个tagView对应其SuperView的上左下右距离
    self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    // 上下行之间的距离
    self.tagView.lineSpacing = 10;
    // item之间的距离
    self.tagView.interitemSpacing = 20;
    // 最大宽度
    self.tagView.preferredMaxLayoutWidth = 375;
       // 开始加载
    [self.groupArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 初始化标签
        SKTag *tag = [[SKTag alloc] initWithText:self.groupArray[idx]];
        // 标签相对于自己容器的上左下右的距离
        tag.padding = UIEdgeInsetsMake(3, 15, 3, 15);
        // 弧度
        tag.cornerRadius = 6.0f;
        // 字体
        tag.font = [UIFont boldSystemFontOfSize:12];
        // 边框宽度
        tag.borderWidth = 0.5f;
        // 背景
        //tag.bgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        tag.bgColor = [UIColor clearColor];
        // 边框颜色
        //tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        tag.borderColor = [UIColor colorWithHexString:@"#26bdab"];
        // 字体颜色
        //tag.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
        tag.textColor = [UIColor colorWithHexString:@"#26bdab"];
        // 是否可点击
        tag.enable = YES;
        // 加入到tagView
        [self.tagView addTag:tag];
    }];
    // 点击事件回调
    __weak UGSearchViewController * weakself = self;
    
    
    
    
    
    self.tagView.didTapTagAtIndex = ^(NSUInteger idx){
        weakself.searchPramas = [NSMutableDictionary dictionary];
        
        
        
        
        NSString * indexstr = [NSString stringWithFormat:@"%lu",(unsigned long)idx];
       
        int index = [indexstr intValue];
       NSLog(@"%ld",(long)index);
        NSLog(@"%ld",weakself.HotListModel.countryTypeList.count);
   
               
        //NSMutableDictionary * params = [NSMutableDictionary dictionary];
        //params[@"token"] = kToken;

        
        if (weakself.HotListModel.countryTypeList.count >0) {
            if ( ((int)weakself.HotListModel.countryTypeList.count  - index -1) >0 || ((int)weakself.HotListModel.countryTypeList.count  - index -1) ==0)  {
               //点击的是 countryTypeList 里的东西
                NSArray * countryArray =  weakself.HotListModel.countryTypeList;
                
                SearchNameModel * model = [SearchNameModel mj_objectWithKeyValues:countryArray[index]];
                
                 weakself.searchPramas[@"countryType"] =model.countryType;
                NSLog(@"model.countryType==%@",model.countryType);
                
                
            }else{
                //点击的是 其他两个里面的东西
                if ( ((int)weakself.HotListModel.genderList.count +weakself.HotListModel.countryTypeList.count - index -1) >0 || ((int)weakself.HotListModel.genderList.count +weakself.HotListModel.countryTypeList.count - index -1) ==0 ) {
                    //点击的是 genderList 里的东西
                    NSArray * genderArray =  weakself.HotListModel.genderList;
                    NSInteger genderListIndex = index - weakself.HotListModel.countryTypeList.count;
                    SearchNameModel * model = [SearchNameModel mj_objectWithKeyValues:genderArray[genderListIndex]];
                    
                    
                    NSLog(@"model.genderType==%@",model.genderType);
                     weakself.searchPramas[@"gender"] =model.genderType;
                    
                }else{
                    
                    NSArray * serviceTypeArray =  weakself.HotListModel.genderList;
                    NSInteger serviceTypeListIndex = index - weakself.HotListModel.countryTypeList.count - weakself.HotListModel.countryTypeList.count;
                    SearchNameModel * model = [SearchNameModel mj_objectWithKeyValues:serviceTypeArray[serviceTypeListIndex]];
                    
                    
                    
                    
                     weakself.searchPramas[@"serviceType"] = model.serviceType;
                    
                }
                
                
                
                
                
            }
            
        }
        
        
        
      
        NSLog(@"%@", weakself.searchPramas);
        weakself.searchPramas[@"page"] = @"0";
        
        
        [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params:weakself.searchPramas success:^(id json) {
            _pageInt = 1;
            NSLog(@"%@",kToken);
            NSLog(@"%@",json);
            
            
            NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in tuijian) {
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                [weakself.seaListArray addObject:model];
            }
            
            
            
            
            [weakself.searchListTableView reloadData];
            weakself.searchListTableView.hidden = NO;
            [weakself.historylable removeFromSuperview];
            
            [weakself.clearView removeFromSuperview];
        } failure:^(NSError *error) {
            
            
            
            
            
        }];
        

        
        
    };
    
    // 获取刚才加入所有tag之后的内在高度
     tagHeight = self.tagView.intrinsicContentSize.height;
    NSLog(@"高度%lf",tagHeight);
    self.tagView.frame = CGRectMake(0, 56+69, kScreenWidth, tagHeight);
    [self.tagView layoutSubviews];
    [_BGscrollView addSubview:self.tagView];

    
  //CGRectMake(0, tagHeight + 90 +69, kScreenWidth, 300)
    _historytableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    _historytableview.scrollEnabled =NO;
    _historytableview.delegate =self;
    _historytableview.dataSource = self;
    
    [_BGscrollView addSubview:_historytableview];
    
    
    
    
    
    
}
-(void)setHistorUI{
    
   _historylable = [[UILabel alloc]init];
    
    _historylable.text = @"历史搜索";
    _historylable.font = [UIFont systemFontOfSize:15];
    
    _historylable.frame = CGRectMake(20, tagHeight + 76+69, 70, 16);
   
    if(array.count >0){
         [_BGscrollView addSubview:_historylable];
        
        
    }
    
    
    
    
}
-(void)setbottomBtn{
    _clearView = [[UIView alloc]init];
    _clearView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _clearView.layer.cornerRadius = 8.0f;
        UITapGestureRecognizer * contecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_clearHistory)];
  
          [_clearView addGestureRecognizer:contecognizer];
    _clearView.frame = CGRectMake(kScreenWidth/3, _historytableview.origin.y + _historytableview.bounds.size.height +20, 125, 25);
    
    [_BGscrollView addSubview:_clearView];
    _clearView.layer.borderWidth = 1.0f;
    _clearView.layer.borderColor = [[UIColor  colorWithHexString:@"#999999"] CGColor];
    UILabel * clearLable = [[UILabel alloc]init];
    clearLable.text = @"清除历史记录";
    clearLable.textColor = [UIColor colorWithHexString:@"#999999"];
    clearLable.font = [UIFont systemFontOfSize:15];
    clearLable.frame = CGRectMake(20, 5, 105, 15);
    [_clearView addSubview:clearLable];
    UIImageView * clearimage = [[UIImageView alloc]init];
    clearimage.image = [UIImage imageNamed:@"clear_history"];
    clearimage.frame = CGRectMake(8, 6, 12, 12);
    [_clearView addSubview:clearimage];
    CGFloat contentHight = _clearView.origin.y + _clearView.bounds.size.height + 20;
    _BGscrollView.contentSize = CGSizeMake(0,contentHight);
    
    
    
}
-(void)click_cancleBtn{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)click_clearHistory{
    
    [array removeAllObjects];
    [_historytableview reloadData];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"history_array"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
     _historytableview.frame = CGRectMake(0, tagHeight + 90 +69, kScreenWidth, array.count * 44);
    [_historylable removeFromSuperview];
    [_clearView removeFromSuperview];
    _BGscrollView.contentSize = CGSizeMake(0,kScreenHeight - 100);
    [_BGscrollView setContentSize:CGSizeMake(0, 0)];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchListTableView) {
        if (self.seaListArray.count >0) {
            return self.seaListArray.count;
        }else{
            
            return 0;
        }
        
        
        
        
        
    }else{
        
        
        if (array.count >0) {
            _historytableview.frame = CGRectMake(0, tagHeight + 90 +69, kScreenWidth, array.count * 44);
            return array.count;
            
        }else{
            return 0;
        }
        
        
    }
    
    
    
    
    

}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.searchListTableView) {
        
        UGNewPageConTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"search_cell"];
        if (cell ==nil) {
            cell = [[UGNewPageConTableViewCell alloc]initWithFrame:CGRectZero];
            
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //(@"%@",self.consultantArray);
        cell.ListModel = self.seaListArray[indexPath.row];
        return cell;
        

        
        
        
        
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"history_cell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"history_cell"];
        }
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#434343"];
        
        return cell;
        
    }
    return nil;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
     self.searchPramas = [NSMutableDictionary dictionary];
    //NSLog(@"dsaasx");
    [array insertObject:searchBar.text atIndex:0];
    [_historytableview reloadData];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"history_array"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.searchPramas = [NSMutableDictionary dictionary];
    //_searchPramas[@"token"] = kToken;
     self.searchPramas[@"name"] = searchBar.text;
    
    
    self.searchPramas[@"page"] = @"0";
    NSLog(@"%@", self.searchPramas);
            [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params: self.searchPramas success:^(id json) {
                [self.searchListTableView.mj_footer endRefreshing];
                NSLog(@"%@",kToken);
                NSLog(@"%@",json);
                if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
                    _pageInt = 1;
                    [self.seaListArray removeAllObjects];
                    NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
                    for (NSDictionary * dict in tuijian) {
                        CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                        [self.seaListArray addObject:model];
                    }
                    
                    if (self.seaListArray.count>0) {
                        self.no_dataView.hidden=YES;
                        [self.searchListTableView reloadData];
                        self.searchListTableView.hidden = NO;
                        [self.searchListTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                        [self.searchListTableView setContentOffset:CGPointMake(0, 0)];

                        [_historylable removeFromSuperview];
                        [_BGscrollView removeFromSuperview];
                        [_clearView removeFromSuperview];
                        
                    }else {
                        
                        self.no_dataView.hidden=NO;
                        self.searchListTableView.hidden = YES;
                        [_historylable removeFromSuperview];
                        [_clearView removeFromSuperview];
                        
                    }
                    
                    
                }else if ([json[@"header"][@"code"] isEqualToString:@"400"]){
                    

                }
                
              } failure:^(NSError *error) {
                  
                  
                  
                  
                  
            }];

    
    
    
    
    
    
    
    
    
    
    
    
}

-(void)loadNewData{
   self.searchPramas[@"page"] = [NSString stringWithFormat:@"%d",_pageInt];
    [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params:_searchPramas success:^(id json) {
        NSLog(@"%@",kToken);
        NSLog(@"%@",json);
        [self endRefresh];
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            _pageInt +=1;
            NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in tuijian) {
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                [self.seaListArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if (self.seaListArray.count>0) {
                    self.no_dataView.hidden=YES;
                    [self.searchListTableView reloadData];
                    self.searchListTableView.hidden = NO;
                    [_historylable removeFromSuperview];
                    [_BGscrollView removeFromSuperview];
                    [_clearView removeFromSuperview];
                    
                }
                
            });
            
        }else if ([json[@"header"][@"code"] isEqualToString:@"400"]){
            
            
        }
        
    } failure:^(NSError *error) {
        
        
        
        
        
    }];
    
    
    
    
    

    
    
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.searchListTableView) {
        UGNewPageConTableViewCell * cell = [[UGNewPageConTableViewCell alloc]init];
        cell.ListModel = cell.ListModel = self.seaListArray[indexPath.row];
        
        
        
        return cell.totleHight;

    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==_historytableview) {
        self.searchPramas = [NSMutableDictionary dictionary];
       // NSMutableDictionary * params = [NSMutableDictionary dictionary];
       // params[@"token"] = kToken;
      self.searchPramas[@"name"] = array[indexPath.row];
        NSLog(@"%@",array[indexPath.row]);
        NSLog(@"%@", self.searchPramas);
        self.searchPramas[@"page"] = @"0";
        [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params:self.searchPramas success:^(id json) {
            NSLog(@"%@",kToken);
            NSLog(@"%@",json);
            
            _pageInt = 1;
            NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in tuijian) {
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                [self.seaListArray addObject:model];
            }
            if (self.seaListArray.count >0) {
                 self.no_dataView.hidden=YES;
                [self.searchListTableView reloadData];
                self.searchListTableView.hidden = NO;
                [_historylable removeFromSuperview];
                [_clearView removeFromSuperview];
                
            }else{
                
                self.no_dataView.hidden=NO;
                self.searchListTableView.hidden = YES;
                [_historylable removeFromSuperview];
                [_clearView removeFromSuperview];

            }
            
            
        } failure:^(NSError *error) {
            
            
            
            
            
        }];
        
    }else if (tableView == self.searchListTableView){
        
        
        CounselorListModel * model = self.seaListArray[indexPath.row];
        
        NSLog(@"%@",model.counselorId);
        
        UGCounselorDetailNewViewController * counselorDetailNewVC = [[UGCounselorDetailNewViewController alloc]init];
        counselorDetailNewVC.counselorId =model.counselorId;
        
        counselorDetailNewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:counselorDetailNewVC animated:YES];
        

        
        
        
        
    }
    
    
    
    

    
    
}
-(void)endRefresh{
    [self.searchListTableView.mj_header endRefreshing];
    [self.searchListTableView.mj_footer endRefreshing];
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
