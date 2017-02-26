//
//  UGPaytimeViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGPaytimeViewController.h"
#import "PayTimeListModel.h"
#import "UGAgreementViewController.h"
#import "UgComordViewController.h"
#import "UGSanfangAgreementViewController.h"
#import "TripartiteAgreementViewController.h"

@interface UGPaytimeViewController ()

@property (strong,nonatomic) UIScrollView * scrollView;
@property (strong,nonatomic) NSMutableArray * groupArray;
@property (strong,nonatomic) NSString * workDay;
@property (strong,nonatomic) NSString * workDayPercent;
@end

@implementation UGPaytimeViewController
-(NSMutableArray *)groupArray{
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    
    return _groupArray;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"优顾支付时间预览"];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenHeight, kScreenHeight - 64 - 44)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    UIButton  * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44 , kScreenWidth, 44)];
    
    
    button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [button setTitle: @"阅读三方协议" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button addTarget:self action:@selector(click_readBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    

    
    [self  loadrequest];
    
    
}
-(void)loadrequest{
    
    NSMutableDictionary * pramas = [NSMutableDictionary dictionary];
    
    pramas[@"token"] = kToken;
    pramas[@"serviceType"] = _serviceType;
    pramas[@"grade"] = _grade;
    
    [HttpClientManager getAsyn:UG_getPayTimeDetail_URL params:pramas success:^(id json) {
        
        if ([json[@"header"][@"code"]  isEqualToString:@"200"]) {
            
            NSArray * array = json[@"body"][@"payTimeList"];
            _workDay = json[@"body"][@"workDay"];
            _workDayPercent = json[@"body"][@"workDayPercent"];
            for (NSDictionary * dict in array) {
                PayTimeListModel * model = [PayTimeListModel mj_objectWithKeyValues:dict];
                
                
                [self.groupArray addObject:model];
            }
            
            [self initUI];
        }
        
        

    } failure:^(NSError *error) {
        
    }];
    
    
    
}
-(void)setNewUI:(CGFloat ) number{
    
    
    
    
    CGFloat spacing = ((kScreenWidth - 60) - 4* 50)/3;
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    
    CGFloat testNumber= number;
    
    [_scrollView addSubview:headView];
    NSArray * array = @[@"具体服务",@"支付保障",@"三方协议",@"订单",@"付款"];
    for (int i = 0; i<4; i++) {
        UILabel * titilelable = [[UILabel alloc]initWithFrame:CGRectMake(30+ i * (50 + spacing), 10, 50, 20)];
        
        
        //titilelable.backgroundColor = [UIColor blueColor];
        titilelable.tag = 10 +i;
        
        titilelable.text = array[i];
        titilelable.font = [UIFont systemFontOfSize:12];
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
-(void)initUI
{
    
    [self setNewUI:2];
    
    
    UILabel * firstlable = [[UILabel alloc]init];
    
    
    
    
    
    
    
    firstlable.text = @"客户支付平台费用";
    firstlable.textColor = [UIColor colorWithHexString:@"#666666"];
    firstlable.font = [UIFont systemFontOfSize:14];
    firstlable.textAlignment = NSTextAlignmentLeft;
    firstlable.frame = CGRectMake(64, 22+64, 200, 16);
    [_scrollView addSubview:firstlable];
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor= [UIColor colorWithHexString:@"#eeeeee"];
    
    
    lineView.frame = CGRectMake(40, firstlable.origin.y + 3, 1, 200);
    
    
    [_scrollView addSubview:lineView];
    
    
    
    
    
    
    
    
    UIView * cycleView= [[UIView alloc]initWithFrame:CGRectMake(36 , firstlable.origin.y + 3, 10, 10)];
    cycleView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    cycleView.layer.cornerRadius = 5;

     [_scrollView addSubview:cycleView];
    
    
    
    UILabel * twolable = [[UILabel alloc]init];
    
   
    twolable.textColor = [UIColor colorWithHexString:@"#666666"];
    twolable.textAlignment = NSTextAlignmentLeft;
    twolable.frame = CGRectMake(64, firstlable.bottom +61, kScreenWidth * 0.71, 38);
    twolable.numberOfLines = 0;
    twolable.font = [UIFont systemFontOfSize:14];
    //[self setAttribute:twolable withstr:@"10个工作日"];
    [self setAttribute:twolable withstr:_workDay and:_workDayPercent];
    [_scrollView addSubview:twolable];
    UIView * cycleView1= [[UIView alloc]initWithFrame:CGRectMake(36 , twolable.origin.y + 3, 10, 10)];
    cycleView1.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    cycleView1.layer.cornerRadius = 5;
    [_scrollView addSubview:cycleView1];
    
    for (int i = 0; i < self.groupArray.count; i++) {
        
        PayTimeListModel * model = self.groupArray[i];
        UILabel * lable = [[UILabel alloc]init];
        
        
        lable.textColor = [UIColor colorWithHexString:@"#666666"];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.frame = CGRectMake(64, twolable.bottom +41  + i*(35),  kScreenWidth * 0.71, 16);
        lable.numberOfLines = 0;
        
        lable.font = [UIFont systemFontOfSize:14];
        lable.text = [NSString stringWithFormat:@"%@ %@",model.payTime,model.descb];
        
          [_scrollView addSubview:lable];
        UIView * cycleView2= [[UIView alloc]initWithFrame:CGRectMake(36 , lable.origin.y + 5, 10, 10)];
        cycleView2.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        cycleView2.layer.cornerRadius = 5;
        [_scrollView addSubview:cycleView2];

        
    }
    
    UILabel * thirdLable= [[UILabel alloc]init];
    
    thirdLable.textColor = [UIColor colorWithHexString:@"#666666"];
    thirdLable.textAlignment = NSTextAlignmentLeft;
    thirdLable.frame = CGRectMake(64, twolable.bottom +64  + 35*self.groupArray.count,  kScreenWidth * 0.71, 38);
    thirdLable.numberOfLines = 0;
    thirdLable.font = [UIFont systemFontOfSize:14];
    thirdLable.text = @"客户确认合同内服务完成,顾问收取剩余费用";
    [_scrollView addSubview:thirdLable];
    
    UIView * cycleView3= [[UIView alloc]initWithFrame:CGRectMake(36 , thirdLable.origin.y + 3, 10, 10)];
    cycleView3.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    cycleView3.layer.cornerRadius = 5;
    [_scrollView addSubview:cycleView3];
    
    //
    
    CGFloat height = cycleView3.origin.y - firstlable.origin.y -3;
    lineView.height = height ;
    
    
    //  提示
    UILabel * promptlable =  [[UILabel alloc]init];
    promptlable.frame = CGRectMake((kScreenWidth -40)/2, thirdLable.bottom +40, 40, 16);
    promptlable.text = @"提示";
    promptlable.font = [UIFont systemFontOfSize:14];
    promptlable.textColor = [UIColor colorWithHexString:@"#6a6a6a"];
    //[_scrollView addSubview:promptlable];

    UIImageView * promptimage  = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(promptlable.x -20, promptlable.y + 3, 14, 13)];
    
    
    promptimage.image = [UIImage imageNamed:@"prompt_photo"];
    //[_scrollView addSubview:promptimage];
    
    
    UILabel * fourLable= [[UILabel alloc]init];
    
    fourLable.textColor = [UIColor colorWithHexString:@"#666666"];
    fourLable.textAlignment = NSTextAlignmentLeft;
    fourLable.frame = CGRectMake(kScreenWidth * 0.15, promptlable.bottom +20, kScreenWidth * 0.71, 85);
    fourLable.numberOfLines = 0;
    fourLable.font = [UIFont systemFontOfSize:14];
    fourLable.text =@"客户与顾问签订协议后,费用支付至优顾平台优顾将会在第一时间把第一笔比列款项支付给顾问。您可以在平台余额中查看到平台还未支付给顾问的费用。如果您还有任何与费用相关的疑问，请与我们联系。"   ;
   
  CGFloat hight=  [self getHeightWithContent:fourLable.text width:kScreenWidth * 0.71 font:14];
    
   fourLable.frame = CGRectMake(kScreenWidth * 0.15, promptlable.bottom +20, kScreenWidth * 0.71, hight);
    
    //[_scrollView addSubview:fourLable];
    
    
    UILabel * kefuable= [[UILabel alloc]init];
    
    kefuable.textColor = [UIColor colorWithHexString:@"#666666"];
    kefuable.textAlignment = NSTextAlignmentCenter;
    kefuable.frame = CGRectMake(kScreenWidth * 0.15, fourLable.bottom +40,  kScreenWidth * 0.71, 14);
    kefuable.numberOfLines = 0;
    kefuable.font = [UIFont systemFontOfSize:12];
    kefuable.text =@"客服电话: 400-061-2819";
    
    
    //[_scrollView addSubview:kefuable];

    
    UILabel * workDayLable= [[UILabel alloc]init];
    
    workDayLable.textColor = [UIColor colorWithHexString:@"#666666"];
    workDayLable.textAlignment = NSTextAlignmentCenter;
    workDayLable.frame = CGRectMake(kScreenWidth * 0.15, kefuable.bottom +20,  kScreenWidth * 0.71, 14);
    workDayLable.numberOfLines = 0;
    workDayLable.font = [UIFont systemFontOfSize:12];
    workDayLable.text =@"工作日: 9:00 - 18:00";
    
    
    //[_scrollView addSubview:workDayLable];

    
    

   // _scrollView.contentSize = CGSizeMake(0, workDayLable.bottom +30);
    _scrollView.contentSize = CGSizeMake(0, thirdLable.bottom + 40);
}
-(void)setAttribute:(UILabel *)lable withstr:(NSString *) workDay and:(NSString * )workDayPercent{
    
   NSString * totlelable = [NSString stringWithFormat:@"客户支付平台费用后%@个工作日后顾问收到总款的%@",workDay, workDayPercent];
//    NSString * str= [NSString stringWithFormat:@"预约倒计时:%@",timeStr];
    
    NSMutableAttributedString *titleLablestr=[[NSMutableAttributedString alloc]initWithString:totlelable];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[titleLablestr string]rangeOfString:@"客户支付平台费用后"];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#666666"] range:range1];
    
    NSRange range2=[[titleLablestr string]rangeOfString:workDay];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#26bdab"] range:range2];
  
   lable.attributedText = titleLablestr;

    
}

-(void)click_readBtn{
    /*
       UGSanfangAgreementViewController * vc = [[UGSanfangAgreementViewController alloc]init];
    
        vc.serviceid = _serviceid;
        vc.counselorId = _counselorId;
    
        [self pushToNextViewController:vc];//#import "TripartiteAgreementViewController.h"
    */
    
    TripartiteAgreementViewController * vc = [[TripartiteAgreementViewController alloc]init];
    vc.serviceid = _serviceid;
    vc.counselorId = _counselorId;
    [self pushToNextViewController:vc];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}  context:nil];
    return rect.size.height;
    
    
    
}


@end
