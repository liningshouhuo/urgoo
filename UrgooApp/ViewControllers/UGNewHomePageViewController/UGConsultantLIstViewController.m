//
//  UGConsultantLIstViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGConsultantLIstViewController.h"
#import "UGNewPageConTableViewCell.h"
#import "CounselorListModel.h"
#import "SearchLIstModel.h"
#import "SearchNameModel.h"
#import "UGSearchViewController.h"
#import "UGCounselorDetailNewViewController.h"
#import "JHRefresh.h"
#import "MJRefresh.h"
@interface UGConsultantLIstViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL showList;
    UITableView  * seachTableview;
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
    
    
    
}
@property (strong,nonatomic) UITableView * consultantTableView;
@property (strong,nonatomic) NSMutableArray * consultantArray;
@property (strong,nonatomic) SearchLIstModel * searchlistModel;
@property (assign,nonatomic) int number ;
@property (strong,nonatomic) NSMutableDictionary * params;
@property (strong,nonatomic) UIView * notfindView;
@property (strong,nonatomic) UIView * mengbanView;
@end

@implementation UGConsultantLIstViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTranslucent:YES];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
////    _alphaView.alpha = 1.0;
////    [_seachView removeFromSuperview];
//    
//    //[alphaView removeFromSuperview];
//   [self.navigationController.navigationBar setTranslucent:NO];
    //[[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"顾问列表"];
    seachDict = [NSMutableDictionary dictionary];
   
    [self loadRequest];
    [self loadSearchRequest];
    [self setChoose_List];
    [self needRightAction:YES];
    [self notfindUI];
    _number = 1;
    showList = YES;
    
}


-(void)notfindUI{
    
    _notfindView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+44, kScreenWidth, kScreenHeight - 64 -44)];
    [self.view addSubview:_notfindView];
    _notfindView.hidden = YES;
    //[self.view bringSubviewToFront:_notfindView];
    UIImageView * notimageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-143)/2, 201 - 64-44, 143, 74)];
    
    notimageView.image = [UIImage imageNamed:@"no_find_image"];
    
    [_notfindView addSubview:notimageView];
    
    
    
    
    UILabel * lable = [[UILabel alloc]init];
    lable.text = @"更改筛选条件，一定可以找到合适的顾问";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.frame = CGRectMake(0, notimageView.origin.y + notimageView.size.height +15, kScreenWidth, 16);
    lable.textColor = [UIColor colorWithHexString:@"#999999"];
    lable.font = [UIFont systemFontOfSize:14];
    [_notfindView addSubview:lable];
    
    
    
    
}
-(NSMutableArray *)consultantArray{
    if (_consultantArray == nil) {
        _consultantArray = [NSMutableArray array];
        
    }
    return _consultantArray;
    
}
-(void)setServiceType:(NSString *)serviceType{
    _serviceType = serviceType;
    
    NSLog(@"%@",self.serviceType);
    
    
    
}
-(NSMutableDictionary *)params{
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
    
    
}

//顾问列表
-(void)loadRequest{
    //顾问列表
   
    self.params[@"token"]= kToken;
     self.params[@"page"]= @"0";
     self.params[@"countryType"]= @"";

      self.params[@"gender"]= @"";
    if (self.serviceType == nil) {
        NSLog(@"dsdscsd");
         self.params[@"serviceType"]= @"";
    }else{
        
         NSLog(@"%@",self.serviceType);
       [seachDict setObject:self.serviceType forKey:@"first"];
         self.params[@"serviceType"]= self.serviceType;
    
        
    }
    
    [HttpClientManager postAsyn:UG_getMyCounselorList_URL params: self.params success:^(id json) {
        NSLog(@"%@",kToken);
        NSLog(@"%@",json);
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in tuijian) {
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                [self.consultantArray addObject:model];
            }
            
            [self setconsutantUI];
            
        }
        
    } failure:^(NSError *error) {
           }];

    
    
    
}
//顾问搜索列表
-(void)loadSearchRequest{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"]= kToken;
     [SVProgressHUD showWithStatus:@"loading..."];
    [HttpClientManager postAsyn:UG_nosign_screen_URL params:params success:^(id json) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",json);
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            
            _searchlistModel = [SearchLIstModel mj_objectWithKeyValues:json[@"body"][@"obj"]];
        }
        
        
        [self setHeadUI];
        //[self.view bringSubviewToFront:_notfindView];
        
           } failure:^(NSError *error) {
    }];
    

    
}



