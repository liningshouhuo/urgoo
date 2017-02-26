//
//  UGNewServiceViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/2.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGNewServiceViewController.h"
#import "UGMyServiceViewController.h"
#import "Masonry.h"
#import "UGTasksTableViewCell.h"
#import "UGMyreportViewController.h"
#import "TaskplanningModel.h"
@interface UGNewServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView * tableview;
@property (strong,nonatomic) NSMutableArray * groupArray;

@end

@implementation UGNewServiceViewController



-(NSMutableArray *)groupArray{
    
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
        
    }
    
    
    return _groupArray;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self needBackAction:NO];
    [self needRightAction:NO];
    
    [self setCustomTitle:@"规划"];
    [self initUI];
    if ([_formType isEqualToString:@"111"]) {
        [self needBackAction:YES];
    }
   // [self loadrequrest];
   
}
-(void)loadrequrest{
    
    NSMutableDictionary * pramas = [NSMutableDictionary dictionary];
    
    pramas[@"token"] = @"p2OdthB5P+A=";
    
    pramas[@"termType"] = @"2";
    
    [HttpClientManager getAsyn:getStudentTaskListNewest params:pramas success:^(id json) {
        NSLog(@"%@",json);
        NSArray * totalGroup = [NSArray array];
        totalGroup = json[@"body"][@"taskList"];
        for (NSDictionary * dict in totalGroup) {
            
            TaskplanningModel * model = [TaskplanningModel mj_objectWithKeyValues:dict];
            
            [self.groupArray addObject:model];
        }
        
        
        [self setNewUI];
        
                
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
    
}
-(void)setNewUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    UIView * headBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headBgView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [self.view addSubview:headBgView];
    UITapGestureRecognizer * planRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_renBtn)];
    [headBgView addGestureRecognizer:planRecognizer];
    
    
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:headBgView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = headBgView.bounds;
    maskLayer.path = maskPath.CGPath;
    headBgView.layer.mask = maskLayer;
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cycle_plan_photo"]];
    [headBgView addSubview:imageView];
    
    UIView * bgWhiteView = [[UIView alloc]init];
    bgWhiteView.backgroundColor = [UIColor whiteColor];
    bgWhiteView.layer.cornerRadius = 5;
    [headBgView addSubview:bgWhiteView];
    
    UILabel * recentLable= [[UILabel alloc]init];
    
    recentLable.textColor = [UIColor colorWithHexString:@"#26bdab"];
    recentLable.text = @"最近规划";
    recentLable.textAlignment = NSTextAlignmentCenter;
    recentLable.font = [UIFont systemFontOfSize:11];
    [bgWhiteView addSubview:recentLable];
    
    
    UIImageView * giftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gift_photo"]];
    
    [headBgView addSubview:giftImage];
    
    
    UILabel * distanceLable = [[UILabel alloc]init];
    distanceLable.textColor = [UIColor colorWithHexString:@"#0e8072"];
    distanceLable.text = @"距离";
    distanceLable.textAlignment = NSTextAlignmentLeft;
    distanceLable.font = [UIFont systemFontOfSize:13];
    [headBgView addSubview:distanceLable];
    
    UILabel * dateLable = [[UILabel alloc]init];
    dateLable.textColor = [UIColor whiteColor];
    dateLable.text = @"2016年9月10日";
    dateLable.textAlignment = NSTextAlignmentLeft;
    dateLable.font = [UIFont systemFontOfSize:13];
    [headBgView addSubview:dateLable];
    
    
    UILabel * dayLable = [[UILabel alloc]init];
    dayLable.textColor = [UIColor whiteColor];
    dayLable.text = @"62天";
    dayLable.textAlignment = NSTextAlignmentLeft;
    dayLable.font = [UIFont systemFontOfSize:13];
    [headBgView addSubview:dayLable];

    
    UIImageView * lineView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"white_xu_line"]];
    
    [headBgView addSubview:lineView];

    
    
    UILabel * gradeLable = [[UILabel alloc]init];
    
    gradeLable.textColor = [UIColor whiteColor];
    gradeLable.text = @"托福-90分";
    gradeLable.textAlignment = NSTextAlignmentRight;
    gradeLable.font = [UIFont systemFontOfSize:18];
    [headBgView addSubview:gradeLable];

    
    
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headBgView.mas_top).offset(16);
        make.left.mas_equalTo(headBgView.mas_left).offset(40);
        make.size.mas_equalTo(CGSizeMake(15, 40));
         }];
    
    //z
    [bgWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headBgView.mas_top).offset(16);
        make.left.mas_equalTo(imageView.mas_right).offset(8);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];

    [recentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhiteView.mas_top).offset(3.5);
        make.left.mas_equalTo(bgWhiteView.mas_left);
        make.size.mas_equalTo(CGSizeMake(60, 13));
    }];
    [giftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bgWhiteView.mas_bottom).offset(-2);
        make.left.mas_equalTo(bgWhiteView.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(17, 18));
    }];

    [distanceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhiteView.mas_bottom).offset(6);
        make.left.mas_equalTo(bgWhiteView.mas_left);
        make.size.mas_equalTo(CGSizeMake(26, 15));

    }];
    [dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhiteView.mas_bottom).offset(6);
        make.left.mas_equalTo(distanceLable.mas_right).offset(3);
        make.size.mas_equalTo(CGSizeMake(95, 15));
        
    }];
    [dayLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhiteView.mas_bottom).offset(6);
        make.right.mas_equalTo(headBgView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake(30, 15));
        
    }];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dayLable.mas_top).offset(9);
        make.left.mas_equalTo(dateLable.mas_right).offset(3);
        make.right.mas_equalTo(dayLable.mas_left).offset(-3);
        make.height.mas_equalTo(1);
    }];
    [gradeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgWhiteView.mas_top);
       // make.left.mas_equalTo(dateLable.mas_right).offset(3);
        make.right.mas_equalTo(dayLable.mas_right);
        make.size.mas_equalTo(CGSizeMake(200, 18));
    }];

    
    
   
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 60)/2,75, 60, 17)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click_renBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [headBgView addSubview:button];
    UILabel * Recent_tasksLable = [[UILabel alloc]init];
    Recent_tasksLable.textColor = [UIColor colorWithHexString:@"#cccccc"];
    Recent_tasksLable.font = [UIFont systemFontOfSize:17];
    Recent_tasksLable.text = @"最近任务";
    
    [self.view addSubview:Recent_tasksLable];
    _tableview = [[UITableView alloc]init];
    _tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorStyle =   UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.bounces = NO;
    _tableview.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [_tableview registerClass:[UGTasksTableViewCell class] forCellReuseIdentifier:@"UG_task"];

    [self.view addSubview:_tableview];
    [Recent_tasksLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headBgView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(kScreenWidth/2).offset(-1);
        make.size.mas_equalTo(CGSizeMake(70, 17));
    }];
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Recent_tasksLable.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight - 64 - 100 -44));
    }];

    
}
-(void)initUI{
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Group_17"]];
    
    
    imageView.frame = CGRectMake(20, (kScreenHeight -  1.38 *(kScreenWidth-40) -64- 44)/2 -30, kScreenWidth-40, 1.38 *(kScreenWidth-20));
    UILabel * lable = [[UILabel alloc]init];
    
    
    lable.frame = CGRectMake((kScreenWidth - 60)/2, imageView.origin.y + imageView.size.height + 10, 60, 17);
    lable.text = @"敬请期待";
    lable.textColor = [UIColor colorWithHexString:@"#cccccc"];
    
    lable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lable];
    
    
    [self.view addSubview:imageView];
    
    
}
-(void)testBtn{
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0,kScreenHeight - 64 - 17 - 30, 60, 17)];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click_renBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)click_renBtn{
    UGMyServiceViewController * vc = [[UGMyServiceViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self pushToNextViewController:vc];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.groupArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UGTasksTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UG_task"];
    if (cell ==nil) {
        cell = [[UGTasksTableViewCell alloc]initWithFrame:CGRectZero];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.taskModel = self.groupArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UGMyreportViewController * vc = [[UGMyreportViewController alloc]init];
        
        [self pushToNextViewController:vc];
        
        
    }
    
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
