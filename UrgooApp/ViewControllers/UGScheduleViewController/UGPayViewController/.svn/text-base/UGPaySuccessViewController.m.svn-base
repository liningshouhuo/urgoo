//
//  UGPaySuccessViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/6/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGPaySuccessViewController.h"
#import "Masonry.h"
#import "UGMyOrderViewController.h"
#import "PayOrderDtlModel.h"
#import "UGMyOrderDetailsViewController.h"
#import "UGPayViewController.h"
@interface UGPaySuccessViewController()
@property (copy,nonatomic) NSString * priceTotal;
@property (copy,nonatomic) NSString * balancePrice;
@property (copy,nonatomic) NSString * priceed;

@end
@implementation UGPaySuccessViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadOrderDtl];
    
    
    
}
-(void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    [self setCustomTitle:@"订单支付"];
    [self needBackAction:YES];
    [self loadOrderDtl];
    //[self initUI];
}

-(void)needBackAction:(BOOL)isNeed
{
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backtoorder)];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}

-(void)loadOrderDtl{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"orderId"] = self.orderId;
    //http://10.203.203.190:8080/urgoo/001/001/order/getParentOrderDetail
    //getParentOrderDetail   http://localhost:8080/urgoo/001/001/payorder/getOrderBalanceMoney?token=ENW2sR+g=&orderId=1
    //001/001/payorder/getOrderBalanceMoney?token=ENW2sR+g=&orderId=1
    [SVProgressHUD show];
    //NSLog(@"%@token=%@orderId=%@",getOrderBalanceMoney,kToken,self.orderId);
    [HttpClientManager getAsyn: getOrderBalanceMoney params:params success:^(id json) {
        NSLog(@"json==%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        PayOrderDtlModel * model = [PayOrderDtlModel mj_objectWithKeyValues:json[@"body"]];
        //_payorderId = model.payRequestOrderId;
       /// _subject= @"dasdda";
        
       // _body = model.serviceName;
        _priceTotal = model.priceTotal;
        _balancePrice = model.balancePrice;
        _priceed= model.priceed;
        // NSLog(@"%@ %@ %@ %@",_payorderId,_subject,_total_fee,_body);
        [self initUI];
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];
    
    
    
}

-(void)initUI{
    
    UIImageView * imageivew = [[UIImageView alloc]init];
    
    imageivew.image = [UIImage imageNamed:@"Schedules_shure_s"];
    
    [self.view addSubview:imageivew];
    
    UILabel * lable = [[UILabel alloc]init];
    //lable.text = @"¥2000 定金支付成功";
    lable.text = @"支付成功~";
    lable.font = [UIFont systemFontOfSize:17];
    lable.textAlignment = NSTextAlignmentCenter;
   
    lable.textColor =[UIColor colorWithHexString:@"#383838"];
    
    [self.view addSubview:lable];
    
    
    UILabel * totalLable = [[UILabel alloc]init];
    //lable.text = @"¥2000 定金支付成功";
    
    totalLable.font = [UIFont systemFontOfSize:14];
    totalLable.textAlignment = NSTextAlignmentCenter;
    
    //totalLable.textColor =[UIColor colorWithHexString:@"#383838"];
    
    [self.view addSubview:totalLable];
    
    
    UILabel * alreadyLable = [[UILabel alloc]init];
    //lable.text = @"¥2000 定金支付成功";
    
    alreadyLable.font = [UIFont systemFontOfSize:14];
    alreadyLable.textAlignment = NSTextAlignmentCenter;
    
    //totalLable.textColor =[UIColor colorWithHexString:@"#383838"];
    
    [self.view addSubview:alreadyLable];
    

    
    
    
    NSString * moneyLable = _priceTotal;
    NSString * str= [NSString stringWithFormat:@"订单总金额:%@",moneyLable];
    
    NSMutableAttributedString *titleLablestr=[[NSMutableAttributedString alloc]initWithString:str];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[titleLablestr string]rangeOfString:@"订单总金额:"];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9b9b9b"] range:range1];
    
    NSRange range2=[[titleLablestr string]rangeOfString:moneyLable];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#383838"] range:range2];
    totalLable.attributedText = titleLablestr;
    
    
    
    
    
    
    //已支付
    NSString * alreadMoney =_priceed;
    NSString * alreadyStr= [NSString stringWithFormat:@"已支付金额:%@",alreadMoney];
    
    NSMutableAttributedString *  alreadytitleLablestr=[[NSMutableAttributedString alloc]initWithString:alreadyStr];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range3=[[alreadytitleLablestr string]rangeOfString:@"已支付金额:"];
    [alreadytitleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9b9b9b"] range:range3];
    
    NSRange range4=[[titleLablestr string]rangeOfString:alreadMoney];
    [alreadytitleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#383838"] range:range4];
    alreadyLable.attributedText = alreadytitleLablestr;
    
    
    
    
    
    
   // 待支付
    
    UILabel * waittingLable = [[UILabel alloc]init];
    //lable.text = @"¥2000 定金支付成功";
    
    waittingLable.font = [UIFont systemFontOfSize:14];
    waittingLable.textAlignment = NSTextAlignmentCenter;
    
    //totalLable.textColor =[UIColor colorWithHexString:@"#383838"];
    
    [self.view addSubview:waittingLable];
    NSString * waittingMoney = _balancePrice;
    NSString * waittingStr= [NSString stringWithFormat:@"待支付金额:%@",waittingMoney];
    
    NSMutableAttributedString *  waittingtitleLablestr=[[NSMutableAttributedString alloc]initWithString:waittingStr];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range5=[[waittingtitleLablestr string]rangeOfString:@"待支付金额:"];
    [waittingtitleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#9b9b9b"] range:range5];
    
    NSRange range6=[[waittingtitleLablestr string]rangeOfString:waittingMoney];
    [waittingtitleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#26bdab"] range:range6];
    waittingLable.attributedText = waittingtitleLablestr;

    
    
    
    UIButton * bottomBtn = [[UIButton alloc]init];
    
    [bottomBtn  addTarget:self action:@selector(click_bottomBtn) forControlEvents:UIControlEventTouchUpInside ];
    [bottomBtn setTitle:@"继续支付" forState:0];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    bottomBtn.layer.cornerRadius = 4.0f;
    [self.view addSubview:bottomBtn];
    if ([_priceTotal isEqualToString:_priceed]) {
        bottomBtn.hidden = YES;
    }
    
    
    
    UIButton * orderbottomBtn = [[UIButton alloc]init];
    
    [orderbottomBtn  addTarget:self action:@selector(click_bottomtoOrderDTl) forControlEvents:UIControlEventTouchUpInside ];
    [orderbottomBtn setTitle:@"订单详情" forState:0];
    orderbottomBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    //orderbottomBtn.titleLabel.textColor = [UIColor blackColor];
    [orderbottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    orderbottomBtn.layer.cornerRadius = 4.0f;
    orderbottomBtn.layer.borderWidth = 0.5;
    
    orderbottomBtn.layer.borderColor = [[UIColor colorWithHexString:@"#9b9b9b"] CGColor];
    [self.view addSubview:orderbottomBtn];
    

    
    [imageivew  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(45);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(82, 82));
    }];
    [lable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageivew.mas_bottom).offset(14);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(165, 16));
    }];
    [totalLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lable.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(165, 16));
    }];
    
    [alreadyLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalLable.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(165, 16));
    }];
    [waittingLable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alreadyLable.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(165, 16));
    }];

    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lable.mas_bottom).offset(150);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(250, 44));
    }];
    [orderbottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bottomBtn.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(250, 44));
    }];
}
-(void)click_bottomBtn{               
    
   [self.navigationController popViewControllerAnimated:YES];
//    UGPayViewController * vc = [[UGPayViewController alloc]init];
//    vc.orderId = self.orderId;
//    [self pushToNextViewController:vc];
    //继续支付
    
    
    
}
-(void)backtoorder{
    
    
    NSLog(@"dasdasdsa");
    //我的订单-
    UGMyOrderViewController *vc  =[[UGMyOrderViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:vc];
    
}
-(void)click_bottomtoOrderDTl{
    
    NSLog(@"dasdasdsa");
    //我的订单-
    
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/001/001/order/parentOrderIn?termType=2&orderId=%@&",UG_HOST,self.orderId];
//     NSString * urlStr = [NSString stringWithFormat:@"http://www-prd-urgoo.com/urgoo/001/001/order/parentOrderIn?termType=2&orderId=%@&",self.orderId];
    UGMyOrderDetailsViewController *vc = [[UGMyOrderDetailsViewController alloc]init];
   vc.type = @"我的订单";
   vc.urlStr = urlStr;
    [self pushToNextViewController:vc];

    
}
-(void)dealloc{
    
    NSLog(@"控制器   被 销毁了============== ， ");
    
    
    
    
}
@end
