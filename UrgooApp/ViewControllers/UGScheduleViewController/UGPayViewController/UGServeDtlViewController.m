//
//  UGServeDtlViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGServeDtlViewController.h"
#import "UGPaytimeViewController.h"
static CGFloat heightOne;
static CGFloat heightTwo;
static CGRect  frameOne;

@interface UGServeDtlViewController ()
@property (strong,nonatomic) UIScrollView * scrollview;

@end

@implementation UGServeDtlViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:YES];
    _backGroundView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 44)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backGroundView];

    [self setCustomTitle:@"具体服务"];
    UIButton  * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44 , kScreenWidth, 44)];
    
    
    button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [button setTitle: @"阅读支付保障" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button addTarget:self action:@selector(click_toOrad) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
    
    
    [self setNewUI:1];
    
    
    
    [self initUI];
    
    
}
-(void)setNewUI:(CGFloat ) number{
    
    
    
    
    CGFloat spacing = ((kScreenWidth - 60) - 4* 50)/3;
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    
    CGFloat testNumber= number;
    
    [_backGroundView addSubview:headView];
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
    _counselorModel = _dataModel.counselorDetail;
    
    
    //服务内容
    NSArray *serviceLongList = _dataModel.serviceLongList;
    NSMutableArray *serviceListArr = [NSMutableArray array];
    for (ServiceLongListsModel *model in serviceLongList) {
        if (model.detailed) {
            [serviceListArr addObject:model.detailed];
        }
    }
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(20,20 +64, 100, 15)];
    lable2.text = @"服务内容:";
    lable2.font = [UIFont systemFontOfSize:15 ];
    lable2.textColor = [UIColor colorWithHexString:@"#999999"];
    [_backGroundView addSubview:lable2];
    
    //NSArray *seaveArr = @[@"服务内容1",@"服务内容2",@"服务内容3",@"服务内容4",@"服务内容5",@"服务内容6"];
    NSArray *seaveArr = serviceListArr;
    _isDownArr = [NSMutableArray array];
    heightOne  = 120;
    
           //收起状态
        for (int i = 0; i < seaveArr.count; i ++) {
            
            UIImageView *trueImage = [[UIImageView alloc] init];
            trueImage.frame = CGRectMake( lable2.x, lable2.bottom+12 + i*18, 10, 10);
            trueImage.backgroundColor = [UIColor clearColor];
            trueImage.image = [UIImage imageNamed:@"pay_select"];
            [_backGroundView addSubview:trueImage];
            if (i == _isDownArr.count-1) {
                trueImage.image = [UIImage imageNamed:@""];
            }
            
            UILabel *seaveLable = [[UILabel alloc] init];
            seaveLable.frame = CGRectMake(lable2.x+8+5, lable2.bottom+10 + i*18, _backGroundView.width-50, 13);
            seaveLable.text = seaveArr[i];
            seaveLable.font = [UIFont systemFontOfSize:13];
            seaveLable.textColor = [UIColor colorWithHexString:@"666666"];
            [_backGroundView addSubview:seaveLable];
            
            heightOne = seaveLable.bottom;
        }
   
    
    
    //顾问备注
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(20, heightOne + 20, 100, 15)];
    lable3.text = @"顾问备注:";
    lable3.font = [UIFont systemFontOfSize:15 ];
    lable3.textColor = [UIColor colorWithHexString:@"#999999"];
    [_backGroundView addSubview:lable3];
    
    if (_counselorModel.extraService.length > 0) {
        
        NSArray *seaArr = @[_counselorModel.extraService];
        for (int i = 0; i < seaArr.count; i ++) {
            
            UILabel *seaLable = [[UILabel alloc] init];
            seaLable.frame = CGRectMake(lable3.x, lable3.bottom-5 + i*18, _backGroundView.width-50, 13);
            seaLable.text = seaArr[i];
            seaLable.font = [UIFont systemFontOfSize:13];
            seaLable.textColor = [UIColor colorWithHexString:@"666666"];
            [seaLable heightForLableText:seaArr[i] fontOfSize:13 frame:seaLable.frame];
            [_backGroundView addSubview:seaLable];
            
            heightTwo = seaLable.bottom;
        }
    }else{
        lable3.frame = CGRectMake(20, heightOne + 20, 100, 0);
        heightTwo = lable3.bottom - 10;
    }
    
    
    
    //顾问备注
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(20, heightTwo + 20, 200, 15)];
    lable4.text = @"聘用保障计划:";
    lable4.font = [UIFont systemFontOfSize:15 ];
    lable4.textColor = [UIColor colorWithHexString:@"#999999"];
    [_backGroundView addSubview:lable4];


    
    NSArray *arr = @[@"1.平台所有入驻顾问均严格审核，顾问信息真实有效。",@"2.平台定期对客户与顾问进行服务满意度回访。",@"3.平台按照三方协议约定分批支付款项给顾问，客户可随时查阅平台余额。",@"4.若服务期间产生疑义，优顾平台可暂停支付并启动调查流程。"];
    CGFloat heightt = 0;
    for (int i = 0; i < arr.count; i ++) {
        
        NSString *str = [NSString stringWithFormat:@"%@",arr[i]];
        UILabel *note = [[UILabel alloc] init];
        note.textColor = [UIColor colorWithHexString:@"666666"];
        note.frame = CGRectMake(20, lable4.bottom+heightt-5, _backGroundView.width-50, 13);
        [note heightForLableText:str fontOfSize:13 frame:note.frame];
        heightt += note.height;
        [_backGroundView addSubview:note];
        
        frameOne = note.frame;
    }


    
    _backGroundView.contentSize = CGSizeMake(0, frameOne.origin.y +40);
    
   }






-(void)click_toOrad{
    UGPaytimeViewController * vc = [[UGPaytimeViewController alloc]init];
    vc.serviceType = _serviceType;
    vc.grade = _grade;
    vc.serviceid = _serviceid;
    vc.counselorId = _counselorId;
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:vc];
    
    
    
    
    
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
