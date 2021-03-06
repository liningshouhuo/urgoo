//
//  UGPayViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/6/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGPayViewController.h"
#import "Masonry.h"
#import "UGPaySuccessViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "PayOrderDtlModel.h"
#import "UGPayErrorViewController.h"
#import "UGPayViewController.h"
#import "UGMyOrderViewController.h"
//#import "HRPayModel.h"

@interface UGPayViewController()
{
    UITextField * total_Field;
    UIView * choosePayView;
}
@property (copy,nonatomic) UILabel * moneyLable;

@property (copy,nonatomic) UIButton * payButton;
@property (assign,nonatomic) int consultCannumber;
@property (copy,nonatomic) NSString * depositStatus;
@property (copy,nonatomic) NSString * body;
@property (copy,nonatomic) NSString * subject;
@property (copy,nonatomic) NSString * payStatus;
@property (copy,nonatomic) NSString * total_fee;
@property (copy,nonatomic) NSString * payorderId;
@property (assign,nonatomic) int testNumber;
@property (copy,nonatomic) NSString * priceTotal;
@property (copy,nonatomic) NSString * balancePrice;
@property (copy,nonatomic) NSString * priceed;
@property (copy,nonatomic) NSString * serviceName;
@property (strong,nonatomic) NSMutableDictionary * payDict;

//@property (strong,nonatomic) HRPayModel *hRPayModel;
@property (copy,nonatomic) NSString * payReqSign;
@property (copy,nonatomic) NSString * outTradeNo;
@property (copy,nonatomic) NSString * MD5sign;
@property (copy,nonatomic) NSString * random;
@property (copy,nonatomic) NSString * hRBody;


@end
@implementation UGPayViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    _payButton = [[UIButton alloc]init];
    [choosePayView removeFromSuperview];
    [self loadOrderDtl];
    _payDict = [NSMutableDictionary dictionary];
    
    
}



