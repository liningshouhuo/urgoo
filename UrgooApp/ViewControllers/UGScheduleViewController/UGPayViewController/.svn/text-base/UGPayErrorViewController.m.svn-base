//
//  UGPayErrorViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/2.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGPayErrorViewController.h"
#import "Masonry.h"
#import "UGMyOrderDetailsViewController.h"
#import "UGMyOrderViewController.h"
#import "UGPayViewController.h"
@interface UGPayErrorViewController ()

@end

@implementation UGPayErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    [self setCustomTitle:@"订单支付"];
    [self needBackAction:YES];
    [self initUI];
    
    
}
-(void)initUI{
    UIImageView * imageivew = [[UIImageView alloc]init];
    
    imageivew.image = [UIImage imageNamed:@"pay_error_"];
    
    [self.view addSubview:imageivew];

    
    
    UILabel * lable = [[UILabel alloc]init];
    //lable.text = @"¥2000 定金支付成功";
    lable.text = @"支付失败";
    lable.font = [UIFont systemFontOfSize:17];
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.textColor =[UIColor colorWithHexString:@"#383838"];
    
    [self.view addSubview:lable];

    
    UILabel * backlable = [[UILabel alloc]init];
    //lable.text = @"¥2000 定金支付成功";
    backlable.text = @"请返回收银台继续支付~";
    backlable.font = [UIFont systemFontOfSize:14];
    backlable.textAlignment = NSTextAlignmentCenter;
    
    backlable.textColor =[UIColor colorWithHexString:@"#26bdab"];
    
    [self.view addSubview:backlable];
    

    
    
    UIButton * bottomBtn = [[UIButton alloc]init];
    
    [bottomBtn  addTarget:self action:@selector(click_bottomBtn) forControlEvents:UIControlEventTouchUpInside ];
    [bottomBtn setTitle:@"返回收银台" forState:0];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    bottomBtn.layer.cornerRadius = 4.0f;
    [self.view addSubview:bottomBtn];
    
    
    
    
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
    [backlable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lable.mas_bottom).offset(25);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 16));
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
    
//    UGPayViewController * vc = [[UGPayViewController alloc]init];
//    vc.orderId = self.orderId;
//    [self pushToNextViewController:vc];
 [self.navigationController popViewControllerAnimated:YES];
    
    //继续支付
    
    
    
}
-(void)click_bottomtoOrderDTl{
    
    //我的订单-
    NSString * urlStr = [NSString stringWithFormat:@"%@001/001/order/parentOrderIn?termType=2&orderId=%@&",UG_HOST,self.orderId];
    UGMyOrderDetailsViewController *vc = [[UGMyOrderDetailsViewController alloc]init];
    vc.type = @"我的订单";
    vc.urlStr = urlStr;
    [self pushToNextViewController:vc];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
