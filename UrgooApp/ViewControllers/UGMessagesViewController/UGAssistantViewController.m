//
//  UGAssistantViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAssistantViewController.h"
#import "UGSystemViewController.h"
#import "UGTasksViewController.h"
#import "UGAcountViewController.h"
#import "UGMessageDetaillViewController.h"
#import "UGTasksDetaillViewController.h"

@interface UGAssistantViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *bigScrollView;//底部的scrollView
@property(strong,nonatomic)UIImageView  *redImageView;//设置消息的红点,system
@property(strong,nonatomic)UIImageView  *redImageViewT;//设置消息的红点,task
@property(strong,nonatomic)UIImageView  *redImageViewA;//设置消息的红点,account

@property(strong,nonatomic)UGSystemViewController *systemVC;
@property(strong,nonatomic)UGTasksViewController *tasksVC;
@property(strong,nonatomic)UGAcountViewController *accountVC;

@property(strong,nonatomic)BodyInformationModel *bodyInformationModel;

@end

@implementation UGAssistantViewController

-(void)backAction
{
    if (_isJPush) {
        [[AppDelegate sharedappDelegate] showTabBar];
        [AppDelegate sharedappDelegate].tabbar.selectedIndex = 3;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //获取消息数据
    [self getNet_InformationData_isShowRedDot:0];//系统消息
    //[self getNet_InformationData_task:0];//task消息
    //[self getNet_InformationData_account:0];//account消息
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"通知"];
    
    [self getNet_InformationData_system:0];//系统消息
    [self getNet_InformationData_task:0];//task消息
    
    [self initUI];

}
#pragma mark - initUI
-(void)initUI
{
    NSArray *titleArr = @[@"系统消息",@"个人消息"];
    for (NSInteger i=0; i<titleArr.count; i++) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectBtn.frame = CGRectMake(i*kScreenWidth/2, 0, kScreenWidth/2, 39.5);
        [selectBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [selectBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateSelected];
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"a5a5a5"] forState:UIControlStateNormal];
        
        selectBtn.tag =100+i;
        [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectBtn];
        
        if (i==0) {//RGB(37, 175, 153)
            selectBtn.selected = YES;
            //selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        
    }
    
    //小圆点
    //_redImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3-35, 10, 6 , 6)];
    _redImageView=[[UIImageView alloc]init];
    _redImageView.size = CGSizeMake(6, 6);
    _redImageView.centerX = kScreenWidth/4 + 35 ;
    _redImageView.centerY = 39/2 - 5;
    _redImageView.image = [UIImage imageNamed:@"message_new_info"];
    _redImageView.layer.masksToBounds = YES;
    _redImageView.layer.cornerRadius = 3;
    _redImageView.userInteractionEnabled = YES;
    _redImageView.hidden = NO;
    //[self setMessageMark:YES];
    
    //    _redImageViewT=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3-40+kScreenWidth/3, 10, 6 , 6)];
    _redImageViewT=[[UIImageView alloc]init];
    _redImageViewT.size = CGSizeMake(6, 6);
    _redImageViewT.centerX = kScreenWidth/4*3 + 35 ;
    _redImageViewT.centerY = 39/2 - 5;
    _redImageViewT.image = [UIImage imageNamed:@"message_new_info"];
    _redImageViewT.layer.masksToBounds = YES;
    _redImageViewT.layer.cornerRadius = 3;
    _redImageViewT.userInteractionEnabled = YES;
    _redImageViewT.hidden = NO;
    
    //    _redImageViewA=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/3-30+kScreenWidth/3*2, 10, 6 , 6)];
    _redImageViewA=[[UIImageView alloc]init];
    _redImageViewA.size = CGSizeMake(6, 6);
    _redImageViewA.centerX = kScreenWidth/6 * 5 + 20 ;
    _redImageViewA.centerY = 39/2 - 5;
    _redImageViewA.image = [UIImage imageNamed:@"message_new_info"];
    _redImageViewA.layer.masksToBounds = YES;
    _redImageViewA.layer.cornerRadius = 3;
    _redImageViewA.userInteractionEnabled = YES;
    _redImageViewA.hidden = YES;
    
    UILabel *lineLabel1 =[[UILabel alloc]initWithFrame:CGRectMake(0, 39.5, kScreenWidth, 0.5)];
    lineLabel1.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [self.view addSubview:lineLabel1];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bigScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-64-40)];
    self.bigScrollView.contentSize = CGSizeMake(2*kScreenWidth, 0);
    self.bigScrollView.delegate = self;
    self.bigScrollView.pagingEnabled = YES;
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.bigScrollView];
    
    //三种controller
    
    _systemVC =[[UGSystemViewController alloc]init];
    _systemVC.view.frame = CGRectMake(0, 0, _bigScrollView.width, _bigScrollView.height);
    _systemVC.assistantVC = self;
    __weak typeof(self) weakSelf = self;
    _systemVC.modelBlock = ^(InformationModel *model){
        UGMessageDetaillViewController *VC = [[UGMessageDetaillViewController alloc] init];
        VC.informationModel = model;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    [self.bigScrollView addSubview:_systemVC.view];
    
    
    _tasksVC =[[UGTasksViewController  alloc]init];
    _tasksVC.view.frame = CGRectMake(kScreenWidth, 0, _bigScrollView.width, _bigScrollView.height);
    
    
    _tasksVC.assistantVC = self;
    _tasksVC.modelBlock = ^(MesgAccountModel *model){
        UGMessageDetaillViewController *VC = [[UGMessageDetaillViewController alloc] init];
        VC.mesgAccountModel = model;
        [weakSelf.navigationController pushViewController:VC animated:YES];
        /*
        UGTasksDetaillViewController *VC = [[UGTasksDetaillViewController alloc] init];
        VC.mesgAccountModel = model;
        [weakSelf.navigationController pushViewController:VC animated:YES];
         */
    };
    
    [self.bigScrollView addSubview:_tasksVC.view];
    
    
    _accountVC =[[UGAcountViewController alloc]init];
    _accountVC.view.frame = CGRectMake(kScreenWidth*2, 0, _bigScrollView.width, _bigScrollView.height);
    _accountVC.assistantVC = self;
    _accountVC.modelBlock = ^(MesgAccountModel *model){
        UGMessageDetaillViewController *VC = [[UGMessageDetaillViewController alloc] init];
        VC.mesgAccountModel = model;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    //[self.bigScrollView addSubview:_accountVC.view];
    
    
}
-(void)getNet_InformationData_isShowRedDot:(int)page{//system
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"type"] = @"";
    params[@"termType"] = @"2";
    params[@"page"] = @(page);
    
    [HttpClientManager postAsyn:UG_informationTablePerson_URL params:params success:^(id json) {
        if (json) {
            DLog(@"系统消息：%@",json);
            
            //判断有无消息
            NSString *systemCount = [NSString stringWithFormat:@"%@",json[@"body"][@"systemCount"]];
            if ([systemCount intValue] > 0){
                [self addMessageMark:YES who:@"s"];
            }else if ([systemCount intValue] == 0){
                [self addMessageMark:NO who:@"s"];
            }
            
            NSString *personCount = [NSString stringWithFormat:@"%@",json[@"body"][@"personCount"]];
            if ([personCount intValue] > 0){
                [self addMessageMark:YES who:@"t"];
            }else if ([personCount intValue] == 0){
                [self addMessageMark:NO who:@"t"];
            }
        }
    } failure:^(NSError *error) {
        [self showSVErrorString:@"Network request failed, please try again later"];
    }];
}