-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    [self setCustomTitle:@"支付定金"];
    [self needBackAction:YES];
           UITapGestureRecognizer * contecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKey)];
   
          [self.view addGestureRecognizer:contecognizer];
  

    //[self loadOrderDtl];
    NSLog(@"%@",self.orderId);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ailipay:) name:@"alipay_resultStatus" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weCatpay:) name:@"weCat_resultStatus" object:nil];
    
}
- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [outputStr length ])];
    
    return [outputStr stringByRemovingPercentEncoding];
    
}
#pragma mark  网络请求 订单详情 
-(void)loadOrderDtl{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"orderId"] = self.orderId;
    
          [SVProgressHUD show];
       [HttpClientManager getAsyn: getOrderBalanceMoney params:params success:^(id json) {
        NSLog(@"json==%@",json);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        PayOrderDtlModel * model = [PayOrderDtlModel mj_objectWithKeyValues:json[@"body"]];
        _payorderId = model.payRequestOrderId;
        _subject= @"Urgoo";
        
        _body = [NSString stringWithFormat:@"%@",model.serviceName];
        _priceTotal = [NSString stringWithFormat:@"%@",model.priceTotal];
        _balancePrice = [NSString stringWithFormat:@"%@",model.balancePrice];
        _priceed= [NSString stringWithFormat:@"%@",model.priceed];
       
        [self initUI];
           
    } failure:^(NSError *error) {
        
        [self showSVErrorString:@"网络错误请重试"];
        [SVProgressHUD dismiss];
        
    }];
    
    
    
}
-(void)setNewUI{
    
    
    
    
    CGFloat spacing = ((kScreenWidth - 60) - 4* 50)/3;
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    headView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
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

-(void)initUI{
    [self setNewUI];
    
    UIView * moneyView = [[UIView alloc]init];
    moneyView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:moneyView];
    
    UILabel * titlelable = [[UILabel alloc]init];
    titlelable.text = @"共需支付";
     titlelable.font = [UIFont systemFontOfSize:13];
    titlelable.textColor = [UIColor colorWithHexString:@"#444444"];
    [moneyView addSubview:titlelable];
    
    _moneyLable = [[UILabel alloc]init];
    _moneyLable .text =[NSString stringWithFormat:@"¥%@",_priceTotal];
    _moneyLable.textAlignment = NSTextAlignmentCenter;
    _moneyLable.font = [UIFont systemFontOfSize:30];
     _moneyLable.textColor = [UIColor colorWithHexString:@"#444444"];
    [moneyView addSubview:_moneyLable];
    
    
    UIImageView * lineview = [[UIImageView alloc]init];
    lineview.backgroundColor = RGB(244, 244, 244);
    lineview.image = [UIImage imageNamed:@"lineView_image"];
    [moneyView addSubview:lineview];
    
    UILabel * alreadyLabl = [[UILabel alloc]init];
    alreadyLabl.text = @"已支付:";
    alreadyLabl.font = [UIFont systemFontOfSize:14];
    [moneyView addSubview:alreadyLabl];

    UILabel * wiattingLabl = [[UILabel alloc]init];
    wiattingLabl.font = [UIFont systemFontOfSize:14];
    wiattingLabl.text = @"待支付:";
    [moneyView addSubview:wiattingLabl];
    
    UILabel * alreadyLable = [[UILabel alloc]init];
    alreadyLable.font = [UIFont systemFontOfSize:14];
    alreadyLable.text = _priceed;
    alreadyLable.textColor = [UIColor colorWithHexString:@"#26bdab"];
    [moneyView addSubview:alreadyLable];
    
    UILabel * wiattingLable = [[UILabel alloc]init];
    wiattingLable.font = [UIFont systemFontOfSize:14];
    double priceTotal = [_priceTotal doubleValue];
    double balancePrice = [_priceed doubleValue];
    double testNum =priceTotal - balancePrice;
    wiattingLable.text = [NSString stringWithFormat:@"%.2f",testNum];
    wiattingLable.textColor = [UIColor colorWithHexString:@"#26bdab"];
    [moneyView addSubview:wiattingLable];

    
    
    
    
    
    UIView * totalView = [[UIView alloc]init];
    totalView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:totalView];
    
    
    
    UILabel * total_feelable = [[UILabel alloc]init];
    total_feelable.font = [UIFont systemFontOfSize:14];
    total_feelable.text = @"本次支付金额";
    [totalView addSubview:total_feelable];
    
    
    
    total_Field = [[UITextField alloc]init];
    total_Field.font = [UIFont systemFontOfSize:14];
    total_Field.placeholder = @":请输入金额";
    // [total_Field setKeyboardType:UIKeyboardTypeNumberPad];
    [totalView addSubview:total_Field];
    
    
    choosePayView = [[UIView alloc]init];
    choosePayView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:choosePayView];
    
    UILabel * paylable = [[UILabel alloc]init];
    paylable.text = @"支付方式";
    paylable.font = [UIFont systemFontOfSize:13];
    paylable.textColor = [UIColor colorWithHexString:@"#6a6a6a"];
    paylable.textAlignment = NSTextAlignmentLeft;
    [choosePayView  addSubview:paylable];
    
    for (int i =0; i<4; i++ ) {
        
        UIImageView * lineview = [[UIImageView alloc]init];
        //lineview.backgroundColor = RGB(244, 244, 244);
        lineview.image = [UIImage imageNamed:@"lineView_image"];
        [choosePayView addSubview:lineview];
        
        UIImageView * imageview = [[UIImageView alloc]init];
        [choosePayView addSubview:imageview];
        
        UILabel * lable =[[UILabel alloc]init];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textAlignment = NSTextAlignmentLeft;
        [choosePayView addSubview:lable];
        
        UIButton * button = [[UIButton alloc]init];
        button.tag = i+50;
        [button setImage:[UIImage imageNamed:@"button_noSelect"] forState:0];
                [button addTarget:self action:@selector(click_btn_forPay:) forControlEvents:  UIControlEventTouchUpInside];
        [choosePayView  addSubview:button];
        
        if (i == 0) {
            lineview.frame =CGRectMake(0, 33, kScreenWidth, 1);
            imageview.image =[UIImage imageNamed:@"AlipAy_image"];
            imageview.frame = CGRectMake(30, 48, 25, 26);
            lable.text = @"支付宝支付";
            lable.frame = CGRectMake(107, 54, 80, 14);
            button.frame = CGRectMake(kScreenWidth * 0.856, 39, 53, 44);
        }else if (i == 1){
            lineview.frame =CGRectMake(10, 90, kScreenWidth -10, 1);
            imageview.image =[UIImage imageNamed:@"Wecat_image"];
            imageview.frame = CGRectMake(30, 105, 29, 27);
            lable.text = @"微信支付";
            lable.frame = CGRectMake(107, 111, 80, 14);
            button.frame = CGRectMake(kScreenWidth * 0.856, 96, 53, 44);
        }else if (i==2){
            lineview.frame =CGRectMake(10, 147, kScreenWidth - 10 , 1);
            imageview.image =[UIImage imageNamed:@"huaruiBank_icon"];
            imageview.frame = CGRectMake(29, 165, 31, 20);//y = 162
            lable.text = @"银行卡支付";
            lable.frame = CGRectMake(107, 147+21, 100, 14);
            button.frame = CGRectMake(kScreenWidth * 0.856, 153, 53, 44);
        }else if (i == 3){
            lineview.frame =CGRectMake(0, 147+57, kScreenWidth , 1);
        }
        
    }
    
    UIButton * bottomBtn = [[UIButton alloc]init];
    
    [bottomBtn  addTarget:self action:@selector(click_bottomBtn) forControlEvents:UIControlEventTouchUpInside ];
    [bottomBtn setTitle:@"确定" forState:0];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    bottomBtn.layer.cornerRadius = 4.0f;
    [self.view addSubview:bottomBtn];
    
    
    [moneyView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 108));
    }];

    
    [bottomBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 44));
    }];
    
    
    [titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyView.mas_top).offset(15);
        make.centerX.mas_equalTo(moneyView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(65, 14));
    }];
    
    [alreadyLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_moneyLable.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(0.176*kScreenWidth);
        make.size.mas_equalTo(CGSizeMake(50, 14));
    }];
    [alreadyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_moneyLable.mas_bottom).offset(20);
        make.left.mas_equalTo(alreadyLabl.mas_right);
        make.size.mas_equalTo(CGSizeMake(65, 14));
    }];

    [wiattingLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_moneyLable.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(0.586*kScreenWidth);
        make.size.mas_equalTo(CGSizeMake(50, 14));
    }];
    
    [wiattingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_moneyLable.mas_bottom).offset(20);
        make.left.mas_equalTo(wiattingLabl.mas_right);
        make.size.mas_equalTo(CGSizeMake(65, 14));
    }];


    [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth,44));
    }];

    [total_feelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalView.mas_top).offset(15);
        make.left.mas_equalTo(totalView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(90,14));
    }];
    [total_Field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalView.mas_top).offset(15);
        make.left.mas_equalTo(total_feelable.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-150,14));
    }];
    


    [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titlelable.mas_bottom);
        make.centerX.mas_equalTo(moneyView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(169, 32));
    }];
    [choosePayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(totalView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth,203));//223-65
    }];
    [paylable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(choosePayView.mas_top).offset(10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(55,13));
    }];
    

    
}
-(void)needBackAction:(BOOL)isNeed
{
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}
-(void)click_btn_forPay:(UIButton * )sender{
    
    for (NSInteger i = 50; i<53; i++) {
        
        UIButton * button = (UIButton * )[self.view viewWithTag:i];
        [button setImage:[UIImage imageNamed:@"button_noSelect"] forState: UIControlStateNormal];
        
    }
    UIButton * button =(UIButton * )[self.view viewWithTag:sender.tag];
    [button setImage:[UIImage imageNamed:@"pay_select"] forState:UIControlStateNormal];
    _payDict[@"paymodel"] = [NSNumber numberWithInteger:sender.tag];

   
   
//    if(_payButton == sender) {
//        _consultCannumber+=1;
//        
//        if ((_consultCannumber + 1)%2 ==0) {
//                      //sender.tag = 0;
//            [sender setImage:[UIImage imageNamed:@"button_noSelect"] forState:    UIControlStateNormal];
//            
//
//        }
//        else if((_consultCannumber + 1)%2 ==1){
//            
//             [sender setImage:[UIImage imageNamed:@"pay_select"] forState:    UIControlStateNormal];
//            
//        }
//        
//        
//        
//    } else{
//        _consultCannumber = 0;
//               //设置背景颜色
//        
//        [sender setImage:[UIImage imageNamed:@"pay_select"] forState:    UIControlStateNormal];
//        
// [_payButton setImage:[UIImage imageNamed:@"button_noSelect"] forState:0];
//        //button.backgroundColor = [UIColor redColor];
//        
//        
//    }
//    
//    _payButton = sender;
    

}