//
-(void)setHeadUI{
    
    NSArray * titleArray =@[@"所有服务",@"顾问国籍",@"高级筛选"];
    
    for (int i =0; i<3; i++) {
        
        UIButton * button  = [[UIButton alloc ]init];
        button.frame = CGRectMake(i *  kScreenWidth/3 , 69, kScreenWidth/3, 41);
        
        if (i==0) {
            if (self.btnTitle == nil) {
                
                [button setTitle:titleArray[i] forState: UIControlStateNormal];
            }else{
                [button setTitle:self.btnTitle forState: UIControlStateNormal];
            }
        }else{
            [button setTitle:titleArray[i] forState: UIControlStateNormal];
        }
        button.tag = i + 200;
        
        [button setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
         [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(click_chooseBtn:) forControlEvents:   UIControlEventTouchUpInside];
        arrowImage = [[UIImageView alloc]init];
        arrowImage.tag = 203 +i;
        arrowImage.image = [UIImage imageNamed:@"normalArrow"];
        arrowImage.frame = CGRectMake( kScreenWidth/3 -22 , 18, 8, 6 );
//        if (i==1) {
//            arrowImage.frame = CGRectMake(250  , 20, 10, 8 );
//            
//        }
        [button addSubview:arrowImage];
        UIView * lineview = [[UIView alloc]init];
        lineview.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        lineview.frame = CGRectMake(0, 40, kScreenWidth/3, 1);
        [button addSubview:lineview];
        UIView * lineview1 = [[UIView alloc]init];
        lineview1.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        lineview1.frame = CGRectMake( kScreenWidth/3, 9, 1, 23);
        [button addSubview:lineview1];
        [self.view addSubview:button];
    }
    
    
    
    
    
    
}
#pragma mark 顾问列表
-(void)setconsutantUI{
    _consultantTableView = [[UITableView alloc]init];
    _consultantTableView.frame = CGRectMake(0, 49 +69, kScreenWidth, kScreenHeight-64 -49);
    _consultantTableView.estimatedRowHeight = 340.0f;
    _consultantTableView.rowHeight = UITableViewAutomaticDimension;
    //_consultantTableView.backgroundColor = [UIColor redColor];
    _consultantTableView.separatorStyle =   UITableViewCellSeparatorStyleNone;
    [_consultantTableView registerClass:[UGNewPageConTableViewCell class] forCellReuseIdentifier:@"newpagecell"];
    _consultantTableView.dataSource = self;
    _consultantTableView.delegate = self;
    self.consultantTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadNewData];
    }];

    //_consultantArray.
    [self.view addSubview:_consultantTableView];
    [self.view insertSubview:seachTableview aboveSubview:_consultantTableView];
    [self.view insertSubview:_mengbanView aboveSubview:_consultantTableView];
    [self .view insertSubview:_notfindView aboveSubview:_consultantTableView];
}
-(void)loadNewData1{
    
    
    self.params[@"page"] = [NSString stringWithFormat:@"%d",_number];
    NSLog(@"self.params======%@",self.params);
    [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params: self.params success:^(id json) {
        
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            _number+=1;
            // [self.consultantArray removeAllObjects];
            NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in tuijian) {
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                [self.consultantArray addObject:model];
            }
            // [choose_moreView removeFromSuperview];
            choose_moreView.hidden = YES;
            _mengbanView.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self endRefresh];
                
                [_consultantTableView reloadData];
                
            });
            
            
            
            
        }else{
            
            
            
            
            
            [self showSVErrorString:@"网络繁忙，请重试"];
        }
        
        //                [self setconsutantUI];
    } failure:^(NSError *error) {
        
        
        
        
        
        
    }];
    
    
    
    
    
    
    
}
-(void)loadNewData{
    
    if (showList) {
        
    
    self.params[@"page"] = [NSString stringWithFormat:@"%d",_number];
    NSLog(@"self.params======%@",self.params);
    [HttpClientManager postAsyn:UG_getMyCounselorList_URL params: self.params success:^(id json) {
        
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
             _number+=1;
           // [self.consultantArray removeAllObjects];
            NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
            for (NSDictionary * dict in tuijian) {
                CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                [self.consultantArray addObject:model];
            }
            // [choose_moreView removeFromSuperview];
            choose_moreView.hidden = YES;
            _mengbanView.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self endRefresh];
                
                [_consultantTableView reloadData];
                
            });

            
            
            
        }else{
            
            
            
            
            
            [self showSVErrorString:@"网络繁忙，请重试"];
        }

        
        //                [self setconsutantUI];
    } failure:^(NSError *error) {
        
        
        
        
        
        
    }];
    

    
    
    }else{
        
        
        
        
        [self loadNewData1];
        
        
        
        
    }
    
    
}
#pragma mark 筛选列表
-(void)setChoose_List{
    _mengbanView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+44, kScreenWidth, kScreenHeight - 64 -44)];
    [self.view addSubview:_mengbanView];
          UITapGestureRecognizer * contecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBGview)];
    
            [_mengbanView addGestureRecognizer:contecognizer];
 

    _mengbanView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _mengbanView.hidden = YES;
    seachTableview  =[[UITableView alloc]initWithFrame:CGRectMake(0,64+44, kScreenWidth, 200)];
    
    seachTableview.dataSource = self;
    seachTableview.delegate = self;
    seachTableview.hidden = YES;
    seachTableview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:seachTableview];
    
    
    
    
}
-(void)clickBGview{
    
    _mengbanView.hidden = YES;
    seachTableview.hidden = YES;
    
    
    
    
}
#pragma mark 高级帅选
-(void)setUP_chooseMoreUI{
    choose_moreView = [[UIScrollView alloc]init];
    choose_moreView.frame = CGRectMake(0, 49+69, kScreenWidth, kScreenHeight -49 -64);
    choose_moreView.backgroundColor = [UIColor whiteColor];
    choose_moreView.contentSize = CGSizeMake(0, 667-49-64);
    choose_moreView.hidden = YES;
    [self.view addSubview:choose_moreView];
    //NSMutableArray * titleLiatArray = [NSMutableArray array];
    NSArray * titileArray = @[@"服务类型",@"指导方式",@"中文水平",@"顾问经验",@"顾问国籍",@"协会认证",@"顾问性别"];
    NSArray * testArray = @[_searchlistModel.serviceList,_searchlistModel.serviceModeList,_searchlistModel.chineselevelList,_searchlistModel.counselorExperanceList,_searchlistModel.countryTypeList,_searchlistModel.orgList,_searchlistModel.genderList];
    NSArray * lastBtnArray = @[@"重置",@"确定"];
    
//   //服务类型
//    UIView * severView = [[UIView alloc]init];
//    
//    severView.tag = 20;
//    UILabel * titleLable = [[UILabel alloc]init];
//    titleLable.text = titileArray[0];
//    titleLable.textColor = [UIColor colorWithHexString:@"#666666"];
//    titleLable.font = [UIFont systemFontOfSize:15];
//    
//    [severView addSubview:titleLable];
//    
//    
//    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 68,  kScreenWidth-10,1)];
//    lineView.backgroundColor =[UIColor colorWithHexString:@"#eeeeee"];
//    
//    [severView addSubview:lineView];
//    [choose_moreView addSubview:severView];
//    
    
    
    CGFloat hight1 = 0.0;
    CGFloat hight2= 0.0;
    CGFloat hight3= 0.0;
    CGFloat hight4= 0.0;
    CGFloat hight5= 0.0;
    CGFloat hight6= 0.0;
    CGFloat hight7= 0.0;
    int lieshu;
    if (kScreenWidth == 320) {
         lieshu = 3;
        
    }else{
         lieshu = 4;
        
    }
    
    
    
    for (int i =0; i<titileArray.count; i++) {
        
        UIView * bgview = [[UIView alloc]init];
        [choose_moreView addSubview:bgview];
        if (i == 0) {
            bgview.tag = 80;
            
        }else if (i==1){
            
            bgview.tag = 120;
        }
        else if(i == 6){
            
            bgview.tag = 110;
        }else{
            
            bgview.tag = (i+2) * 10;
        }
        UILabel * titleLable = [[UILabel alloc]init];
        titleLable.text = titileArray[i];
        titleLable.textColor = [UIColor colorWithHexString:@"#666666"];
        titleLable.font = [UIFont systemFontOfSize:15];
       
        [bgview addSubview:titleLable];
        
        
        UIView * lineView = [[UIView alloc]init];
        lineView.backgroundColor =[UIColor colorWithHexString:@"#eeeeee"];
        
        [bgview addSubview:lineView];
        NSArray * array = [NSArray arrayWithArray:testArray[i]];
        
        for (int j = 0; j<array.count;j++ ) {
            int row=j/lieshu;//行号
           
            int loc=j%lieshu;//列号
            
            UIButton * button = [[UIButton alloc]init];
            button.tag = bgview.tag + j +1;
            [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal ];
              [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateSelected];
            SearchNameModel * model = [SearchNameModel mj_objectWithKeyValues:array[j]];
            if (i ==0) {
                NSString * serchname = array[j][@"serviceName"];
                [button setTitle:serchname forState:UIControlStateNormal];
            }else if (i==2){
                
                [button setTitle:model.chineseLevelName forState:UIControlStateNormal];
            }else if (i==3){
               [button setTitle:model.counselorExperanceName forState:UIControlStateNormal];
            }
            else if (i==4){
                [button setTitle:model.countryName forState:UIControlStateNormal];
            }else if (i==5){
                [button setTitle:model.organizationName forState:UIControlStateNormal];
            }else if (i==6){
                [button setTitle:model.genderName forState:UIControlStateNormal];
            }else if (i==1){
                [button setTitle:model.serviceModeName forState:UIControlStateNormal];
 
                
                
            }



            
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            if (i==0) {
                if ([[seachDict allKeys]containsObject:@"first"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"first"] intValue];
                    if (j == indexbtn) {
                         button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }
                
                
            }else if (i == 2){
                if ([[seachDict allKeys]containsObject:@"foursh"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"foursh"] intValue];
                    if (j == indexbtn) {
                        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }
                
                
                
            }else if (i == 3){
                if ([[seachDict allKeys]containsObject:@"third"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"third"] intValue];
                    if (j == indexbtn) {
                        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }
                
                
                
            }
            else if (i == 4){
                if ([[seachDict allKeys]containsObject:@"second"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"second"] intValue];
                    if (j == indexbtn) {
                        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }

                
                
            }else if (i == 5){
                if ([[seachDict allKeys]containsObject:@"fifth"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"fifth"] intValue];
                    if (j == indexbtn) {
                        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }
                
                
                
            }else if (i == 6){
                if ([[seachDict allKeys]containsObject:@"sixth"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"sixth"] intValue];
                    if (j == indexbtn) {
                        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }
                
                
                
            }else if (i==1){
                
                if ([[seachDict allKeys]containsObject:@"seven"]) {
                    
                    NSInteger  indexbtn = [seachDict[@"seven"] intValue];
                    if (j == indexbtn) {
                        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
                        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
                    }
                    
                }
                

                
                
                
                
            }
            button.layer.borderWidth = 1.0f;
            button.layer.cornerRadius = 10;

            [button addTarget:self action:@selector(click_testBtn:) forControlEvents:UIControlEventTouchUpInside ];
            
            
            
            
            button.frame= CGRectMake(30 + loc * 80, 36* row  +36, 70, 20);
            
            
            [bgview addSubview:button];
        }
      
        
        if (i==0) {
            if (array.count >0) {
              hight1=  ((array.count -1) / lieshu +1)* 36;
            }
       
            bgview.frame = CGRectMake(0, 0, kScreenWidth, hight1 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
        }else if (i==1){
            if (array.count >0) {
                hight2  = ((array.count -1) / lieshu +1)* 36;;
            }

            bgview.frame = CGRectMake(0, hight1 +20, kScreenWidth, hight2 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
        }else if (i==2){
            if (array.count >0) {
                hight3  = ((array.count -1) / lieshu +1)* 36;
            }
            
            bgview.frame = CGRectMake(0, hight1 +hight2+26*(i ), kScreenWidth, hight3 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
        }else if (i==3){
            if (array.count >0) {
                hight4  = ((array.count -1) / lieshu +1)* 36;
            }
            
            bgview.frame = CGRectMake(0, hight1 +hight2 +hight3 +26*(i ), kScreenWidth, hight4 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
        }else if (i==4){
            if (array.count >0) {
                hight5  = ((array.count -1) / lieshu +1)* 36;
            }
            
            bgview.frame = CGRectMake(0, hight1 +hight2 +hight3 + hight4 +26*(i ), kScreenWidth, hight5 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
        }else if (i==5){
            if (array.count >0) {
                hight6  = ((array.count -1) / lieshu +1)* 36;
            }
            
            bgview.frame = CGRectMake(0, hight1 +hight2 +hight3 + hight4 +hight5 +26*(i ), kScreenWidth, hight6 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
        }else if (i==6){
            if (array.count >0) {
                hight7  = ((array.count -1) / lieshu +1)* 36;
            }
            
            bgview.frame = CGRectMake(0, hight1 +hight2 +hight3 + hight4 +hight5+hight6 +26*(i ), kScreenWidth, hight7 +26);
            lineView.frame = CGRectMake(10,bgview.bounds.size.height - 1,  kScreenWidth-10,1);
            
        }





        
            
            
        titleLable.frame = CGRectMake(30, 10, 70, 16);
            
        
        
        }
    
    
       // UILabel * titlelable = [UILabel alloc]initWithFrame:<#(CGRect)#>
        
        
        
    
    
    for (int i= 0; i<lastBtnArray.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        button.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        button.layer.borderWidth = 1.0f;
        button.layer.cornerRadius = 22;
        button.clipsToBounds = YES;
        button.backgroundColor = [UIColor whiteColor];
        button.tag = 100 +i;
        [button setTitle:lastBtnArray[i] forState: UIControlStateNormal];
        [button addTarget:self action:@selector(click_chooseMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState: UIControlStateNormal];
        button.frame= CGRectMake(44+ i* kScreenWidth/2 ,hight1 + hight2 +hight3 +hight4 +hight5 +hight6 + hight7+ 7 * 26 +10, 100, 44);
        [choose_moreView addSubview:button];

    }
    
    choose_moreView.contentSize = CGSizeMake(0, hight1 + hight2 +hight3 +hight4 +hight5 +hight6 + hight7+ 6 * 26 +10 + 100);

    
}

#pragma mark  点击小按钮

-(void)click_testBtn:(UIButton *)sender{
    
    
   
    
    
    
    
    
    
    if (sender.tag >39 && sender.tag < 49){
        for (NSInteger i = 41; i<49; i++) {
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            
        }
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
        selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
        seachDict[@"foursh"] = [NSString stringWithFormat:@"%ld",sender.tag - 41];

        

        
        
        
        
    }else if (sender.tag >49 && sender.tag < 59){
        for (NSInteger i = 51; i<59; i++) {
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            
        }
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
        selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
        
        seachDict[@"third"] = [NSString stringWithFormat:@"%ld",sender.tag - 51];

        
    }else if (sender.tag >59 && sender.tag < 69){
        for (NSInteger i = 61; i<69; i++) {
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            
        }
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
        selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
        //海外
        seachDict[@"second"] = [NSString stringWithFormat:@"%ld",sender.tag - 61];
        
        
    }else if (sender.tag >69 && sender.tag < 80){
        for (NSInteger i = 71; i<80; i++) {
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            
        }
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
        selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
      
        seachDict[@"fifth"] = [NSString stringWithFormat:@"%ld",sender.tag - 71];
        
    }else if (sender.tag >110 && sender.tag < 121){
        for (NSInteger i = 111; i<120; i++) {
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            
        }
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
        selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
        
         seachDict[@"sixth"] = [NSString stringWithFormat:@"%ld",sender.tag - 111];
        
    }else if (sender.tag >80 &&sender.tag < 100) {
      
            for (NSInteger i = 81; i<100; i++) {
                UIButton * button = (UIButton *)[self.view viewWithTag:i];
                //button.backgroundColor = [UIColor redColor];
                button.layer.borderColor = [[UIColor clearColor] CGColor];
                [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
                
            }
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
            seachDict[@"first"] = [NSString stringWithFormat:@"%ld",sender.tag - 81];
            
            
        
    }else if (sender.tag >120){
        for (NSInteger i = 121; i<130; i++) {
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            
        }
        UIButton * selectBtn = (UIButton *)[self.view viewWithTag:sender.tag];
        selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
        seachDict[@"seven"] = [NSString stringWithFormat:@"%ld",sender.tag - 121];
        

        
    }



    

    
     NSLog(@"%@",seachDict);
    
    
    
    
    
    
}
#pragma mark 重置与确定
-(void)click_chooseMoreBtn:(UIButton *)sender{
    
    if (sender.tag == 100) {
        //重置
        for (NSInteger i = 81; i<100; i++) {
            //服务方式
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
             UIButton * selectBtn = (UIButton *)[self.view viewWithTag:81];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
            
            
        }
         for (NSInteger i = 41; i<49; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:41];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];

        }
        for (NSInteger i = 51; i<59; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:51];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];

        }

        for (NSInteger i = 61; i<69; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:61];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];

        }
        for (NSInteger i = 61; i<69; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:61];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
            
        }

        for (NSInteger i = 71; i<79; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:71];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];

        }
        for (NSInteger i = 111; i<119; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:111];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
            
        }

        for (NSInteger i = 121; i<130; i++) {
            
            UIButton * button = (UIButton *)[self.view viewWithTag:i];
            //button.backgroundColor = [UIColor redColor];
            button.layer.borderColor = [[UIColor clearColor] CGColor];
            [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:  UIControlStateNormal];
            UIButton * selectBtn = (UIButton *)[self.view viewWithTag:121];
            selectBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
            [selectBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:  UIControlStateNormal];
            
        }

        
        NSArray * keyArray= [seachDict allKeys];
        NSArray * paramsArray = [self.params allKeys];
        for (int i = 0; i<keyArray.count; i++) {
            [seachDict setValue:@"0" forKey:keyArray[i]];
            NSLog(@"%@",seachDict);
           
            
        }
        for (int j =0;j< paramsArray.count; j++) {
            [self.params setValue:@"0" forKey:paramsArray[j]];
             NSLog(@"%@",self.params);
        }
        
        
    }else{
        
        showList = NO;
         self.params[@"token"]= kToken;
         self.params[@"page"]= @"0";
         self.params[@"serviceType"]= @"";

         self.params[@"gender"]= @"";
        self.params[@"serviceMode"]= @"";

         self.params[@"countryType"]= @"";
         self.params[@"chineseLevelType"]= @"";
         self.params[@"organizationType"]= @"";
         self.params[@"counselorExperanceType"]= @"";
        int  first = [seachDict[@"first"] intValue] ;
        NSArray * seaviceArray =    _searchlistModel.serviceList;
        SearchNameModel * model1 = [SearchNameModel mj_objectWithKeyValues:seaviceArray[first]];
        
         int  foursh = [seachDict[@"foursh"] intValue] ;
        //seachDict[@"foursh"] = [NSString stringWithFormat:@"%ld",sender.tag - 31];
        NSArray * chineseArray =    _searchlistModel.chineselevelList;

         SearchNameModel * model2 = [SearchNameModel mj_objectWithKeyValues:chineseArray[foursh]];
        
        //third second
        int  third = [seachDict[@"third"] intValue] ;
        
        NSArray * experienceArray =    _searchlistModel.counselorExperanceList;
        
        SearchNameModel * model3 = [SearchNameModel mj_objectWithKeyValues:experienceArray[third]];
        
        int  second = [seachDict[@"second"] intValue] ;
        
        NSArray * countryArray =    _searchlistModel.countryTypeList;
        
        SearchNameModel * model4 = [SearchNameModel mj_objectWithKeyValues:countryArray[second]];
        
        int  fifth = [seachDict[@"fifth"] intValue] ;
        
        NSArray * organizationArray =    _searchlistModel.orgList;
        
        SearchNameModel * model5 = [SearchNameModel mj_objectWithKeyValues:organizationArray[fifth]];
        
        
        
        int  sixth = [seachDict[@"sixth"] intValue] ;
        
        NSArray * sixthArray =    _searchlistModel.genderList;
        
        SearchNameModel * model6 = [SearchNameModel mj_objectWithKeyValues:sixthArray[sixth]];
        
        int  seven = [seachDict[@"seven"] intValue] ;
        
        NSArray * sevenArray =    _searchlistModel.serviceModeList;
        
        SearchNameModel * model7 = [SearchNameModel mj_objectWithKeyValues:sevenArray[seven]];

         self.params[@"serviceType"]= model1.serviceType;
         self.params[@"chineseLevelType"]= model2.chineseLevelType;
         self.params[@"counselorExperanceType"]= model3.counselorExperanceType;
         self.params[@"countryType"]= model4.countryType;
         self.params[@"organizationType"]= model5.organizationType;
        self.params[@"gender"]= model6.genderType;
        self.params[@"serviceMode"]= model7.serviceMode;
        if (first == 0) {
              self.params[@"serviceType"]= @"";
        }else if(foursh == 0){
              self.params[@"chineseLevelType"]= @"";
        }else if (third ==0){
              self.params[@"counselorExperanceType"]=@"";
            
            
        }else if (second == 0){
              self.params[@"countryType"]=@"";
            
        }else if (fifth ==0){
             self.params[@"organizationType"]= @"";
            
            
        }else if (sixth ==0){
               self.params[@"gender"]= @"";
        }else if (seven ==0){
            self.params[@"serviceMode"]= @"";
        }
        
        NSLog(@"params====%@", self.params);
       
        [SVProgressHUD show];
        
        
        self.params[@"page"] = @"0";
        [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params: self.params success:^(id json) {
            NSLog(@"%@",kToken);
            
            NSLog(@"%@",json);
            [SVProgressHUD dismiss];
            if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
                self.number = 1;
                [self.consultantArray removeAllObjects];
                NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
                for (NSDictionary * dict in tuijian) {
                    CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                    [self.consultantArray addObject:model];
                }
               // [choose_moreView removeFromSuperview];
                choose_moreView.hidden = YES;
                _mengbanView.hidden = YES;
                UIButton * tempbutton =(UIButton *)[self.view viewWithTag:202];
                tempbutton.selected = NO;
                
                UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:205];
                [tempimage setImage:[UIImage imageNamed:@"normalArrow"]];
                UIButton * tempbutton200 =(UIButton *)[self.view viewWithTag:200];
                if ([model1.serviceName isEqualToString:@"不限"]) {
                    [tempbutton200 setTitle:@"所有顾问"forState:UIControlStateNormal];
                }else{
                    
                    [tempbutton200 setTitle:model1.serviceName forState:UIControlStateNormal];
                }
                UIButton * tempbutton201 =(UIButton *)[self.view viewWithTag:201];
                if ([model4.countryName isEqualToString:@"不限"]) {
                     [tempbutton201 setTitle:@"顾问国籍" forState:UIControlStateNormal];
                }else{
                    
                    [tempbutton201 setTitle:model4.countryName forState:UIControlStateNormal];
                }

                [choose_moreView removeFromSuperview];
                choose_moreView = nil;
                

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [_consultantTableView reloadData];
                    if (tuijian.count >0) {
                         _notfindView.hidden = YES;
                        [_consultantTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                        [_consultantTableView setContentOffset:CGPointMake(0, 0)];
                    }else{
                        
                        
                        _notfindView.hidden = NO;
                    }

                    
                });

                
                
            }else{
                
                
                
                
                
                [self showSVErrorString:@"网络繁忙，请重试"];
            }

        
            //                [self setconsutantUI];
        } failure:^(NSError *error) {
            
            
            [SVProgressHUD dismiss];
            
            
            
        }];
        

       
        
        
        
        
        
        
        
    }
    
    
    
    
}
#pragma mark 筛选顾问 点击 所有顾问
-(void)click_chooseBtn:(UIButton *)sender{
//    if (sender.selected) {
//        sender.selected = NO;
//    }else{
//        sender.selected = YES;
//    }
    //[arrowImage setImage:[UIImage imageNamed:@"selsect_arrow"]];
    _mengbanView.hidden = YES;
    //seachTableview.hidden = YES;
    seachArray = [NSMutableArray array];
    for (NSInteger i = 200; i< 203; i++) {
        UIButton * tempbutton =(UIButton *)[self.view viewWithTag:i];
        tempbutton.selected = NO;
        
       
    }
    UIButton * tembutton = (UIButton *)[self.view viewWithTag:sender.tag];
    tembutton.selected = YES;
    seachTableview.tag = sender.tag + 10;
    for (NSInteger i = 203; i<206; i++) {
        UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:i];
        [tempimage setImage:[UIImage imageNamed:@"normalArrow"]];
    }
    UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:sender.tag +3];
    [tempimage setImage:[UIImage imageNamed:@"selsect_arrow"]];
    
    if (sender.tag == 200) {
        NSMutableArray * serviceList = [NSMutableArray array];
        // NSArray * array = _searchlistModel.serviceList;
        for (NSDictionary * dict in _searchlistModel.serviceList) {
            [serviceList addObject:dict[@"serviceName"]];
        }
        [seachArray addObjectsFromArray:serviceList];
        seachTableview.height = seachArray.count * 44 ;
        [seachTableview reloadData];
        [choose_moreView removeFromSuperview];
        choose_moreView = nil;
         choose_moreView = nil;
        if (seachTableview.hidden) {
            _mengbanView.hidden = NO;
        seachTableview.hidden = NO;
            UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:sender.tag +3];
            [tempimage setImage:[UIImage imageNamed:@"selsect_arrow"]];

        }else{
             _mengbanView.hidden = YES;
         seachTableview.hidden = YES;
            UIButton * tempbutton =(UIButton *)[self.view viewWithTag:sender.tag];
            tempbutton.selected = NO;

            UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:sender.tag +3];
            [tempimage setImage:[UIImage imageNamed:@"normalArrow"]];
         
            
        }
