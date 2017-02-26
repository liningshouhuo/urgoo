//
//  UGConfirmOrderViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/4.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGConfirmOrderViewController.h"
#import "UGSeverAgreementViewController.h"
#import "UGMyOrderDetailsViewController.h"
#import "UGMyOrderViewController.h"
#import "UGGotoFwXyViewController.h"
#import "UGGotoPtGzViewController.h"
#import "UGCounselorDetailNewViewController.h"

@interface UGConfirmOrderViewController ()

@end

@implementation UGConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self setCustomTitle:@"确认订单"];
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    DLog(@"path=%@",[[request URL] absoluteString]);
    
    NSString *pathStr = [[request URL] absoluteString];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    
    NSInteger accountObj = [pathArr count];
    
   NSLog(@"pathArr=%@",pathArr);
    if (pathArr.count>1) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        DLog(@"拼接前的地址--%@",urlStr);
        
        if ([pathArr[0] isEqualToString:gotoXyJz]) {
            
            UGSeverAgreementViewController *vc = [[UGSeverAgreementViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }
        else if ([pathArr[0] isEqualToString:gotoOrderDtlJz]) {//原协议：gotoOrderListJz
            
            UGMyOrderDetailsViewController *vc = [[UGMyOrderDetailsViewController alloc]init];
            vc.type = @"我的订单";
            vc.urlStr = urlStr;
            //vc.isShouye = YES;
            [self pushToNextViewController:vc];
            
        }else if ([pathArr[0] isEqualToString:gotoFwXy]) {//顾问服务 UGGotoFwXyViewController
            
            UGGotoFwXyViewController *vc = [[UGGotoFwXyViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];

            
        }else if ([pathArr[0] isEqualToString:gotoPtGz]) {//支付规则  UGGotoPtGzViewController
            
            UGGotoPtGzViewController *vc = [[UGGotoPtGzViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            

            
        }else if ([pathArr[0] isEqualToString:gotoGwDtl]) {//顾问详情  UGGotoPtGzViewController
            
            UGCounselorDetailNewViewController * counselorDetailNewVC = [[UGCounselorDetailNewViewController alloc]init];
            counselorDetailNewVC.counselorId = pathArr[1];
          //  NSLog(@"counselorId===%@",counselorId);
            counselorDetailNewVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:counselorDetailNewVC animated:YES];
            
            
        }



        
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
