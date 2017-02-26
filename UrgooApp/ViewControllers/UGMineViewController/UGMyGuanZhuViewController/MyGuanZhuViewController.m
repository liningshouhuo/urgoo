//
//  MyGuanZhuViewController.m
//  UrgooApp
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "MyGuanZhuViewController.h"
#import "UGNewPageConTableViewCell.h"
#import "CounselorListModel.h"
#import "SearchLIstModel.h"
#import "SearchNameModel.h"
#import "UGCounselorDetailNewViewController.h"
#import "UGConsultantLIstViewController.h"

@interface MyGuanZhuViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL showList;
    
    NSMutableArray * tableArray;
    CGFloat tabHight;
    NSMutableDictionary * seachDict;
    NSMutableArray * seachArray;
    UIScrollView *choose_moreView;
    UIButton * severBtn;
    UIButton * chinaBtn;
    UIButton * experienceBtn;
    UIButton * localBtn;
    UIButton *  associationBtn;
    UIButton *  genderBtn;
    UIImageView * arrowImage;
    UIView * severView;
    
    UIView *noDataView;
}

@property (strong,nonatomic) UITableView * consultantTableView;
@property (strong,nonatomic) NSMutableArray * consultantArray;
@property (strong,nonatomic) SearchLIstModel * searchlistModel;
@property (strong,nonatomic) CounselorListModel *counselorListModel;
@property (assign,nonatomic) NSInteger        index;

@end

@implementation MyGuanZhuViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadRequest:@"0"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setTranslucent:NO];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"我关注的顾问"];
    seachDict = [NSMutableDictionary dictionary];
    
    _index=0;
    
    [self setconsutantUI];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
    
}
-(NSMutableArray *)consultantArray{
    if (_consultantArray == nil) {
        _consultantArray = [NSMutableArray array];
        
    }
    return _consultantArray;
    
}

-(void)KaddNoDataView
{
    noDataView = [[UIView alloc] init];
    noDataView.frame = CGRectMake(0, 10, kScreenWidth, kScreenHeight-120);
    noDataView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:noDataView aboveSubview:self.consultantTableView];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(50, noDataView.height/4, kScreenWidth/3, kScreenWidth/3);
    imageView.center = CGPointMake(kScreenWidth/2, imageView.centerY);
    imageView.image = [UIImage imageNamed:@"NoData_icon_image"];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [noDataView addSubview:imageView];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(0, 300, 30, 30);
    imageV.center = CGPointMake(kScreenWidth/2+30, imageView.y-30);
    imageV.image = [UIImage imageNamed:@"search_icon_xin"];
    imageV.layer.masksToBounds = YES;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    [noDataView addSubview:imageV];
    
    UILabel *lable = [[UILabel alloc] init];
    lable.frame = CGRectMake(0, 300, noDataView.width-30, 20);
    lable.center = CGPointMake(30, imageView.y-30);
    lable.font = [UIFont systemFontOfSize:13];
    lable.textAlignment = NSTextAlignmentRight;
    lable.text = @"在顾问资料页点击";
    [noDataView addSubview:lable];
    
    UILabel *lable2 = [[UILabel alloc] init];
    lable2.frame = CGRectMake(imageV.rightWith, lable.y, noDataView.width, 20);
    lable2.font = [UIFont systemFontOfSize:13];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.text = @"收藏顾问";
    [noDataView addSubview:lable2];
    
    UIButton *selectButn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButn.frame = CGRectMake(0, 0, 120, 30);
    selectButn.center = CGPointMake(kScreenWidth/2, imageView.bottom+40);
    selectButn.layer.cornerRadius = 5;
    selectButn.layer.masksToBounds = YES;
    selectButn.titleLabel.font = [UIFont systemFontOfSize:13];
    selectButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    [selectButn setTitle:@"挑选顾问" forState:UIControlStateNormal];
    [selectButn addTarget:self action:@selector(clickSelectButn) forControlEvents:UIControlEventTouchUpInside];
    [noDataView addSubview:selectButn];
}
-(void)clickSelectButn
{
    UGConsultantLIstViewController * vc= [[UGConsultantLIstViewController alloc] init];
    [self pushToNextViewController:vc];
}