-(void)click_bottomBtn{
    
    float total_fee = [total_Field.text floatValue];
    float needpay = [_balancePrice floatValue];
    float totalPay = [_priceTotal floatValue];
    
    
    NSLog(@"%f   %f   %f",total_fee,needpay,totalPay);
    if (total_Field.text.length >0) {
        NSString * paymodel = [NSString stringWithFormat:@"%@", _payDict[@"paymodel"]];
        
        
        NSLog(@"%lu",(unsigned long)paymodel.length);
        if ([paymodel isEqualToString:@"(null)"]) {
            [self showSVErrorString:@"请输入支付方式"];
        }else{
    
        if ([_priceed isEqualToString:@"0.0"]) {

            
            if (total_fee >totalPay) {
                [self showSVErrorString:@"超过需要支付的金额"];
            }else{
                
                
                if ([paymodel isEqualToString:@"50"]) {
                    NSLog(@"支付宝");
                    // 1.拼接请求参数
                    [SVProgressHUD show];
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"token"] = kToken;
                    params[@"subject"] = _subject;
                    params[@"body"] = _body;
                    params[@"total_fee"] = total_Field.text;
                    //params[@"total_fee"] = @"0.01";
                    params[@"orderId"] =[NSString stringWithFormat:@"%@-%@",_payorderId,self.orderId];
                    
                    NSLog(@"%@",params[@"orderId"]);
                    [HttpClientManager getAsyn: UG_launchAliPay_URL params:params success:^(id resultData) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
                        NSString *appScheme = @"urgoo.client";
                        
                        
                        [[AlipaySDK defaultService] payOrder:resultData[@"body"][@"aliPayRequest"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            NSString *  resultStatus = resultDic[@"resultStatus"];
                            NSLog(@"resultStatusresultStatusresultStatusresultStatus===%@",resultStatus);
                            NSLog(@"reslut =------- %@",resultDic);
                            if ([resultStatus isEqualToString:@"9000"]) {
                                _depositStatus = @"1";
                                
                                _payStatus = @"1";
                                [self payafter];
                                NSLog(@"这是 不带支付宝app的");
                            }else if ([resultStatus isEqualToString:@"6001"]){
                                
                                [self showSVErrorString:@"支付失败"];
                                
                                _payStatus = @"0";
                                
                                [self payafter];
                                NSLog(@"这是 不带支付宝app的6001");
                            }
                            
                        }];
                        
                        NSLog(@"%@",resultData);
                        
                    } failure:^(NSError *error) {
                        //[weakSelf showSVErrorString:@"Network request failed, please try again later"];
                        NSLog(@"失败了");
                        [SVProgressHUD dismiss];
                    }];
                    
                    
                }else if ([paymodel isEqualToString:@"51"]){
                    NSLog(@"微信");
                    [self weixinPay];
                    
                }else if ([paymodel isEqualToString:@"52"]){
                    NSLog(@"华瑞银行0.0");
                    [self HRGetDataPayAndHRRejest];
                    
                }else{
                    
                    [self showSVErrorString:@"请选择支付方式"];
                }
                
            }
            
            
        }else{
            
            
            if (total_fee >needpay) {
                [self showSVErrorString:@"超过需要支付的金额"];
            }else{
                
                if ([paymodel isEqualToString:@"50"]) {
                    NSLog(@"支付宝");
                    // 1.拼接请求参数
                    [SVProgressHUD show];
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    params[@"token"] = kToken;
                    params[@"subject"] = _subject;
                    params[@"body"] = _body;
                    params[@"total_fee"] = total_Field.text;
                    //params[@"total_fee"] = @"0.01";
                    params[@"orderId"] =[NSString stringWithFormat:@"%@-%@",_payorderId,self.orderId];
                    
                    NSLog(@"%@",params[@"orderId"]);
                    [HttpClientManager getAsyn: UG_launchAliPay_URL params:params success:^(id resultData) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                        });
                        //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
                        NSString *appScheme = @"urgoo.client";
                        
                        
                        [[AlipaySDK defaultService] payOrder:resultData[@"body"][@"aliPayRequest"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                            
                            NSString *  resultStatus = resultDic[@"resultStatus"];
                            NSLog(@"resultStatusresultStatusresultStatusresultStatus===%@",resultStatus);
                            NSLog(@"reslut =------- %@",resultDic);
                            if ([resultStatus isEqualToString:@"9000"]) {
                                _depositStatus = @"1";
                                
                                _payStatus = @"1";
                                [self payafter];
                                NSLog(@"这是 不带支付宝app的");
                            }else if ([resultStatus isEqualToString:@"6001"]){
                                
                                [self showSVErrorString:@"支付失败"];
                                
                                _payStatus = @"0";
                                
                                [self payafter];
                                NSLog(@"这是 不带支付宝app的6001");
                            }
                            
                        }];
                        
                        NSLog(@"%@",resultData);
                        
                    } failure:^(NSError *error) {
                        
                        NSLog(@"失败了");
                        [SVProgressHUD dismiss];
                    }];
                    
                    
                    
                }else if ([paymodel isEqualToString:@"51"]){
                    NSLog(@"微信");
                    [self weixinPay];
                    
                }else if ([paymodel isEqualToString:@"52"]){
                    NSLog(@"华瑞银行 -> >0.0");
                    [self HRGetDataPayAndHRRejest];
                    
                }else{
                    
                    [self showSVErrorString:@"请选择支付方式"];
                    
                }

                
            }
            
            
        }
    
        }
    
    
    }else{
        
        
        [self showSVErrorString:@"请输入支付金额"];
    }
    
    
}
//支付结束后的
-(void)payafter{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"totalFee"] = total_Field.text;
    params[@"payRequestOrderId"] = _payorderId;
    params[@"orderId"] = self.orderId;
    params[@"payStatus"] = _payStatus;
    
        // params[@"deposit"] = @"0.01";
        
        [HttpClientManager getAsyn: payorder_insertSubOrderDetail params:params success:^(id json) {
            
            NSLog(@"====%@",json);
            
            if ([_payStatus isEqualToString:@"1"]) {
                
                UGPaySuccessViewController * vc = [[UGPaySuccessViewController alloc]init];
                vc.orderId = self.orderId;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                UGPayErrorViewController * vc = [[UGPayErrorViewController alloc]init];
                vc.orderId = self.orderId;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];

                
                
            }

            
        } failure:^(NSError *error) {
            NSLog(@"yttytygj");
            
        }];
    
}

