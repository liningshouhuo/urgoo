//
//  UgComordViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UgComordViewController.h"
#import "Masonry.h"
#import "OrderInfoModel.h"
#import "UGPayViewController.h"
#import "UGCounselorDetailNewViewController.h"

@interface UgComordViewController ()
@property (strong,nonatomic) OrderInfoModel * orderModel;
@property (strong,nonatomic) NSString * orderId;
@end

@implementation UgComordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
[self setCustomTitle:@"订单"];
    [self setNewUI];
    
    NSMutableDictionary * pramas = [NSMutableDictionary dictionary];
    
    pramas[@"token"] = kToken;
     pramas[@"serviceId"] = self.serviceid;
     pramas[@"counselorId"] =self.counselorId;
    
    NSLog(@"%@  %@ %@",pramas[@"token"],pramas[@"serviceId"],pramas[@"counselorId"]);
    [HttpClientManager getAsyn:UG_confirmService_URL params:pramas success:^(id json) {
        
        
        NSLog(@"%@",json);
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            
          _orderModel = [OrderInfoModel mj_objectWithKeyValues:json[@"body"][@"orderInfo"]];
            
            [self setViewDtl:_orderModel];
        }
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
   
    
}
-(void)setViewDtl:( OrderInfoModel * )orderModel{
    
//    NSArray *familyNames = [UIFont familyNames];
//    for( NSString *familyName in familyNames ){
//        
//        NSLog(@"Family: %s \n", [familyName UTF8String] );
//        
//        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//        for( NSString *fontName in fontNames ){
//            
//            NSLog(@"\tFont: %s \n", [fontName UTF8String] );
//        }
//    }
    UIView * firstBGView = [[UIView alloc]init];
    
   
    [self.view addSubview:firstBGView];
    
    [firstBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(128);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 100));
    }];

    
    
    
    NSArray * titleArray = @[@"顾问:",@"购买服务:",@"服务费用:",@"服务年限:",@"订单编号:",@"下单时间:"];
    
    UILabel * nameTitle = [[UILabel alloc]init];
    nameTitle.text = titleArray[0];
    nameTitle.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:14];
    nameTitle.textColor = [UIColor colorWithHexString:@"#999999"];
    [firstBGView addSubview:nameTitle];
    
    [nameTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(firstBGView.mas_left).offset(25);
        make.centerY.mas_equalTo(firstBGView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(45, 17));
    }];
    
    UIImageView * iconView =[[UIImageView alloc]init];
    iconView.layer.cornerRadius = 30;
    [iconView sd_setImageWithURL:[NSURL URLWithString:orderModel.userIcon] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    iconView.clipsToBounds = YES;
    [firstBGView addSubview:iconView];
    
    
    UILabel * nameLable = [[UILabel alloc]init];
    nameLable.text = orderModel.enName;
    nameLable.font = [UIFont systemFontOfSize:17 weight:0.1];
    nameLable.textAlignment =NSTextAlignmentLeft;
    nameLable.textColor = [UIColor colorWithHexString:@"#000000"];
    [firstBGView addSubview:nameLable];
    
    
    UIView * lineView1 = [[UIView alloc]init];
    
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [firstBGView addSubview:lineView1];
    
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTitle.mas_right).offset(10);
        make.centerY.mas_equalTo(nameTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconView.mas_right).offset(10);
        make.centerY.mas_equalTo(iconView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];

    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTitle.mas_left);
        make.bottom.mas_equalTo(firstBGView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - nameTitle.origin.x, 1));
    }];
    
   
        
   UILabel * sevLable = [[UILabel alloc]init];
        
    sevLable.font = [UIFont systemFontOfSize:15];
    
    
    [self.view addSubview:sevLable];
    
    
    
    UIView * lineView2 = [[UIView alloc]init];
    
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:lineView2];

    [self setAttribute:sevLable withstr:titleArray[1] and:orderModel.serviceName with:@""color:[UIColor colorWithHexString:@"#666666"]];
    [sevLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameTitle.mas_left);
        make.top.mas_equalTo(firstBGView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];
   
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sevLable.mas_left);
        make.top.mas_equalTo(sevLable.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - nameTitle.origin.x, 1));
    }];
    
    
    UILabel * costLable = [[UILabel alloc]init];
    
    costLable.font = [UIFont systemFontOfSize:15];
    
    
    [self.view addSubview:costLable];
    
    
    
    UIView * lineView3 = [[UIView alloc]init];
    
    lineView3.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:lineView3];

     [self setAttribute:costLable withstr:titleArray[2] and:orderModel.servicePrice with:@" RMB"color:[UIColor colorWithHexString:@"#26bdab"]];
        
        
    [costLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView2.mas_left);
        make.top.mas_equalTo(lineView2.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];
    
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(costLable.mas_left);
        make.top.mas_equalTo(costLable.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - nameTitle.origin.x, 1));
    }];
    

    UILabel * yearLable = [[UILabel alloc]init];
    
    yearLable.font = [UIFont systemFontOfSize:15];
    
    
    [self.view addSubview:yearLable];
    [self setAttribute:yearLable withstr:titleArray[3] and:orderModel.serviceLife with:@""color:[UIColor colorWithHexString:@"#26bdab"]];

    
    UIView * bgLineView = [[UIView alloc]init];
    bgLineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self.view addSubview:bgLineView];
    [yearLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView3.mas_left);
        make.top.mas_equalTo(lineView3.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(250, 20));
    }];

    [bgLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(yearLable.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 6));
    }];

    
    UILabel * orderCodeLable = [[UILabel alloc]init];
    
    orderCodeLable.font = [UIFont systemFontOfSize:15];
    
    
    [self.view addSubview:orderCodeLable];
    
    
    
    UIView * lineView4 = [[UIView alloc]init];
    
    lineView4.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:lineView4];
    
    [self setAttribute:orderCodeLable withstr:titleArray[4] and:orderModel.orderCode with:@""color:[UIColor colorWithHexString:@"#666666"]];
    
    
    [orderCodeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yearLable.mas_left);
        make.top.mas_equalTo(bgLineView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - nameTitle.origin.x, 20));
    }];
    
    [lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderCodeLable.mas_left);
        make.top.mas_equalTo(orderCodeLable.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - nameTitle.origin.x, 1));
    }];
    

    UILabel * timeLable = [[UILabel alloc]init];
    
    timeLable.font = [UIFont systemFontOfSize:15];
    
    
    [self.view addSubview:timeLable];
    
    
    
    UIView * lineView5 = [[UIView alloc]init];
    
    lineView5.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self.view addSubview:lineView5];
    
    [self setAttribute:timeLable withstr:titleArray[5] and:orderModel.orderTime with:@""color:[UIColor colorWithHexString:@"#666666"]];
    

    
    [timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(yearLable.mas_left);
        make.top.mas_equalTo(lineView4.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - nameTitle.origin.x, 20));
    }];
    
    
    
    
    
    
    
    
    
    UIButton  * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44 , kScreenWidth, 44)];
    
    
    button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [button setTitle: @"确认订单" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
 
}
-(void)setNewUI{
    
    
    
    
    CGFloat spacing = ((kScreenWidth - 60) - 4* 50)/3;
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 64)];
    
    
    CGFloat testNumber= 4;
    
    [self.view addSubview:headView];
    NSArray * array = @[@"具体服务",@"支付保障",@"三方协议",@"订单",@"付款"];
    for (int i = 0; i<4; i++) {
        UILabel * titilelable = [[UILabel alloc]initWithFrame:CGRectMake(30+ i * (50 + spacing), 10, 50, 20)];
        
        
        //titilelable.backgroundColor = [UIColor blueColor];
        titilelable.tag = 10 +i;
        
        titilelable.text = array[i];
        titilelable.font = [UIFont systemFontOfSize:12];
        titilelable.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:titilelable];
        
        
        UIButton * cycleView = [[UIButton alloc]initWithFrame:CGRectMake(titilelable.origin.x + 16, titilelable.bottom +10, 18, 18)];
        cycleView.layer.borderWidth = 1.0f;
        cycleView.layer.borderColor = [RGB(153, 153, 153) CGColor];
        NSString * btnStr = [NSString stringWithFormat:@"%d",i+1];
        cycleView.tag  = 20 +i;
        cycleView.titleLabel.font = [UIFont systemFontOfSize:10];
        cycleView.layer.cornerRadius = 9;
        [cycleView setTitle:btnStr forState:UIControlStateNormal];
        [cycleView setTitleColor:RGB(153, 153, 153)  forState:UIControlStateNormal];
        cycleView.backgroundColor = [UIColor clearColor];
        [headView addSubview:cycleView];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(cycleView.origin.x + cycleView.size.width   , cycleView.bottom - cycleView.size.height/2 -1, 50 + spacing - cycleView.size.width, 2)];
        
        lineView.tag = 30+i;
        
        lineView.backgroundColor  =RGB(153, 153, 153);
        
        if (i<3) {
            
            [headView addSubview:lineView];
            
            
            
            
            
            
            
        }
        
        if (i<testNumber) {
            titilelable.textColor = [UIColor colorWithHexString:@"#26bdab"];
            cycleView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
            [cycleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cycleView.layer.borderColor = [UIColor colorWithHexString:@"#26bdab"].CGColor;
            
        }
        if (i<(testNumber-1)) {
            
            lineView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        }
        
        
        
        
    }
    
    
    
    
}
//防止短时间内重复点击 时间0.5
- (void)starButtonClicked:(id)sender
{
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(click_orderBtn) object:sender];
    [self performSelector:@selector(click_orderBtn) withObject:sender afterDelay:0.5f];
}