#pragma mark -刷新数据
-(void)addUpData
{   //上拉
    typeof(self) weakSelf = self;

    [self.consultantTableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.index= 0;
            [weakSelf loadRequest:@"0"];
    }];
}




-(void)addDownData
{
    //下拉
    typeof(self) weakSelf = self;
   
        [self.consultantTableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
            weakSelf.index += 1;
            [weakSelf loadRequest:[NSString stringWithFormat:@"%ld",weakSelf.index]];
        }];
}

//顾问列表
-(void)loadRequest:(NSString *)page{
    
    [noDataView removeFromSuperview];
    
    //顾问列表
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"]= kToken;
    params[@"page"]= page;
    /*params[@"countryType"]= @"";
    
    params[@"gender"]= @"";
    params[@"serviceMode"]= @"";*/ 
    
    [HttpClientManager postAsyn:UG_MyCounselorList_URL params:params success:^(id json) {
        NSLog(@"%@",kToken);
        NSLog(@"%@",json);
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            
        
        NSString * totalSize = json[@"body"][@"totalSize"];
        NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
        
        if(tuijian){
            
            if (tuijian.count > 0) {
                [self setCustomTitle:[NSString stringWithFormat:@"我关注的顾问(%@)",totalSize]];
            }
            
            if([page isEqualToString:@"0"]){
                if (tuijian.count == 0) {
                    [self KaddNoDataView];
                }
                [self.consultantArray removeAllObjects];
                for (NSDictionary * dict in tuijian) {
                    CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                    [self.consultantArray addObject:model];
                }
                [self.consultantTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                
                
            }else{
                for (NSDictionary * dict in tuijian) {
                    CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                    [self.consultantArray addObject:model];
                }
                [self.consultantTableView footerEndRefreshing];
            }
            
            [self.consultantTableView reloadData];
           
        }
        
        }else{
            
             [self showSVErrorString:@"网络异常，请稍后重试"];
            
        }
       
       
    } failure:^(NSError *error) {
        
         [self showSVErrorString:@"请求网络失败，请稍后重试"];
    }];
    
    
    
    
}


#pragma mark 我的顾问列表
-(void)setconsutantUI{
    _consultantTableView = [[UITableView alloc]init];
    _consultantTableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64 );
    _consultantTableView.estimatedRowHeight = 340.0f;
    _consultantTableView.rowHeight = UITableViewAutomaticDimension;
    //_consultantTableView.backgroundColor = [UIColor redColor];
    _consultantTableView.separatorStyle =   UITableViewCellSeparatorStyleNone;
    [_consultantTableView registerClass:[UGNewPageConTableViewCell class] forCellReuseIdentifier:@"newpagecell"];
    _consultantTableView.dataSource = self;
    _consultantTableView.delegate = self;
    //_consultantArray.
    [self.view addSubview:_consultantTableView];
    [self addUpData];
    [self addDownData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _consultantTableView) {
        
        return self.consultantArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _consultantTableView) {
        
        UGNewPageConTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"newpagecell"];
        if (cell ==nil) {
            cell = [[UGNewPageConTableViewCell alloc]initWithFrame:CGRectZero];
            
        }
        //(@"%@",self.consultantArray);
        cell.ListModel = self.consultantArray[indexPath.row];
        return cell;
        
    }
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _consultantTableView) {
        UGNewPageConTableViewCell * cell = [[UGNewPageConTableViewCell alloc]init];
        cell.ListModel = self.consultantArray[indexPath.row];
        
        return cell.totleHight;
    }
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        _counselorListModel = _consultantArray[indexPath.row];
    
        UGCounselorDetailNewViewController *counselorDetailVC = [[UGCounselorDetailNewViewController alloc] init];
        counselorDetailVC.counselorId=_counselorListModel.counselorId;
        counselorDetailVC.byGuanZhu = @"guanzhu";
        [self pushToNextViewController:counselorDetailVC];
    
}


@end