#pragma mark - 微信支付
-(void)weixinPay{
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"body"] =   _body;
   NSLog(@"%@",_total_fee);
    params[@"totalFee"] = total_Field.text;
    params[@"payRequestOrderId"] = [NSString stringWithFormat:@"%@-%@",_payorderId,self.orderId];     //params[@"totalFee"] = @"0.01";
    
    
    
    [SVProgressHUD show];
    [HttpClientManager postAsyn: UG_tenPayLaunch_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        DLog(@"resultData--->%@",json);
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSDictionary *dict = json[@"body"];
            NSMutableString *stamp  = [dict objectForKey:@"timeStamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [dict objectForKey:@"partnerId"];
            req.prepayId            = [dict objectForKey:@"prepayId"];
            req.nonceStr            = [dict objectForKey:@"nonceStr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            
            [WXApi sendReq:req];
            
            NSLog(@"sendReq:req  结果：%d",[WXApi sendReq:req]);
        }
        
    } failure:^(NSError *error) {
          [SVProgressHUD dismiss];
        
    }];
    
}

#pragma mark 支付成功后的回调
//支付宝
-(void)ailipay:(NSNotification * )notification{
    NSString  * resultStatus =  notification.userInfo[@"resultStatus"];
    NSLog(@"resultStatus===---==-=-==-=--%@",resultStatus);
    if ([resultStatus isEqualToString:@"9000"]) {
        
        NSMutableDictionary * params1 = [NSMutableDictionary dictionary];
        params1[@"token"] = kToken;
        params1[@"totalFee"] = total_Field.text;
        params1[@"payRequestOrderId"] = _payorderId;
        params1[@"orderId"] = self.orderId;
        params1[@"payStatus"] = @"1";
        
       // params[@"deposit"] = @"0.01";
        
        
        
        
        [HttpClientManager getAsyn: payorder_insertSubOrderDetail params:params1 success:^(id json) {
            
            AssistantsService *service=[[AssistantsService alloc] init];
            MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
            
            if ([msg.code isEqualToString:@"200"]) {
                
                NSLog(@"====支付宝成功回调");
                NSLog(@"%@",params1);
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"yttytygj");
            
        }];

        UGPaySuccessViewController * vc = [[UGPaySuccessViewController alloc]init];
        vc.orderId = self.orderId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        NSMutableDictionary * params1 = [NSMutableDictionary dictionary];
        params1[@"token"] = kToken;
        params1[@"totalFee"] = total_Field.text;
        params1[@"payRequestOrderId"] = _payorderId;
        params1[@"orderId"] = self.orderId;
        params1[@"payStatus"] = @"0";
        
        // params[@"deposit"] = @"0.01";
        NSLog(@"%@",params1);
        
        
        [HttpClientManager getAsyn: payorder_insertSubOrderDetail params:params1 success:^(id json) {
            
            AssistantsService *service=[[AssistantsService alloc] init];
            MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
            
            if ([msg.code isEqualToString:@"200"]) {
                
                NSLog(@"====支付宝成功回调");
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"yttytygj");
            
        }];
        UGPayErrorViewController * vc = [[UGPayErrorViewController alloc]init];
        vc.orderId = self.orderId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}
-(void)hiddenKey
{
    [total_Field resignFirstResponder];
}

//微信
-(void)weCatpay:(NSNotification * )notification{
    NSString * str = notification.userInfo[@"weCatpay"];
    NSLog(@"%@",str);
    if ([str isEqualToString:@"0"]) {
        NSLog(@"微信支付成功");
        
        NSMutableDictionary * params1 = [NSMutableDictionary dictionary];
        params1[@"token"] = kToken;
        params1[@"totalFee"] = total_Field.text;
        params1[@"payRequestOrderId"] = _payorderId;
        params1[@"orderId"] = self.orderId;
        params1[@"payStatus"] = @"1";
        
       // params[@"depositStatus"] = @"1";
        
        //params[@"deposit"] = @"0.01";
        
        [HttpClientManager getAsyn: payorder_insertSubOrderDetail params:params1 success:^(id json) {
            
            AssistantsService *service=[[AssistantsService alloc] init];
            MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
           
            if ([msg.code isEqualToString:@"200"]) {
                
                 NSLog(@"====微信宝成功回调");
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"yttytygj");
            
        }];
        UGPaySuccessViewController * vc = [[UGPaySuccessViewController alloc]init];
        //vc.isPayText = @"¥2000 定金支付成功";
        vc.orderId = self.orderId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
       
       NSLog(@"微信支付失败");
//
        NSMutableDictionary * params1 = [NSMutableDictionary dictionary];
        params1[@"token"] = kToken;
        params1[@"totalFee"] = total_Field.text;
        params1[@"payRequestOrderId"] = _payorderId;
        params1[@"orderId"] = self.orderId;
        params1[@"payStatus"] = @"0";
        
        // params[@"depositStatus"] = @"1";
        
        //params[@"deposit"] = @"0.01";
        
        [HttpClientManager getAsyn: payorder_insertSubOrderDetail params:params1 success:^(id json) {
            
            
            AssistantsService *service=[[AssistantsService alloc] init];
            MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
            
            if ([msg.code isEqualToString:@"200"]) {
                
                NSLog(@"====微信宝成功回调");
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"yttytygj");
            
        }];
    
        UGPayErrorViewController * vc = [[UGPayErrorViewController alloc]init];
        vc.orderId = self.orderId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
  
//        
  }
    
}

-(void)backAction{
    
    //我的订单-
    UGMyOrderViewController *vc  =[[UGMyOrderViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:vc];
    
}
-(void)dealloc{
    
    NSLog(@"控制器   被 销毁了============== ， ");
    
}


#pragma mark - 华瑞银行--支付成功返回服务器数据
-(void)HRPayStateToBackendServerPayedMoney:(NSString *)payed andTradeNo:(NSString *)outTradeNo
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"totalFee"] = payed;
    params[@"payRequestOrderId"] = outTradeNo;
    params[@"orderId"] = self.orderId;
    params[@"payStatus"] = @"1";
    
    [HttpClientManager postAsyn: payorder_insertSubOrderDetail params:params success:^(id json) {
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSLog(@"====华瑞银行成功回调");
            NSLog(@"%@",params);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UGPaySuccessViewController * vc = [[UGPaySuccessViewController alloc]init];
                vc.orderId = self.orderId;
                [self.navigationController pushViewController:vc animated:YES];
            });
        }

    } failure:^(NSError *error) {
        NSLog(@"yttytygj");
    }];
    
}