#pragma mark -message消息的数据
-(void)getNet_InformationData_system:(int)page{//system
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"type"] = @"";
    params[@"termType"] = @"2";
    params[@"page"] = @(page);
    
    [HttpClientManager postAsyn:UG_informationTablePerson_URL params:params success:^(id json) {
        if (json) {
            DLog(@"系统消息：%@",json);
            [BodyInformationModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"information" : @"InformationModel",
                         };
            }];
            _bodyInformationModel = [BodyInformationModel mj_objectWithKeyValues:json[@"body"]];
            NSArray *informationModelArr = _bodyInformationModel.information;
            [_systemVC initUI:informationModelArr andPage:page];
            
        }
    } failure:^(NSError *error) {
        [self showSVErrorString:@"Network request failed, please try again later"];
    }];
}
-(void)getNet_InformationData_task:(int)page{//tesk
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"type"] = @"0";
    params[@"termType"] = @"2";
    params[@"page"] = @(page);
    
    [HttpClientManager postAsyn:UG_informationTablePerson_URL params:params success:^(id json) {
        if (json) {
            NSArray *informationModelArr = [MesgAccountModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"information"]];
    
            
            [_tasksVC initUI:informationModelArr andPage:page];
        }
    } failure:^(NSError *error) {
        [self showSVErrorString:@"Network request failed, please try again later"];
    }];
}
-(void)getNet_InformationData_account:(int)page{//account
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"type"] = @"2";
    params[@"termType"] = @"2";
    params[@"page"] = @(page);
    
    [HttpClientManager postAsyn:UG_informationTable_URL params:params success:^(id json) {
        if (json) {
            NSArray *informationModelArr = [MesgAccountModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"information"]];
            [_accountVC initUI:informationModelArr andPage:page];
        }
    } failure:^(NSError *error) {
        [self showSVErrorString:@"Network request failed, please try again later"];
    }];
}


#pragma mark -消息_红点_是否显示
-(void)addMessageMark:(BOOL)isOr who:(NSString *)who{
    if ([who isEqual:@"s"]) {
        if (isOr) {
            [self.view addSubview:_redImageView];
        }else{
            [_redImageView removeFromSuperview];
        }
    }
    if ([who isEqual:@"t"]){
        if (isOr) {
            [self.view addSubview:_redImageViewT];
        }else{
            [_redImageViewT removeFromSuperview];
        }
    }
    if ([who isEqual:@"a"]){
        if (isOr) {
            [self.view addSubview:_redImageViewA];
        }else{
            [_redImageViewA removeFromSuperview];
        }
    }
    
}
-(void)selectAction:(UIButton *)button
{
    for (NSInteger i=0; i<3; i++) {
        UIButton *tmpBtn = (UIButton *)[self.view viewWithTag:100 + i];
        //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        tmpBtn.selected = NO;
    }
    button.selected = YES;
    
    NSInteger select =button.tag -100;
    [_bigScrollView setContentOffset:CGPointMake(select*kScreenWidth, 0) animated:YES];

}

#pragma mark - scrollDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/kScreenWidth;
    for (NSInteger i =100; i<103; i++) {
        UIButton *tmpBtn  = (UIButton *)[self.view viewWithTag:i];
        tmpBtn.selected = NO;
        //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    UIButton *selectBtn = (UIButton *)[self.view viewWithTag:100+index];
    selectBtn.selected = YES;
    //selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_bigScrollView setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
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