//         [choose_moreView removeFromSuperview];
    }else if (sender.tag == 201){
        NSMutableArray * countryTypeList = [NSMutableArray array];
        // NSArray * array = _searchlistModel.serviceList;
        for (NSDictionary * dict in _searchlistModel.countryTypeList) {
            [countryTypeList addObject:dict[@"countryName"]];
        }
          [choose_moreView removeFromSuperview];
        choose_moreView = nil;
        [seachArray addObjectsFromArray:countryTypeList];
         seachTableview.height = seachArray.count * 44 ;
        [seachTableview reloadData];
        if (seachTableview.hidden == YES) {
            _mengbanView.hidden = NO;

            seachTableview.hidden = NO;
            UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:sender.tag +3];
            [tempimage setImage:[UIImage imageNamed:@"selsect_arrow"]];
            
        }else if (seachTableview.hidden == NO){
            _mengbanView.hidden = YES;

            seachTableview.hidden = YES;
            UIButton * tempbutton =(UIButton *)[self.view viewWithTag:sender.tag];
            tempbutton.selected = NO;
            
            UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:sender.tag +3];
            [tempimage setImage:[UIImage imageNamed:@"normalArrow"]];
            
            
        }

        //[choose_moreView removeFromSuperview];
    }else{
        
         seachTableview.hidden = YES;
        
        if (!choose_moreView) {
            
            [self setUP_chooseMoreUI];
            choose_moreView.hidden = NO;
            _mengbanView.hidden = YES;
        }else{
            
            
            
            UIButton * tempbutton =(UIButton *)[self.view viewWithTag:sender.tag];
            tempbutton.selected = NO;
            
            UIImageView * tempimage =(UIImageView *)[self.view viewWithTag:sender.tag +3];
            [tempimage setImage:[UIImage imageNamed:@"normalArrow"]];

            seachTableview.hidden = YES;
            [choose_moreView removeFromSuperview];
            choose_moreView = nil;


 
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _consultantTableView) {
        
        return self.consultantArray.count;
    }else if (tableView == seachTableview){
        if (seachArray.count>0) {
            return seachArray.count;
        }else{
            
            return 3;
        }
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.ListModel = self.consultantArray[indexPath.row];
        return cell;

    }else if (tableView == seachTableview){
       
            UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"seachCell"];
        
        if (seachArray.count >0) {
            
            cell.textLabel.text =seachArray[indexPath.row];
            if ([[seachDict allKeys]containsObject:@"first"] || [[seachDict allKeys]containsObject:@"second"]) {
                if ([[seachDict allKeys]containsObject:@"first"]) {
                    if([[seachDict allKeys]containsObject:@"second"]){
                        if (seachTableview.tag == 210) {
                            NSInteger index = [seachDict[@"first"] intValue];
                            if (indexPath.row == index) {
                                cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                            }
                        }else if (seachTableview.tag == 211){
                            NSInteger index = [seachDict[@"second"] intValue];
                            if (indexPath.row == index) {
                                cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                            }

                        }
                        
                        
                        
                    }else{
                        
                        if (seachTableview.tag == 210) {
                            NSInteger index = [seachDict[@"first"] intValue];
                            if (indexPath.row == index) {
                                cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                            }
                        }
                        
                        
                        if (seachTableview.tag == 211) {
                            if (indexPath.row == 0) {
                                cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                            }

                        
                        
                    }
                }
                }else if ([[seachDict allKeys]containsObject:@"second"]){
                    if (seachTableview.tag == 210) {
                        if (indexPath.row == 0) {
                            cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                        }
                        

                    }else if (seachTableview.tag == 211){
                        NSInteger index = [seachDict[@"second"] intValue];
                        if (indexPath.row == index) {
                            cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                        }

                        
                    }
                    
                    
                    
                    
                    
                }
                
                
               
            }else {
                
                
                //  都不含
                
                if (indexPath.row == 0) {
                    cell.textLabel.textColor = [UIColor colorWithHexString:@"26bdab"];
                }

                
            }
        
        
        
        
        
        }
        
            
      
        return cell;
    }

    return nil;
    
    }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _consultantTableView) {
        UGNewPageConTableViewCell * cell = [[UGNewPageConTableViewCell alloc]init];
         cell.ListModel = self.consultantArray[indexPath.row];

        
                return cell.totleHight;
    }else if (tableView == seachTableview){
        return 44;
    }
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _consultantTableView) {
        
      
        CounselorListModel * model = self.consultantArray[indexPath.row];
        
        NSLog(@"%@",model.counselorId);
        
        UGCounselorDetailNewViewController * counselorDetailNewVC = [[UGCounselorDetailNewViewController alloc]init];
        counselorDetailNewVC.counselorId =model.counselorId;
       
        counselorDetailNewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:counselorDetailNewVC animated:YES];
        

        
        
        
        
        
        
        
        
        
        
       
    }else if (tableView == seachTableview){
        
        showList = NO;
        _notfindView.hidden = YES;
        
        //(@"%ld",(long)seachTableview.tag);
        
      
        self.params[@"token"]= kToken;
        self.params[@"page"]= @"0";
        self.number = 1;
//        if (self.params[@"serviceType"]) {
//            <#statements#>
//        }
//        self.params[@"serviceType"]= @"";
        
        _mengbanView.hidden = YES;
        if (seachTableview.tag == 210) {
            
                
                seachDict[@"first"] = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
            NSArray *  serviceList = _searchlistModel.serviceList;
            
            NSDictionary * dict =serviceList[indexPath.row];
            NSLog(@"%@",dict);
                NSString * serveice = dict[@"serviceType"];
                self.params[@"serviceType"]= serveice ;
            
            if (indexPath.row ==0) {
                UIButton * ServeiceUIButton = (UIButton *)[self.view viewWithTag:200];
                [ServeiceUIButton setTitle:@"所有服务" forState:UIControlStateNormal];
            }else{
                NSString * buttontitle  =  seachArray[indexPath.row];
                UIButton * ServeiceUIButton = (UIButton *)[self.view viewWithTag:200];
                [ServeiceUIButton setTitle:buttontitle forState:UIControlStateNormal];
                
            }
           
            seachDict[@"foursh"] = @"";
            seachDict[@"third"] = @"";
            seachDict[@"fifth"]= @"";
            seachDict[@"sixth"]= @"";
            seachDict[@"seven"]= @"";
                self.params[@"chineseLevelType"]= @"";
            
                self.params[@"counselorExperanceType"]=@"";
                
                
           
               self.params[@"organizationType"]= @"";
                
          
            
                
                
           
                self.params[@"gender"]= @"";
           
                self.params[@"serviceMode"]= @"";
          

            
            
            [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params: self.params success:^(id json) {
                NSLog(@"%@",kToken);
                NSLog(@"%@",json);
                
                if ([json[@"header"][@"code"]  isEqualToString:@"200"]){
                    [self.consultantArray removeAllObjects];
                    NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
                    for (NSDictionary * dict in tuijian) {
                        CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                        [self.consultantArray addObject:model];
                    }
                    
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                      
                        
                        [_consultantTableView reloadData];
                        
                        
                        if (tuijian.count >0) {
                             _notfindView.hidden = YES;
                            [_consultantTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                            [_consultantTableView setContentOffset:CGPointMake(0, 0)];
                        }else{
                            
                            
                            _notfindView.hidden = NO;
                            
                            
                            
                        }


                        
                    });

                                      //
                }else{
                    
                    
                    
                    
                    
                    [self showSVErrorString:@"网络繁忙，请重试"];
                }

//                [self setconsutantUI];
            } failure:^(NSError *error) {
            }];
            
            

            
            
            
            
            
            
        }else if (seachTableview.tag == 211){
            
            if (indexPath.row ==0) {
                UIButton * ServeiceUIButton = (UIButton *)[self.view viewWithTag:201];
                [ServeiceUIButton setTitle:@"顾问国籍 " forState:UIControlStateNormal];

            }else{
                NSString * buttontitle  =  seachArray[indexPath.row];
                UIButton * ServeiceUIButton = (UIButton *)[self.view viewWithTag:201];
                [ServeiceUIButton setTitle:buttontitle forState:UIControlStateNormal];
                
            }

            
            
            
         seachDict[@"second"] = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
           // seachTableview.frame = CGRectMake(0, 49, kScreenWidth, 200 -55);
            NSArray *  countryType = _searchlistModel.countryTypeList;
            
            NSDictionary * dict =countryType[indexPath.row];
            NSLog(@"%@",dict);
            NSString * countryTypestr = dict[@"countryType"];
           // self.params[@"serviceType"]= serveice ;

            self.params[@"countryType"]= countryTypestr;
            if (indexPath.row == 0) {
                  self.params[@"countryType"]= @"";
            }
            self.params[@"chineseLevelType"]= @"";
            
            self.params[@"counselorExperanceType"]=@"";
            
            
            
            self.params[@"organizationType"]= @"";
            
            
            
            
            
            
            self.params[@"gender"]= @"";
            
            self.params[@"serviceMode"]= @"";
            

            
            [HttpClientManager postAsyn:UG_getSearchCounselorList_URL params: self.params success:^(id json) {
                NSLog(@"%@",kToken);
                NSLog(@"%@",json);
                if ([json[@"header"][@"code"]  isEqualToString:@"200"]){
                    [self.consultantArray removeAllObjects];
                    
                    NSArray * tuijian  = json[@"body"][@"counselorListInfoList"];
                    [self.consultantArray removeAllObjects];
                    for (NSDictionary * dict in tuijian) {
                        CounselorListModel * model = [CounselorListModel mj_objectWithKeyValues:dict];
                        [self.consultantArray addObject:model];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        
                        [_consultantTableView reloadData];
                        
                        if (tuijian.count >0) {
                             _notfindView.hidden = YES;
                            [_consultantTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                            [_consultantTableView setContentOffset:CGPointMake(0, 0)];
                        }else{
                            
                            
                            
                         _notfindView.hidden = NO;
                            
                            
                            
                            
                            
                        }

                        
                    });
                    
                }else{
                    
                    
                    
                    
                    
                    [self showSVErrorString:@"网络繁忙，请重试"];
                }

                //                [self setconsutantUI];
            } failure:^(NSError *error) {
            }];
            

            
            
            
            
        }
        
        
        seachTableview .hidden = YES;
        NSLog(@"%@",seachDict);
    }

    
    
}

-(void)needRightAction:(BOOL)isNeed{
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"seach_fangdajing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(jumptoseach)];
        self.navigationItem.rightBarButtonItem = backItem;
        
        
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    }
    
    
    
    
    
}
-(void)jumptoseach{
    
    UGSearchViewController * vc = [[UGSearchViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    
    [self pushToNextViewController:vc];

    
    
    
}
-(void)endRefresh{
    [self.consultantTableView.mj_header endRefreshing];
    [self.consultantTableView.mj_footer endRefreshing];
}

#pragma mark 帅选 顾问的 网络请求
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

@end