#pragma mark - 华瑞银行--验证开发者及数据
-(void)HRGetDataPayAndHRRejest
{
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"body"] = _body;//_body
    params[@"totalFee"] = _priceTotal;
    params[@"orderId"] = self.orderId;
    
    [HttpClientManager postAsyn:UG_payHuaRuiPayLaunch_URL params:params success:^(id json) {
        
        //DLog(@"%@",[self DlogJSONStringByJson:json]);
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            //_hRPayModel = [HRPayModel mj_objectWithKeyValues:json[@"body"]];
            _random     = [NSString stringWithFormat:@"%@",json[@"body"][@"randomNumber"]];
            _MD5sign    = [NSString stringWithFormat:@"%@",json[@"body"][@"approveDevSign"]];
            _outTradeNo = [NSString stringWithFormat:@"%@",json[@"body"][@"outTradeNo"]];
            _payReqSign = [NSString stringWithFormat:@"%@",json[@"body"][@"payReqSign"]];
            _hRBody     = [NSString stringWithFormat:@"%@",json[@"body"][@"body"]];
            
            //成为代理
            HRCallBackModel *callBackModel=[HRCallBackModel defaultManger];
            callBackModel.HRdelegate = self;
            [HRSDK approveDevValidationWithMD5sign:_MD5sign random:_random];
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];

}