-(void)click_orderBtn{
    
    NSMutableDictionary * pramas = [NSMutableDictionary dictionary];
    
    pramas[@"token"] = kToken;
    pramas[@"serviceId"] = self.serviceid;
    pramas[@"counselorId"] =self.counselorId;
    pramas[@"orderCode"] = _orderModel.orderCode;
    NSLog(@"dshcsjkd");
        [SVProgressHUD show];
    NSLog(@"%@  %@ %@",pramas[@"token"],pramas[@"serviceId"],pramas[@"counselorId"]);
    [HttpClientManager getAsyn:UG_insertOrder_URL params:pramas success:^(id json) {
        
        [SVProgressHUD dismiss];
        NSLog(@"%@",json);
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            _orderId =json[@"body"][@"orderId"];
            
            
            UGPayViewController * vc = [[UGPayViewController alloc]init];
            
            
            vc.orderId = _orderId;
            
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self pushToNextViewController:vc];
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];

    
    
}


-(void)setAttribute:(UILabel *)lable withstr:(NSString *) workDay and:(NSString * )workDayPercent with:(NSString *)lastday color:(UIColor *)color{
    
    NSString * totlelable = [NSString stringWithFormat:@"%@  %@ %@",workDay, workDayPercent,lastday];
    //    NSString * str= [NSString stringWithFormat:@"预约倒计时:%@",timeStr];
    
    NSMutableAttributedString *titleLablestr=[[NSMutableAttributedString alloc]initWithString:totlelable];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[titleLablestr string]rangeOfString:workDay];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:range1];
    
    NSRange range2=[[titleLablestr string]rangeOfString:workDayPercent];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:color range:range2];
    //    NSRange range3=[[titleLablestr string]rangeOfString:@"顾问收到总款的35%"];
    //    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:range3];
    
    lable.attributedText = titleLablestr;
    
    
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