#pragma mark - 华瑞银行--接口回调类型
-(void)getRespCallBackFromHR:(HRCallBackModel*)resp{
    
    //HR_REQ_KEY_APPROVE_DEV  接口回调类型
    NSLog(@"%@",[self convertStrFromDic:resp.callBackResult]);
    
    if (resp.key == HR_REQ_KEY_APPROVE_DEV) {
        
        if([[resp.callBackResult objectForKey:@"returnCode"]  isEqual: @"000000"]){
            NSLog(@"验证成功");
            [HRSDK getUserIDsWithAppUsertoken:[User_Default objectForKey:@"Growing_user_id"]];
        }
    }else if (resp.key == HR_REQ_KEY_GET_USER_IDS){
        
        if([[resp.callBackResult objectForKey:@"returnCode"]  isEqual: @"000000"]){
            NSLog(@"获取用户OPENID成功");
            NSString *personUnionID = @"";
            if([resp.callBackResult objectForKey:@"personUnionID"]){
                personUnionID = [resp.callBackResult objectForKey:@"personUnionID"];
            }
            [self payOrder:[resp.callBackResult objectForKey:@"openID"] persiond:personUnionID];
        }
    }else if (resp.key == HR_REQ_KEY_ORDER_PAY_BIND_CARD){
        
        NSLog(@"*******支付回调*******");
        if([[resp.callBackResult objectForKey:@"returnCode"]  isEqual: @"000000"]){
            NSLog(@"￥￥￥￥￥￥成功￥￥￥￥￥");
            [self HRPayStateToBackendServerPayedMoney:[resp.callBackResult objectForKey:@"payFee"] andTradeNo:[resp.callBackResult objectForKey:@"outTradeNo"]];
        }
    }
}

- (void)payOrder: (NSString *)openID persiond: (NSString *)persiond{
    
    if([_balancePrice isEqualToString:@"0.0"]){
        _balancePrice = _priceTotal;
    }
    
    HRPaymentInfo *payMentInfo = [[HRPaymentInfo alloc]init];
    
    payMentInfo.mchID       = @"SYT004";
    payMentInfo.outTradeNo  = _outTradeNo;//订单编号
    payMentInfo.confirmOrder= @"N";
    payMentInfo.totalFee    = _priceTotal;//
    payMentInfo.limitPay    = @"01";
    payMentInfo.attach      = @"";
    payMentInfo.body        = _hRBody;//_body
    payMentInfo.detail      = @"";
    payMentInfo.goodsTag    = @"goodsTag";
    payMentInfo.timeValid   = @"20";
    payMentInfo.paidAmount  = _priceed;//已支付
    payMentInfo.unpaidAmount= _balancePrice;//待支付
    payMentInfo.deviceInfo  = @"";
    payMentInfo.feeType     = @"CNY";
    payMentInfo.mchName     = @"优顾";
    
    NSDictionary *examgeDic=@{@"realName":@"",@"cardNo":@"",@"identity":@"",@"revmobile":@"",@"mobile":@""};
    
    [HRSDK payOrderWithViewController:self openID:openID personUnionID:persiond sign:_payReqSign random:_random paymentInfo:payMentInfo extraMessage:examgeDic];
    
}

//转化方法
-(NSString *)convertStrFromDic:(id)dic{
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *josnStr=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return josnStr;
    
}








@end
